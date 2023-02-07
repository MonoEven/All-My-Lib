#Include <cjson\cjson>
#Include <struct\struct>

flag := cimgui.dll_file("cimgui\lib\cimgui.dll")
if flag
    dllcall("LoadLibrary", "str", flag)
else
    throw error("cimgui.dll is not existed.")

defs_cjson := cJson()
defs_cjson.parse(cimgui.dll_file("cimgui\lib\definitions.json"))
impl_defs_cjson := cJson()
impl_defs_cjson.parse(cimgui.dll_file("cimgui\lib\impl_definitions.json"))const_cjson := cJson()
const_cjson.parse(cimgui.dll_file("cimgui\lib\structs_and_enums.json"))
typedef_cjson := cJson()
typedef_cjson.parse(cimgui.dll_file("cimgui\lib\typedefs_dict.json"))

class cimgui
{
    static defs_var := ["args", "argsT", "argsoriginal", "call_args", "cimguiname", "defaults", "funcname", "location", "ov_cimguiname", "ret", "signature", "stname", "templated"]
    static warning := ""
    
    static dll_file(dll_name)
    {
        if !dll_name
            return false
        if fileexist(dll_name)
            return dll_name
        else if fileexist(format("{}\lib\{}", regread("HKLM\SOFTWARE\AutoHotkey", "InstallDir", ""), dll_name))
            return format("{}\lib\{}", regread("HKLM\SOFTWARE\AutoHotkey", "InstallDir", ""), dll_name)
        else if fileexist(format("{}\lib\{}", a_scriptdir, dll_name))
            return format("{}\lib\{}", a_scriptdir, dll_name)
        else
            return false
    }
    
    static strBuffer(str, encoding := "utf-8")
    {
        buf := buffer(strput(str, encoding))
        strput(str, buf, encoding)
        return buf
    }
    
    static __get(prop_name, param)
    {
        if instr(prop_name, "_")
        {
            prefix := strsplit(prop_name, "_")[1] "_"
            target := const_cjson["enums"][prefix]
            
            loop target.length
            {
                if target[a_index - 1]["name"].get() = prop_name
                {
                    ret := cimgui.simple_eval(target[a_index - 1]["value"].get())
                    cimgui.%prop_name% := ret
                    return ret
                }
            }
            return ""
        }
        return ""
    }
    
    static __call(name, param)
    {
        if defs_cjson.has(name)
            tmp := defs_cjson[name][0]
        else if impl_defs_cjson.has(name)
            tmp := impl_defs_cjson[name][0]
        else
            return ""
        argsT := tmp["argsT"]
        real_param := []
        defaults_flag := 0
        loop argsT.length
        {
            tmp2 := argsT[a_index - 1]
            tmp3 := [tmp2["name"].get(), tmp2["type"].get()]
            if tmp["defaults"].has(tmp3[1])
            {
                defaults_flag += 1
                tmp3.push(cimgui.defaults_eval(tmp["defaults"][tmp3[1]].get()))
            }
            real_param.push(tmp3)
        }
        if (param.length < argsT.length - defaults_flag) || (param.length > argsT.length)
            cimgui.warning .= name " input number of func is false`n"
        else
        {
            dllfunc := dllcall.bind("cimgui\" name)
            loop argsT.length
            {
                tmp_value := a_index > param.length ? cimgui.toahkvalue(real_param[a_index][3]) : param[a_index]
                real_bind := cimgui.toahktype(real_param[a_index][2], tmp_value)
                if real_bind.length && (instr(real_bind[1], "struct ") || instr(real_bind[1], "union "))
                {
                    if tmp_value is cimgui.struct
                        real_bind := tmp_value.struct.exportself()
                    else if tmp_value is struct
                        real_bind := tmp_value.exportself()
                    else if tmp_value is array
                        real_bind := tmp_value
                    else
                        real_bind[1] := "ptr"
                }
                dllfunc := dllfunc.bind(real_bind*)
            }
            ret := dllfunc()
            ret_type := tmp["ret"].get()
            if ret_type != "void" && !(ret_type is cJson.Null)
            {
                real_type := cimgui.toahktype(ret_type, "")
                if real_type[1] = "ptr"
                {
                    if real_type[2] is buffer
                        return strget(dllfunc("ptr"), , "utf-8")
                }
                return ret
            }
        }
    }
    
    static defaults_eval(_string)
    {
        if _string is number
            return _string
        else
        {
            _string := rtrim(_string, ")")
            array_string := strsplit(_string, "(", , 2)
            struct_name := trim(array_string[1])
            if array_string.length = 2
            {
                array_string := strsplit(array_string[2], ",")
                tmp_struct := cimgui.struct(struct_name, 0).struct
                for member in array_string
                {
                    tmp_value := trim(member)
                    tmp_value := isnumber(tmp_value) ? tmp_value : cimgui.%tmp_value%
                    tmp_struct[tmp_struct.exports[1][a_index]] := tmp_value
                }
                return tmp_struct
            }
            else
                return isnumber(struct_name) ? struct_name : cimgui.%struct_name%
        }
    }
    
    static simple_eval(expression)
    {
        if isnumber(expression)
            return integer(expression)
        else if instr(expression, "<<")
        {
            value := strsplit(expression, "<<")
            ret := trim(value[1])
            loop value.length - 1
                ret := ret << trim(value[a_index + 1])
            return ret
        }
        else if instr(expression, "|")
        {
            value := strsplit(expression, "|")
            ret := cimgui.%trim(value[1])%
            loop value.length - 1
                ret := ret | cimgui.%trim(value[a_index + 1])%
            return ret
        }
        else
            return ""
    }
    
    static sizeof(struct_name)
    {
        if const_cjson["structs"].has(struct_name)
            return cimgui.struct(struct_name, 0).struct.size
        else
            return struct.type_map.%cimgui.toahktype(struct_name, "")[1]%[2]
    }
    
    static toahktype(cimfunctype, value)
    {
        cimfunctype := trim(strreplace(cimfunctype, "const"))
        if const_cjson["enums"].has(cimfunctype)
            return ["int", value]
        if value is object && !(value is array)
            value := value.ptr
        if instr(cimfunctype, "struct ") || instr(cimfunctype, "union ")
            return [cimfunctype, value]
        if value = "nullptr" || value = "NULL"
            return []
        if (instr(cimfunctype, "*") && cimfunctype != "char*")
            return ["ptr", value]
        if cimfunctype = "char*"
            return ["ptr", cimgui.strBuffer(value)]
        map_type := 
        {
            bool: "char",
            char: "char",
            %"signed char"%: "char",
            %"unsigned char"%: "uchar",
            short: "short",
            %"signed short"%: "short",
            %"unsigned short"%: "ushort",
            int: "int",
            %"signed int"%: "int",
            %"unsigned int"%: "uint",
            long: "int",
            %"signed long"%: "int",
            %"unsigned long"%: "uint",
            size_t: "uint",
            float: "float",
            double: "double"
        }
        if !map_type.hasprop(cimfunctype)
        {
            if typedef_cjson.has(cimfunctype)
                return cimgui.toahktype(typedef_cjson[cimfunctype].get(), value)
            return []
        }
        return [map_type.%cimfunctype%, value]
    }
    
    static toahkvalue(cimfuncvalue)
    {
        if cimfuncvalue = "nullptr" || cimfuncvalue = "NULL" || cimfuncvalue is struct
            return cimfuncvalue
        else if substr(cimfuncvalue, -1) = "f"
            return float(rtrim(cimfuncvalue, "f"))
        else if substr(cimfuncvalue, -1) = "l"
            return integer(rtrim(cimfuncvalue, "l"))
        return cimfuncvalue
    }
    
    class struct
    {
        __new(name, ptr)
        {
            struct_array := cimgui.struct.get_struct_array(name)
            this.struct := struct(struct_array)
            this.ptr := ptr
        }
        
        __item[name, param*]
        {
            get
            {
                tmp := this.struct[name]
                if tmp = "" || this.ptr = 0
                    return ""
                tmp_addr := this.struct[name, "addr"]
                tmp_type := this.struct[name, "type"]
                tmp2 := tmp
                while tmp2 is struct
                {
                    if a_index > param.length
                        return tmp
                    tmp2 := tmp[param[a_index]]
                    tmp_addr += tmp[param[a_index], "addr"]
                    tmp_type := tmp[param[a_index], "type"]
                    tmp := tmp2
                }
                return numget(this.ptr, tmp_addr, tmp_type)
            }
            
            set
            {
                tmp := this.struct[name]
                if tmp = "" || this.ptr = 0
                    return ""
                tmp_addr := this.struct[name, "addr"]
                tmp_type := this.struct[name, "type"]
                tmp2 := tmp
                while tmp2 is struct
                {
                    if a_index > param.length
                        break
                    tmp2 := tmp[param[a_index]]
                    tmp_addr += tmp[param[a_index], "addr"]
                    tmp_type := tmp[param[a_index], "type"]
                    tmp := tmp2
                }
                if tmp2 is struct
                {
                    flag := false
                    if value is array
                    {
                        flag := true
                        put_array := value
                    }
                    else if value is struct
                    {
                        flag := true
                        put_array := value.exportself()
                    }
                    else if value is cimgui.struct
                    {
                        flag := true
                        put_array := value.struct.exportself()
                    }
                    if !flag
                        return
                    for key in tmp2.exports[2]
                    {
                        tmp := param.clone()
                        tmp.push(key)
                        this[name, tmp*] := put_array[a_index * 2]
                    }
                    return
                }
                return numput(tmp_type, value, this.ptr, tmp_addr)
            }
        }
        
        static get_struct_array(struct_name)
        {
            struct_array := []
            if const_cjson["structs"].has(struct_name)
            {
                tmp_array := const_cjson["structs"][struct_name]
                loop tmp_array.length
                {
                    tmp_object := tmp_array[a_index - 1]
                    tmp_name := tmp_object["name"].get()
                    tmp_size_flag := tmp_object.has("size")
                    tmp_type := tmp_object.has("template_type") ? tmp_object["template_type"].get() : tmp_object["type"].get()
                    if substr(tmp_type, 1, 5) = "union"
                        struct_array.push(["union", cimgui.struct.get_union_array(tmp_type)])
                    else
                    {
                        real_type := cimgui.toahktype(tmp_type, "")[1]
                        if substr(real_type, 1, 7) = "struct "
                            struct_array.push(["struct", tmp_name, cimgui.struct.get_struct_array(substr(real_type, 8))])
                        else
                            struct_array.push([real_type, tmp_name])
                        if tmp_size_flag
                            struct_array[-1].push({size: integer(tmp_object["size"].get())})
                    }
                }
            }
            return struct_array
        }
        
        static get_union_array(union_string)
        {
            struct_array := []
            union_array := union.eval(union_string)
            for member in union_array
            {
                real_type := cimgui.toahktype(member[1], "")[1]
                if substr(real_type, 1, 7) = "struct "
                    struct_array.push(["struct", member[2], cimgui.struct.get_struct_array(substr(real_type, 8))])
                else
                    struct_array.push([real_type, member[2]])
            }
            return struct_array
        }
    }
}

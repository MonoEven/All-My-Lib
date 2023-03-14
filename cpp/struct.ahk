#Include <cpp\cstring>
#Include <cpp\malloc>

class struct
{
    static encoding := "utf-8"
    static warningFlag := false
    
    static type_map := map(
        "__int8", ["char", 1],
        "__int16", ["short", 2],
        "__int32", ["int", 4],
        "__int64", ["int64", 8],
        "bool", ["char", 1],
        "byte", ["char", 1],
        "char", ["char", 1],
        "double", ["double", 8],
        "error_status_t", ["uint", 4],
        "float", ["float", 4],
        "int", ["int", 4],
        "int8_t", ["char", 1],
        "int16_t", ["short", 2],
        "int32_t", ["int", 4],
        "int64_t", ["int64", 8],
        "long", ["int", 4],
        "long long", ["int64", 8],
        "short", ["short", 2],
        "signed char", ["char", 1],
        "signed int", ["int", 4],
        "signed short", ["short", 2],
        "signed long", ["int", 4],
        "signed __int64", ["int64", 8],
        "ptr", ["ptr", a_ptrsize],
        "size_t", ["uptr", a_ptrsize],
        "uint8_t", ["uchar", 1],
        "uint16_t", ["ushort", 2],
        "uint32_t", ["uint", 4],
        "uint64_t", ["uint64", 8],
        "unsigned", ["uint", 4],
        "unsigned __int64", ["uint64", 8],
        "unsigned char", ["uchar", 1],
        "unsigned int", ["uint", 4],
        "unsigned long", ["uint", 4],
        "unsigned short", ["ushort", 2],
        "wchar_t", ["ushort", 2],
        "BOOL", ["int", 4],
        "BOOLEAN", ["uchar", 1],
        "BSTR", ["ptr", a_ptrsize],
        "BYTE", ["uchar", 1],
        "CHAR", ["char", 1],
        "FLOAT", ["float", 4],
        "DOUBLE", ["double", 8],
        "DWORD", ["uint", 4],
        "DWORD_PTR", ["ptr", a_ptrsize],
        "DWORD32", ["uint", 4],
        "DWORD64", ["uint64", 8],
        "DWORDLONG", ["uint64", 8],
        "HANDLE", ["ptr", a_ptrsize],
        "HCALL", ["uint", 4],
        "HRESULT", ["int", 4],
        "INT", ["int", 4],
        "INT8", ["char", 1],
        "INT16", ["short", 2],
        "INT32", ["int", 4],
        "LDAP_UDP_HANDLE", ["ptr", a_ptrsize],
        "LMCSTR", ["ushort", 2],
        "LONG", ["int", 4],
        "LONG_PTR", ["ptr", a_ptrsize],
        "LONG32", ["int", 4],
        "LONG64", ["int64", 8],
        "LONGLONG", ["int64", 8],
        "LPCSTR", ["ptr", a_ptrsize],
        "LPCVOID", ["ptr", a_ptrsize],
        "LPCWSTR", ["ushort", 2],
        "LPSTR", ["ptr", a_ptrsize],
        "LPTSTR", ["ptr", a_ptrsize],
        "LPCTSTR", ["ptr", a_ptrsize],
        "NET_API_STATUS", ["uint", 4],
        "NTSTATUS", ["int", 4],
        "QWORD", ["uint64", 8],
        "RPC_BINDING_HANDLE", ["ptr", a_ptrsize],
        "SHORT", ["short", 2],
        "SIZE_T", ["uptr", a_ptrsize],
        "STRING", ["ptr", a_ptrsize],
        "UCHAR", ["uchar", 1],
        "UINT", ["uint", 4],
        "UINT8", ["uchar", 1],
        "UINT16", ["ushort", 2],
        "UINT32", ["uint", 4],
        "UINT64", ["uint64", 8],
        "ULONG", ["uint", 4],
        "ULONG_PTR", ["uptr", a_ptrsize],
        "ULONG32", ["uint", 4],
        "ULONG64", ["uint64", 8],
        "ULONGLONG", ["uint64", 8],
        "USHORT", ["ushort", 2],
        "UNICODE", ["ushort", 2],
        "VOID", ["ptr", a_ptrsize],
        "WCHAR", ["ushort", 2],
        "WORD", ["ushort", 2])
    
    __new(ptr := 0, member_array := [], type_map := map(), default_value := map())
    {
        this.warning := ""
        if ptr is array
        {
            this.ptr := 0
            this.members := ptr
            this.type_map := (member_array is map) ? member_array : type_map
        }
        else if ptr is string
        {
            this.ptr := 0
            tmp := struct.eval(ptr)
            this.members := tmp[1]
            default_value := tmp[2]
            this.type_map := (member_array is map) ? member_array : type_map
        }
        else
        {
            this.ptr := ptr
            this.members := member_array is string ? struct.eval(member_array) : member_array
            this.type_map := type_map
        }
        this.exports := [[],[]]
        for member in this.members
        {
            if member[1] = "struct" || member[1] = "union"
                get_type := member[1]
            else
                get_type := this.type_map.has(member[1]) ? this.type_map[member[1]][1] : struct.type_map.has(member[1]) ? struct.type_map[member[1]][1] : "ptr"
            this.exports[1].push(get_type)
            this.exports[2].push(member[2])
        }
        this.addr := this.align()
        this.members := this.rebuild()
        this.size := this.addr.pop()
        if !this.ptr
        {
            this.ptr := malloc.malloc(this.size)
            cstring.memset(this.ptr, 0, this.size)
        }
        for key, value in default_value
            this[key] := value
    }
    
    __delete()
    {
        if this.ptr
            malloc.free(this.ptr)
    }
    
    __item[name, param*]
    {
        get
        {
            if !(name is array) && instr(name, ".")
                name := strsplit(name, ".")
            if name is array && param.length && param[1] = "addr"
            {
                total_addr := 0
                tmp := this
                loop name.length - 1
                {
                    total_addr += tmp[name[a_index], "addr"]
                    tmp := tmp[name[a_index]]
                }
                return total_addr + tmp[name[-1], param*]
            }
            else if name is array
            {
                tmp := this
                loop name.length - 1
                    tmp := tmp[name[a_index]]
                return tmp[name[-1], param*]
            }
            if this.members.has(name)
            {
                member := this.members[name]
                size := 1
                get_type := this.type_map.has(member[1]) ? this.type_map[member[1]] : struct.type_map.has(member[1]) ? struct.type_map[member[1]] : ["ptr", 8]
                if param.length
                {
                    if param[1] = "type"
                        return get_type[1]
                    if param[-1] is integer
                        size := member[2].hasprop("size") ? param[-1] + 1 : 1
                    if param[1] = "addr"
                        return (size = 1 || !member[2].hasprop("size")) ? member[-1] : member[-1] + (size - 1) * get_type[2]
                }
                if member[1] = "struct" || member[1] = "union"
                    return (size = 1 && !member[2].hasprop("size")) ? (member[2].%member[1]%) : (member[2].%member[1]%)[size]
                return numget(this.ptr, member[-1] + (size - 1) * get_type[2], get_type[1])
            }
            else if this.members.has("")
            {
                member := this.members[""]
                if member[1] = "union"
                {
                    if param.length && param[1] = "addr"
                    {
                        ret := member[2].union[name, param*]
                        if !(ret = "")
                            return ret + member[-1]
                    }
                    return member[2].union[name, param*]
                }
            }
        }
        
        set
        {
            if !(name is array) && instr(name, ".")
                name := strsplit(name, ".")
            if name is array
            {
                tmp := this
                loop name.length - 1
                    tmp := tmp[name[a_index]]
                tmp[name[-1], param*] := value
                return
            }
            if !isnumber(value) && value is string
                value := cextra.strBuffer(value).ptr
            if this.members.has(name)
            {
                member := this.members[name]
                size := 1
                if param.length && param[-1] is integer
                    size := member[2].hasprop("size") ? param[-1] + 1 : 1
                if member[1] = "struct" || member[1] = "union"
                    return
                get_type := this.type_map.has(member[1]) ? this.type_map[member[1]] : struct.type_map.has(member[1]) ? struct.type_map[member[1]] : ["ptr", 8]
                return numput(get_type[1], value, member[-1] + (size - 1) * get_type[2], this.ptr)
            }
            else if this.members.has("")
            {
                member := this.members[""]
                if member[1] = "union"
                    return member[2].union[name, param] := value
            }
        }
    }
    
    align()
    {
        this.max_align := 0
        old_addr := addr := 0
        addr_array := []
        for member in this.members
        {
            type_map := this.type_map.has(member[1]) ? this.type_map : struct.type_map.has(member[1]) ? struct.type_map : ""
            if type_map
            {
                old_addr := addr
                type_size := type_map[member[1]][2]
                addr := struct.find_nearmul(addr, type_size)
                addr_array.push(addr)
                tmp_size := (member.length >= 3 && member[3].hasprop("size")) ? member[3].size : 1
                addr += type_size * tmp_size
                this.max_align := max(this.max_align, type_size)
            }
            else if instr(member[1], "*")
            {
                old_addr := addr
                type_size := a_ptrsize
                addr := struct.find_nearmul(addr, type_size)
                addr_array.push(addr)
                tmp_size := (member.length >= 3 && member[3].hasprop("size")) ? member[3].size : 1
                addr += type_size * tmp_size
                this.max_align := max(this.max_align, type_size)
            }
            else if member[1] = "struct"
            {
                struct_flag := member[3] is struct
                tmp_struct := !struct_flag ? struct(0, member[3], this.type_map) : member[3]
                old_addr := addr
                type_size := tmp_struct.max_align
                addr := struct.find_nearmul(addr, type_size)
                addr_array.push(addr)
                if (member.length >= 4 && member[4].hasprop("size"))
                {
                    tmp_array := [tmp_struct]
                    tmp_size := member[4].size
                    loop tmp_size - 1
                        tmp_array.push(!struct_flag ? struct(0, member[3], this.type_map) : (ptr := malloc.malloc(member[3].size), cstring.memset(ptr, 0, member[3].size), tmp := member[3].clone(), tmp.ptr := ptr, tmp))
                    member[3] := tmp_array
                    addr += tmp_struct.size * tmp_size
                }
                else
                {
                    member[3] := tmp_struct
                    addr += tmp_struct.size
                }
            }
            else if member[1] = "union"
            {
                if !(member[2] is string)
                    member.insertat(2, "")
                union_flag := member[3] is union
                tmp_union := !union_flag ? union(member[3], this.type_map) : member[3]
                old_addr := addr
                type_size := tmp_union.max_align
                addr := struct.find_nearmul(addr, type_size)
                addr_array.push(addr)
                if false ; (member.length >= 4 && member[4].hasprop("size"))
                {
                    tmp_array := [tmp_union]
                    tmp_size := member[4].size
                    loop tmp_size - 1
                        tmp_array.push(!union_flag ? union(member[3], this.type_map) : (ptr := malloc.malloc(member[3].size), cstring.memset(ptr, 0, member[3].size), tmp := member[3].clone(), tmp.ptr := ptr, tmp))
                    member[3] := tmp_array
                    addr += tmp_union.size * tmp_size
                }
                else
                {
                    member[3] := tmp_union
                    addr += tmp_union.size
                }
            }
            else
            {
                old_addr := addr
                type_size := a_ptrsize
                addr := struct.find_nearmul(addr, type_size)
                addr_array.push(addr)
                tmp_size := (member.length >= 3 && member[3].hasprop("size")) ? member[3].size : 1
                addr += type_size * tmp_size
                this.max_align := max(this.max_align, type_size)
                this.warning .= "type " member[1] " auto analysis as ptr.`n"
            }
        }
        addr_array.push(struct.find_nearmul(addr, this.max_align))
        return addr_array
    }
    
    export(values*)
    {
        export_array := []
        for value in this.exports[1]
        {
            try
                get_value := values[a_index]
            catch
                get_value := "nullptr"
            if get_value is array
            {
                if get_value[1] is struct
                {
                    tmp := get_value.clone()
                    tmp_struct := tmp.removeat(1)
                    export_array.push(tmp_struct.export(tmp*)*)
                }
                else
                    export_array.push(get_value*)
            }
            else if !(get_value = "nullptr")
                export_array.push(value, get_value)
        }
        return export_array
    }
    
    exportname()
    {
        warning := ""
        export_array := []
        index := 1
        for value in this.exports[1]
        {
            if value = "struct"
            {
                struct_name := this.exports[2][index++]
                tmp_array := this[struct_name].exportname()
                loop tmp_array.length
                    tmp_array[a_index] := struct_name "." tmp_array[a_index]
                export_array.push(tmp_array*)
            }
            else if value = "union"
                warning .= "union " this.exports[2][index++] " has been passed.`n"
            else
                export_array.push(this.exports[2][index++])
        }
        if warning && struct.warningFlag
            msgbox warning
        return export_array
    }
    
    exportself()
    {
        warning := ""
        export_array := []
        for value in this.exports[1]
        {
            if value = "struct"
                export_array.push(this[this.exports[2][a_index]].exportself()*)
            else if value = "union"
                warning .= "union " this.exports[2][a_index] " has been passed.`n"
            else
                export_array.push(value, this[this.exports[2][a_index]])
        }
        if warning && struct.warningFlag
            msgbox warning
        return export_array
    }
    
    rebuild()
    {
        members := map()
        for member in this.members
        {
            if member[1] = "struct" || member[1] = "union"
            {
                members[member[2]] := [member[1], {%strlower(member[1])%: member[3]}, this.addr[a_index]]
                if (member.length >= 4 && member[4].hasprop("size")) && member[1] != "union"
                    members[member[2]][2].size := member[4].size
            }
            else
            {
                members[member[2]] := [member[1], {}, this.addr[a_index]]
                if (member.length >= 3 && member[3].hasprop("size"))
                    members[member[2]][2].size := member[3].size
            }
        }
        return members
    }
    
    static eval(_string, mode := "struct")
    {
        _string := strreplace(_string, ",", ";,")
        blank_flag := " "
        dot_flag := ","
        tab_flag := "`t"
        end_flag := ";"
        equal_flag := "="
        star_flag := "*"
        lbracket1_flag := "["
        rbracket1_flag := "]"
        lbracket2_flag := "{"
        rbracket2_flag := "}"
        last_type := ""
        tmp_type := ""
        tmp_name := ""
        tmp_size := ""
        tmp_blank_flag := false
        tmp_struct_flag := false
        tmp_union_flag := false
        tmp_size_flag := false
        tmp_pass_flag := false
        tmp_default_value_flag := false
        bracket_num := 0
        _string := trim(strreplace(_string, "`n"))
        eval_array := []
        tmp_default_value := ""
        tmp_struct_array := []
        tmp_union_array := []
        tmp_pass_string := ""
        default_value := map()
        if (substr(_string, 1, strlen(mode)) = mode || substr(_string, 1, 1) = "{")
        {
            pop_length := 0
            if substr(_string, -1) = "}"
            {
                _string := substr(_string, instr(_string, "{") + 1)
                pop_length := 1
            }
            else if substr(_string, -2) = "};"
            {
                _string := substr(_string, instr(_string, "{") + 1)
                pop_length := 2
            }
            if pop_length
                _string := substr(_string, 1, strlen(_string) - pop_length)
        }
        loop parse _string
        {
            if tmp_pass_flag
            {
                tmp_pass_string .= a_loopfield
                switch a_loopfield
                {
                    case lbracket2_flag:
                        bracket_num++
                    case rbracket2_flag:
                        bracket_num--
                }
                if !bracket_num
                {
                    if tmp_struct_flag
                    {
                        tmp := struct.eval(tmp_pass_string)
                        tmp_struct_array := tmp[1]
                        for key, value in tmp[2]
                        {
                            if key is array
                                default_value[[tmp_name, key*]] := value
                            else
                                default_value[[tmp_name, key]] := value
                        }
                    }
                    else if tmp_union_flag
                        tmp_union_array := union.eval(tmp_pass_string)[1]
                    tmp_pass_flag := false
                }
                continue
            }
            switch a_loopfield
            {
                case dot_flag:
                {
                    tmp_type := last_type
                }
                case equal_flag:
                {
                    tmp_name := strsplit(tmp_type, " ")[-1]
                    tmp_type := trim(substr(tmp_type, 1, strlen(tmp_type) - strlen(tmp_name)))
                    tmp_default_value_flag := true
                }
                case lbracket1_flag:
                {
                    tmp_size_flag := true
                }
                case rbracket1_flag:
                {
                    tmp_size_flag := false
                }
                case lbracket2_flag:
                {
                    tmp := strsplit(trim(tmp_type), " ", , 2)
                    tmp_type := tmp[1]
                    if tmp_type = "struct"
                        tmp_struct_flag := true
                    else if tmp_type = "union"
                        tmp_union_flag := true
                    tmp_name := tmp.length = 2 ? tmp[2] : ""
                    tmp_pass_flag := true
                    tmp_pass_string .= "{"
                    bracket_num++
                }
                case blank_flag, tab_flag:
                {
                    if tmp_blank_flag || !tmp_type
                        continue
                    tmp_blank_flag := true
                    tmp_type .= " "
                }
                case end_flag:
                {
                    if tmp_struct_flag
                    {
                        push_array := [tmp_type, tmp_name, tmp_struct_array]
                        try
                        {
                            tmp_size := integer(tmp_size)
                            if tmp_size
                                push_array.push({size: tmp_size})
                        }
                        eval_array.push(push_array)
                        tmp_struct_flag := false
                        tmp_struct_array := []
                    }
                    else if tmp_union_flag
                    {
                        push_array := [tmp_type, tmp_name, tmp_union_array]
                        try
                        {
                            tmp_size := integer(tmp_size)
                            if tmp_size
                                push_array.push({size: tmp_size})
                        }
                        eval_array.push(push_array)
                        tmp_union_flag := false
                        tmp_union_array := []
                    }
                    else
                    {
                        tmp_type := trim(tmp_type)
                        if !tmp_name
                        {
                            if instr(tmp_type, "*")
                                tmp_type := strreplace(strreplace(tmp_type, "* ", "*"), "*", "* ")
                            tmp_name := strsplit(tmp_type, " ")[-1]
                            tmp_type := trim(substr(tmp_type, 1, strlen(tmp_type) - strlen(tmp_name)))
                        }
                        push_array := [tmp_type, tmp_name]
                        try
                        {
                            tmp_size := integer(tmp_size)
                            if tmp_size
                                push_array.push({size: tmp_size})
                        }
                        eval_array.push(push_array)
                    }
                    if tmp_default_value_flag && !tmp_struct_flag && !tmp_union_flag
                    {
                        if instr(tmp_default_value, ".")
                        {
                            try
                            {
                                tmp_default_value := float(tmp_default_value)
                                default_value[tmp_name] := tmp_default_value
                            }
                        }
                        else
                        {
                            try
                            {
                                tmp_default_value := integer(tmp_default_value)
                                default_value[tmp_name] := tmp_default_value
                            }
                        }
                        tmp_default_value := ""
                        tmp_default_value_flag := false
                    }
                    last_type := tmp_type
                    tmp_type := ""
                    tmp_name := ""
                    tmp_size := ""
                    tmp_blank_flag := false
                    tmp_pass_string := ""
                }
                default:
                {
                    if tmp_size_flag
                        tmp_size .= a_loopfield
                    else if tmp_default_value_flag
                        tmp_default_value .= a_loopfield
                    else
                    {
                        if tmp_blank_flag
                        {
                            if a_loopfield = "*"
                                tmp_type := trim(tmp_type)
                            tmp_blank_flag := false
                        }
                        else if tmp_struct_flag || tmp_union_flag
                            continue
                        tmp_type .= a_loopfield
                    }
                }
            }
        }
        return [eval_array, default_value]
    }
    
    static find_nearmul(a, b)
    {
        while true
        {
            if mod(a, b) = 0
                return a
            a++
        }
    }
    
    ; Gui Part
    static add_typemap(struct_gui)
    {
        path := fileselect(, , "please select a standard type_map file")
        if !path
            return
        loop read path
        {
            tmp := trim(a_loopreadline)
            if (flag := strsplit(tmp, " "), flag.length) >= 3
            {
                tmp_type := flag[-2]
                tmp_value := flag[-1]
                tmp := trim(substr(tmp, 1, strlen(tmp) - strlen(tmp_value)))
                tmp := trim(substr(tmp, 1, strlen(tmp) - strlen(tmp_type)))
                struct_gui.type_map[tmp] := [tmp_type, integer(tmp_value)]
            }
        }
    }
    
    static get_struct(struct_gui)
    {
        if !struct_gui["EditBox"].Text
            struct_gui["ResultBox"].Text := ""
        else
        {
            try
            {
                _struct := struct(struct_gui["EditBox"].Value, struct_gui.type_map)
                _retv1 := format("; v1`nvarsetcapacity(tmp_struct, {}, 0)`n`n", _struct.size)
                _retv2 := format("; v2`ntmp_struct := buffer({}, 0)`n`n", _struct.size)
                output_array := _struct.exportself()
                numget_check := struct_gui["NumGetCheck"].Value
                numput_check := struct_gui["NumPutCheck"].Value
                version := struct_gui["Version"].Text
                for name in _struct.exportname()
                {
                    addr := instr(name, ".") ? _struct[strsplit(name, "."), "addr"] : _struct[name, "addr"]
                    if numget_check
                    {
                        if version = "v1"
                            _retv1 .= format("; numget(tmp_struct, {}, `"{}`") `; {}`n", addr, output_array[a_index * 2 - 1], name)
                        else
                            _retv2 .= format("; numget(tmp_struct, {}, `"{}`") `; {}`n", addr, output_array[a_index * 2 - 1], name)
                    }
                    if numput_check
                    {
                        if version = "v1"
                            _retv1 .= format("; numput({}, tmp_struct, {}, `"{}`") `; {}`n", output_array[a_index * 2 - 1], output_array[a_index * 2], addr, name)
                        else
                            _retv2 .= format("; numput(`"{}`", {}, tmp_struct, {}) `; {}`n", output_array[a_index * 2 - 1], output_array[a_index * 2], addr, name)
                    }
                }
                struct_gui["ResultBox"].Value := version = "v1" ? _retv1 : _retv2
            }
            catch
            {
                struct_gui["ResultBox"].Text := "invalid struct"
                throw
            }
        }
    }
    
    static gui()
    {
        struct_gui := gui()
        struct_gui.type_map := map()
        struct_gui.setfont("s11","MicroSoft YaHei")
        struct_gui.add("button", "vClearButton x5 y5", "Clear All").OnEvent("Click", (*) => (struct_gui["EditBox"].Text := "", struct_gui["ResultBox"].Text := ""))
        struct_gui.add("button", "vAddButton yp x+2", "Add TypeMap").OnEvent("Click", (*) => this.add_typemap(struct_gui))
        struct_gui.add("button", "vClearTypeMapButton yp x+3", "Clear TypeMap").OnEvent("Click", (*) => struct_gui.type_map := map())
        struct_gui.add("text", "xs", "please input struct here")
        struct_gui.add("edit", "vEditBox xs w600 h300")
        struct_gui.add("checkbox", "vNumGetCheck xp y+1 h25", "numget")
        struct_gui.add("checkbox", "vNumPutCheck yp x+1 h25", "numput")
        struct_gui.add("dropdownlist", "vVersion yp x+1 w100 Choose1", ["v1", "v2"])
        struct_gui.add("button", "vGetButton yp x+2 h25", "Get Result").OnEvent("Click", (*) => this.get_struct(struct_gui))
        struct_gui.add("text", "xs", "copy result here")
        struct_gui.add("edit", "vResultBox xs w600 h300 ReadOnly")
        struct_gui.show()
        return struct_gui
    }
}

class union
{
    static encoding := "utf-8"
    
    __new(member_array := [], type_map := map())
    {
        this.warning := ""
        this.members := member_array is string ? union.eval(member_array)[1] : member_array
        this.type_map := type_map
        this.align()
        this.members := this.rebuild()
        this.size := this.max_align
        this.ptr := malloc.malloc(this.size)
        cstring.memset(this.ptr, 0, this.size)
    }
    
    __delete()
    {
        if this.ptr
            malloc.free(this.ptr)
    }
    
    __item[name, param*]
    {
        get
        {
            if !(name is array) && instr(name, ".")
                name := strsplit(name, ".")
            if name is array && param.length && param[1] = "addr"
            {
                total_addr := 0
                tmp := this
                loop name.length - 1
                {
                    total_addr += tmp[name[a_index], "addr"]
                    tmp := tmp[name[a_index]]
                }
                return total_addr + tmp[name[-1], param*]
            }
            else if name is array
            {
                tmp := this
                loop name.length - 1
                    tmp := tmp[name[a_index]]
                return tmp[name[-1], param*]
            }
            if this.members.has(name)
            {
                member := this.members[name]
                size := 1
                get_type := this.type_map.has(member[1]) ? this.type_map[member[1]] : struct.type_map.has(member[1]) ? struct.type_map[member[1]] : ["ptr", 8]
                if param.length
                {
                    if param[1] = "type"
                        return get_type[1]
                    if param[-1] is integer
                        size := member[2].hasprop("size") ? param[-1] + 1 : 1
                    if param[1] = "addr"
                        return (size = 1 || !member[2].hasprop("size")) ? member[-1] : member[-1] + (size - 1) * get_type[2]
                }
                if member[1] = "struct" || member[1] = "union"
                    return (size = 1 && !member[2].hasprop("size")) ? (member[2].%member[1]%) : (member[2].%member[1]%)[size]
                return numget(this.ptr, member[-1] + (size - 1) * get_type[2], get_type[1])
            }
        }
        
        set
        {
            if !(name is array) && instr(name, ".")
                name := strsplit(name, ".")
            if name is array
            {
                tmp := this
                loop name.length - 1
                    tmp := tmp[name[a_index]]
                tmp[name[-1], param*] := value
                return
            }
            if !isnumber(value) && value is string
                value := cextra.strBuffer(value, union.encoding).ptr
            if this.members.has(name)
            {
                member := this.members[name]
                size := 1
                if param.length && param[-1] is integer
                    size := member[2].hasprop("size") ? param[-1] + 1 : 1
                if member[1] = "struct" || member[1] = "union"
                    return
                get_type := this.type_map.has(member[1]) ? this.type_map[member[1]] : struct.type_map.has(member[1]) ? struct.type_map[member[1]] : ["ptr", 8]
                return numput(get_type[1], value, member[-1] + (size - 1) * get_type[2], this.ptr)
            }
        }
    }
    
    align()
    {
        max_size := 0
        this.max_align := 0
        for member in this.members
        {
            type_map := this.type_map.has(member[1]) ? this.type_map : struct.type_map.has(member[1]) ? struct.type_map : ""
            if type_map
            {
                type_size := type_map[member[1]][2]
                this.max_align := max(this.max_align, type_size)
                tmp_size := (member.length >= 3 && member[3].hasprop("size")) ? member[3].size : 1
                max_size := max(max_size, type_size * tmp_size)
            }
            else if instr(member[1], "*")
            {
                type_size := a_ptrsize
                this.max_align := max(this.max_align, type_size)
                tmp_size := (member.length >= 3 && member[3].hasprop("size")) ? member[3].size : 1
                max_size := max(max_size, type_size * tmp_size)
            }
            else if member[1] = "struct"
            {
                struct_flag := member[3] is struct
                tmp_struct := !struct_flag ? struct(0, member[3], this.type_map) : member[3]
                type_size := tmp_struct.max_align
                this.max_align := max(this.max_align, type_size)
                if (member.length >= 4 && member[4].hasprop("size"))
                {
                    tmp_array := [tmp_struct]
                    tmp_size := member[4].size
                    loop tmp_size - 1
                        tmp_array.push(!struct_flag ? struct(0, member[3], this.type_map) : (buf := buffer(member[3].size, 0), tmp := member[3].clone(), tmp.ptr := buf.ptr, tmp))
                    member[3] := tmp_array
                    max_size := max(max_size, tmp_struct.size * tmp_size)
                }
                else
                {
                    member[3] := tmp_struct
                    max_size := max(max_size, tmp_struct.size)
                }
            }
            else if member[1] = "union"
            {
                if !(member[2] is string)
                    member.insertat(2, "")
                union_flag := member[3] is union
                tmp_union := !union_flag ? union(member[3], this.type_map) : member[3]
                type_size := tmp_union.max_align
                this.max_align := max(this.max_align, type_size)
                if false ; (member.length >= 4 && member[4].hasprop("size"))
                {
                    tmp_array := [tmp_union]
                    tmp_size := member[4].size
                    loop tmp_size - 1
                        tmp_array.push(!union_flag ? union(member[3], this.type_map) : (buf := buffer(member[3].size, 0), tmp := member[3].clone(), tmp.ptr := buf.ptr, tmp))
                    member[3] := tmp_array
                    max_size := max(max_size, tmp_union.size * tmp_size)
                }
                else
                {
                    member[3] := tmp_union
                    max_size := max(max_size, tmp_union.size)
                }
            }
            else
            {
                type_size := a_ptrsize
                this.max_align := max(this.max_align, type_size)
                tmp_size := (member.length >= 3 && member[3].hasprop("size")) ? member[3].size : 1
                max_size := max(max_size, type_size * tmp_size)
                this.warning .= "type " member[1] " auto analysis as ptr.`n"
            }
        }
        this.max_align := struct.find_nearmul(max_size, this.max_align)
    }
    
    rebuild()
    {
        members := map()
        for member in this.members
        {
            if member[1] = "struct" || member[1] = "union"
            {
                members[member[2]] := [member[1], {%strlower(member[1])%: member[3]}, 0]
                if (member.length >= 4 && member[4].hasprop("size")) && member[1] != "union"
                    members[member[2]][2].size := member[4].size
            }
            else
            {
                members[member[2]] := [member[1], {}, 0]
                if (member.length >= 3 && member[3].hasprop("size"))
                    members[member[2]][2].size := member[3].size
            }
        }
        return members
    }
    
    static eval(_string, mode := "union")
    {
        return struct.eval(_string, mode)
    }
}
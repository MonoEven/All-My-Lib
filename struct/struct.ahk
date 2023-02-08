class struct
{
    static encoding := "utf-8"
    
    static type_map :=
    {
        bool: ["char", 1],
        char: ["char", 1],
        %"signed char"%: ["char", 1],
        uchar: ["uchar", 1],
        %"unsigned char"%: ["uchar", 1],
        short: ["short", 2],
        %"signed short"%: ["short", 2],
        ushort: ["ushort", 2],
        %"unsigned short"%: ["ushort", 2],
        int: ["int", 4],
        %"signed int"%: ["int", 4],
        uint: ["uint", 4],
        %"unsigned int"%: ["uint", 4],
        long: ["int", 4],
        %"signed long"%: ["int", 4],
        %"unsigned long"%: ["uint", 4],
        size_t: ["uint", 4],
        float: ["float", 4],
        double: ["double", 8],
        ptr: ["ptr", 8]
    }
    
    static strBuffer(str, encoding := "utf-8")
    {
        buf := buffer(strput(str, encoding))
        strput(str, buf, encoding)
        return buf
    }
    
    __new(ptr := 0, member_array := [], type_map := {})
    {
        this.warning := ""
        if ptr is array
        {
            this.ptr := 0
            this.members := ptr
            this.type_map := (member_array is object) ? member_array : type_map
        }
        else if ptr is string
        {
            this.ptr := 0
            this.members := struct.eval(ptr)
            this.type_map := (member_array is object) ? member_array : type_map
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
                get_type := this.type_map.hasprop(member[1]) ? this.type_map.%member[1]%[1] : struct.type_map.hasprop(member[1]) ? struct.type_map.%member[1]%[1] : "ptr"
            this.exports[1].push(get_type)
            this.exports[2].push(member[2])
        }
        this.addr := this.align()
        this.members := this.rebuild()
        this.size := this.addr.pop()
        if !this.ptr
        {
            this.buf := buffer(this.size)
            this.ptr := this.buf.ptr
        }
    }
    
    __item[name, param*]
    {
        get
        {
            if this.members.has(name)
            {
                member := this.members[name]
                size := 1
                get_type := this.type_map.hasprop(member[1]) ? this.type_map.%member[1]% : struct.type_map.hasprop(member[1]) ? struct.type_map.%member[1]% : ["ptr", 8]
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
            if !isnumber(value) && value is string
                value := struct.strBuffer(value).ptr
            if this.members.has(name)
            {
                member := this.members[name]
                size := 1
                if param.length && param[-1] is integer
                    size := member[2].hasprop("size") ? param[-1] + 1 : 1
                if member[1] = "struct" || member[1] = "union"
                    return
                get_type := this.type_map.hasprop(member[1]) ? this.type_map.%member[1]% : struct.type_map.hasprop(member[1]) ? struct.type_map.%member[1]% : ["ptr", 8]
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
            type_map := this.type_map.hasprop(member[1]) ? this.type_map : struct.type_map.hasprop(member[1]) ? struct.type_map : ""
            if type_map
            {
                old_addr := addr
                type_size := type_map.%member[1]%[2]
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
                        tmp_array.push(!struct_flag ? struct(0, member[3], this.type_map) : (buf := buffer(member[3].size), tmp := member[3].clone(), tmp.buf := buf, tmp.ptr := buf.ptr, tmp))
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
                        tmp_array.push(!union_flag ? union(member[3], this.type_map) : (buf := buffer(member[3].size), tmp := member[3].clone(), tmp.buf := buf, tmp.ptr := buf.ptr, tmp))
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
        if warning
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
    
    static eval(_string)
    {
        _string := regexreplace(_string, " +", " ")
        _string := strreplace(_string, " *", "* ")
        _string := strreplace(_string, "*", "* ")
        _string := strreplace(_string, "unsigned ", "u")
        _string := regexreplace(_string, "(\n)+|(\r)+")
        if substr(_string, 1, 6) = "struct"
            _string := substr(_string, 7)
        _string := trim(rtrim(ltrim(trim(_string), "{"), "}"))
        struct_array := []
        lst_string := strsplit(_string, ";")
        if lst_string.length && !lst_string[-1]
            lst_string.pop()
        for member in lst_string
        {
            tmp_array := strsplit(regexreplace(strreplace(trim(rtrim(trim(member), "]")), "[", " "), " +", " "), " ")
            if tmp_array.length = 3
                tmp_array[3] := {size: tmp_array[3]}
            struct_array.push(tmp_array)
        }
        return struct_array
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
}

class union
{
    static encoding := "utf-8"
    
    __new(member_array := [], type_map := {})
    {
        this.warning := ""
        this.members := member_array is string ? union.eval(member_array) : member_array
        this.type_map := type_map
        this.align()
        this.members := this.rebuild()
        this.size := this.max_align
        this.buf := buffer(this.size)
        this.ptr := this.buf.ptr
    }
    
    __item[name, param*]
    {
        get
        {
            if this.members.has(name)
            {
                member := this.members[name]
                size := 1
                get_type := this.type_map.hasprop(member[1]) ? this.type_map.%member[1]% : struct.type_map.hasprop(member[1]) ? struct.type_map.%member[1]% : ["ptr", 8]
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
            if !isnumber(value) && value is string
                value := struct.strBuffer(value, union.encoding).ptr
            if this.members.has(name)
            {
                member := this.members[name]
                size := 1
                if param.length && param[-1] is integer
                    size := member[2].hasprop("size") ? param[-1] + 1 : 1
                if member[1] = "struct" || member[1] = "union"
                    return
                get_type := this.type_map.hasprop(member[1]) ? this.type_map.%member[1]% : struct.type_map.hasprop(member[1]) ? struct.type_map.%member[1]% : ["ptr", 8]
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
            type_map := this.type_map.hasprop(member[1]) ? this.type_map : struct.type_map.hasprop(member[1]) ? struct.type_map : ""
            if type_map
            {
                type_size := type_map.%member[1]%[2]
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
                        tmp_array.push(!struct_flag ? struct(0, member[3], this.type_map) : (buf := buffer(member[3].size), tmp := member[3].clone(), tmp.ptr := buf.ptr, tmp))
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
                        tmp_array.push(!union_flag ? union(member[3], this.type_map) : (buf := buffer(member[3].size), tmp := member[3].clone(), tmp.ptr := buf.ptr, tmp))
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
    
    static eval(_string)
    {
        _string := regexreplace(_string, " +", " ")
        _string := strreplace(_string, " *", "* ")
        _string := strreplace(_string, "*", "* ")
        _string := strreplace(_string, "unsigned ", "u")
        _string := regexreplace(_string, "(\n)+|(\r)+")
        if substr(_string, 1, 5) = "union"
            _string := substr(_string, 6)
        _string := trim(rtrim(ltrim(trim(_string), "{"), "}"))
        union_array := []
        lst_string := strsplit(_string, ";")
        if lst_string.length && !lst_string[-1]
            lst_string.pop()
        for member in lst_string
        {
            tmp_array := strsplit(regexreplace(strreplace(trim(rtrim(trim(member), "]")), "[", " "), "( )+", " "), " ")
            if tmp_array.length = 3
                tmp_array[3] := {size: tmp_array[3]}
            union_array.push(tmp_array)
        }
        return union_array
    }
}

class cextra
{
    static core_module := dllcall("LoadLibrary", "str", "msvcrt.dll", "uptr")
    
    static bufString(buf)
    {
        str := ""
        while (a_index <= buf.size) && (current := numget(buf, a_index - 1, "char"))
            str .= chr(current)
        return str
    }
    
    static strBuffer(str, encoding := "utf-8")
    {
        buf := buffer(strput(str, encoding))
        strput(str, buf, encoding)
        return buf
    }
    
    static funcAddress(funcname)
    {
        return dllcall("GetProcAddress", "ptr", this.core_module, "ptr", this.strBuffer(funcname), "uptr")
    }
}
rely(obj)
{
    err_rely := []
    if !hasmethod(obj, "__rely")
        return true
    
    for i in obj.__rely()
    {
        arr_i := strsplit(i, ":")
        lib_i := arr_i[1]
        ver_i := arr_i[2]
        if file_path(lib_i)
        {
            if vercompare(version(strsplit(lib_i, "\")[-1]), ver_i) >= 0
                continue
        }
        else
        {
            try
            {
                base_class := %lib_i%
                if vercompare(version(base_class), ver_i) >= 0
                    continue
            }
        }
        err_rely.push(i)
    }
    if !err_rely.length
        return true
    return err_rely
    
    file_path(filename)
    {
        filename := instr(filename, ".ahk") ? filename : filename ".ahk"
        if fileexist(format("{}\lib\{}", regread("HKLM\SOFTWARE\AutoHotkey", "InstallDir", ""), filename))
            return true
        else if fileexist(format("{}\lib\{}", A_ScriptDir, filename))
            return true
        else
            return false
    }
}

version(_class)
{
    if hasmethod(_class, "__version")
        return _class.__version()
    return "0.0.0"
}
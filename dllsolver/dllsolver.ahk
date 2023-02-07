class dllsolver
{
    static parse(param*)
    {
        if param.length = 1
        {
            param := param[1]
            if param is map
            {
                if param.has("class_name") && param.has("dll_name") && param.has("lib_name")
                {
                    if param.has("file_name")
                        return dllsolver.parseFunc(param["class_name"], param["dll_name"], param["file_name"], param["lib_name"])
                    else
                        return dllsolver.parseFunc(param["class_name"], param["dll_name"], dllsolver.parseDll(param["dll_name"]), param["lib_name"])
                }
            }
            else if param is object
            {
                if param.hasprop("class_name") && param.hasprop("dll_name") && param.hasprop("lib_name")
                {
                    if param.hasprop("file_name")
                        return dllsolver.parseFunc(param.class_name, param.dll_name, param.file_name, param.lib_name)
                    else
                        return dllsolver.parseFunc(param.class_name, param.dll_name, dllsolver.parseDll(param.dll_name), param.lib_name)
                }
            }
        }
        else if param.length = 3
        {
            param := param.clone()
            param.insertat(3, dllsolver.parseDll(param[2]))
            return dllsolver.parseFunc(param*)
        }
        else if param.length = 4
            return dllsolver.parseFunc(param*)
    }
    
    static parseDll(dll_name)
    {
        flag := dllsolver.dll_file("lib\" dll_name ".dll")
        if flag
        {
            flag2 := dllsolver.dll_file("dllsolver\lib\dumpbin.exe")
            if flag2
                return dllsolver.ReadProcessStdOut(format("{} -exports {}", flag2, flag))
            else
                throw error("dumpbin.exe is not existed.")
        }
        else
            throw error(dll_name ".dll is not existed.")
    }
    
    static parseFunc(class_name, dll_name, file_name, lib_name)
    {
        script := format("
        (
        flag := {}.dll_file("{}\lib\{}.dll")
        if flag
            dllcall("LoadLibrary", "str", flag)
        else
            throw error("{}.dll is not existed.")

        class {}
        {
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
        )", class_name, lib_name, dll_name, dll_name, class_name)
        fileappend(script, lib_name ".ahk")
        read_flag := false
        try
        {
            loop read, file_name, lib_name ".ahk"
            {
                trim_text := trim(a_loopreadline)
                if substr(trim_text, 1, 7) = "ordinal"
                {
                    read_flag := true
                    continue
                }
                if (!read_flag && !(substr(trim_text, 1, 7) = "ordinal")) || !trim_text
                    continue
                if trim_text = "Summary"
                    break
                tmp := strsplit(trim_text, " ")[-1]
                tmp2 := regexreplace(tmp, "^(\?+\d+|\?+|\d+)")
                tmp2 := regexreplace(tmp2, "@+(\$)+|@+|(\$)+", "_")
                script := format("`n    `n    static {}(param*)`n    {`n        dllcall(`"{}\{}`")`n    }", tmp2, dll_name, tmp)
                fileappend(script)
            }
        }
        catch
        {
            loop parse, file_name, "`n", "`r"
            {
                trim_text := trim(a_loopfield)
                if substr(trim_text, 1, 7) = "ordinal"
                {
                    read_flag := true
                    continue
                }
                if (!read_flag && !(substr(trim_text, 1, 7) = "ordinal")) || !trim_text
                    continue
                if trim_text = "Summary"
                    break
                tmp := strsplit(trim_text, " ")[-1]
                tmp2 := regexreplace(tmp, "^(\?+\d+|\?+|\d+)")
                tmp2 := regexreplace(tmp2, "@+(\$)+|@+|(\$)+", "_")
                script := format("`n    `n    static {}(param*)`n    {`n        dllcall(`"{}\{}`")`n    }", tmp2, dll_name, tmp)
                fileappend(script, lib_name ".ahk")
            }
        }
        fileappend("`n}`n", lib_name ".ahk")
    }
    
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
    
    static ReadProcessStdOut(cmd, stdin := "", encoding := "utf-8")
    {
        sa := Buffer(24)
        NumPut("uint", sa.Size, sa)
        NumPut("ptr", 0, "uint", 1, sa, 8)

        if !DllCall("CreatePipe", "ptr*", &hReadPipeOut := 0, "ptr*", &hWritePipeOut := 0, "ptr", sa, "uint", 0)
            throw OSError()
        DllCall("SetHandleInformation", "ptr", hReadPipeOut, "uint", 1, "uint", 0)

        si := Buffer(104, 0)
        NumPut("uint", si.Size, si)
        NumPut("uint", 0x101, si, 60)
        NumPut("ptr", hWritePipeOut, si, 88)

        if stdin !== ""
        {
            if !DllCall("CreatePipe", "ptr*", &hReadPipeIn := 0, "ptr*", &hWritePipeIn := 0, "ptr", sa, "uint", 0)
                throw OSError()
            DllCall("SetHandleInformation", "ptr", hWritePipeIn, "uint", 1, "uint", 0)
            NumPut("ptr", hReadPipeIn, si, 80)
        }

        if !DllCall("CreateProcessW", "ptr", 0, "str", cmd, "ptr", 0, "ptr", 0, "int", true, "uint", 0, "ptr", 0, "ptr", 0, "ptr", si, "ptr", pi := Buffer(24))
        {
            DllCall("CloseHandle", "ptr", hWritePipeOut)
            DllCall("CloseHandle", "ptr", hReadPipeOut)
            throw OSError()
        }
        DllCall("CloseHandle", "ptr", NumGet(pi, "ptr"))
        DllCall("CloseHandle", "ptr", NumGet(pi, 8, "ptr"))
        DllCall("CloseHandle", "ptr", hWritePipeOut)

        if stdin !== ""
        {
            DllCall("CloseHandle", "ptr", hReadPipeIn)
            if !DllCall("WriteFile", "ptr", hWritePipeIn, "ptr", dllsolver.strBuffer(stdin, encoding), "uint", StrPut(stdin, encoding) - 1, "uint*", &lpNumberOfBytesWritten := 0, "ptr", 0){
                DllCall("CloseHandle", "ptr", hWritePipeIn)
                throw OSError()
            }
            DllCall("CloseHandle", "ptr", hWritePipeIn)
        }

        stdout := ""
        while DllCall("ReadFile", "ptr", hReadPipeOut, "ptr", buf := Buffer(4096), "uint", buf.Size, "uint*", &lpNumberOfBytesRead := 0, "ptr", 0) && lpNumberOfBytesRead
            stdout .= StrGet(buf, lpNumberOfBytesRead, encoding)
        DllCall("CloseHandle", "ptr", hReadPipeOut)

        return stdout
    }
}
flag := ahkThread.dll_file("thread\lib\AutoHotkey.dll")
if flag
    dllcall("LoadLibrary", "str", flag)
else
    throw error("AutoHotkey.dll is not existed.")

class ahkThread
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
    
    static strBuffer(str, encoding := "utf-8")
    {
        buf := buffer(strput(str, encoding))
        strput(str, buf, encoding)
        return buf
    }
    
    static addScript(script, threadId, flags := 0)
    {
        return dllcall("AutoHotkey\addScript", "str", script, "uint", flags, "uint", threadId, "cdecl")
    }
    
    static ahkAssign(varName, varValue, threadId)
    {
        return dllcall("AutoHotkey\ahkAssign", "str", varName, "str", varValue, "uint", threadId, "cdecl")
    }
    
    static ahkExec(script, threadId)
    {
        return dllcall("AutoHotkey\ahkExec", "str", script, "uint", threadId, "cdecl")
    }
    
    static exitThread(threadId)
    {
        return dllcall("AutoHotkey\g_ThreadExitApp", "uint", threadId)
    }
    
    static getVar(varName, threadId, flags := 0)
    {
        if !instr(varName, ".")
            return dllcall("AutoHotkey\ahkGetVar", "str", varName, "uint", flags, "uint", threadId, "cdecl")
    }
    
    static newThread(script, parameters := "", title := "", wait := "", library := "")
    {
        return dllcall("AutoHotkey\NewThread", "str", script, "str", parameters, "str", title, "str", wait, "str", library, "cdecl")
    }
}
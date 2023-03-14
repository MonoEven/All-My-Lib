class console
{
    static AllocConsole()
    {
        return dllcall("AllocConsole")
    }
    
    static AttachConsole(dwProcessId)
    {
        return dllcall("AttachConsole", "uint", dwProcessId)
    }
    
    static FreeConsole()
    {
        return dllcall("FreeConsole")
    }
}

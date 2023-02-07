class ctypes
{
    __new(dll_name)
    {
        this.token := dllcall("LoadLibrary", "str", dll_name)
    }
    
    __get(func_name)
    {
        
    }
    
    static dll(dll_name)
    {
        return ctypes(dll_name)
    }
}

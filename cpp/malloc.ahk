#Include <cpp\cextra>

class malloc
{
    static calloc(__count, __size)
    {
        static funcAddr := cextra.funcAddress("calloc")
        return dllcall(funcAddr, "uint", __count, "uint", __size)
    }
    
    static free(__block)
    {
        static funcAddr := cextra.funcAddress("free")
        return dllcall(funcAddr, "ptr", __block)
    }
    
    static malloc(__size)
    {
        static funcAddr := cextra.funcAddress("malloc")
        return dllcall(funcAddr, "uint", __size)
    }
    
    static realloc(__block, __size)
    {
        static funcAddr := cextra.funcAddress("realloc")
        return dllcall(funcAddr, "ptr", __block, "uint", __size)
    }
}
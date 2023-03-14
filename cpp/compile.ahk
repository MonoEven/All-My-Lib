#Include <cpp\cpp>

class compile
{
    static free(ptr)
    {
        malloc.free(ptr)
    }
    
    static error(fmt)
    {
        throw error(fmt)
    }
    
    static malloc(size)
    {
        ptr := malloc.malloc(size)
        if (!ptr && size)
            this.error("memory full (malloc)")
        return ptr
    }
    
    static mallocz(size)
    {
        ptr := this.malloc(size)
        cstring.memset(ptr, 0, size)
        return ptr
    }
    
    static realloc(ptr, size)
    {
        ptr := malloc.realloc(ptr, size)
        if (!ptr && size)
            this.error("memory full (realloc)")
        return ptr
    }
    
    static strdup(str)
    {
        ptr := this.malloc(cstring.strlen(str) + 1)
        cstring.strcpy(ptr, str)
        return ptr
    }
}

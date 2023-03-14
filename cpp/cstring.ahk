#Include <cpp\cextra>

class cstring
{    
    static memchr(__buf, __val, __maxcount)
    {
        static funcAddr := cextra.funcAddress("memchr")
        return dllcall(funcAddr, "ptr", __buf, "ptr", __val, "uint", __maxcount)
    }
    
    static memcmp(__buf1, __buf2, __size)
    {
        static funcAddr := cextra.funcAddress("memcmp")
        return dllcall(funcAddr, "ptr", __buf1, "ptr", __buf2, "uint", __size)
    }
    
    static memcpy(__dst, __src, __n)
    {
        static funcAddr := cextra.funcAddress("memcpy")
        return dllcall(funcAddr, "ptr", __dst, "ptr", __src, "uint", __n)
    }
    
    static memcpy_s(__dst, __os, __src, __n)
    {
        static funcAddr := cextra.funcAddress("memcpy_s")
        return dllcall(funcAddr, "ptr", __dst, "uint", __os, "ptr", __src, "uint", __n)
    }
    
    static memmove(__dst, __src, __n)
    {
        static funcAddr := cextra.funcAddress("memmove")
        return dllcall(funcAddr, "ptr", __dst, "ptr", __src, "uint", __n)
    }
    
    static memmove_s(__dst, __os, __src, __n)
    {
        static funcAddr := cextra.funcAddress("memmove_s")
        return dllcall(funcAddr, "ptr", __dst, "uint", __os, "ptr", __src, "uint", __n)
    }
    
    static memset(__dst, __val, __n)
    {
        static funcAddr := cextra.funcAddress("memset")
        return dllcall(funcAddr, "ptr", __dst, "int", __val, "uint", __n)
    }
    
    static strcat(__dst, __src)
    {
        static funcAddr := cextra.funcAddress("strcat")
        if (__dst is string)
            __dst := cextra.strBuffer(__dst)
        if (__src is string)
            __src := cextra.strBuffer(__src)
        return strget(dllcall(funcAddr, "ptr", __dst, "ptr", __src), , "utf-8")
    }
    
    static strchr(__str, __val)
    {
        static funcAddr := cextra.funcAddress("strchr")
        if (__str is string)
            __str := cextra.strBuffer(__str)
        return strget(dllcall(funcAddr, "ptr", __str, "int", __val), , "utf-8")
    }
    
    static strcmp(__str1, __str2)
    {
        static funcAddr := cextra.funcAddress("strcmp")
        if (__str1 is string)
            __str1 := cextra.strBuffer(__str1)
        if (__str2 is string)
            __str2 := cextra.strBuffer(__str2)
        return dllcall(funcAddr, "ptr", __str1, "ptr", __str2)
    }
    
    static strcpy(__dst, __src)
    {
        static funcAddr := cextra.funcAddress("strcpy")
        if (__src is string)
            __src := cextra.strBuffer(__src)
        return strget(dllcall(funcAddr, "ptr", __dst, "ptr", __src), , "utf-8")
    }
    
    static strcspn(__str, __control)
    {
        static funcAddr := cextra.funcAddress("strcspn")
        if (__str is string)
            __str := cextra.strBuffer(__str)
        if (__control is string)
            __control := cextra.strBuffer(__control)
        return dllcall(funcAddr, "ptr", __str, "ptr", __control)
    }
    
    static strlen(__str)
    {
        static funcAddr := cextra.funcAddress("strlen")
        if (__str is string)
            __str := cextra.strBuffer(__str)
        return dllcall(funcAddr, "ptr", __str)
    }
    
    static strncat(__dst, __src, __n)
    {
        static funcAddr := cextra.funcAddress("strncat")
        if (__dst is string)
            __dst := cextra.strBuffer(__dst)
        if (__src is string)
            __src := cextra.strBuffer(__src)
        return strget(dllcall(funcAddr, "ptr", __dst, "ptr", __src, "uint", __n), , "utf-8")
    }
    
    static strncpy(__dst, __src, __n)
    {
        static funcAddr := cextra.funcAddress("strncpy")
        if (__src is string)
            __src := cextra.strBuffer(__src)
        return strget(dllcall(funcAddr, "ptr", __dst, "ptr", __src, "uint", __n), , "utf-8")
    }
    
    static strnlen(__str, __maxcount)
    {
        static funcAddr := cextra.funcAddress("strnlen")
        if (__str is string)
            __str := cextra.strBuffer(__str)
        return dllcall(funcAddr, "ptr", __str, "uint", __maxcount)
    }
    
    static strpbrk(__str, __control)
    {
        static funcAddr := cextra.funcAddress("strpbrk")
        if (__str is string)
            __str := cextra.strBuffer(__str)
        if (__control is string)
            __control := cextra.strBuffer(__control)
        return dllcall(funcAddr, "ptr", __str, "ptr", __control)
    }
    
    static strrchr(__str, __ch)
    {
        static funcAddr := cextra.funcAddress("strrchr")
        if (__str is string)
            __str := cextra.strBuffer(__str)
        return strget(dllcall(funcAddr, "ptr", __str, "int", __ch), , "utf-8")
    }
    
    static strspn(__str, __control)
    {
        static funcAddr := cextra.funcAddress("strspn")
        if (__str is string)
            __str := cextra.strBuffer(__str)
        if (__control is string)
            __control := cextra.strBuffer(__control)
        return dllcall(funcAddr, "ptr", __str, "ptr", __control)
    }
    
    static wcscat(__dst, __src)
    {
        static funcAddr := cextra.funcAddress("wcscat")
        if (__dst is string)
            __dst := cextra.strBuffer(__dst)
        if (__src is string)
            __src := cextra.strBuffer(__src)
        return strget(dllcall(funcAddr, "ptr", __dst, "ptr", __src), , "utf-8")
    }
    
    static wcschr(__str, __val)
    {
        static funcAddr := cextra.funcAddress("wcschr")
        if (__str is string)
            __str := cextra.strBuffer(__str)
        return strget(dllcall(funcAddr, "ptr", __str, "int", __val), , "utf-8")
    }
    
    static wcscmp(__str1, __str2)
    {
        static funcAddr := cextra.funcAddress("wcscmp")
        if (__str1 is string)
            __str1 := cextra.strBuffer(__str1)
        if (__str2 is string)
            __str2 := cextra.strBuffer(__str2)
        return dllcall(funcAddr, "ptr", __str1, "ptr", __str2)
    }
    
    static wcscpy(__dst, __src)
    {
        static funcAddr := cextra.funcAddress("wcscpy")
        if (__src is string)
            __src := cextra.strBuffer(__src)
        return strget(dllcall(funcAddr, "ptr", __dst, "ptr", __src), , "utf-8")
    }
    
    static wcscspn(__str, __control)
    {
        static funcAddr := cextra.funcAddress("wcscspn")
        if (__str is string)
            __str := cextra.strBuffer(__str)
        if (__control is string)
            __control := cextra.strBuffer(__control)
        return dllcall(funcAddr, "ptr", __str, "ptr", __control)
    }
    
    static wcslen(__str)
    {
        static funcAddr := cextra.funcAddress("wcslen")
        if (__str is string)
            __str := cextra.strBuffer(__str)
        return dllcall(funcAddr, "ptr", __str)
    }
    
    static wcsncat(__dst, __src, __n)
    {
        static funcAddr := cextra.funcAddress("wcsncat")
        if (__dst is string)
            __dst := cextra.strBuffer(__dst)
        if (__src is string)
            __src := cextra.strBuffer(__src)
        return strget(dllcall(funcAddr, "ptr", __dst, "ptr", __src, "uint", __n), , "utf-8")
    }
    
    static wcsncpy(__dst, __src, __n)
    {
        static funcAddr := cextra.funcAddress("wcsncpy")
        if (__src is string)
            __src := cextra.strBuffer(__src)
        return strget(dllcall(funcAddr, "ptr", __dst, "ptr", __src, "uint", __n), , "utf-8")
    }
    
    static wcsnlen(__str, __maxcount)
    {
        static funcAddr := cextra.funcAddress("wcsnlen")
        if (__str is string)
            __str := cextra.strBuffer(__str)
        return dllcall(funcAddr, "ptr", __str, "uint", __maxcount)
    }
    
    static wcspbrk(__str, __control)
    {
        static funcAddr := cextra.funcAddress("wcspbrk")
        if (__str is string)
            __str := cextra.strBuffer(__str)
        if (__control is string)
            __control := cextra.strBuffer(__control)
        return dllcall(funcAddr, "ptr", __str, "ptr", __control)
    }
    
    static wcsrchr(__str, __ch)
    {
        static funcAddr := cextra.funcAddress("wcsrchr")
        if (__str is string)
            __str := cextra.strBuffer(__str)
        return strget(dllcall(funcAddr, "ptr", __str, "int", __ch), , "utf-8")
    }
    
    static wcsspn(__str, __control)
    {
        static funcAddr := cextra.funcAddress("wcsspn")
        if (__str is string)
            __str := cextra.strBuffer(__str)
        if (__control is string)
            __control := cextra.strBuffer(__control)
        return dllcall(funcAddr, "ptr", __str, "ptr", __control)
    }
}

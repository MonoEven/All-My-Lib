#Include <cpp\cmath>
#Include <cpp\cextra>

class stdlib extends cmath
{
    static abort()
    {
        static funcAddr := cextra.funcAddress("abort")
        return dllcall(funcAddr)
    }
    
    static bsearch(__key, __base, __numofelements, __sizeofelements, __comparefunction)
    {
        static funcAddr := cextra.funcAddress("bsearch")
        if __comparefunction is func
            __comparefunction := callbackcreate(__comparefunction, "cdel")
        return (ret := dllcall(funcAddr, "ptr", __key, "ptr", __base, "uint", __numofelements, "uint", __sizeofelements, "int", __comparefunction), callbackfree(__comparefunction), ret)
    }
    
    static exit(code)
    {
        static funcAddr := cextra.funcAddress("exit")
        return dllcall(funcAddr, "int", code)
    }
    
    static itoa(__value, __radix)
    {
        static funcAddr := cextra.funcAddress("_itoa_s")
        buf := buffer(1024)
        dllcall(funcAddr, "int", __value, "ptr", buf, "uint", buf.size, "int", __radix)
        return strget(buf, , "utf-8")
    }
    
    static qsort(__base, __numofelements, __sizeofelements, __comparefunction)
    {
        static funcAddr := cextra.funcAddress("qsort")
        if __comparefunction is func
            __comparefunction := callbackcreate(__comparefunction, "cdel")
        return (ret := dllcall(funcAddr, "ptr", __base, "uint", __numofelements, "uint", __sizeofelements, "int", __comparefunction), callbackfree(__comparefunction), ret)
    }
    
    static rand()
    {
        static funcAddr := cextra.funcAddress("rand")
        return dllcall(funcAddr)
    }
    
    static srand(__seed)
    {
        static funcAddr := cextra.funcAddress("srand")
        return dllcall(funcAddr, "int", __seed)
    }
    
    static strtol(__string, __radix, &__endptr := 0)
    {
        static funcAddr := cextra.funcAddress("strtol")
        if (__string is string)
            __string := cextra.strBuffer(__string)
        return dllcall(funcAddr, "ptr", __string, "ptr*", &__endptr, "int", __radix)
    }
    
    static strtoul(__string, __radix, &__endptr := 0)
    {
        static funcAddr := cextra.funcAddress("strtoul")
        if (__string is string)
            __string := cextra.strBuffer(__string)
        return dllcall(funcAddr, "ptr", __string, "ptr*", &__endptr, "int", __radix)
    }
    
    static system(__command)
    {
        static funcAddr := cextra.funcAddress("system")
        if (__command is string)
            __command := cextra.strBuffer(__command)
        return dllcall(funcAddr, "ptr", __command)
    }
}

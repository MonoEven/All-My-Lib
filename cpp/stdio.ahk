#Include <cpp\cextra>
#Include <cpp\malloc>

class stdio
{
    static stdin
    {
        get
        {
            static ret := dllcall(cextra.funcAddress("__iob_func"))
            return ret
        }
    }
    static stdout
    {
        get
        {
            static ret := this.stdin + a_ptrsize
            return ret
        }
    }
    static stderr
    {
        get
        {
            static ret := this.stdin + 2 * a_ptrsize
            return ret
        }
    }
    
    static fclose(__stream)
    {
        static funcAddr := cextra.funcAddress("fclose")
        return dllcall(funcAddr, "ptr", __stream)
    }
    
    static fflush(__stream)
    {
        static funcAddr := cextra.funcAddress("fflush")
        return dllcall(funcAddr, "ptr", __stream)
    }
    
    static fopen(__filename, __mode)
    {
        static funcAddr := cextra.funcAddress("fopen")
        if (__filename is string)
            __filename := cextra.strBuffer(__filename)
        if (__mode is string)
            __mode := cextra.strBuffer(__mode)
        return dllcall(funcAddr, "ptr", __filename, "ptr", __mode, "uptr")
    }
    
    static freopen(__filename, __mode, __stream)
    {
        static funcAddr := cextra.funcAddress("freopen")
        if (__filename is string)
            __filename := cextra.strBuffer(__filename)
        if (__mode is string)
            __mode := cextra.strBuffer(__mode)
        return dllcall(funcAddr, "ptr", __filename, "ptr", __mode, "ptr", __stream, "uptr")
    }
    
    static fprintf(__stream, __format, args*)
    {
        static funcAddr := cextra.funcAddress("fprintf")
        if (__format is string)
            __format := cextra.strBuffer(__format)
        dllbind := dllcall.bind(funcAddr, "ptr", __stream, "ptr", __format)
        for i in args
        {
            if (i is string)
                i := cextra.strBuffer(i)
            if (i is array)
                dllbind := dllbind.bind(i*)
            else
                dllbind := dllbind.bind("ptr", i)
        }
        return dllbind()
    }
    
    static fscanf(__stream, __format, args*)
    {
        static funcAddr := cextra.funcAddress("fscanf")
        if (__format is string)
            __format := cextra.strBuffer(__format)
        dllbind := dllcall.bind(funcAddr, "ptr", __stream, "ptr", __format)
        for i in args
        {
            if (i is array)
                dllbind := dllbind.bind(i*)
            else if (i is buffer)
                dllbind := dllbind.bind("ptr", i)
            else
                dllbind := dllbind.bind("ptr*", i)
        }
        return dllbind()
    }
    
    static getchar()
    {
        static funcAddr := cextra.funcAddress("getchar")
        return chr(dllcall(funcAddr))
    }
    
    static printf(__format, args*)
    {
        stdio.freopen("conout$", "w", stdio.stdout)
        return (ret := stdio.fprintf(stdio.stdout, __format, args*), stdio.fclose(stdio.stdout), ret)
    }
    
    static putchar(__character)
    {
        static funcAddr := cextra.funcAddress("putchar")
        if __character is string
            __character := ord(__character)
        return dllcall(funcAddr, "int", __character)
    }
    
    static scanf(__format, args*)
    {
        stdio.freopen("conin$", "r", stdio.stdin)
        return (ret := stdio.fscanf(stdio.stdin, __format, args*), stdio.fclose(stdio.stdin), ret)
    }
}

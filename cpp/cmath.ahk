#Include <cpp\cextra>

class cmath
{
    static M_E := 2.7182818284590452354
    static M_LOG2E := 1.4426950408889634074
    static M_LOG10E := 0.43429448190325182765
    static M_LN2 := 0.69314718055994530942
    static M_LN10 := 2.30258509299404568402
    static M_PI := 3.14159265358979323846
    static M_PI_2 := 1.57079632679489661923
    static M_PI_4 := 0.78539816339744830962
    static M_1_PI := 0.31830988618379067154
    static M_2_PI := 0.63661977236758134308
    static M_2_SQRTPI := 1.12837916709551257390
    static M_SQRT2 := 1.41421356237309504880
    static M_SQRT1_2 := 0.70710678118654752440
    
    static abs(__number)
    {
        static funcAddr := cextra.funcAddress("abs")
        return dllcall(funcAddr, "int", __number)
    }
    
    static acos(__x)
    {
        static funcAddr := cextra.funcAddress("acos")
        return dllcall(funcAddr, "double", __x)
    }
    
    static asin(__x)
    {
        static funcAddr := cextra.funcAddress("asin")
        return dllcall(funcAddr, "double", __x)
    }
    
    static atan(__x)
    {
        static funcAddr := cextra.funcAddress("atan")
        return dllcall(funcAddr, "double", __x)
    }
    
    static atan2(__y, __x)
    {
        static funcAddr := cextra.funcAddress("atan2")
        return dllcall(funcAddr, "double", __x, "double", __y)
    }
    
    static atof(__string)
    {
        static funcAddr := cextra.funcAddress("atof")
        if __string is string
            __string := cextra.strBuffer(__string)
        return dllcall(funcAddr, "ptr", __string)
    }
    
    static atoi(__string)
    {
        static funcAddr := cextra.funcAddress("atoi")
        if __string is string
            __string := cextra.strBuffer(__string)
        return dllcall(funcAddr, "ptr", __string)
    }
    
    static atol(__string)
    {
        static funcAddr := cextra.funcAddress("atol")
        if __string is string
            __string := cextra.strBuffer(__string)
        return dllcall(funcAddr, "ptr", __string)
    }
    
    static ceil(__x)
    {
        static funcAddr := cextra.funcAddress("ceil")
        return dllcall(funcAddr, "double", __x)
    }
    
    static cos(__x)
    {
        static funcAddr := cextra.funcAddress("cos")
        return dllcall(funcAddr, "double", __x)
    }
    
    static cosh(__x)
    {
        static funcAddr := cextra.funcAddress("cosh")
        return dllcall(funcAddr, "double", __x)
    }
    
    static exp(__x)
    {
        static funcAddr := cextra.funcAddress("exp")
        return dllcall(funcAddr, "double", __x)
    }
    
    static fabs(__x)
    {
        static funcAddr := cextra.funcAddress("fabs")
        return dllcall(funcAddr, "double", __x)
    }
    
    static floor(__x)
    {
        static funcAddr := cextra.funcAddress("floor")
        return dllcall(funcAddr, "double", __x)
    }
    
    static fmod(__x, __y)
    {
        static funcAddr := cextra.funcAddress("fmod")
        return dllcall(funcAddr, "double", __x, "double", __y)
    }
    
    static frexp(__x, &__y := 0)
    {
        static funcAddr := cextra.funcAddress("frexp")
        return dllcall(funcAddr, "double", __x, "int*", &__y)
    }
    
    static labs(__x)
    {
        static funcAddr := cextra.funcAddress("labs")
        return dllcall(funcAddr, "int", __x)
    }
    
    static ldexp(__x, __y)
    {
        static funcAddr := cextra.funcAddress("ldexp")
        return dllcall(funcAddr, "double", __x, "double", __y)
    }
    
    static log(__x)
    {
        static funcAddr := cextra.funcAddress("log")
        return dllcall(funcAddr, "double", __x)
    }
    
    static log10(__x)
    {
        static funcAddr := cextra.funcAddress("log10")
        return dllcall(funcAddr, "double", __x)
    }
    
    static modf(__x, &__y := 0)
    {
        static funcAddr := cextra.funcAddress("modf")
        return dllcall(funcAddr, "double", __x, "double*", &__y)
    }
    
    static pow(__x, __y)
    {
        static funcAddr := cextra.funcAddress("pow")
        return dllcall(funcAddr, "double", __x, "double", __y)
    }
    
    static sin(__x)
    {
        static funcAddr := cextra.funcAddress("sin")
        return dllcall(funcAddr, "double", __x)
    }
    
    static sinh(__x)
    {
        static funcAddr := cextra.funcAddress("sinh")
        return dllcall(funcAddr, "double", __x)
    }
    
    static sqrt(__x)
    {
        static funcAddr := cextra.funcAddress("sqrt")
        return dllcall(funcAddr, "double", __x)
    }
    
    static tan(__x)
    {
        static funcAddr := cextra.funcAddress("tan")
        return dllcall(funcAddr, "double", __x)
    }
    
    static tanh(__x)
    {
        static funcAddr := cextra.funcAddress("tanh")
        return dllcall(funcAddr, "double", __x)
    }
}

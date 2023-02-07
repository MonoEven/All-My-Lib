#Include <boost\boost_const>

class Boost_Math
{
    static __get(name, param)
    {
        if name = "inf"
            return this.atanh(1)
        else if name = "nan"
            return this.acosh(0)
    }
    
    static dll_init()
    {
        if !Boost_Const.flagMap.has("boost::math")
        {
            flag := Boost_Const.dll_file("boost\lib\boost_math_c99-vc1416-mt-x64-1_81.dll")
            if flag
                dllcall("LoadLibrary", "Str", flag)
            else
                throw error("boost_math_c99-vc1416-mt-x64-1_81.dll is not existed.")
            flag := Boost_Const.dll_file("boost\lib\boost_math_tr1-vc1416-mt-x64-1_81.dll")
            if flag
                dllcall("LoadLibrary", "Str", flag)
            else
                throw error("boost_math_tr1-vc1416-mt-x64-1_81.dll is not existed.")
            Boost_Const.flagMap["boost::math"] := true
        }
    }
    
    static acosh(number)
    {
        this.dll_init()
        return dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_acosh", "double", number, "double")
    }
    
    static asinh(number)
    {
        this.dll_init()
        return dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_asinh", "double", number, "double")
    }
    
    static assoc_laguerre(n, m, x)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_assoc_laguerre", "uint", n, "uint", m, "double", x, "double")
    }
    
    static assoc_legendre(n, m, x)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_assoc_legendre", "uint", n, "uint", m, "double", x, "double")
    }
    
    static atanh(number)
    {
        this.dll_init()
        return dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_atanh", "double", number, "double")
    }
    
    static beta(x, y)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_beta", "double", x, "double", y, "double")
    }
    
    static cbrt(number)
    {
        this.dll_init()
        return dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_cbrt", "double", number, "double")
    }
    
    static comp_ellint_1(k)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_comp_ellint_1", "double", k, "double")
    }
    
    static comp_ellint_2(k)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_comp_ellint_2", "double", k, "double")
    }
    
    static comp_ellint_3(k, v)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_comp_ellint_3", "double", k, "double", v, "double")
    }
    
    static copysign(number1, number2)
    {
        this.dll_init()
        return dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_copysign", "double", number1, "double", number2, "double")
    }
    
    static cyl_bessel_i(v, x)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_cyl_bessel_i", "double", v, "double", x, "double")
    }
    
    static cyl_bessel_j(v, x)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_cyl_bessel_j", "double", v, "double", x, "double")
    }
    
    static cyl_bessel_k(v, x)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_cyl_bessel_k", "double", v, "double", x, "double")
    }
    
    static cyl_neumann(v, x)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_cyl_neumann", "double", v, "double", x, "double")
    }
    
    static ellint_1(k, f)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_ellint_1", "double", k, "double", f, "double")
    }
    
    static ellint_2(k, f)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_ellint_2", "double", k, "double", f, "double")
    }
    
    static ellint_3(k, v, f)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_ellint_3", "double", k, "double", v, "double", f, "double")
    }
    
    static erfc(number)
    {
        this.dll_init()
        return dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_erfc", "double", number, "double")
    }
    
    static erf(number)
    {
        this.dll_init()
        return dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_erf", "double", number, "double")
    }
    
    static expint(number)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_expint", "double", number, "double")
    }
    
    static expm1(number)
    {
        this.dll_init()
        return dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_expm1", "double", number, "double")
    }
    
    static fmax(number1, number2)
    {
        this.dll_init()
        return dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_fmax", "double", number1, "double", number2, "double")
    }
    
    static fmin(number1, number2)
    {
        this.dll_init()
        return dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_fmin", "double", number1, "double", number2, "double")
    }
    
    static hermite(n, x)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_hermite", "uint", n, "double", x, "double")
    }
    
    static hypot(number1, number2)
    {
        this.dll_init()
        return dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_hypot", "double", number1, "double", number2, "double")
    }
    
    static laguerre(n, x)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_laguerre", "uint", n, "double", x, "double")
    }
    
    static legendre(n, x)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_legendre", "uint", n, "double", x, "double")
    }
    
    static lgamma(number)
    {
        this.dll_init()
        return dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_lgamma", "double", number, "double")
    }
    
    static llround(number)
    {
        this.dll_init()
        return dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_llround", "double", number, "int64")
    }
    
    static log1p(number)
    {
        this.dll_init()
        return dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_log1p", "double", number, "double")
    }
    
    static lround(number)
    {
        this.dll_init()
        return dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_lround", "double", number, "int")
    }
    
    static nextafter(number1, number2)
    {
        this.dll_init()
        return dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_nextafter", "double", number1, "double", number2, "double")
    }
    
    static nexttoward(number1, number2)
    {
        this.dll_init()
        return dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_nexttoward", "double", number1, "double", number2, "double")
    }
    
    static riemann_zeta(number)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_riemann_zeta", "double", number, "double")
    }
    
    static round(number)
    {
        this.dll_init()
        return dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_round", "double", number, "double")
    }
    
    static sph_bessel(n, x)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_sph_bessel", "uint", n, "double", x, "double")
    }
    
    static sph_legendre(l, m, t)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_sph_legendre", "uint", l, "uint", m, "double", t, "double")
    }
    
    static sph_neumann(n, x)
    {
        this.dll_init()
        return dllcall("boost_math_tr1-vc1416-mt-x64-1_81\boost_sph_neumann", "uint", n, "double", x, "double")
    }
    
    static tgamma(number)
    {
        this.dll_init()
        return dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_tgamma", "double", number, "double")
    }
    
    static trunc(number)
    {
        this.dll_init()
        return integer(dllcall("boost_math_c99-vc1416-mt-x64-1_81\boost_trunc", "double", number, "double"))
    }
    
    class Double
    {
        static dll_init()
        {
            if !Boost_Const.flagMap.has("boost::math::double")
            {
                flag := Boost_Const.dll_file("boost\lib\boost_math_c99l-vc1416-mt-x64-1_81.dll")
                if flag
                    dllcall("LoadLibrary", "Str", flag)
                else
                    throw error("boost_math_c99l-vc1416-mt-x64-1_81.dll is not existed.")
                flag := Boost_Const.dll_file("boost\lib\boost_math_tr1l-vc1416-mt-x64-1_81.dll")
                if flag
                    dllcall("LoadLibrary", "Str", flag)
                else
                    throw error("boost_math_tr1l-vc1416-mt-x64-1_81.dll is not existed.")
                Boost_Const.flagMap["boost::math::double"] := true
            }
        }
        
        static acosh(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_acoshl", "double", number, "double")
        }
        
        static asinh(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_asinhl", "double", number, "double")
        }
        
        static assoc_laguerre(n, m, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_assoc_laguerrel", "uint", n, "uint", m, "double", x, "double")
        }
        
        static assoc_legendre(n, m, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_assoc_legendrel", "uint", n, "uint", m, "double", x, "double")
        }
        
        static atanh(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_atanhl", "double", number, "double")
        }
        
        static beta(x, y)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_betal", "double", x, "double", y, "double")
        }
        
        static cbrt(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_cbrtl", "double", number, "double")
        }
        
        static comp_ellint_1(k)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_comp_ellint_1l", "double", k, "double")
        }
        
        static comp_ellint_2(k)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_comp_ellint_2l", "double", k, "double")
        }
        
        static comp_ellint_3(k, v)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_comp_ellint_3l", "double", k, "double", v, "double")
        }
        
        static copysign(number1, number2)
        {
            this.dll_init()
            return dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_copysignl", "double", number1, "double", number2, "double")
        }
        
        static cyl_bessel_i(v, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_cyl_bessel_il", "double", v, "double", x, "double")
        }
        
        static cyl_bessel_j(v, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_cyl_bessel_jl", "double", v, "double", x, "double")
        }
        
        static cyl_bessel_k(v, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_cyl_bessel_kl", "double", v, "double", x, "double")
        }
        
        static cyl_neumann(v, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_cyl_neumannl", "double", v, "double", x, "double")
        }
        
        static ellint_1(k, f)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_ellint_1l", "double", k, "double", f, "double")
        }
        
        static ellint_2(k, f)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_ellint_2l", "double", k, "double", f, "double")
        }
        
        static ellint_3(k, v, f)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_ellint_3l", "double", k, "double", v, "double", f, "double")
        }
        
        static erfc(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_erfcl", "double", number, "double")
        }
        
        static erf(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_erfl", "double", number, "double")
        }
        
        static expint(number)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_expintl", "double", number, "double")
        }
        
        static expm1(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_expm1l", "double", number, "double")
        }
        
        static fmax(number1, number2)
        {
            this.dll_init()
            return dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_fmaxl", "double", number1, "double", number2, "double")
        }
        
        static fmin(number1, number2)
        {
            this.dll_init()
            return dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_fminl", "double", number1, "double", number2, "double")
        }
        
        static hermite(n, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_hermitel", "uint", n, "double", x, "double")
        }
        
        static hypot(number1, number2)
        {
            this.dll_init()
            return dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_hypotl", "double", number1, "double", number2, "double")
        }
        
        static laguerre(n, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_laguerrel", "uint", n, "double", x, "double")
        }
        
        static legendre(n, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_legendrel", "uint", n, "double", x, "double")
        }
        
        static lgamma(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_lgammal", "double", number, "double")
        }
        
        static llround(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_llroundl", "double", number, "int64")
        }
        
        static log1p(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_log1pl", "double", number, "double")
        }
        
        static lround(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_lroundl", "double", number, "int")
        }
        
        static nextafter(number1, number2)
        {
            this.dll_init()
            return dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_nextafterl", "double", number1, "double", number2, "double")
        }
        
        static nexttoward(number1, number2)
        {
            this.dll_init()
            return dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_nexttowardl", "double", number1, "double", number2, "double")
        }
        
        static riemann_zeta(number)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_riemann_zetal", "double", number, "double")
        }
        
        static round(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_roundl", "double", number, "double")
        }
        
        static sph_bessel(n, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_sph_bessell", "uint", n, "double", x, "double")
        }
        
        static sph_legendre(l, m, t)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_sph_legendrel", "uint", l, "uint", m, "double", t, "double")
        }
        
        static sph_neumann(n, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1l-vc1416-mt-x64-1_81\boost_sph_neumannl", "uint", n, "double", x, "double")
        }
        
        static tgamma(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_tgammal", "double", number, "double")
        }
        
        static trunc(number)
        {
            this.dll_init()
            return integer(dllcall("boost_math_c99l-vc1416-mt-x64-1_81\boost_truncl", "double", number, "double"))
        }
    }
    
    class Float
    {
        static dll_init()
        {
            if !Boost_Const.flagMap.has("boost::math::float")
            {
                flag := Boost_Const.dll_file("boost\lib\boost_math_c99f-vc1416-mt-x64-1_81.dll")
                if flag
                    dllcall("LoadLibrary", "Str", flag)
                else
                    throw error("boost_math_c99f-vc1416-mt-x64-1_81.dll is not existed.")
                flag := Boost_Const.dll_file("boost\lib\boost_math_tr1f-vc1416-mt-x64-1_81.dll")
                if flag
                    dllcall("LoadLibrary", "Str", flag)
                else
                    throw error("boost_math_tr1f-vc1416-mt-x64-1_81.dll is not existed.")
                Boost_Const.flagMap["boost::math::float"] := true
            }
        }
        
        static acosh(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_acoshf", "float", number, "float")
        }
        
        static asinh(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_asinhf", "float", number, "float")
        }
        
        static assoc_laguerre(n, m, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_assoc_laguerref", "uint", n, "uint", m, "float", x, "float")
        }
        
        static assoc_legendre(n, m, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_assoc_legendref", "uint", n, "uint", m, "float", x, "float")
        }
        
        static atanh(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_atanhf", "float", number, "float")
        }
        
        static beta(x, y)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_betaf", "float", x, "float", y, "float")
        }
        
        static cbrt(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_cbrtf", "float", number, "float")
        }
        
        static comp_ellint_1(k)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_comp_ellint_1f", "float", k, "float")
        }
        
        static comp_ellint_2(k)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_comp_ellint_2f", "float", k, "float")
        }
        
        static comp_ellint_3(k, v)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_comp_ellint_3f", "float", k, "float", v, "float")
        }
        
        static copysign(number1, number2)
        {
            this.dll_init()
            return dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_copysignf", "float", number1, "float", number2, "float")
        }
        
        static cyl_bessel_i(v, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_cyl_bessel_if", "float", v, "float", x, "float")
        }
        
        static cyl_bessel_j(v, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_cyl_bessel_jf", "float", v, "float", x, "float")
        }
        
        static cyl_bessel_k(v, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_cyl_bessel_kf", "float", v, "float", x, "float")
        }
        
        static cyl_neumann(v, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_cyl_neumannf", "float", v, "float", x, "float")
        }
        
        static ellint_1(k, f)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_ellint_1f", "float", k, "float", f, "float")
        }
        
        static ellint_2(k, f)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_ellint_2f", "float", k, "float", f, "float")
        }
        
        static ellint_3(k, v, f)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_ellint_3f", "float", k, "float", v, "float", f, "float")
        }
        
        static erfc(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_erfcf", "float", number, "float")
        }
        
        static erf(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_erff", "float", number, "float")
        }
        
        static expint(number)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_expintf", "float", number, "float")
        }
        
        static expm1(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_expm1f", "float", number, "float")
        }
        
        static fmax(number1, number2)
        {
            this.dll_init()
            return dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_fmaxf", "float", number1, "float", number2, "float")
        }
        
        static fmin(number1, number2)
        {
            this.dll_init()
            return dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_fminf", "float", number1, "float", number2, "float")
        }
        
        static hermite(n, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_hermitef", "uint", n, "float", x, "float")
        }
        
        static hypot(number1, number2)
        {
            this.dll_init()
            return dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_hypotf", "float", number1, "float", number2, "float")
        }
        
        static laguerre(n, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_laguerref", "uint", n, "float", x, "float")
        }
        
        static legendre(n, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_legendref", "uint", n, "float", x, "float")
        }
        
        static lgamma(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_lgammaf", "float", number, "float")
        }
        
        static llround(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_llroundf", "float", number, "int64")
        }
        
        static log1p(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_log1pf", "float", number, "float")
        }
        
        static lround(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_lroundf", "float", number, "int")
        }
        
        static nextafter(number1, number2)
        {
            this.dll_init()
            return dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_nextafterf", "float", number1, "float", number2, "float")
        }
        
        static nexttoward(number1, number2)
        {
            this.dll_init()
            return dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_nexttowardf", "float", number1, "double", number2, "float")
        }
        
        static riemann_zeta(number)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_riemann_zetaf", "float", number, "float")
        }
        
        static round(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_roundf", "float", number, "float")
        }
        
        static sph_bessel(n, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_sph_besself", "uint", n, "float", x, "float")
        }
        
        static sph_legendre(l, m, t)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_sph_legendref", "uint", l, "uint", m, "float", t, "float")
        }
        
        static sph_neumann(n, x)
        {
            this.dll_init()
            return dllcall("boost_math_tr1f-vc1416-mt-x64-1_81\boost_sph_neumannf", "uint", n, "float", x, "float")
        }
        
        static tgamma(number)
        {
            this.dll_init()
            return dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_tgammaf", "float", number, "float")
        }
        
        static trunc(number)
        {
            this.dll_init()
            return integer(dllcall("boost_math_c99f-vc1416-mt-x64-1_81\boost_truncf", "float", number, "float"))
        }
    }
}

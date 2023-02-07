; Author: Mono
; Time: 2022.09.08
; Version: 1.0.0

Class Math
{
    Static E := 2.718281828459045
    Static PI := 3.141592653589793
    Static TAU := 6.283185307179586
    Static INF := 2 ** 63 - 1
    Static NAN := "-"
    
    ; Trigonometric function
    Static ACos(Number)
    {
        Return ACos(Number)
    }
    
    Static ASin(Number)
    {
        Return ASin(Number)
    }
    
    Static ATan(Number)
    {
        Return ATan(Number)
    }
    
    Static ATan2(x, y)
    {
        Return ATan(y / x)
    }
    
    Static Cos(Number)
    {
        Return Cos(Number)
    }
    
    Static Sin(Number)
    {
        Return Sin(Number)
    }
    
    Static Tan(Number)
    {
        Return Tan(Number)
    }
    
    ; Hyperbolic function
    Static ACosh(Number)
    {
        Return Ln(Number + Sqrt(Number ** 2 - 1))
    }
    
    Static ASinh(Number)
    {
        Return Ln(Number + Sqrt(Number ** 2 + 1))
    }
    
    Static ATanh(Number)
    {
        Return 0.5 * Ln((1 + Number) / (1 - Number))
    }
    
    Static Cosh(Number)
    {
        Return (Math.Exp(Number) + Math.Exp(-Number)) / 2
    }
    
    Static Sinh(Number)
    {
        Return (Math.Exp(Number) - Math.Exp(-Number)) / 2
    }
    
    Static Tanh(Number)
    {
        Return (Math.Exp(Number) - Math.Exp(-Number)) / (Math.Exp(Number) + Math.Exp(-Number))
    }
    
    ; Power function
    Static Exp(Number)
    {
        if Number < 0
            Return 1 / Exp(Abs(Number))
        
        Return Exp(Number)
    }
    
    Static Expm1(Number)
    {
        if Number < 0
            Return 1 / Exp(Abs(Number)) - 1
        
        Return Exp(Number) - 1
    }
    
    Static Pow(x, y)
    {
        if y < 0
            Return (1 / x) ** Abs(y)
        
        Return x ** y
    }
    
    Static Sqrt(Number)
    {
        Return Sqrt(Number)
    }
    
    ; Logarithmic function
    Static Log(Number*)
    {
        if Number.Length == 1
            Return Ln(Number[1])
        
        Return Ln(Number[1]) / Ln(Number[2])
    }
    
    Static Log10(Number)
    {
        Return Log(Number)
    }
    
    Static Log1p(Number)
    {
        Return Ln(Number + 1)
    }
    
    Static Log2(Number)
    {
        Return Ln(Number) / Ln(2)
    }
    
    ; Rounding function
    Static Ceil(Number)
    {
        Return Ceil(Number)
    }
    
    Static Floor(Number)
    {
        Return Floor(Number)
    }
    
    Static ISqrt(Number)
    {
        Return Floor(Sqrt(Number))
    }
    
    Static Trunc(Number)
    {
        Return Integer(Number)
    }
    
    ; Angle conversion function
    Static Degrees(Number)
    {
        Return 180 * (Number / Math.PI)
    }
    
    Static Radians(Number)
    {
        Return (Number / 180) * Math.PI
    }
    
    ; Split function
    Static Modf(Number)
    {
        a := Integer(Number)
        b := Round(Number - a, 10)
        
        Return [b, a]
    }
    
    Static Frexp(Number)
    {
        flag := 1
        
        if Number < 0
        {
            flag := -1
            Number := -Number
        }
        
        b := Integer(Ln(Number) / Ln(2)) + 1
        a := Round(Number / (2 ** b) * flag, 10)
        
        Return [a, b]
    }
    
    ; Other Function
    Static FAbs(Number)
    {
        Return Abs(Number)
    }
    
    Static Factorial(Number)
    {
        a := []
        temp := 0
        digit := 2
        i := 2
        j := 1
        a.Push(1)

        While i <= Number
        {
            num := 0
            
            While j < digit
            {
                temp := a[j] * i + num
                a[j] := Mod(temp, 10)
                num := temp // 10
                j++
            }
            
            j := 1
            
            While(num)
            {
                a.Push(Mod(num, 10))
                num //= 10
                digit++
            }
            
            i++
        }

        Loop a.Length
            Res .= a[-A_Index]
        
        if !Integer(Res) && Number
            Return Res
        
        Return Integer(Res)
    }
    
    ; Special function
    Static Erf(Number)
    {
        flag := 1
        
        if Number < 0
        {
            flag := -1
            Number := -Number
        }
        
        Return Round(2 / (Sqrt(Math.PI)) * Math.Integral(_(x) => Exp(-(x ** 2)), 0, Number) * flag, 10)
    }
    
    Static Erfc(Number)
    {
        Return Round(1 - Math.Erf(Number), 10)
    }
    
    Static Gamma(Number)
    {
        if isInteger(Number) && Abs(Number) <= 20
            Return Integer(Math.Factorial(Number) / Number)
        
        Return Round(Math.Integral(_(x) => (1 / Exp(Tan(x))) * (Tan(x) ** (Number - 1)) * (1 + Tan(x) ** 2), 1 / 10 ** 10, Math.PI / 2), 10)
    }
    
    Static LGamma(Number)
    {
        Return Log(Abs(Math.Gamma(Number)))
    }
    
    Static Integral(Function, a, b, precision := 100000)
    {
        h := (b - a) / precision
        result := 0
        i := 0
        
        Loop precision - 1
        {
            result += (Function(a + i) + Function(a + i + h)) / 2
            i += h
        }
        
        Return result * h
    }
    
    ; Judgment function
    Static IsFinite(Number)
    {
        Return !Math.IsINF(Number) && !Math.IsNAN(Number)
    }
    
    Static IsINF(Number)
    {
        Return Number && (String(Integer(Number)) != Number)
    }
    
    Static IsNAN(Number)
    {
        Return !isNumber(Number)
    }
    
    ; N-Number Function
    Static Comb(Population, Individual)
    {
        Result := 1
        
        Loop Individual
            Result *= ((Population - A_Index + 1) // A_Index)
        
        Return Result
    }
    
    Static CopySign(x, y)
    {
        if y
            Return Abs(x) * (y // Abs(y))
        
        Return x
    }
    
    Static Dist(x, y)
    {
        Sum := 0
        
        Loop x.Length
            Sum += (x[A_Index] - y[A_Index]) ** 2
        
        Return Sum
    }
    
    Static FMod(x, y)
    {
        Return Mod(x, y)
    }
    
    Static FSum(Number*)
    {
        Sum := 0
        
        For i in Number
            Sum += i
        
        Return Sum
    }
    
    Static Gcd(Number*)
    {
        if Number.Length == 1
            Return Number[1]
        
        if Number.Length == 2
        {
            total := 0
            m := Number[1]
            n := Number[2]
            
            if (m < n)
            {
                temp := m
                m := n
                n := temp
            }
            
            if (n == 0)
                Return 0
            
            while (m != n)
            {
                if (m & 1)
                {
                    if (n & 1)
                    {
                        temp := m
                        m := (m + n) >> 1
                        n := (temp - n) >> 1
                     }
                       
                     else
                        n  >>= 1
                }
                  
                else
                {
                     if (n & 1)
                     {
                          m >>= 1
                            
                          if (m < n)
                          {
                               temp := m
                               m := n
                               n := temp
                          }
                     }
                       
                     else
                     {
                          m >>= 1
                          n >>= 1
                          total++
                     }
                  }
            }
            
            m <<= total
            
            Return m
        }
        
        Tmp := Number.RemoveAt(1)
        Ret := Math.Gcd(Number*)
        
        Return Math.Gcd(Tmp, Ret)
    }
    
    Static Hypot(CoordinateX, CoordinateY)
    {
        Return Sqrt(CoordinateX * CoordinateX + CoordinateY * CoordinateY)
    }
    
    Static Lcm(Number*)
    {
        if Number.Length == 1
            Return Number[1]
        
        if Number.Length == 2
        {
            m := Number[1]
            n := Number[2]
            
            Return m * n // Math.Gcd(m, n)
        }
        
        Tmp := Number.RemoveAt(1)
        Ret := Math.Lcm(Number*)
        
        Return Math.Lcm(Tmp, Ret)
    }
    
    Static LDExp(x, y)
    {
        Return x * (2 ** y)
    }
    
    Static Perm(Population, Individual)
    {
        Result := 1
        
        Loop Individual
            Result *= (Population - A_Index + 1)
        
        Return Result
    }
    
    Static Prod(Number*)
    {
        Prod := 1
        
        For i in Number
            Prod *= i
        
        Return Prod
    }
    
    Static Remainder(x, y)
    {
        Return Mod(x, y)
    }
}
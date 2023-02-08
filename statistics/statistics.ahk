; Author: Mono
; Time: 2022.09.12
; Version: 1.0.0

Class Statistics
{
    ; Mean
    Static FMean(Arr)
    {
        Sum := 0
        
        For i in Arr
            Sum += i
        
        Return Sum / Arr.Length
    }
    
    Static Geometric_Mean(Arr)
    {
        Mul := 1
        
        For i in Arr
            Mul *= i
        
        Return Mul ** (1 / Arr.Length)
    }
    
    Static Harmonic_Mean(Arr)
    {
        Sum := 0
        
        For i in Arr
            Sum += (1 / i)
        
        Return Arr.Length / Sum
    }
    
    Static Mean(Arr)
    {
        Sum := 0
        
        For i in Arr
            Sum += i
        
        Return Sum // Arr.Length
    }
    
    ; Median
    Static Median(Arr)
    {
        Arr := Arr.Clone()
        
        Loop Arr.Length
        {
            Index := A_Index
            
            Loop Arr.Length - Index
            {
                if Arr[Index] > Arr[A_Index + Index]
                {
                    Tmp := Arr[Index]
                    Arr[Index] := Arr[A_Index + Index]
                    Arr[A_Index + Index] := Tmp
                }
            }
        }
        
        Return Mod(Arr.Length, 2) ? Arr[Floor(Arr.Length / 2)] : (Arr[Arr.Length // 2] + Arr[Arr.Length // 2 + 1]) / 2
    }
    
    Static Median_Low(Arr)
    {
        Arr := Arr.Clone()
        
        Loop Arr.Length
        {
            Index := A_Index
            
            Loop Arr.Length - Index
            {
                if Arr[Index] > Arr[A_Index + Index]
                {
                    Tmp := Arr[Index]
                    Arr[Index] := Arr[A_Index + Index]
                    Arr[A_Index + Index] := Tmp
                }
            }
        }
        
        Return Mod(Arr.Length, 2) ? Arr[Floor(Arr.Length / 2)] : Arr[Arr.Length // 2]
    }
    
    Static Median_High(Arr)
    {
        Arr := Arr.Clone()
        
        Loop Arr.Length
        {
            Index := A_Index
            
            Loop Arr.Length - Index
            {
                if Arr[Index] > Arr[A_Index + Index]
                {
                    Tmp := Arr[Index]
                    Arr[Index] := Arr[A_Index + Index]
                    Arr[A_Index + Index] := Tmp
                }
            }
        }
        
        Return Arr[Arr.Length // 2 + 1]
    }
    
    Static Median_Grouped(Arr, Interval := 1)
    {
        if Arr.Length == 1
            Return Arr[1]
        
        Arr := Arr.Clone()
        
        Loop Arr.Length
        {
            Index := A_Index
            
            Loop Arr.Length - Index
            {
                if Arr[Index] > Arr[A_Index + Index]
                {
                    Tmp := Arr[Index]
                    Arr[Index] := Arr[A_Index + Index]
                    Arr[A_Index + Index] := Tmp
                }
            }
        }
        
        x := Arr[Arr.Length // 2 + 1]
        
        For i in Arr
        {
            if i == x
            {
                l1 := A_Index - 1
                Break
            }
        }
        
        For i in Arr
        {
            if i > x
            {
                l2 := A_Index - 2
                Break
            }
        }
        
        L := x - Interval / 2
        cf := l1
        f := l2 - l1 + 1
        
        Return L + Interval * (Arr.Length / 2 - cf) / f
    }
    
    ; Mode
    Static Mode(Arr)
    {
        Tmp := Map()
        
        For i in Arr
            Tmp.Has(i) ? Tmp[i]++ : (Tmp[i] := 1)
        
        For Key, Value in Tmp
            isSet(MaxKey) ? ((MaxValue < Value) ? (MaxKey := Key, MaxValue := Value) : "") : (MaxKey := Key, MaxValue := Value)
        
        Return MaxKey
    }
    
    Static MultiMode(Arr)
    {
        Tmp := Map()
        Tmp2 := []
        
        For i in Arr
            Tmp.Has(i) ? Tmp[i]++ : (Tmp[i] := 1)
        
        For Key, Value in Tmp
            isSet(MaxValue) ? ((MaxValue < Value) ? (MaxValue := Value) : "") : (MaxValue := Value)
        
        For Key, Value in Tmp
        {
            if Value == MaxValue
                Tmp2.Push(Key)
        }
        
        Return Tmp2
    }
    
    ; Standard deviation
    Static Pstdev(Arr)
    {
        avg := Statistics.FMean(Arr)
        Sum := 0
        
        For i in Arr
            Sum += (i - avg) ** 2
        
        Return Sqrt(Sum / Arr.Length)
    }
    
    Static Pvariance(Arr)
    {
        avg := Statistics.FMean(Arr)
        Sum := 0
        
        For i in Arr
            Sum += (i - avg) ** 2
        
        Return Sum / Arr.Length
    }
    
    Static Stddev(Arr)
    {
        avg := Statistics.FMean(Arr)
        Sum := 0
        
        For i in Arr
            Sum += (i - avg) ** 2
        
        Return Sqrt(Sum / (Arr.Length - 1))
    }
    
    Static Variance(Arr)
    {
        avg := Statistics.FMean(Arr)
        Sum := 0
        
        For i in Arr
            Sum += (i - avg) ** 2
        
        Return Sum / (Arr.Length - 1)
    }
    
    ; Other Function
    Static Correlation(x, y)
    {
        Return Statistics.Covariance(x, y) / (Statistics.Stddev(x) * Statistics.Stddev(y))
    }
    
    Static Covariance(x, y)
    {
        Ex := Statistics.FMean(x)
        Ey := Statistics.FMean(y)
        xy := []
        
        Loop x.Length
            xy.Push(x[A_Index] * y[A_Index])
        
        Exy := Statistics.FMean(xy)
        
        Return (Exy - Ex * Ey) * x.Length / (x.Length - 1)
    }
    
    Static Linear_Regression(x, y)
    {
        x_ := Statistics.FMean(x)
        y_ := Statistics.FMean(y)
        
        Sum1 := 0
        Sum2 := 0
        
        Loop x.Length
        {
            Sum1 += x[A_Index] * y[A_Index]
            Sum2 += x[A_Index] ** 2
        }
        
        b := (Sum1 - x.Length * x_ * y_) / (Sum2 - x.Length * (x_ ** 2))
        a := y_ - b * x_
        
        Return [b, a]
    }
    
    Static Quantiles(Arr, n := 4, method := "exclusive")
    {
        Arr := Arr.Clone()
        
        Loop Arr.Length
        {
            Index := A_Index
            
            Loop Arr.Length - Index
            {
                if Arr[Index] > Arr[A_Index + Index]
                {
                    Tmp := Arr[Index]
                    Arr[Index] := Arr[A_Index + Index]
                    Arr[A_Index + Index] := Tmp
                }
            }
        }
        
        if method == "inclusive"
        {
            m := Arr.Length - 1
            result := []
            
            Loop n - 1
            {
                j := A_Index * m // n
                delta := Mod(A_Index * m, n)
                interpolated := (Arr[j + 1] * (n - delta) + Arr[j + 2] * delta) / n
                result.Push(interpolated)
            }
            
            Return result
        }
        
        if method == "exclusive"
        {
            m := Arr.Length + 1
            result := []
            
            Loop n - 1
            {
                j := A_Index * m // n
                j := (j < 1) ? 1 : (j > Arr.Length - 1) ? Arr.Length - 1 : j
                delta := A_Index * m - j * n
                interpolated := (Arr[j] * (n - delta) + Arr[j + 1] * delta) / n
                result.Push(interpolated)
            }
            
            Return result
        }
    }
}
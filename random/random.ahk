; Author: Mono
; Time: 2022.09.22
; Version: 1.0.0

_RandomSeed := TimeStamp.ConvertUnix(A_Now)
_RandomStep := 1000
_RandomTimes := 100

Class _Random
{
    Static Choice(Number*)
    {
        Lst_Number := []
        
        Loop Number.Length
        {
            if Type(Number[A_Index]) == "Array"
            {
                index := A_Index
                Loop Number[index].Length
                    Lst_Number.Push(Number[index][A_Index])
            }
            
            else
                Lst_Number.Push(Number[A_Index])
        }
        
        Return Lst_Number[_Random.Random(1, Lst_Number.Length)]
    }
    
    Static CryptRandom()
    {
        buf := Buffer(8, 0)
        ret := ""
        DllCall("bcrypt.dll\BCryptGenRandom", "Ptr", 0, "Ptr", buf, "UInt64", buf.size, "UInt64", 0x00000002)
        tmp := NumGet(buf, 0, "UShort")
        tmp := CryptStrAdd(tmp, CryptStrMul(NumGet(buf, 2, "UShort"), 2 ** 16))
        tmp := CryptStrAdd(tmp, CryptStrMul(NumGet(buf, 4, "UShort"), 2 ** 32))
        tmp := CryptStrAdd(tmp, CryptStrMul(NumGet(buf, 6, "UShort"), 2 ** 48))
        ret := CryptStrAdd(ret, tmp)
        
        Return ret
    }
    
    Static Getrandbits(k)
    {
        Return _Random.Randint(0, 2 ** k)
    }
    
    Static Rand()
    {
        Global _RandomSeed
        
        Loop Random(_RandomTimes)
            _RandomSeed := Mod((214013 * _RandomSeed + 2531011), 0x100000000)
        
        Return _RandomSeed * (1.0 / 4294967296.0)
    }
    
    Static Randn(Number)
    {
        Return Array(BoxMuller(Number)*)
    }
    
    Static Random(A := "", B := "")
    {
        if A == ""
        {
            A := 0
            B := 1
        }
        
        else if B == ""
        {
            tmp := A
            A := 0
            B := tmp
        }
        
        else if A > B
        {
            tmp := A
            A := B
            B := tmp
        }
        
        if B - A > 1
            Ret := Integer((B + 1 - A) * _Random.Random() + A)
        
        else
            Ret := ((10 ** 18) & MT19937(_RandomSeed)) / (10 ** 18) + A
        
        _Random.Seed(_RandomSeed + _RandomStep)
        
        Return Ret
    }
    
    Static RandInt(A := 0, B := 1)
    {
        Ret := Integer((B + 1 - A) * _Random.Random() + A)
        _Random.Seed(_RandomSeed + _RandomStep)
        
        Return Ret
    }
    
    Static RandRange(Start, Stop := "", Step := 1)
    {
        Lst_RandRange := _Random.Range(Start, Stop, Step).Array()
        
        Return Lst_RandRange[_Random.Random(1, Lst_RandRange.Length)]
    }
    
    Class Range
    {
        __New(Start, Stop := "", Step := 1)
        {
            if !Step
                Throw ValueError("Step cannot be 0.")
            
            if Stop == ""
            {
                Tmp := Start
                Start := 1
                Stop := Tmp
            }
            
            this.Length := Max(0, (Stop - Start) // Abs(Step) + 1)
            this.Start := Start
            this.Stop := Stop
            this.Step := Step
        }
        
        __Enum(_)
        {
            this.LoopTimes := this.Length
            this.Index := 0
            
            Return Fn
            
            Fn(&Idx := 0, &Value := 0)
            {
                if !this.LoopTimes
                    Return False
                
                Idx := (IsSet(Value)) ? this.Start + this.Index * this.Step : this.Index + 1
                Value := this.Start + this.Index * this.Step
                this.Index++
                
                Return this.LoopTimes--
            }
        }
        
        Array()
        {
            Ret := []
            
            Loop this.Length
            {
                if this.Step > 0
                    Ret.Push(this.Start + (A_Index - 1) * this.Step)
                
                else
                    Ret.Push(this.Stop + (A_Index - 1) * this.Step)
            }
            
            Return Ret
        }
    }
    
    Static Sample(Sequence, k)
    {
        Start := _Random.Random(Sequence.Length)
        Ret := []
        
        Loop k
            Ret.push(Sequence[Mod(A_Index + Start, k) + 1])
        
        Return Ret
    }
    
    Static Seed(Number)
    {
        Global _RandomSeed := Number
    }
    
    Static Shuffle(Lst_Number)
    {
        Loop _Random.RandRange(1, Lst_Number.Length, 1)
        {
            SwapX := _Random.RandRange(1, Lst_Number.Length, 1)
            SwapY := _Random.RandRange(1, Lst_Number.Length, 1)
            _Random.Swap(SwapX, SwapY, Lst_Number)
        }
        
        Return Lst_Number
    }
    
    Static Step(Number)
    {
        Global _RandomStep := Number
    }
    
    Static Swap(ValueX, ValueY, Arr)
    {
        Temp := Arr[ValueX]
        Arr[ValueX] := Arr[ValueY]
        Arr[ValueY] := Temp
    }
    
    Static Times(Number)
    {
        Global _RandomTimes := Number
    }
    
    Static Triangular(low := 0, high := 1, mode := -1)
    {
        mode := (mode == -1) ? ((low + high) / 2) : mode
    }
    
    Static Uniform(Stop, Start := 0, Swap := -1)
    {
        if Swap == -1
        {
            Temp := Stop
            Stop := Start
            Start := Temp
        }
        
        Random_Value := _Random.Random()
        
        Return Start + (Stop - Start) * Random_Value
    }
}

BoxMuller(Number)
{
    Avg := 0
    Diff := 1
    Lst_y := []
    Pi := 3.141592653589793
    
    Loop Number
    {
        A := _Random.Random()
        B := _Random.Random()
        y := Sqrt((-2) * Log(A)) * Cos(2 * Pi * B) * Diff + Avg
        Lst_y.Push(y)
    }
    
    Return Lst_y
}

CryptStrBin2Dec(num)
{
    ret := "0"
    tmp := "1"
    num := StrSplit(num)
    
    Loop num.Length
    {
        if num[-A_Index] == "0"
        {
            tmp := CryptStrMul(tmp, "2")
            Continue
        }
        
        ret := CryptStrAdd(ret, tmp)
        tmp := CryptStrMul(tmp, "2")
    }
    
    Return ret
}

CryptStrDec2Bin(num)
{
    if num == "1"
        Return "1"
    
    retstr := ""
    tmpret := ""
    
    while num
    {
        tmpret := CryptStrMul(num, "5")
        retstr .= (StrSplit(tmpret)[-1] == "5") ? 1 : 0
        num := SubStr(tmpret, 1, StrLen(tmpret) - 1)
        
        if num == "1"
        {
            retstr .= "1"
            Break
        }
    }
    
    retstr := StrSplit(retstr)
    ret := ""
    
    Loop retstr.Length
        ret .= retstr[-A_Index]
    
    Return ret ? ret : "0"
}

CryptStrBitAnd(num1, num2)
{
    num1 := StrSplit(num1)
    num2 := StrSplit(num2)
    retstr := ""
    
    if num1.Length > num2.Length
    {
        tmp := num1
        num1 := num2
        num2 := tmp
    }
    
    Loop num1.Length
        retstr .= num1[-A_Index] & num2[-A_Index]
    
    retstr := StrSplit(retstr)
    ret := ""
    flag := False
    
    Loop retstr.Length
    {
        if !flag
        {
            flag := retstr[-A_Index]
            
            if !flag
                Continue
        }
        
        ret .= retstr[-A_Index]
    }
    
    Return ret ? ret : "0"
}

CryptStrBitOr(num1, num2)
{
    num1 := StrSplit(num1)
    num2 := StrSplit(num2)
    retstr := ""
    
    if num1.Length > num2.Length
    {
        tmp := num1
        num1 := num2
        num2 := tmp
    }
    
    Loop num2.Length
    {
        if A_Index <= num1.Length
            retstr .= num1[-A_Index] | num2[-A_Index]
        
        else
            retstr .= num2[-A_Index]
    }
    
    retstr := StrSplit(retstr)
    ret := ""
    flag := False
    
    Loop retstr.Length
    {
        if !flag
        {
            flag := retstr[-A_Index]
            
            if !flag
                Continue
        }
        
        ret .= retstr[-A_Index]
    }
    
    Return ret ? ret : "0"
}

CryptStrBitXOr(num1, num2)
{
    num1 := StrSplit(num1)
    num2 := StrSplit(num2)
    retstr := ""
    
    if num1.Length > num2.Length
    {
        tmp := num1
        num1 := num2
        num2 := tmp
    }
    
    Loop num2.Length
    {
        if A_Index <= num1.Length
            retstr .= num1[-A_Index] ^ num2[-A_Index]
        
        else
            retstr .= 1 - num2[-A_Index]
    }
    
    retstr := StrSplit(retstr)
    ret := ""
    flag := False
    
    Loop retstr.Length
    {
        if !flag
        {
            flag := retstr[-A_Index]
            
            if !flag
                Continue
        }
        
        ret .= retstr[-A_Index]
    }
    
    Return ret ? ret : "0"
}

CryptStrAdd(num1, num2)
{
    num1 := StrSplit(num1)
    num2 := StrSplit(num2)
    end1 := num1.Length - 1
    end2 := num2.Length - 1
    retstr := ""
    next := 0

    while (end1 >= 0 || end2 >= 0)
    {
        val1 := 0
        
        if (end1 >= 0)
        {
            val1 := num1[end1 + 1] - 0
            end1--
        }

        val2 := 0
        
        if (end2 >= 0)
        {
            val2 := num2[end2 + 1] - 0
            end2--
        }

        ret := val1 + val2 + next
        
        if (ret > 9)
        {
            ret -= 10
            next := 1
        }
        
        else
            next := 0
        
        retstr .= ret
    }
    
    if (next == 1)
        retstr .= 1
    
    res := ""
    retstr := StrSplit(retstr)
    
    Loop retstr.Length
        res .= retstr[-A_Index]

    return res ? res : "0"
}

CryptStrMul(num1, num2)
{
    num1 := StrSplit(num1)
    num2 := StrSplit(num2)
    m := num1.Length
    n := num2.Length
    res := []
    
    Loop m + n
        res.push(0)
    
    Loop m
    {
        i := m - A_Index
        
        Loop n
        {
            j := n - A_Index
            mul := (num1[i + 1] - 0) * (num2[j + 1] - 0)
            p1 := i + j
            p2 := i + j + 1
            sum := mul + res[p2 + 1]
            res[p2 + 1] := mod(sum, 10)
            res[p1 + 1] += sum // 10
        }
    }
    
    i := 0
    
    while (i < res.Length && res[i + 1] == 0)
        i++
    
    str := ""
    i++
    
    Loop res.Length - i + 1
        str .= (res[i++])
    
    Return Strlen(str) == 0 ? "0" : str
}

MT19937(seed)
{
    ; enum
    N := 624
    M := 397
    R := 31
    A := 0x9908B0DF
    F := 1812433253
    U := 11
    S := 7
    B := 0x9D2C5680
    T := 15
    C := 0xEFC60000
    L := 18
    MASK_LOWER := (1 << R) - 1
    MASK_UPPER := (1 << R)
    
    mt := []
    mt.Length := N
    index := 0
    Initialize(seed)
    
    Return Extract()
    
    Initialize(seed)
    {
        mt[1] := seed
        
        Loop N - 1
        {
            mt[A_Index + 1] := (F * (mt[A_Index] ^ (mt[A_Index] >> 30)) + A_Index)
        }
        
        index := N
    }
    
    Twist()
    {
        Loop N - 1
        {
            x := (mt[A_Index + 1] & MASK_UPPER) + (mt[Mod((A_Index + 1), N) + 1] & MASK_LOWER)
            xA := x >> 1
            
            if (X & 0x1)
            {
                xA ^= A
            }
            
            mt[A_Index] := mt[Mod((A_Index + M), N) + 1] ^ xA
        }
        
        index := 0
    }
    
    Extract()
    {
        i := index
        
        if index >= N
        {
            Twist()
            i := index
        }
        
        y := mt[i + 1]
        index := i + 1
        y ^= (y >> U)
        y ^= (y << S) & B
        y ^= (y << T) & C
        y ^= (y >> L)
        
        return y
    }
}

ClearMT19937(seed)
{
    ; enum
    N := 624
    M := 397
    R := 31
    A := 0x9908B0DF
    F := 1812433253
    U := 11
    S := 7
    B := 0x9D2C5680
    T := 15
    C := 0xEFC60000
    L := 18
    MASK_LOWER := (1 << R) - 1
    MASK_UPPER := (1 << R)
    
    mt := []
    mt.Length := N
    index := 0
    Initialize(seed)
    
    Return Extract()
    
    Initialize(seed)
    {
        mt[1] := seed
        
        Loop N - 1
        {
            tmp := CryptStrDec2Bin(mt[A_Index])
            tmp2 := (StrLen(tmp) > 30) ? SubStr(tmp, 1, StrLen(tmp) - 30) : "0"
            mt[A_Index + 1] := CryptStrDec2Bin(CryptStrMul(F, CryptStrAdd(CryptStrBin2Dec(CryptStrBitXOr(tmp, tmp2)), A_Index)))
        }
        
        index := N
    }
    
    Twist()
    {
        Loop N - 1
        {
            x := CryptStrAdd(CryptStrBin2Dec(CryptStrBitAnd(mt[A_Index + 1], CryptStrDec2Bin(MASK_UPPER))), CryptStrBin2Dec(CryptStrBitAnd(mt[Mod((A_Index + 1), N) + 1], CryptStrDec2Bin(MASK_LOWER))))
            tmp := CryptStrDec2Bin(x)
            tmp2 := (StrLen(tmp) > 1) ? SubStr(tmp, 1, StrLen(tmp) - 1) : "0"
            xA := tmp2
            
            if CryptStrBitAnd(tmp, "1")
            {
                xA := CryptStrBitXOr(xA, CryptStrDec2Bin(A))
            }
            
            mt[A_Index] := CryptStrBitXOr(mt[Mod((A_Index + M), N) + 1], xA)
        }
        
        index := 0
    }
    
    Extract()
    {
        i := index
        
        if index >= N
        {
            Twist()
            i := index
        }
        
        y := mt[i + 1]
        index := i + 1
        tmp := (StrLen(y) > U) ? SubStr(y, 1, StrLen(y) - U) : "0"
        y := CryptStrBitXOr(y, tmp)
        
        Loop S
            y .= "0"
       
        y := CryptStrBitXOr(y, CryptStrBitAnd(y, CryptStrDec2Bin(B)))
        
        Loop T
            y .= "0"
        
        y := CryptStrBitXOr(y, CryptStrBitAnd(y, CryptStrDec2Bin(C)))
        tmp := (StrLen(y) > L) ? SubStr(y, 1, StrLen(y) - L) : "0"
        y := CryptStrBitXOr(y, tmp)
        
        Return CryptStrBin2Dec(y)
    }
}

Class TimeStamp
{
    Static ConvertUnix(InputTime, Zone := 8)
    {
        Deviation := -Zone * 60 * 60
        Ret := DateDiff(InputTime, 19700101000000, "Seconds") + Deviation
        
        Return Ret
    }
    
    Static ConvertUTC(InputTime, Zone := 8)
    {
        Deviation := -Zone * 60 * 60
        Init := 62135596800
        Ret := (DateDiff(InputTime, 19700101000000, "Seconds") + Deviation + Init) * 10000000
        
        Return Ret
    }
    
    Static ConvertCommon(InputTime, TimeType, Zone := 8)
    {
        Deviation := Zone * 60 * 60
        Init := 62135596800
        
        if TimeType = "UTC"
        {
            Ret := DateAdd(19700101000000, (InputTime // 10000000) - Init + Deviation, "Seconds")
        }
        
        else if TimeType == "Unix"
        {
            Ret := DateAdd(19700101000000, InputTime + Deviation, "Seconds")
        }
        
        Return Ret
    }
}
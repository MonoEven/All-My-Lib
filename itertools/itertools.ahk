; Author: Mono
; Time: 2022.09.22
; Version: 1.0.0

Class Itertools
{
    Class Accumulate
    {
        __New(arr, function := -1)
        {
            if arr is String
                arr := StrSplit(arr)
            
            this.arr := arr
            this.pos := 1
            this.ret := 0
            this.function := (function == -1) ? add : function
            
            add(x, y)
            {
                Return x + y
            }
        }
        
        __Enum(_)
        {
            Return Fn
            
            Fn(&ret)
            {
                if this.pos > this.arr.Length
                {
                    this.pos := 1
                    
                    Return False
                }
                
                if this.pos == 1
                {
                    this.ret := this.arr[this.pos++]
                    ret := this.ret
                }
                
                else
                {
                    this.ret := this.function.call(this.ret, this.arr[this.pos++])
                    ret := this.ret
                }                
                Return True
            }
        }
    }
    
    Class Chain
    {
        __New(arr*)
        {
            if arr is String
                arr := StrSplit(arr)
            
            this.arr := arr
            this.pos := 1
            this.pos2d := 1
        }
        
        __Enum(_)
        {
            Return Fn
            
            Fn(&ret)
            {
                if this.pos2d > this.arr[this.pos].Length
                {
                    this.pos2d := 1
                    this.pos++
                }
                
                if this.pos > this.arr.Length
                {
                    this.pos := 1
                    
                    Return False
                }
                
                ret := this.arr[this.pos][this.pos2d++]
                
                Return True
            }
        }
    }
    
    Class Combinations
    {
        __New(arr, times)
        {
            if arr is String
                arr := StrSplit(arr)
            
            this.arr := arr
            this.pos := []
            this.times := times
            
            Loop this.times
                this.pos.Push(1)
        }
        
        __Enum(_)
        {
            Return Fn
            
            Fn(&ret)
            {
                flag := 0
                
                Loop this.times - 1
                {
                    if this.pos[-A_Index] > this.arr.Length
                    {
                        this.pos[-A_Index] := 1
                        this.pos[-A_Index - 1]++
                    }
                }
                
                if this.pos[1] > this.arr.Length
                {
                    this.pos[1] := 1
                    
                    Return False
                }
                
                while !flag
                {
                    tmp := []
                    tmp2 := Map()
                    
                    Loop this.times
                    {
                        tmpflag := (A_Index == 1) ? 0 : (this.arr[this.pos[A_Index]] > this.arr[this.pos[A_Index - 1]]) ? 0 : 1
                        
                        if tmp2.Has(this.arr[this.pos[A_Index]]) || tmpflag
                        {
                            this.pos[-1]++
                            
                            Loop this.times - 1
                            {
                                if this.pos[-A_Index] > this.arr.Length
                                {
                                    this.pos[-A_Index] := 1
                                    this.pos[-A_Index - 1]++
                                }
                            }
                            
                            if this.pos[1] > this.arr.Length
                            {
                                this.pos[1] := 1
                                
                                Return False
                            }
                            
                            Continue 2
                        }
                        
                        else
                        {
                            tmp.Push(this.arr[this.pos[A_Index]])
                            tmp2[this.arr[this.pos[A_Index]]] := 0
                        }
                    }
                    
                    ret := tmp
                    this.pos[-1]++
                    flag := 1
                }
                
                Return True
            }
        }
    }
    
    Class Combinations_With_Replacement
    {
        __New(arr, times)
        {
            if arr is String
                arr := StrSplit(arr)
            
            this.arr := arr
            this.pos := []
            this.times := times
            
            Loop this.times
                this.pos.Push(1)
        }
        
        __Enum(_)
        {
            Return Fn
            
            Fn(&ret)
            {
                flag := 0
                
                Loop this.times - 1
                {
                    if this.pos[-A_Index] > this.arr.Length
                    {
                        this.pos[-A_Index] := 1
                        this.pos[-A_Index - 1]++
                    }
                }
                
                if this.pos[1] > this.arr.Length
                {
                    this.pos[1] := 1
                    
                    Return False
                }
                
                while !flag
                {
                    tmp := []
                    
                    Loop this.times
                    {
                        tmpflag := (A_Index == 1) ? 0 : (this.arr[this.pos[A_Index]] >= this.arr[this.pos[A_Index - 1]]) ? 0 : 1
                        
                        if tmpflag
                        {
                            this.pos[-1]++
                            
                            Loop this.times - 1
                            {
                                if this.pos[-A_Index] > this.arr.Length
                                {
                                    this.pos[-A_Index] := 1
                                    this.pos[-A_Index - 1]++
                                }
                            }
                            
                            if this.pos[1] > this.arr.Length
                            {
                                this.pos[1] := 1
                                
                                Return False
                            }
                            
                            Continue 2
                        }
                        
                        else
                            tmp.Push(this.arr[this.pos[A_Index]])
                    }
                    
                    ret := tmp
                    this.pos[-1]++
                    flag := 1
                }
                
                Return True
            }
        }
    }
    
    Class Compress
    {
        __New(arr, flags)
        {
            if arr is String
                arr := StrSplit(arr)
            
            this.arr := arr
            this.flags := flags
            this.pos := 1
        }
        
        __Enum(_)
        {
            Return Fn
            
            Fn(&ret)
            {
                while (this.pos <= this.flags.Length) && (!this.flags[this.pos])
                    this.pos++
                
                if this.pos > this.arr.Length
                {
                    this.pos := 1
                    
                    Return False
                }
                
                ret := this.arr[this.pos++]
                
                Return True
            }
        }
    }
    
    Class Count
    {
        __New(init, step := 1)
        {
            this.start := init
            this.step := step
        }
        
        __Enum(_)
        {
            Return Fn
            
            Fn(&ret)
            {
                ret := this.start
                this.start += this.step
                
                Return True
            }
        }
    }
    
    Class Cycle
    {
        __New(arr)
        {
            if arr is String
                arr := StrSplit(arr)
            
            this.arr := arr
            this.pos := 1
        }
        
        __Enum(_)
        {
            Return Fn
            
            Fn(&ret)
            {
                ret := this.arr[this.pos]
                this.pos := ((this.pos + 1) > this.arr.Length) ? 1 : (this.pos + 1)
                
                Return True
            }
        }
    }
    
    Class Dropwhile
    {
        __New(function, arr)
        {
            if arr is String
                arr := StrSplit(arr)
            
            this.function := function
            this.flag := 0
            this.arr := arr
            this.pos := 1
        }
        
        __Enum(_)
        {
            Return Fn
            
            Fn(&ret)
            {
                while (!this.flag) && (this.pos <= this.arr.Length) && (this.function.call(this.arr[this.pos]))
                    this.pos++
                
                if this.pos > this.arr.Length
                {
                    this.pos := 1
                    
                    Return False
                }
                
                this.flag := 1
                ret := this.arr[this.pos++]
                
                Return True
            }
        }
    }
    
    Class Filterfalse
    {
        __New(function, arr)
        {
            if arr is String
                arr := StrSplit(arr)
            
            this.function := function
            this.arr := arr
            this.pos := 1
        }
        
        __Enum(_)
        {
            Return Fn
            
            Fn(&ret)
            {
                while (this.pos <= this.arr.Length) && (this.function.call(this.arr[this.pos]))
                    this.pos++
                
                if this.pos > this.arr.Length
                {
                    this.pos := 1
                    
                    Return False
                }
                
                ret := this.arr[this.pos++]
                
                Return True
            }
        }
    }
    
    Class Ifilter
    {
        __New(Func, Iterable)
        {
            this.Func := Func
            this.Iterable := Iterable
        }
        
        __Enum(Number)
        {
            this.Pos := this.Iterable
            
            Return Fn
            
            Fn(&Res := 0)
            {
                Res := Next(this.Pos)
                
                While !this.Func.Call(Res)
                    Res := Next(this.Pos)
                
                Return 1
            }
        }
    }
    
    Class IfilterFalse
    {
        __New(Func, Iterable)
        {
            this.Func := Func
            this.Iterable := Iterable
        }
        
        __Enum(Number)
        {
            this.Pos := this.Iterable
            
            Return Fn
            
            Fn(&Res := 0)
            {
                Res := Next(this.Pos)
                
                While this.Func.Call(Res)
                    Res := Next(this.Pos)
                
                Return 1
            }
        }
    }
    
    Class Islice
    {
        __New(arr, start, stop := "", step := 1)
        {
            if arr is String
                arr := StrSplit(arr)
            
            if !step
                Throw ValueError("Step cannot be 0.")
            
            if stop == ""
            {
                tmp := start
                start := 1
                stop := tmp
            }
            
            this.arr := arr
            this.index := 0
            this.start := start
            this.stop := stop
            this.step := step
            this.length := Max(0, (this.stop - this.start) // Abs(this.step) + 1)
        }
        
        __Enum(_)
        {
            Return Fn
            
            Fn(&ret)
            {
                if !this.Length
                {
                    this.length := Max(0, (this.stop - this.start) // Abs(this.step) + 1)
                    this.index := 0
                    
                    Return False
                }
                
                ret := this.arr[this.start + this.index * this.step]
                this.index++
                
                Return this.length--
            }
        }
    }
    
    Class Pairwise
    {
        __New(arr)
        {
            if arr is String
                arr := StrSplit(arr)
            
            this.arr := arr
            this.pos := 1
        }
        
        __Enum(_)
        {
            Return Fn
            
            Fn(&ret)
            {
                if this.pos >= this.arr.length
                {
                    this.pos := 1
                    
                    Return False
                }
                
                ret := [this.arr[this.pos++], this.arr[this.pos]]
                
                Return True
            }
        }
    }
    
    Class Permutations
    {
        __New(arr, times)
        {
            if arr is String
                arr := StrSplit(arr)
            
            this.arr := arr
            this.pos := []
            this.times := times
            
            Loop this.times
                this.pos.Push(1)
        }
        
        __Enum(_)
        {
            Return Fn
            
            Fn(&ret)
            {
                flag := 0
                
                Loop this.times - 1
                {
                    if this.pos[-A_Index] > this.arr.Length
                    {
                        this.pos[-A_Index] := 1
                        this.pos[-A_Index - 1]++
                    }
                }
                
                if this.pos[1] > this.arr.Length
                {
                    this.pos[1] := 1
                    
                    Return False
                }
                
                while !flag
                {
                    tmp := []
                    tmp2 := Map()
                    
                    Loop this.times
                    {
                        if tmp2.Has(this.arr[this.pos[A_Index]])
                        {
                            this.pos[-1]++
                            
                            Loop this.times - 1
                            {
                                if this.pos[-A_Index] > this.arr.Length
                                {
                                    this.pos[-A_Index] := 1
                                    this.pos[-A_Index - 1]++
                                }
                            }
                            
                            if this.pos[1] > this.arr.Length
                            {
                                this.pos[1] := 1
                                
                                Return False
                            }
                            
                            Continue 2
                        }
                        
                        else
                        {
                            tmp.Push(this.arr[this.pos[A_Index]])
                            tmp2[this.arr[this.pos[A_Index]]] := 0
                        }
                    }
                    
                    ret := tmp
                    this.pos[-1]++
                    flag := 1
                }
                
                Return True
            }
        }
    }
    
    Class Product
    {
        __New(arr*)
        {
            For i in arr
            {
                if i is String
                    arr[A_Index] := StrSplit(i)
            }
            
            this.arr := arr
            this.pos := []
            
            Loop this.arr.Length
                this.pos.Push(1)
        }
        
        __Enum(_)
        {
            Return Fn
            
            Fn(&ret)
            {
                Loop this.arr.Length - 1
                {
                    if this.pos[-A_Index] > this.arr[-A_Index].Length
                    {
                        this.pos[-A_Index] := 1
                        this.pos[-A_Index - 1]++
                    }
                }
                
                if this.pos[1] > this.arr[1].Length
                {
                    this.pos[1] := 1
                    
                    Return False
                }
                
                tmp := []
                
                Loop this.arr.Length
                    tmp.Push(this.arr[A_Index][this.pos[A_Index]])
                
                ret := tmp
                this.pos[-1]++
                
                Return True
            }
        }
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
    
    Class Repeat
    {
        __New(value, times := -1)
        {
            this.value := value
            this.times := times
        }
        
        __Enum(_)
        {
            Return Fn
            
            Fn(&ret)
            {
                ret := this.value
                
                if !this.times
                    Return False
                
                this.times--
                Return True
            }
        }
    }
    
    Class Takewhile
    {
        __New(function, arr)
        {
            if arr is String
                arr := StrSplit(arr)
            
            this.function := function
            this.arr := arr
            this.pos := 1
        }
        
        __Enum(_)
        {
            Return Fn
            
            Fn(&ret)
            {
                if this.pos > this.arr.Length
                {
                    this.pos := 1
                    
                    Return False
                }
                
                if this.function.call(this.arr[this.pos])
                    ret := this.arr[this.pos++]
                
                else
                {
                    this.pos := 1
                    
                    Return False
                }
                
                Return True
            }
        }
    }
    
    Class Zip_Longest
    {
        __New(arr*)
        {
            if !(arr[-1] is Array)
                this.fillvalue := arr.pop()
            
            else
                this.fillvalue := 0
            
            this.maxlength := 0
            
            For i in arr
            {
                if i is String
                {
                    i := StrSplit(i)
                    arr[A_Index] := i
                }
            
                if i.Length > this.maxlength
                    this.maxlength := i.Length
            }
            
            this.arr := arr
            this.pos := 1
        }
        
        __Enum(_)
        {
            Return Fn
            
            Fn(&ret)
            {
                if this.pos > this.maxlength
                {
                    this.pos := 1
                    
                    Return False
                }
                
                tmp := []
                
                For i in this.arr
                {
                    if i.Length >= this.pos
                        tmp.Push(i[this.pos])
                    
                    else
                        tmp.Push(this.fillvalue)
                }
                
                ret := tmp
                this.pos++
                
                Return True
            }
        }
    }
}

Next(iter)
{
    For i in iter
        Return i
}

List(iter)
{
    Ret := []
    
    For i in iter
        Ret.Push(i)
    
    Return Ret
}
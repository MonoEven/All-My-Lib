; Author: Mono
; Time: 2022.11.08
; Version: 1.0.0

#Include <ahktype\ahktype>
#Include <data\debug>
#Include <xa\xa>

; DefProp
DefProp(Numahk.NDArray().Base, "T", {Get: NumahkTranspose})

NumahkAdd(this)
{
    Return this.Add
}

NumahkTranspose(this)
{
    Return Numahk.Transpose(this)
}

Class Numahk
{
    Static E := 2.718281828459045
    Static PI := 3.141592653589793
    Static TAU := 6.283185307179586
    Static INF := 2 ** 63 - 1
    Static NAN := "-"
    
    Static __version()
    {
        Return "1.0.0"
    }
    
    Class NDArray Extends Array
    {
        ; Basic
        __New(Obj*)
        {
            if !Obj.Length
                Return
            
            Obj.Standardization()
            
            if Obj.NDim == 1
                this.Extend(Obj)
            
            else
            {
                Obj := Obj[1]
                
                For i in Obj
                {
                    if i.NDim == 0
                        this.Extend(i)
                    
                    else
                        this.Push(Numahk.NDArray(i))
                }
            }
        }
        
        __Item[Pos*]
        {
            Get => this.GetMethod(Pos*)
            Set => this.SetMethod(Value, True, Pos*)
        }
        
        __Len()
        {
            Return this.Shape
        }
        
        GetMethod(Lst_Pos*)
        {
            if Lst_Pos.NDim == 1
                Return this.GetSingleMethod(Lst_Pos*)
            
            Tmp := Lst_Pos.Shape
            Tmp.Pop()
            Lst_Pos := Numahk.NDArray(Lst_Pos)
            
            New_Pos := []
            
            For i in Tmp
                New_Pos.Push(Range(1, i).Array())
            
            New_Pos := Dynloop_Loop(New_Pos)
            TmpNDArray := Numahk.Zeros(Tmp)
            
            For i in New_Pos
                TmpNDArray.SetMethod(this.GetSingleMethod(Lst_Pos[i*]*), False, i*)
            
            Return TmpNDArray
        }
        
        GetSingleMethod(Pos*)
        {
            For i in Pos
            {
                if InStr(i, ":")
                {
                    i := i.range
                    
                    if i[2] == -1
                        i[2] := this.Shape[A_Index]
                    
                    Pos[A_Index] := Range(i*).Array()
                }
            }
            
            if Pos.NDim > 1
            {
                Pos := Dynloop_Loop(Pos)
                Tmp := []
                
                For i in Pos
                    Tmp.Push(this.GetSingleMethod(i*))
                
                Return Tmp
            }
            
            Tmp := [this]
            Pos := Pos.Clone()
            
            While Pos.Length
            {
                TmpPos := Pos.RemoveAt(1)
                Tmpthis := Tmp.Pop()
                
                For i in Tmpthis
                {
                    if TmpPos == A_Index
                        Tmp.Push(i)
                }
            }
            
            Return Tmp[-1]
        }
        
        SetMethod(Value, Flag, Pos*)
        {
            Value := (Value.NDim) ? Numahk.NDArray(Value) : Value
            Pos := Pos.Clone()
            LastPos := Pos.Pop()
            Tmp := this.GetSingleMethod(Pos*)
            
            if ListCmp(Tmp[LastPos].Shape, Value.Shape) && Flag
                Throw ValueError("SetMethod Error!`nTarget shape is " Print.ToString(Tmp[LastPos].Shape) ".`nBut got an object with shape " Print.ToString(Value.Shape) ".")
            
            Tmp.RemoveAt(LastPos)
            Tmp.InsertAt(LastPos, Value)
        }
        
        ToString()
        {
            if this.Length < 1
                return "[]"
            
            plus := ""
            text := "[" . debug.ToString(this[1])
            
            Loop this.Length - 1
                plus .= "," . debug.ToString(this[A_Index + 1])
            
            text .= plus
            text .= "]"
            
            return text
        }
        
        ; Operator
        Add(NDArray := 0)
        {
            Return Numahk.Add(this, NDArray)
        }
        
        Div(NDArray := 1)
        {
            Return Numahk.Divide(this, NDArray)
        }
        
        Mul(NDArray := 1)
        {
            Return Numahk.Multiply(this, NDArray)
        }
        
        Sub(NDArray := 0)
        {
            Return Numahk.Subtract(this, NDArray)
        }
        
        ; Function
        All()
        {
            Return Numahk.All()
        }
        
        AMax(Axis := "axis=None")
        {
            Return Numahk.Max(this, Axis)
        }
        
        AMin(Axis := "axis=None")
        {
            Return Numahk.Min(this, Axis)
        }
        
        Any()
        {
            Return Numahk.Any()
        }
        
        ArgMax(Axis := "axis=None")
        {
            Return Numahk.ArgMax(this, Axis)
        }
        
        ArgMin(Axis := "axis=None")
        {
            Return Numahk.ArgMin(this, Axis)
        }
        
        CumProd(Axis := "axis=None")
        {
            Return Numahk.CumProd(this, Axis)
        }
        
        CumSum(Axis := "axis=None")
        {
            Return Numahk.CumSum(this, Axis)
        }
        
        Dot(NDArray*)
        {
            Return Numahk.Dot(this, NDArray*)
        }
        
        Max(Axis := "axis=None")
        {
            Return Numahk.Max(this, Axis)
        }
        
        Mean(Axis := "axis=None")
        {
            Return Numahk.Mean(this, Axis)
        }
        
        Min(Axis := "axis=None")
        {
            Return Numahk.Min(this, Axis)
        }
        
        Reshape(Shape*)
        {
            if Shape.NDim == 2
                Shape := Shape[1]
            
            OldShape := this.Shape
            TmpShape := Shape.Clone()
            
            For i in TmpShape
            {
                if i = -1
                    TmpShape[A_Index] := OldShape.Product // Abs(Shape.Product)
            }
            
            if OldShape.Product !== TmpShape.Product
                Return this
            
            if TmpShape.Length == 1
                Return this.Ravel()
            
            this.Ravel()
            Tmpthis := this.Clone()
            Tmp := []
            LoopTimes := TmpShape.RemoveAt(1)
            
            Loop LoopTimes
            {
                Tmp2 := []
                Loop TmpShape.Product
                    Tmp2.Push(Tmpthis.RemoveAt(1))
                
                Tmp.Push(Tmp2.Reshape(TmpShape))
            }
            
            this.Length := 0
            
            For j in Tmp
                this.Push(Numahk.NDArray(j))
            
            Return this
        }
        
        Sort(Axis := "axis=None")
        {
            Return Numahk.Sort(this, Axis)
        }
        
        Std(Axis := "axis=None")
        {
            Return Numahk.Std(this, Axis)
        }
        
        Sum(Axis := "axis=None")
        {
            Return Numahk.Sum(this, Axis)
        }
        
        SwapAxes(Axis1, Axis2)
        {
            Tmp := Range(0, this.NDim - 1).Array()
            Tmp.Swap(Axis1 + 1, Axis2 + 1)
            
            Return this.Transpose(Tmp)
        }
        
        Transpose(Shape*)
        {
            if !Shape.Length
                Return this.T
            
            if Shape.NDim == 2
                Shape := Shape[1]
            
            New_Shape := Shape.Clone()
            Tmp := this.Shape
            
            For i in Shape
                New_Shape[A_Index] := Tmp[Shape.Index(A_Index - 1)]
            
            New_NDArray := Numahk.Zeros(New_Shape)
            
            Pos_Old := []
            Pos_New := []
            
            Loop Tmp.Length
                Pos_Old.Push(Range(1, Tmp[A_Index]).Array())
            
            Pos_Old := Dynloop_Loop(Pos_Old)
            
            For i in Pos_Old
            {
                k := i.Clone()
                
                Loop k.Length
                    k[A_Index] := i[Shape.Index(A_Index - 1)]
                
                Pos_New.Push(k)
            }
            
            Loop Pos_Old.Length
                New_NDArray[Pos_New[A_Index]*] := this[Pos_Old[A_Index]*]
            
            Return New_NDArray
        }
        
        Var(Axis := "axis=None")
        {
            Return Numahk.Var(this, Axis)
        }
    }
    
    ; NoUse
    Static Reshape(NDArray, Shape*)
    {
        Return Numahk.NDArray(NDArray.Reshape(Shape*))
    }
    
    Static Transpose(NDArray)
    {
        New_Shape := NDArray.Shape.Clone().Reverse()
        
        New_NDArray := Numahk.Zeros(New_Shape)
        
        Pos_Old := []
        Pos_New := []
        
        Loop NDArray.Shape.Length
            Pos_Old.Push(Range(1, NDArray.Shape[A_Index]).Array())
        
        Pos_Old := Dynloop_Loop(Pos_Old)
        
        For i in Pos_Old
        {
            k := i.Clone()
            Pos_New.Push(k.Reverse())
        }
        
        Loop Pos_Old.Length
            New_NDArray[Pos_New[A_Index]*] := NDArray[Pos_Old[A_Index]*]
        
        Return New_NDArray
    }
    
    ; Create
    Static ARange(Args*)
    {
        Return Numahk.NDArray(Range(Args*).Array())
    }
    
    Static Array(Obj*)
    {
        Return Numahk.NDArray(Obj*)
    }
    
    Static AsArray(NDArray)
    {
        Tmp := NDArray.Copy()
        
        Return Numahk.NDArray(Tmp)
    }
    
    Static Asarray_Chkfinite(NDArray)
    {
        Tmp := NDArray.Copy()
        
        Return Numahk.NDArray(Tmp)
    }
    
    Static Empty(Shape)
    {
        if Type(Shape).in(["Integer", "String"])
            Shape := [Shape]
        
        Res_Lst := [""]
        
        Loop Shape.Length
        {
            Res_Lst.mul(Shape[-A_Index])
            
            if A_Index !== Shape.Length
                Res_Lst := [Res_Lst]
        }
        
        Res_Lst := Numahk.NDArray(Res_Lst)
        
        Return Res_Lst
    }
    
    Static Empty_Like(NDArray)
    {
        Shape := NDArray.Shape
        Res_Lst := [""]
        
        Loop Shape.Length
        {
            Res_Lst.mul(Shape[-A_Index])
            
            if A_Index !== Shape.Length
                Res_Lst := [Res_Lst]
        }
        
        Res_Lst := Numahk.NDArray(Res_Lst)
        
        Return Res_Lst
    }
    
    Static Eye(N, M := 0, k := 0)
    {
        if M
            NDArray := Numahk.Zeros([N, M])
        
        else
            NDArray := Numahk.Zeros([N, N])
        
        Loop N
        {
            Try
                NDArray[A_Index, A_Index + k] := 1
        }
        
        Return NDArray
    }
    
    Static Identity(N)
    {
        NDArray := Numahk.Zeros([N, N])
        
        Loop N
            NDArray[A_Index, A_Index] := 1
        
        Return NDArray
    }
    
    Static In1d(NDArray1, NDArray2, Invert := False)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        NDArray := Numahk.Zeros_Like(NDArray1)
        
        New_Pos := []
        
        For i in NDArray1.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For j in New_Pos
        {
            if NDArray2.NDim
            {
                flag := Invert
                
                For k in NDArray2
                {
                    flag := Invert ? (NDArray1[j*] != k) : (NDArray1[j*] = k)
                    
                    if flag != Invert
                    {
                        NDArray[j*] := flag
                        Continue 2
                    }
                }
                
                NDArray[j*] := flag
            }
            
            else
                NDArray[j*] := Invert ? (NDArray1[j*] != NDArray2) : (NDArray1[j*] = NDArray2)
        }
        
        Return NDArray
    }
    
    Static MeshGrid(NDArray*)
    {
        
    }
    
    Static Ones(Shape)
    {
        if Type(Shape).in(["Integer", "String"])
            Shape := [Shape]
        
        Res_Lst := [1]
        
        Loop Shape.Length
        {
            Res_Lst.mul(Shape[-A_Index])
            
            if A_Index !== Shape.Length
                Res_Lst := [Res_Lst]
        }
        
        Res_Lst := Numahk.NDArray(Res_Lst)
        
        Return Res_Lst
    }
    
    Static Ones_Like(NDArray)
    {
        Shape := NDArray.Shape
        Res_Lst := [1]
        
        Loop Shape.Length
        {
            Res_Lst.mul(Shape[-A_Index])
            
            if A_Index !== Shape.Length
                Res_Lst := [Res_Lst]
        }
        
        Res_Lst := Numahk.NDArray(Res_Lst)
        
        Return Res_Lst
    }
    
    Static Where(Cond, NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        For i in NDArray1.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For j in New_Pos
            NDArray1[j*] := ((Cond is Func) ? Cond(NDArray1[j*]) : Cond[j*]) ? NDArray1[j*] : ((NDArray2.NDim) ? NDArray2[j*] : NDArray2)
        
        Return NDArray1
    }
    
    Static Zeros(Shape)
    {
        if Type(Shape).in(["Integer", "String"])
            Shape := [Shape]
        
        Res_Lst := [0]
        
        Loop Shape.Length
        {
            Res_Lst.mul(Shape[-A_Index])
            
            if A_Index !== Shape.Length
                Res_Lst := [Res_Lst]
        }
        
        Res_Lst := Numahk.NDArray(Res_Lst)
        
        Return Res_Lst
    }
    
    Static Zeros_Like(NDArray)
    {
        Shape := NDArray.Shape
        Res_Lst := [0]
        
        Loop Shape.Length
        {
            Res_Lst.mul(Shape[-A_Index])
            
            if A_Index !== Shape.Length
                Res_Lst := [Res_Lst]
        }
        
        Res_Lst := Numahk.NDArray(Res_Lst)
        
        Return Res_Lst
    }
    
    ; Matrix
    Static Diag(NDArray, k := 0)
    {
        if NDArray.NDim == 1
        {
            Tmp := Numahk.Zeros([Abs(k) + NDArray.Length, Abs(k) + NDArray.Length])
            
            Loop NDArray.Length
            {
                Try
                    Tmp[A_Index, A_Index + k] := NDArray[A_Index]
            }
            
            Return Tmp
        }
        
        Tmp := []
        
        Loop NDArray.Length
        {
            Try
                Tmp.Push(NDArray[A_Index, A_Index + k])
        }
        
        Return Numahk.NDArray(Tmp)
    }
    
    Static Dot(NDArray*)
    {
        Temp := NDArray.RemoveAt(1)
        
        if !NDArray.Length
            Return Temp
        
        if NDArray.Length == 1
        {
            Temp2 := NDArray.RemoveAt(1)
            Temp3 := Numahk.Zeros([Temp.Shape[1], Temp2.Shape[2]])
            
            For i in Range(Temp.Shape[1])
            {
                For j in Range(Temp2.Shape[2])
                {
                    Sum := 0
                    
                    For k in Range(Temp.Shape[2])
                        Sum += Temp[i, k] * Temp2[k, j]
                    
                    Temp3[i, j] := Round(Sum, 10)
                }
            }
            
            Return Temp3
        }
        
        else
        {
            Temp2 := Numahk.Dot(Temp, NDArray.RemoveAt(1))
            
            Return Numahk.Dot(Temp2, NDArray*)
        }
    }
    
    Static Trace(NDArray, offset := 0)
    {
        New_Pos := []
        Tmp := NDArray.Shape
        
        if !(Tmp.Length - 2)
            Return Numahk.Diag(NDArray, offset).Sum
        
        Loop Tmp.Length - 2
            New_Pos.InsertAt(1, Range(1, Tmp[-A_Index]).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        Tmp2 := []
        
        For i in New_Pos
        {
            Tmp3 := []
            
            Loop Tmp.Length
            {
                Try
                    Tmp3.Push(NDArray[A_Index, A_Index + offset, i*])
            }
            
            Tmp2.Push(Tmp3.Sum)
        }
        
        Tmp.RemoveAt(1, 2)
        
        Return Numahk.NDArray(Tmp2).Reshape(Tmp)
    }
    
    ; Sort
    Static Intersect1d(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        New_NDArray := []
        
        For i in NDArray1.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            Value := NDArray1[i*]
            
            if Value.in(NDArray2) && !Value.in(New_NDArray)
                New_NDArray.Push(Value)
        }
        
        Return Numahk.NDArray(New_NDArray.Sort())
    }
    
    Static Setdiff1d(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        New_NDArray := []
        
        For i in NDArray1.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            Value := NDArray1[i*]
            
            if !Value.in(NDArray2) && !Value.in(New_NDArray)
                New_NDArray.Push(Value)
        }
        
        Return Numahk.NDArray(New_NDArray.Sort())
    }
    
    Static Setxor1d(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        New_NDArray := []
        
        For i in NDArray1.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            Value := NDArray1[i*]
            
            if !Value.in(NDArray2) && !Value.in(New_NDArray)
                New_NDArray.Push(Value)
        }
        
        For i in New_Pos
        {
            Value := NDArray2[i*]
            
            if !Value.in(NDArray1) && !Value.in(New_NDArray)
                New_NDArray.Push(Value)
        }
        
        Return Numahk.NDArray(New_NDArray.Sort())
    }
    
    Static Sort(NDArray, Axis := "axis=-1")
    {
        if InStr(Axis, "=")
            Axis := Trim(StrSplit(Axis, "=")[2])
        
        if Axis = "None"
            Return Numahk.NDArray(NDArray.Ravel().Sort())
        
        Axis := (Axis == -1) ? NDArray.NDim - 1 : Axis
        
        New_NDArray := []
        Tmp := NDArray.Shape[Axis + 1]
        
        New_Pos := []
        New_Shape := NDArray.Shape
        New_Shape.RemoveAt(Axis + 1)
        
        Loop New_Shape.Length
            New_Pos.Push(Range(1, New_Shape[A_Index]).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        New_PosTmp := []
        
        For i in New_Pos
        {
            Loop Tmp
            {
                iTmp := i.Clone()
                iTmp.InsertAt(Axis + 1, A_Index)
                New_PosTmp.Push(iTmp)
            }
        }
        
        Loop NDArray.Shape.Product // Tmp
        {
            Index := A_Index - 1
            Tmp2 := []
            
            Loop Tmp
                Tmp2.Push(NDArray[New_PosTmp[A_Index + Index * Tmp]*])
            
            Tmp2.Sort()
            
            Loop Tmp
                NDArray[New_PosTmp[A_Index + Index * Tmp]*] := Tmp2[A_Index]
        }
        
        Return NDArray
    }
    
    Static Union1d(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        New_NDArray := []
        
        For i in NDArray1.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
            New_NDArray.Push(NDArray1[i*])
        
        For i in New_Pos
        {
            Value := NDArray2[i*]
            
            if !Value.in(New_NDArray)
                New_NDArray.Push(Value)
        }
        
        Return Numahk.NDArray(New_NDArray.Sort())
    }
    
    Static Unique(NDArray, Return_Index := False, Return_Counts := False)
    {
        Ret := []
        New_NDArray := []
        New_IndexArray := []
        
        For i in NDArray
        {
            if !i.in(New_NDArray)
            {
                New_NDArray.Push(i)
                New_IndexArray.Push(A_Index)
            }
        }
        
        if !Return_Index && !Return_Counts
            Return Numahk.NDArray(New_NDArray)
        
        Ret.Push(New_NDArray)
        
        if Return_Index
            Ret.Push(New_IndexArray)
        
        if Return_Counts
        {
            Tmp := []
            
            For i in New_NDArray
                Tmp.Push(NDArray.Count(i))
            
            Ret.Push(Tmp)
        }
        
        Return Numahk.NDArray(Ret)
    }
    
    ; 1-D Calculate
    Static Abs(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
            NDArray[i*] := Abs(NDArray[i*])
        
        Return NDArray
    }
    
    Static All(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if !NDArray[i*]
                Return False
        }
        
        Return True
    }
    
    Static Any(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray[i*]
                Return True
        }
        
        Return False
    }
    
    Static ArcCos(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
            NDArray[i*] := ACos(NDArray[i*])
        
        Return NDArray
    }
    
    Static ArcCosh(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            Tmp := NDArray[i*]
            NDArray[i*] := Ln(Tmp + Sqrt(Tmp ** 2 - 1))
        }
        
        Return NDArray
    }
    
    Static ArcSin(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
            NDArray[i*] := ASin(NDArray[i*])
        
        Return NDArray
    }
    
    Static ArcSinh(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            Tmp := NDArray[i*]
            NDArray[i*] := Ln(Tmp + Sqrt(Tmp ** 2 + 1))
        }
        
        Return NDArray
    }
    
    Static ArcTan(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
            NDArray[i*] := ATan(NDArray[i*])
        
        Return NDArray
    }
    
    Static ArcTanh(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            Tmp := NDArray[i*]
            NDArray[i*] := 0.5 * Ln((1 + Tmp) / (1 - Tmp))
        }
        
        Return NDArray
    }
    
    Static ArgMax(NDArray, Axis := "axis=None")
    {
        if InStr(Axis, "=")
            Axis := Trim(StrSplit(Axis, "=")[2])
        
        if Axis = "None"
        {
            Tmp := NDArray.Copy().Ravel()
            
            Return Tmp.Index(Max(Tmp*))
        }
        
        Axis := (Axis == -1) ? NDArray.NDim - 1 : Axis
        
        if NDArray.NDim == 1
            Return Tmp.Index(Max(NDArray*))
        
        else
        {
            Lst_Res := []
            Lst_Pos := []
            Tmp := NDArray.Shape
            
            Loop NDArray.NDim
            {
                if Axis + 1 !== A_Index
                    Lst_Pos.Push(Range(1, Tmp[A_Index]).Array())
            }
            
            Lst_Pos := Dynloop_Loop(Lst_Pos)
            
            For i in Lst_Pos
            {
                Tmp2 := []
                
                Loop Tmp[Axis + 1]
                {
                    iTmp := i.Clone()
                    iTmp.InsertAt(Axis + 1, A_Index)
                    Tmp2.Push(NDArray[iTmp*])
                }
                
                Lst_Res.Push(Numahk.ArgMax(Tmp2))
            }
            
            Lst_Res := Numahk.NDArray(Lst_Res)
            Tmp.RemoveAt(Axis + 1)
            Lst_Res.Reshape(Tmp)
            
            Return Lst_Res
        }
    }
    
    Static ArgMin(NDArray, Axis := "axis=None")
    {
        if InStr(Axis, "=")
            Axis := Trim(StrSplit(Axis, "=")[2])
        
        if Axis = "None"
        {
            Tmp := NDArray.Copy().Ravel()
            
            Return Tmp.Index(Min(Tmp*))
        }
        
        Axis := (Axis == -1) ? NDArray.NDim - 1 : Axis
        
        if NDArray.NDim == 1
            Return Tmp.Index(Min(NDArray*))
        
        else
        {
            Lst_Res := []
            Lst_Pos := []
            Tmp := NDArray.Shape
            
            Loop NDArray.NDim
            {
                if Axis + 1 !== A_Index
                    Lst_Pos.Push(Range(1, Tmp[A_Index]).Array())
            }
            
            Lst_Pos := Dynloop_Loop(Lst_Pos)
            
            For i in Lst_Pos
            {
                Tmp2 := []
                
                Loop Tmp[Axis + 1]
                {
                    iTmp := i.Clone()
                    iTmp.InsertAt(Axis + 1, A_Index)
                    Tmp2.Push(NDArray[iTmp*])
                }
                
                Lst_Res.Push(Numahk.ArgMin(Tmp2))
            }
            
            Lst_Res := Numahk.NDArray(Lst_Res)
            Tmp.RemoveAt(Axis + 1)
            Lst_Res.Reshape(Tmp)
            
            Return Lst_Res
        }
    }
    
    Static Ceil(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
            NDArray[i*] := Ceil(NDArray[i*])
        
        Return NDArray
    }
    
    Static Cos(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
            NDArray[i*] := Cos(NDArray[i*])
        
        Return NDArray
    }
    
    Static Cosh(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            Tmp := NDArray[i*]
            NDArray[i*] := (Exp(Tmp) + Exp(-Tmp)) / 2
        }
        
        Return NDArray
    }
    
    Static CumProd(NDArray, Axis := "axis=None")
    {
        if InStr(Axis, "=")
            Axis := Trim(StrSplit(Axis, "=")[2])
        
        if Axis = "None"
        {
            Tmp := NDArray.Copy().Ravel()
            
            Loop Tmp.Length - 1
                Tmp[A_Index + 1] *= Tmp[A_Index]
            
            Return Tmp
        }
        
        Axis := (Axis == -1) ? NDArray.NDim - 1 : Axis
        
        if NDArray.NDim == 1
        {
            Loop NDArray.Length - 1
                NDArray[A_Index + 1] *= NDArray[A_Index]
            
            Return NDArray
        }
        
        else
        {
            Lst_Res := []
            Lst_Pos := []
            Tmp := NDArray.Shape
            
            Loop NDArray.NDim
            {
                if Axis + 1 !== A_Index
                    Lst_Pos.Push(Range(1, Tmp[A_Index]).Array())
            }
            
            Lst_Pos := Dynloop_Loop(Lst_Pos)
            
            For i in Lst_Pos
            {
                Tmp2 := []
                
                Loop Tmp[Axis + 1]
                {
                    iTmp := i.Clone()
                    iTmp.InsertAt(Axis + 1, A_Index)
                    Tmp2.Push(NDArray[iTmp*])
                }
                
                Lst_Res.Push(Tmp2)
            }
            
            Loop Lst_Res.Length
            {
                Index := A_Index
                
                Loop Lst_Res[Index].Length - 1
                    Lst_Res[Index][A_Index + 1] *= Lst_Res[Index][A_Index]
            }
            
            Lst_Res.Ravel()
            Index := 1
            
            For i in Lst_Pos
            {
                Loop Tmp[Axis + 1]
                {
                    iTmp := i.Clone()
                    iTmp.InsertAt(Axis + 1, A_Index)
                    NDArray[iTmp*] := Lst_Res[Index++]
                }
            }
            
            Return NDArray
        }
    }
    
    Static CumSum(NDArray, Axis := "axis=None")
    {
        if InStr(Axis, "=")
            Axis := Trim(StrSplit(Axis, "=")[2])
        
        if Axis = "None"
        {
            Tmp := NDArray.Copy().Ravel()
            
            Loop Tmp.Length - 1
                Tmp[A_Index + 1] += Tmp[A_Index]
            
            Return Tmp
        }
        
        Axis := (Axis == -1) ? NDArray.NDim - 1 : Axis
        
        if NDArray.NDim == 1
        {
            Loop NDArray.Length - 1
                NDArray[A_Index + 1] += NDArray[A_Index]
            
            Return NDArray
        }
        
        else
        {
            Lst_Res := []
            Lst_Pos := []
            Tmp := NDArray.Shape
            
            Loop NDArray.NDim
            {
                if Axis + 1 !== A_Index
                    Lst_Pos.Push(Range(1, Tmp[A_Index]).Array())
            }
            
            Lst_Pos := Dynloop_Loop(Lst_Pos)
            
            For i in Lst_Pos
            {
                Tmp2 := []
                
                Loop Tmp[Axis + 1]
                {
                    iTmp := i.Clone()
                    iTmp.InsertAt(Axis + 1, A_Index)
                    Tmp2.Push(NDArray[iTmp*])
                }
                
                Lst_Res.Push(Tmp2)
            }
            
            Loop Lst_Res.Length
            {
                Index := A_Index
                
                Loop Lst_Res[Index].Length - 1
                    Lst_Res[Index][A_Index + 1] += Lst_Res[Index][A_Index]
            }
            
            Lst_Res.Ravel()
            Index := 1
            
            For i in Lst_Pos
            {
                Loop Tmp[Axis + 1]
                {
                    iTmp := i.Clone()
                    iTmp.InsertAt(Axis + 1, A_Index)
                    NDArray[iTmp*] := Lst_Res[Index++]
                }
            }
            
            Return NDArray
        }
    }
    
    Static Exp(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
            NDArray[i*] := Exp(NDArray[i*])
        
        Return NDArray
    }
    
    Static FAbs(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
            NDArray[i*] := Abs(NDArray[i*])
        
        Return NDArray
    }
    
    Static Floor(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
            NDArray[i*] := Floor(NDArray[i*])
        
        Return NDArray
    }
    
    Static Log(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
            NDArray[i*] := Ln(NDArray[i*])
        
        Return NDArray
    }
    
    Static Log10(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
            NDArray[i*] := Log(NDArray[i*])
        
        Return NDArray
    }
    
    Static Log1p(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
            NDArray[i*] := Ln(NDArray[i*] + 1)
        
        Return NDArray
    }
    
    Static Log2(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
            NDArray[i*] := Ln(NDArray[i*]) / Ln(10)
        
        Return NDArray
    }
    
    Static Logical_Not(NDArray, Function := 0)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            Tmp := NDArray[i*]
            NDArray[i*] := Function ? Function(Tmp) : !Tmp
        }
        
        Return NDArray
    }
    
    Static Max(NDArray, Axis := "axis=None")
    {
        if InStr(Axis, "=")
            Axis := Trim(StrSplit(Axis, "=")[2])
        
        if Axis = "None"
        {
            Tmp := NDArray.Copy().Ravel()
            
            Return Max(Tmp*)
        }
        
        Axis := (Axis == -1) ? NDArray.NDim - 1 : Axis
        
        if NDArray.NDim == 1
            Return Max(NDArray*)
        
        else
        {
            Lst_Res := []
            Lst_Pos := []
            Tmp := NDArray.Shape
            
            Loop NDArray.NDim
            {
                if Axis + 1 !== A_Index
                    Lst_Pos.Push(Range(1, Tmp[A_Index]).Array())
            }
            
            Lst_Pos := Dynloop_Loop(Lst_Pos)
            
            For i in Lst_Pos
            {
                Tmp2 := []
                
                Loop Tmp[Axis + 1]
                {
                    iTmp := i.Clone()
                    iTmp.InsertAt(Axis + 1, A_Index)
                    Tmp2.Push(NDArray[iTmp*])
                }
                
                Lst_Res.Push(Numahk.Max(Tmp2))
            }
            
            Lst_Res := Numahk.NDArray(Lst_Res)
            Tmp.RemoveAt(Axis + 1)
            Lst_Res.Reshape(Tmp)
            
            Return Lst_Res
        }
    }
    
    Static Mean(NDArray, Axis := "axis=None")
    {
        if InStr(Axis, "=")
            Axis := Trim(StrSplit(Axis, "=")[2])
        
        if Axis = "None"
        {
            Tmp := NDArray.Copy().Ravel()
            
            Return Tmp.Sum / Tmp.Length
        }
        
        Axis := (Axis == -1) ? NDArray.NDim - 1 : Axis
        
        if NDArray.NDim == 1
            Return NDArray.Sum / NDArray.Length
        
        else
        {
            Lst_Res := []
            Lst_Pos := []
            Tmp := NDArray.Shape
            
            Loop NDArray.NDim
            {
                if Axis + 1 !== A_Index
                    Lst_Pos.Push(Range(1, Tmp[A_Index]).Array())
            }
            
            Lst_Pos := Dynloop_Loop(Lst_Pos)
            
            For i in Lst_Pos
            {
                Tmp2 := []
                
                Loop Tmp[Axis + 1]
                {
                    iTmp := i.Clone()
                    iTmp.InsertAt(Axis + 1, A_Index)
                    Tmp2.Push(NDArray[iTmp*])
                }
                
                Lst_Res.Push(Numahk.Mean(Tmp2))
            }
            
            Lst_Res := Numahk.NDArray(Lst_Res)
            Tmp.RemoveAt(Axis + 1)
            Lst_Res.Reshape(Tmp)
            
            Return Lst_Res
        }
    }
    
    Static Min(NDArray, Axis := "axis=None")
    {
        if InStr(Axis, "=")
            Axis := Trim(StrSplit(Axis, "=")[2])
        
        if Axis = "None"
        {
            Tmp := NDArray.Copy().Ravel()
            
            Return Min(Tmp*)
        }
        
        Axis := (Axis == -1) ? NDArray.NDim - 1 : Axis
        
        if NDArray.NDim == 1
            Return Min(NDArray*)
        
        else
        {
            Lst_Res := []
            Lst_Pos := []
            Tmp := NDArray.Shape
            
            Loop NDArray.NDim
            {
                if Axis + 1 !== A_Index
                    Lst_Pos.Push(Range(1, Tmp[A_Index]).Array())
            }
            
            Lst_Pos := Dynloop_Loop(Lst_Pos)
            
            For i in Lst_Pos
            {
                Tmp2 := []
                
                Loop Tmp[Axis + 1]
                {
                    iTmp := i.Clone()
                    iTmp.InsertAt(Axis + 1, A_Index)
                    Tmp2.Push(NDArray[iTmp*])
                }
                
                Lst_Res.Push(Numahk.Min(Tmp2))
            }
            
            Lst_Res := Numahk.NDArray(Lst_Res)
            Tmp.RemoveAt(Axis + 1)
            Lst_Res.Reshape(Tmp)
            
            Return Lst_Res
        }
    }
    
    Static Modf(NDArray)
    {
        New_Pos := []
        New_NDArray := [Numahk.Zeros_Like(NDArray), Numahk.Zeros_Like(NDArray)]
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            Tmp := NDArray[i*]
            New_NDArray[1][i*] := Integer(Tmp - Mod(Tmp, 1))
            New_NDArray[2][i*] := Mod(Tmp, 1)
        }
        
        Return New_NDArray
    }
    
    Static Rint(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            Tmp := NDArray[i*]
            
            if Tmp < 0
                NDArray[i*] := (Abs(Tmp - Floor(Tmp)) <= 0.5) ? Floor(Tmp) : Ceil(Tmp)
            
            else
                NDArray[i*] := (Abs(Tmp - Floor(Tmp)) < 0.5) ? Floor(Tmp) : Ceil(Tmp)
        }
        
        Return NDArray
    }
    
    Static Sign(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            Tmp := NDArray[i*]
            NDArray[i*] := (Tmp > 0) ? 1 : ((Tmp < 0) ? -1 : 0)
        }
        
        Return NDArray
    }
    
    Static Sin(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
            NDArray[i*] := Sin(NDArray[i*])
        
        Return NDArray
    }
    
    Static Sinh(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            Tmp := NDArray[i*]
            NDArray[i*] := (Exp(Tmp) - Exp(Tmp)) / 2
        }
        
        Return NDArray
    }
    
    Static Sqrt(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
            NDArray[i*] := Sqrt(NDArray[i*])
        
        Return NDArray
    }
    
    Static Square(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
            NDArray[i*] := NDArray[i*] ** 2
        
        Return NDArray
    }
    
    Static Std(NDArray, Axis := "axis=None")
    {
        if InStr(Axis, "=")
            Axis := Trim(StrSplit(Axis, "=")[2])
        
        if Axis = "None"
        {
            Tmp := NDArray.Copy().Ravel()
            avg := Tmp.Sum / Tmp.Length
            sum := 0
            
            For i in Tmp
                sum += (i - avg) ** 2
            
            Return sum / Tmp.Length
        }
        
        Axis := (Axis == -1) ? NDArray.NDim - 1 : Axis
        
        if NDArray.NDim == 1
        {
            avg := NDArray.Sum / NDArray.Length
            sum := 0
            
            For i in NDArray
                sum += (i - avg) ** 2
            
            Return sum / NDArray.Length
        }
        
        else
        {
            Lst_Res := []
            Lst_Pos := []
            Tmp := NDArray.Shape
            
            Loop NDArray.NDim
            {
                if Axis + 1 !== A_Index
                    Lst_Pos.Push(Range(1, Tmp[A_Index]).Array())
            }
            
            Lst_Pos := Dynloop_Loop(Lst_Pos)
            
            For i in Lst_Pos
            {
                Tmp2 := []
                
                Loop Tmp[Axis + 1]
                {
                    iTmp := i.Clone()
                    iTmp.InsertAt(Axis + 1, A_Index)
                    Tmp2.Push(NDArray[iTmp*])
                }
                
                Lst_Res.Push(Numahk.Std(Tmp2))
            }
            
            Lst_Res := Numahk.NDArray(Lst_Res)
            Tmp.RemoveAt(Axis + 1)
            Lst_Res.Reshape(Tmp)
            
            Return Lst_Res
        }
    }
    
    Static Sum(NDArray, Axis := "axis=None")
    {
        if InStr(Axis, "=")
            Axis := Trim(StrSplit(Axis, "=")[2])
        
        if Axis = "None"
        {
            Tmp := NDArray.Copy().Ravel()
            
            Return Tmp.Sum
        }
        
        Axis := (Axis == -1) ? NDArray.NDim - 1 : Axis
        
        if NDArray.NDim == 1
            Return NDArray.Sum
        
        else
        {
            Lst_Res := []
            Lst_Pos := []
            Tmp := NDArray.Shape
            
            Loop NDArray.NDim
            {
                if Axis + 1 !== A_Index
                    Lst_Pos.Push(Range(1, Tmp[A_Index]).Array())
            }
            
            Lst_Pos := Dynloop_Loop(Lst_Pos)
            
            For i in Lst_Pos
            {
                Tmp2 := []
                
                Loop Tmp[Axis + 1]
                {
                    iTmp := i.Clone()
                    iTmp.InsertAt(Axis + 1, A_Index)
                    Tmp2.Push(NDArray[iTmp*])
                }
                
                Lst_Res.Push(Numahk.Sum(Tmp2))
            }
            
            Lst_Res := Numahk.NDArray(Lst_Res)
            Tmp.RemoveAt(Axis + 1)
            Lst_Res.Reshape(Tmp)
            
            Return Lst_Res
        }
    }
    
    Static Tan(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
            NDArray[i*] := Tan(NDArray[i*])
        
        Return NDArray
    }
    
    Static Tanh(NDArray)
    {
        New_Pos := []
        
        For i in NDArray.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            Tmp := NDArray[i*]
            NDArray[i*] := (Exp(Tmp) - Exp(-Tmp)) / (Exp(Tmp) + Exp(-Tmp))
        }
        
        Return NDArray
    }
    
    Static Var(NDArray, Axis := "axis=None")
    {
        if InStr(Axis, "=")
            Axis := Trim(StrSplit(Axis, "=")[2])
        
        if Axis = "None"
        {
            Tmp := NDArray.Copy().Ravel()
            avg := Tmp.Sum / Tmp.Length
            sum := 0
            
            For i in Tmp
                sum += (i - avg) ** 2
            
            Return Sqrt(sum / Tmp.Length)
        }
        
        Axis := (Axis == -1) ? NDArray.NDim - 1 : Axis
        
        if NDArray.NDim == 1
        {
            avg := NDArray.Sum / NDArray.Length
            sum := 0
            
            For i in NDArray
                sum += (i - avg) ** 2
            
            Return Sqrt(sum / NDArray.Length)
        }
        
        else
        {
            Lst_Res := []
            Lst_Pos := []
            Tmp := NDArray.Shape
            
            Loop NDArray.NDim
            {
                if Axis + 1 !== A_Index
                    Lst_Pos.Push(Range(1, Tmp[A_Index]).Array())
            }
            
            Lst_Pos := Dynloop_Loop(Lst_Pos)
            
            For i in Lst_Pos
            {
                Tmp2 := []
                
                Loop Tmp[Axis + 1]
                {
                    iTmp := i.Clone()
                    iTmp.InsertAt(Axis + 1, A_Index)
                    Tmp2.Push(NDArray[iTmp*])
                }
                
                Lst_Res.Push(Numahk.Var(Tmp2))
            }
            
            Lst_Res := Numahk.NDArray(Lst_Res)
            Tmp.RemoveAt(Axis + 1)
            Lst_Res.Reshape(Tmp)
            
            Return Lst_Res
        }
    }
    
    ; N-D Calculate
    Static Add(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return NDArray1 + NDArray2
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := NDArray1[i*] + NDArray2[i*]
            
            else if NDArray1.NDim
                New_NDArray[i*] := NDArray1[i*] + NDArray2
            
            else
                New_NDArray[i*] := NDArray1 + NDArray2[i*]
        }
        
        Return New_NDArray
    }
    
    Static Cmp(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return ListCmp(NDArray1, NDArray2)
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := ListCmp(NDArray1[i*], NDArray2[i*])
            
            else if NDArray1.NDim
                New_NDArray[i*] := ListCmp(NDArray1[i*], NDArray2)
            
            else
                New_NDArray[i*] := ListCmp(NDArray1, NDArray2[i*])
        }
        
        Return New_NDArray
    }
    
    Static CopySign(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        New_Pos := []
        
        For i in NDArray1.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray2.NDim
            {
                Tmp := NDArray1[i*]
                NDArray1[i*] := (Tmp.Sign == NDArray2[i*].Sign) ? Tmp : -Tmp
            }
            
            else
            {
                Tmp := NDArray1[i*]
                NDArray1[i*] := (Tmp.Sign == NDArray2.Sign) ? Tmp : -Tmp
            }
        }
        
        Return NDArray1
    }
    
    Static Divide(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return NDArray1 / NDArray2
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := NDArray1[i*] / NDArray2[i*]
            
            else if NDArray1.NDim
                New_NDArray[i*] := NDArray1[i*] / NDArray2
            
            else
                New_NDArray[i*] := NDArray1 / NDArray2[i*]
        }
        
        Return New_NDArray
    }
    
    Static Equal(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return NDArray1 = NDArray2
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := NDArray1[i*] = NDArray2[i*]
            
            else if NDArray1.NDim
                New_NDArray[i*] := NDArray1[i*] = NDArray2
            
            else
                New_NDArray[i*] := NDArray1 = NDArray2[i*]
        }
        
        Return New_NDArray
    }
    
    Static Floor_Divide(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return Floor(NDArray1 / NDArray2)
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := Floor(NDArray1[i*] / NDArray2[i*])
            
            else if NDArray1.NDim
                New_NDArray[i*] := Floor(NDArray1[i*] / NDArray2)
            
            else
                New_NDArray[i*] := Floor(NDArray1 / NDArray2[i*])
        }
        
        Return New_NDArray
    }
    
    Static FMax(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return Max(NDArray1, NDArray2)
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := Max(NDArray1[i*], NDArray2[i*])
            
            else if NDArray1.NDim
                New_NDArray[i*] := Max(NDArray1[i*], NDArray2)
            
            else
                New_NDArray[i*] := Max(NDArray1, NDArray2[i*])
        }
        
        Return New_NDArray
    }
    
    Static FMin(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return Min(NDArray1, NDArray2)
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := Min(NDArray1[i*], NDArray2[i*])
            
            else if NDArray1.NDim
                New_NDArray[i*] := Min(NDArray1[i*], NDArray2)
            
            else
                New_NDArray[i*] := Min(NDArray1, NDArray2[i*])
        }
        
        Return New_NDArray
    }
    
    Static Greater(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return NDArray1 > NDArray2
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := NDArray1[i*] > NDArray2[i*]
            
            else if NDArray1.NDim
                New_NDArray[i*] := NDArray1[i*] > NDArray2
            
            else
                New_NDArray[i*] := NDArray1 > NDArray2[i*]
        }
        
        Return New_NDArray
    }
    
    Static Greater_Equal(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return NDArray1 >= NDArray2
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := NDArray1[i*] >= NDArray2[i*]
            
            else if NDArray1.NDim
                New_NDArray[i*] := NDArray1[i*] >= NDArray2
            
            else
                New_NDArray[i*] := NDArray1 >= NDArray2[i*]
        }
        
        Return New_NDArray
    }
    
    Static Ix_(NDArray1, NDArray2)
    {
        Return Dynloop_Loop([NDArray1, NDArray2]).Reshape([NDArray1.Length, NDArray2.Length, 2])
    }
    
    Static Less(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return NDArray1 < NDArray2
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := NDArray1[i*] < NDArray2[i*]
            
            else if NDArray1.NDim
                New_NDArray[i*] := NDArray1[i*] < NDArray2
            
            else
                New_NDArray[i*] := NDArray1 < NDArray2[i*]
        }
        
        Return New_NDArray
    }
    
    Static Less_Equal(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return NDArray1 <= NDArray2
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := NDArray1[i*] <= NDArray2[i*]
            
            else if NDArray1.NDim
                New_NDArray[i*] := NDArray1[i*] <= NDArray2
            
            else
                New_NDArray[i*] := NDArray1 <= NDArray2[i*]
        }
        
        Return New_NDArray
    }
    
    Static Logical_And(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return NDArray1 & NDArray2
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := NDArray1[i*] & NDArray2[i*]
            
            else if NDArray1.NDim
                New_NDArray[i*] := NDArray1[i*] & NDArray2
            
            else
                New_NDArray[i*] := NDArray1 & NDArray2[i*]
        }
        
        Return New_NDArray
    }
    
    Static Logical_Or(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return NDArray1 | NDArray2
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := NDArray1[i*] | NDArray2[i*]
            
            else if NDArray1.NDim
                New_NDArray[i*] := NDArray1[i*] | NDArray2
            
            else
                New_NDArray[i*] := NDArray1 | NDArray2[i*]
        }
        
        Return New_NDArray
    }
    
    Static Logical_XOr(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return NDArray1 ^ NDArray2
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := NDArray1[i*] ^ NDArray2[i*]
            
            else if NDArray1.NDim
                New_NDArray[i*] := NDArray1[i*] ^ NDArray2
            
            else
                New_NDArray[i*] := NDArray1 ^ NDArray2[i*]
        }
        
        Return New_NDArray
    }
    
    Static Maximum(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return Max(NDArray1, NDArray2)
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := Max(NDArray1[i*], NDArray2[i*])
            
            else if NDArray1.NDim
                New_NDArray[i*] := Max(NDArray1[i*], NDArray2)
            
            else
                New_NDArray[i*] := Max(NDArray1, NDArray2[i*])
        }
        
        Return New_NDArray
    }
    
    Static Minimum(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return Min(NDArray1, NDArray2)
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := Min(NDArray1[i*], NDArray2[i*])
            
            else if NDArray1.NDim
                New_NDArray[i*] := Min(NDArray1[i*], NDArray2)
            
            else
                New_NDArray[i*] := Min(NDArray1, NDArray2[i*])
        }
        
        Return New_NDArray
    }
    
    Static Mod(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return Mod(NDArray1, NDArray2)
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := Mod(NDArray1[i*], NDArray2[i*])
            
            else if NDArray1.NDim
                New_NDArray[i*] := Mod(NDArray1[i*], NDArray2)
            
            else
                New_NDArray[i*] := Mod(NDArray1, NDArray2[i*])
        }
        
        Return New_NDArray
    }
    
    Static Multiply(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return NDArray1 * NDArray2
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := NDArray1[i*] * NDArray2[i*]
            
            else if NDArray1.NDim
                New_NDArray[i*] := NDArray1[i*] * NDArray2
            
            else
                New_NDArray[i*] := NDArray1 * NDArray2[i*]
        }
        
        Return New_NDArray
    }
    
    Static Not_Equal(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return NDArray1 != NDArray2
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := NDArray1[i*] != NDArray2[i*]
            
            else if NDArray1.NDim
                New_NDArray[i*] := NDArray1[i*] != NDArray2
            
            else
                New_NDArray[i*] := NDArray1 != NDArray2[i*]
        }
        
        Return New_NDArray
    }
    
    Static Subtract(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return NDArray1 - NDArray2
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := NDArray1[i*] - NDArray2[i*]
            
            else if NDArray1.NDim
                New_NDArray[i*] := NDArray1[i*] - NDArray2
            
            else
                New_NDArray[i*] := NDArray1 - NDArray2[i*]
        }
        
        Return New_NDArray
    }
    
    Static Power(NDArray1, NDArray2)
    {
        NDArray1 := (NDArray1.NDim) ? Numahk.NDArray(NDArray1) : NDArray1
        NDArray2 := (NDArray2.NDim) ? Numahk.NDArray(NDArray2) : NDArray2
        New_Pos := []
        
        if !NDArray1.NDim && !NDArray2.NDim
            Return NDArray1 ** NDArray2
        
        NewShape := NDArray1.NDim ? NDArray1 : NDArray2
        
        New_NDArray := Numahk.Zeros_Like(NewShape)
        
        For i in NewShape.Shape
            New_Pos.Push(Range(1, i).Array())
        
        New_Pos := Dynloop_Loop(New_Pos)
        
        For i in New_Pos
        {
            if NDArray1.NDim && NDArray2.NDim
                New_NDArray[i*] := NDArray1[i*] ** NDArray2[i*]
            
            else if NDArray1.NDim
                New_NDArray[i*] := NDArray1[i*] ** NDArray2
            
            else
                New_NDArray[i*] := NDArray1 ** NDArray2[i*]
        }
        
        Return New_NDArray
    }
    
    ; File
    Static Load(String)
    {
        Return Numahk.NDArray(XA.XA_Load(String ".nahk"))
    }
    
    Static Loadz(String)
    {
        NDArrayz := []
        TmpArray := XA.XA_Load(String ".nahk")
        
        For i in TmpArray
            NDArrayz.Push(Numahk.NDArray(i))
        
        Return NDArrayz
    }
    
    Static Save(String, NDArray)
    {
        NDArrayFile := FileOpen(String ".nahk", "w")
        NDArrayFile.Write(XA.XA_Save(NDArray))
        NDArrayFile.Close()
    }
    
    Static Savez(String, NDArray*)
    {
        NDArrayFile := FileOpen(String ".nahk", "w")
        NDArrayFile.Write(XA.XA_Save(NDArray))
        NDArrayFile.Close()
    }
    
    ; Random
    Class Random
    {
        Static _Seed := Numahk.TimeStamp.ConvertUnix(Numahk.TimeStamp.GetNow())
        
        Static _LCG := Numahk.Random.LCG()
        
        Static Beta(alpha, beta, Shape := -1)
        {
            if Shape = -1
                Return Numahk.Random.BetaAlg(alpha, beta)
            
            if Type(Shape).in(["Integer", "String"])
                Shape := [Shape]
            
            New_Pos := []
            New_NDArray := Numahk.Zeros(Shape)
            
            For i in Shape
                New_Pos.Push(Range(1, i).Array())
            
            New_Pos := Dynloop_Loop(New_Pos)
            
            For i in New_Pos
                New_NDArray[i*] := Numahk.Random.BetaAlg(alpha, beta)
            
            Return New_NDArray
        }
        
        Static BetaAlg(alpha, beta)
        {
            x := Numahk.Random.Random()
            Z := Numahk.Random.GammaValue(alpha) * Numahk.Random.GammaValue(beta) / Numahk.Random.GammaValue(alpha + beta)
            y := x ** (alpha - 1) * (1 - x) ** (beta - 1) / Z
            
            Return y
        }
        
        Static BoxMuller()
        {
            Avg := 0
            Diff := 1
            Pi := 3.141592653589793
            
            A := Numahk.Random.Random()
            B := Numahk.Random.Random()
            y := Sqrt((-2) * Log(A)) * Cos(2 * Pi * B) * Diff + Avg
            
            Return y
        }
        
        Static Choice(a, size := 1, replace := True, p := "")
        {
            if a is Integer
                a := Range(0, a - 1).Array()
            
            if p = ""
            {
                _tmp := ____(_) => a[Numahk.Random.RandInt(1, a.Length + 1)]
                
                if size is Integer
                    Return Numahk.Array(oneloop(_tmp, Range(size)))
                
                else
                    Return Numahk.Array(oneloop(_tmp, Range(size.product)).Reshape(size))
            }
            
            else
            {
                ret := []
                _sum := p.sum
                _size := size is Integer ? size : size.product
                loop _size
                {
                    tmp := _sum ? [] : a
                    while !tmp.Length
                        tmp := oneloop(__(_*) => a[_[1]], p, 2, ___(_*) => Numahk.Random.Rand() <= (_[2] / _sum))
                    ret.Push(tmp[Numahk.Random.RandInt(1, tmp.Length + 1)])
                }
                
                if size is Integer
                    Return Numahk.Array(ret)
                else
                    Return Numahk.Array(ret).Reshape(size)
            }
        }
        
        Static Gamma(alpha, beta := 1, Shape := -1)
        {
            if Shape = -1
                Return Numahk.Random.GammaAlg(alpha, beta)
            
            if Type(Shape).in(["Integer", "String"])
                Shape := [Shape]
            
            New_Pos := []
            New_NDArray := Numahk.Zeros(Shape)
            
            For i in Shape
                New_Pos.Push(Range(1, i).Array())
            
            New_Pos := Dynloop_Loop(New_Pos)
            
            For i in New_Pos
                New_NDArray[i*] := Numahk.Random.GammaAlg(alpha, beta)
            
            Return New_NDArray
        }
        
        Static GammaAlg(alpha, beta)
        {
            x := Numahk.Random.Random()
            Z := Numahk.Random.GammaValue(alpha) * beta ** (-alpha)
            y := x ** (alpha - 1) * exp(-x * beta) / Z
            
            Return y
        }
        
        Static GammaValue(Num)
        {
            if Num = 1
                Return 1
            
            else if Num = 0.5
                Return Pi ** 0.5
            
            else if (Num is Integer and Num > 0 and Num <= 20)
                Return Num * Numahk.Random.GammaValue(Num - 1)
            
            else if Num - Integer(Num) = 0.5
                Return (Num - 1) * Numahk.Random.GammaValue(Num - 1)
                
            Pi := 3.141592653589793
            
            Calc(x)
            {
                a := tan(x)
                b := (1 + a ** 2) * exp(-a)
                
                if Num - 1 == 0
                    Return b
                
                Return b * a ** (Num - 1)
            }
            
            Return Numahk.Operation.Integral(Calc, [0, Pi / 2])
        }
        
        Static Normal(Shape)
        {
            if Type(Shape).in(["Integer", "String"])
                Shape := [Shape]
            
            New_Pos := []
            New_NDArray := Numahk.Zeros(Shape)
            
            For i in Shape
                New_Pos.Push(Range(1, i).Array())
            
            New_Pos := Dynloop_Loop(New_Pos)
            
            For i in New_Pos
                New_NDArray[i*] := Numahk.Random.BoxMuller()
            
            Return New_NDArray
        }
        
        Static Permulation(NDArray)
        {
            New_NDArray := []
            
            if NDArray is Integer
            {
                Loop NDArray
                    New_NDArray.Push(Integer(10 * Numahk.Random.Rand()))
            }
            
            else
            {
                New_NDArray := NUmahk.AsArray(NDArray)
                
                Loop Numahk.Random.RandRange(1, New_NDArray.Length, 1)
                {
                    SwapX := Numahk.Random.RandRange(1, New_NDArray.Length, 1)
                    SwapY := Numahk.Random.RandRange(1, New_NDArray.Length, 1)
                    Numahk.Random.Swap(SwapX, SwapY, New_NDArray)
                }
                
                Return New_NDArray
            }
            
            Numahk.Random._LCG := Numahk.Random.LCG()
            
            Return Numahk.Array(New_NDArray)
        }
        
        Static Rand(Num := 1)
        {
            if Num == 1
                Return Numahk.Random._LCG.Next()
            
            else
            {
                New_NDArray := []
                
                Loop Num
                    New_NDArray.Push(Numahk.Random._LCG.Next())
            }
            
            Return Numahk.Array(New_NDArray)
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
            
            Ret := (B - A) * Numahk.Random.Rand() + A
            
            Return Ret
        }
        
        Static RandInt(Start, End, Num := 1)
        {
            if Num == 1
                Return Integer(Numahk.Random.Random(Start, End))
            
            else
            {
                New_NDArray := []
                
                Loop Num
                    New_NDArray.Push(Integer(Numahk.Random.Random(Start, End)))
            }
            
            Return Numahk.Array(New_NDArray)
        }
        
        Static Randn(Shape*)
        {
            if Type(Shape).in(["Integer", "String"])
                Shape := [Shape]
            
            New_Pos := []
            New_NDArray := Numahk.Zeros(Shape)
            
            For i in Shape
                New_Pos.Push(Range(1, i).Array())
            
            New_Pos := Dynloop_Loop(New_Pos)
            
            For i in New_Pos
                New_NDArray[i*] := Numahk.Random.BoxMuller()
            
            Return New_NDArray
        }
        
        Static RandRange(Start, Stop := "", Step := 1)
        {
            Lst_RandRange := Numahk.Range(Start, Stop, Step).Array()
            
            Return Lst_RandRange[Numahk.Random.Random(1, Lst_RandRange.Length)]
        }
        
        Static Seed(Seed := Numahk.TimeStamp.ConvertUnix(Numahk.TimeStamp.GetNow()))
        {
            Numahk.Random._Seed := Seed
            Numahk.Random._LCG := Numahk.Random.LCG()
        }
        
        Static Shuffle(NDArray)
        {
            Loop Numahk.Random.RandRange(1, NDArray.Length, 1)
            {
                SwapX := Numahk.Random.RandRange(1, NDArray.Length, 1)
                SwapY := Numahk.Random.RandRange(1, NDArray.Length, 1)
                Numahk.Random.Swap(SwapX, SwapY, NDArray)
            }
            
            Return NDArray
        }
        
        Static Swap(ValueX, ValueY, Arr)
        {
            Temp := Arr[ValueX]
            Arr[ValueX] := Arr[ValueY]
            Arr[ValueY] := Temp
        }
        
        Static Uniform()
        {
            Return Numahk.Random.Random()
        }
        
        Class LCG
        {
            a := 672257317069504227
            b := 7382843889490547368
            m := 9223372036854775783
            
            __New(Seed := Numahk.Random._Seed)
            {
                this.Seed := Seed
            }
            
            Next()
            {
                op := Numahk.Operation
                this.Seed := op.StrMod(op.StrAdd(op.StrMul(this.Seed, this.a), this.b), this.m)
                preZero := "0000000000000000000"
                
                Return Float("0." SubStr(preZero . this.Seed, -19)) / 0.9223372036854775783
            }
        }
    }
    
    ; Linalg
    Class Linalg
    {
        
    }
    
    Class Operation
    {
        Static Integral(Function, Scale, Num := 100)
        {
            Sum := 0
            Pos := Scale[1]
            Delta := (Scale[2] - Scale[1]) / Num
            
            Loop Num
            {
                Sum += Function(Pos) * Delta
                Pos += Delta
            }
            
            Return Sum
        }
        
        Static StrAdd(num1, num2)
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
        
        Static StrMod(num1, num2)
        {
            num1 := StrSplit(Abs(num1))
            
            s := 0
            for i in num1
                s := mod(s * 10 + i, num2)
            
            Return s
        }

        Static StrMul(num1, num2)
        {
            flag := 1
            num1 := StrSplit(num1)
            num2 := StrSplit(num2)
            if num1[1] = "-"
            {
                num1.RemoveAt(1)
                flag *= -1
            }
            if num2[1] = "-"
            {
                num2.RemoveAt(1)
                flag *= -1
            }
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
            
            Return Strlen(str) == 0 ? "0" : (flag = -1) ? "-" str : str
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
    
    Class Testing
    {
        Static Assert_Almost_Equal(Actual, Desired, Decimal := 7, Err_Msg := "", Verbose := True)
        {
            Assert(Abs(Desired - Actual) < 1.5 * 10 ** (-Decimal), Err_Msg)
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
            Deviation := -Zone * 60 * 60
            Init := 62135596800
            
            if TimeType = "UTC"
            {
                Ret := (DateDiff(InputTime, 19700101000000, "Seconds") + Deviation + Init) * 10000000
            }
            
            else if TimeType == "Unix"
            {
                Ret := DateDiff(InputTime, 19700101000000, "Seconds") + Deviation
            }
            
            Return Ret
        }
        
        Static GetNow()
        {
            Now_Time := ""
            buf := Buffer(1024)
            DllCall("GetLocalTime", "Ptr", buf)
            Now_Time .= NumGet(buf, 0, "UShort")
            Now_Time .= SubStr("0" NumGet(buf, 2, "UShort"), -2)
            Now_Time .= SubStr("0" NumGet(buf, 6, "UShort"), -2)
            Now_Time .= SubStr("0" NumGet(buf, 8, "UShort"), -2)
            Now_Time .= SubStr("0" NumGet(buf, 10, "UShort"), -2)
            Now_Time .= SubStr("0" NumGet(buf, 12, "UShort"), -2)
            
            Return Now_Time
        }
    }
}

Dynloop_Loop(Data)
{
    if Data.Length == 1
    {
        Lst_rst := []
        
        For i in Data[1]
            Lst_rst.Push([i])
        
        Return Lst_rst
    }
    
    Max_y_idx := Data.Length
    Row_max_idx := 1
    Arr_len := []
    Lst_row := []
    Lst_rst := []
    Arr_idx := [0]
    Arr_idx.mul(Max_y_idx)

    For item in Data
    {
        _n := HasProp(item, "Length") ? item.Length : 1
        Arr_len.Push(_n)
        Lst_row.Extend(item)
        Row_max_idx *= _n
    }
    
    For row_idx in Range(0, Row_max_idx - 1)
    {
        For y_idx in Range(0, Max_y_idx - 1)
        {
            _pdt := 1
            
            For n in Range(y_idx + 1, Arr_len.Length - 1)
                _pdt *= Arr_len[n + 1]
            
            _offset := 0
            
            For n in Range(0, y_idx - 1)
                _offset += Arr_len[n + 1]
            
            Arr_idx[y_idx + 1] := Mod((row_idx // _pdt), Arr_len[y_idx + 1]) + _offset
        }
        
        _lst_tmp := []
        
        For idx in Arr_idx
            _lst_tmp.Push(Lst_row[idx + 1])
        
        Lst_rst.Push(_lst_tmp)
    }

    Return Lst_rst
}
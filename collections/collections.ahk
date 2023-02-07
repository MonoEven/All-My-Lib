#Include <ahktype\ahktype>

Class Counter Extends Map
{
    __New(Obj := "Null")
    {
        if Object == "Null"
            Obj := Array()
    
        if Type(Obj).in(["Integer", "Float", "String"])
        {
            Lst_Object := Obj.Array
            
            Loop Lst_Object.Length
            {
                Key := Lst_Object[A_Index]
                
                if this.Has(Key)
                    this[Key]++
                
                else
                    this[Key] := 1
            }
        }
        
        else if Type(Obj).in(["Array", "Numahk.NDArray"])
        {
            For i in Obj
            {
                Key := Print.ToString(i)
                
                if this.Has(Key)
                    this[Key]++
                
                else
                    this[Key] := 1
            }
        }
        
        else if Type(Obj).in(["Map", "Counter"])
        {
            For Key, Value in Obj
            {
                if isNumber(Value)
                    this[Key] := Value
            }
        }
        
        else if Type(Obj) == "Object"
        {
            For i, Value in Obj.OwnProps()
            {
                if isNumber(Value)
                    this[i] := Value
            }
        }
        
        else
            Throw ValueError("Illegal Input")
    }
    
    Add(Obj)
    {
        Map_Obj := Counter(Obj)
        
        For Key, Value in Map_Obj
        {
            if this.Has(Key)
                this[Key] += Value
            
            else
                this[Key] := Value
        }
        
        For Key, Value in this
        {
            if Value <= 0
                this.Delete(Key)
        }
        
        Return this
    }
    
    And(Obj)
    {
        Map_Obj := Counter(Obj)
        
        For Key, Value in Map_Obj
        {
            if this.Has(Key)
                this[Key] := Min(Value, this[Key])
        }
        
        For Key, Value in this
        {
            if !Map_Obj.Has(Key)
                this.Delete(Key)
            
            if Value <= 0
                this.Delete(Key)
        }
        
        Return this
    }
    
    Del(Key)
    {
        if this.Has(Key)
            this.Delete(Key)
        
        Return this
    }
    
    Elements()
    {
        Ret := []
        
        For Key, Value in this
            Ret.Extend([Key].Mul(Value))
        
        Return Ret
    }
    
    Most_Common(Number := 1)
    {
        if Number > this.Count
            Number := this.Count
        
        Lst_Return := []
        Lst_Map := this.Sort(Cmp(x, y) => x[2] < y[2])
        
        Loop Number
            Lst_Return.Push(Lst_Map[A_Index])
        
        Return Lst_Return
    }
    
    Or(Obj)
    {
        Map_Obj := Counter(Obj)
        
        For Key, Value in Map_Obj
        {
            if this.Has(Key)
                this[Key] := Max(Value, this[Key])
            
            else
                this[Key] := Value
        }
        
        For Key, Value in this
        {
            if Value <= 0
                this.Delete(Key)
        }
        
        Return this
    }
    
    Sub(Obj)
    {
        Map_Obj := Counter(Obj)
        
        For Key, Value in Map_Obj
        {
            if this.Has(Key)
                this[Key] -= Value
                
            if this[Key] <= 0
                this.Delete(Key)
        }
        
        Return this
    }
            
    Subtract(Obj)
    {
        Map_Obj := Counter(Obj)
        
        For Key, Value in Map_Obj
        {
            if this.Has(Key)
                this[Key] -= Value
            
            else
                this[Key] := -Value
        }
        
        Return this
    }
    
    Update(Obj)
    {
        Map_Object := Counter(Obj)
                
        For Key, Value in Map_Object
        {
            if this.Has(Key)
                this[Key] += Value
            
            else
                this[Key] := Value
        }
        
        Return this
    }
}
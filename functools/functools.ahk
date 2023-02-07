; Author: Mono
; Time: 2022.09.08
; Version: 1.0.0

#Include <ahktype\ahktype>

Class FuncTools
{
    Static Map(Function, IterObj*)
    {
        Temp := []
        
        Loop IterObj.Length
            Temp.Extend(IterObj[A_Index])
        
        For i in Temp
            Temp[A_Index] := Function(i)
        
        Return Temp
    }
    
    Static Reduce(Function, IterObj*)
    {
        Temp := []
        
        Loop IterObj.Length
            Temp.Extend(IterObj[A_Index])
        
        if Temp.Length < 2
            Return "Null"
        
        Res := Function(Temp[1], Temp[2])
    
        Loop Temp.Length - 2
            Res := Function(Res, Temp[A_Index + 2])
        
        Return Res
    }
}
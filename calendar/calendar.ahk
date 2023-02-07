; Author: Mono
; Time: 2022.09.22
; Version: 1.0.0

MONDAY := 1
TUESDAY := 2
WEDNESDAY := 3
THURSDAY := 4
FRIDAY := 5
SATURDAY := 6
SUNDAY := 7
January := 1
February := 2

CalendarMonths := ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
CalendarDays := [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
CalendarDay := [" 1", " 2", " 3", " 4", " 5", " 6", " 7", " 8", " 9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]

Class Calendar
{
    Args := {w : 1, l : 1, c : 6, m : 3}
    
    ArgsFormat(arr)
    {
        For i in arr
        {
            tmp := StrSplit(i, "=")
            this.Args.%Trim(tmp[1])% := Integer(Trim(tmp[2]))
        }
    }
    
    Static Prcal(year, arr*)
    {
        this.ArgsFormat(arr)
        Ret := []
        wLength := 2 * 7 + this.Args.w * 6
        Looptimes := Mod(12, this.Args.m) ? (12 // this.Args.m) + 1 : (12 // this.Args.m)
        Pos := 1
        Current := 0
        
        Loop Looptimes
        {
            Ret.Push("")
            Current++
            
            Loop (wLength - StrLen(CalendarMonths[Pos])) // 2
                Ret[Current] .= " "
            
            Ret[Current] .= CalendarMonths[Pos]
            tmp := StrLen(Ret[Current])
            
            Loop wLength - tmp
                Ret[Current] .= " "
        }
    }
}
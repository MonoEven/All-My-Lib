__FloatPos := 8

Json_Generator(content)
{
    Return __ToString(content)
}
    
__ToString(Text)
{
    TText := Type(Text)

    if HasMethod(Text, "ToString")
        return Text.ToString()

    else if TText = "Array"
    {
        if Text.Length < 1
            Return "[]"
        
        String_Plus := ""
        String_Text := "[" . __ToString(Text[1])
        
        Loop Text.Length - 1
            String_Plus .= "," . __ToString(Text[A_Index + 1])
        
        String_Text .= String_Plus
        String_Text .= "]"
        
        return String_Text
    }

    else if TText = "ComObjArray"
    {
        if Text.MaxIndex() < 0
        {
            Text := ComObjArray(VT_VARIANT:=12, 1)
            Text[0] := ""
        }
        
        String_Plus := ""
        String_Text := "[" . __ToString(Text[0])
        
        Loop Text.MaxIndex()
            String_Plus .= "," . __ToString(Text[A_Index])
        
        String_Text .= String_Plus
        String_Text .= "]"
        
        return String_Text
    }

    else if TText = "Map"
    {
        String_Text := "{`r`n"
        
        For i, Value in Text
            String_Text .= __ToString(i) . ": " . __ToString(Value) . ",`r`n"
        
        if SubStr(String_Text, -1) !== "{"
            String_Text := SubStr(String_Text, 1, StrLen(String_Text) - 1)
        
        String_Text .= "`r`n}"
        
        return String_Text
    }

    else if TText = "Integer"
        return Text

    else if TText = "String"
        return Format('"{}"', Text)

    else if TText = "Float"
        return Round(Text, __FloatPos)

    else if TText = "Object"
    {
        String_Text := "{"
        
        For i, Value in Text.OwnProps()
            String_Text .= __ToString(i) . ":" . __ToString(Value) . ","
        
        if SubStr(String_Text, -1) !== "{"
            String_Text := SubStr(String_Text, 1, StrLen(String_Text) - 1)
        
        String_Text .= "}"
        
        return String_Text
    }

    else if TText = "Cv_Mat_Object"
    {
        String_Text := "Channels: " Text.Channels
        String_Text .= "`nData: " Text.Data
        String_Text .= "`nDepth: " Text.Depth
        String_Text .= "`nShape: " __ToString([Text.Rows, Text.Cols, Text.Channels])
        String_Text .= "`nSize: " Text.Size
        String_Text .= "`nStep1: " Text.Step1
        String_Text .= "`nTotal: " Text.Total
        String_Text .= "`nType: " Text.Type
        String_Text .= "`nCols: " Text.MAT.Cols
        String_Text .= "`nDims: " Text.MAT.Dims
        String_Text .= "`nRows: " Text.MAT.Rows
        
        return String_Text
    }

    else if TText = "Func"
    {
        String_Text := "Name: " Text.Name
        String_Text .= "`nIsBuiltIn: " Text.IsBuiltIn
        String_Text .= "`nIsVariadic: " Text.IsVariadic
        String_Text .= "`nMinParams: " Text.MinParams
        String_Text .= "`nMaxParams: " Text.MaxParams
        
        return String_Text
    }

    else if TText = "Class"
    {
        String_Text := ""
        
        For item in Text.OwnProps()
        {
            Try
                String_Text .= Type(Text.%item%) ": " item "`n"
            Catch
                String_Text .= "Func: " item "`n"
        }
        
        For item in Text.Prototype.OwnProps()
        {
            Try
                String_Text .= Type(Text.%item%) ": " item "`n"
            Catch
                String_Text .= "Func: " item "`n"
        }
        
        return SubStr(String_Text, 1, StrLen(String_Text) - 1)
    }

    else if TText = "Gui"
    {
        String_Text := "BackColor: " Text.BackColor
        String_Text .= "`nFocusedCtrl: " Text.FocusedCtrl
        String_Text .= "`nHwnd: " Text.Hwnd
        String_Text .= "`nMarginX: " Text.MarginX
        String_Text .= "`nMarginY: " Text.MarginY
        String_Text .= "`nMenuBar: " Text.MenuBar
        String_Text .= "`nName: " Text.Name
        String_Text .= "`nTitle: " Text.Title
        String_Text .= "`nItem: `n{`n"
        
        For Hwnd, GuiCtrlObj in Text
        {
            String_Text .= "  Control #" A_Index "[Hwnd: " Hwnd ",ClassNN: " GuiCtrlObj.ClassNN "]`n"
        }
        
        String_Text .= "}"
        
        return String_Text
    }

    else
    {
        Try
        {
            String_Text := ""
        
            For item in Text.OwnProps()
            {
                Try
                    String_Text .= Type(Text.%item%) ": " item "`n"
                Catch
                    String_Text .= "Func: " item "`n"
            }
            
            return SubStr(String_Text, 1, StrLen(String_Text) - 1)
        }
        Catch
            return "#Type: " Type(Text) "#"
    }
}
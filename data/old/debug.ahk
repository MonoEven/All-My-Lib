class debug
{
    static _gui := "", hwnd := 0, ctlHwnd := 0
    static StartMakingGui := 0, locked := 1
    static WinName := "Debug Window"
    static FloatPos := 15
    static TimeShow := true
    static onlyResults := false
    
    __New(Content, &value := true)
    {
        value := debug.Msg(Content)
    }
    
    static Msg(Content)
    {
        varErr := error("", -4)
        regmatch := "debug\((.*)\)"
        regexmatch(varErr.stack, regmatch, &var)
        if !var
        {
            regmatch := "debug\((.*),"
            regexmatch(varErr.stack, regmatch, &var)
        }
        varName := debug.isVar(var[1]) ? var[1] : "CONST--" var[1]
        varType := type(Content)
        
        if !debug.onlyResults
            this.makeGui()
        Content := debug.toString(Content)
        Label := format("DebugObject: {}`nDebugValue:", varName)
        
        If (debug.TimeShow) ; append timestamp + str
            Label := "[" A_Hour ":" A_Min ":" A_Sec "]`n" Label
        
        If !debug.onlyResults && (this.hwnd)
        {
            Lst_Label := StrSplit(Label, "`n")
            Lst_Content := StrSplit(Content, "`n")
            
            for _label in Lst_Label
            {
                this.AppendTxt(this.ctlHwnd, StrPtr(_label))
                this._gui["EditBox"].Value .= "`n"
            }
            
            this._gui["EditBox"].Value .= "  "
            
            for _content in Lst_Content
            {
                this.AppendTxt(this.ctlHwnd, StrPtr(_content))
                this._gui["EditBox"].Value .= "`n  "
            }
        }
        
        return Label Content
    }
    
    static makeGui()
    {
        If (WinExist("ahk_id " this.hwnd))
            return
        
        If (this.hwnd Or this.StartMakingGui) ; skip making the GUI
            return
        
        this.StartMakingGui := 1
        
        guiClose := ObjBindMethod(this,"gClose")
        this.guiClose := guiClose
        guiSize := ObjBindMethod(this,"gSize")
        this.guiSize := guiSize
        ctlEvent := ObjBindMethod(this,"event")
        this.ctlEvent := ctlEvent
        
        ArkDebugObj := Gui("+Resize", this.WinName)
        ArkDebugObj.OnEvent("close", this.guiClose)
        ArkDebugObj.OnEvent("size", this.guiSize)
        
        ArkDebugObj.SetFont("s11","Courier New")
        ctl := ArkDebugObj.Add("Button","vCopy x5 y5 Section","Copy to Clipboard").OnEvent("Click",ctlEvent)
        ctl := ArkDebugObj.Add("Button","vClear yp x+5","Clear Window").OnEvent("Click",ctlEvent)
        
        ctl := ArkDebugObj.Add("Edit","vEditBox xs y+0 w700 h500 Multi ReadOnly")
        this.ctlHwnd := ctl.hwnd, ctl := ""
        
        ArkDebugObj.Show("NA NoActivate")
        
        this.locked := 0
        this.hwnd := ArkDebugObj.hwnd
        this.locked := 1
        
        this._gui := ArkDebugObj
    }
    
    static gClose(g)
    {
        this._gui.Destroy()
        this.hwnd := 0, this.ctlHwnd := 0
        this.StartMakingGui := 0
    }
    
    static gSize(g, MinMax, Width, Height)
    {
        ; msgbox "in size"
        x := "", y := "", w := "", h := "", ctl := ""
        w := Width - 10, h := Height - 10 - 40
        ctl := g["EditBox"]
        ctl.GetPos(&x,&y)
        ctl.Move(x,y,w,h)
    }
    
    static AppendTxt(hEdit, ptrText, loc:="bottom")
    {
        charLen := SendMessage(0x000E, 0, 0, , "ahk_id " hEdit)                        ;WM_GETTEXTLENGTH
        If (loc = "bottom")
            SendMessage 0x00B1, charLen, charLen, , "ahk_id " hEdit    ;EM_SETSEL
        Else If (loc = "top")
            SendMessage 0x00B1, 0, 0,, "ahk_id " hEdit
        SendMessage 0x00C2, False, ptrText, , "ahk_id " hEdit            ;EM_REPLACESEL
    }
    
    static event(ctl,info)
    {
        If (ctl.Name = "Copy")
            A_Clipboard := ctl.gui["EditBox"].Value
        Else If (ctl.Name = "Clear")
            ctl.gui["EditBox"].Value := ""
    }
    
    static toString(Text, extraBlank := "")
    {
        TText := Type(Text)
        
        if HasMethod(Text, "toString")
            return Text.toString()
        
        else if Text is Array
        {
            String_Text := "Type: Array`n" extraBlank
            
            if Text.Length < 1
                return String_Text "  Empty"
            
            String_Plus := ""
            if Text[1] is Number || Text[1] is String
                String_Text .= "  Index: 1 => " debug.toString(Text[1], extraBlank)
            else
                String_Text .= "  Index: 1 => " debug.toString(Text[1], extraBlank "  ")
            
            Loop Text.Length - 1
            {
                if Text[A_Index + 1] is Number || Text[A_Index + 1] is String
                    String_Plus .= "`n  " extraBlank "Index: " A_Index + 1 " => " debug.toString(Text[A_Index + 1], extraBlank)
                else
                    String_Plus .= "`n  " extraBlank "Index: " A_Index + 1 " => " debug.toString(Text[A_Index + 1], extraBlank "  ")
            }
            
            String_Text .= String_Plus
            
            return String_Text
        }
        
        else if Text is ComObjArray
        {
            String_Text := "Type: ComObjArray`n" extraBlank
            
            if Text.MaxIndex() < 0
                return String_Text "  Empty"
            
            String_Plus := ""
            if Text[0] is Number || Text[0] is String
                String_Text := "  Index: 0 => " debug.toString(Text[0], extraBlank)
            else
                String_Text := "  Index: 0 => " debug.toString(Text[0], extraBlank "  ")
            
            Loop Text.MaxIndex()
            {
                if Text[A_Index] is Number || Text[A_Index] is String
                    String_Plus .= "`n  " extraBlank "Index: " A_Index " => " debug.toString(Text[A_Index], extraBlank)
                else
                    String_Plus .= "`n  " extraBlank "Index: " A_Index " => " debug.toString(Text[A_Index], extraBlank "  ")
            }
            
            String_Text .= String_Plus
            
            return String_Text
        }
        
        else if Text is Map
        {
            String_Text := "Type: (like)Map`n" extraBlank
            
            if Text.Count < 1
                return String_Text "  Empty"
            
            Map_Enum := Text.__Enum()
            String_Plus := ""
            Map_Enum(&Key, &Value)
            String_Text .= "  Key => " debug.toString(Key, extraBlank)
            if Value is Number || Value is String
                String_Text .= "`n  " extraBlank "Value => " debug.toString(Value, extraBlank)
            else
                String_Text .= "`n  " extraBlank "Value => " debug.toString(Value, extraBlank "  ")
            
            while Map_Enum(&Key, &Value)
            {
                String_Text .= "`n`n  " extraBlank "Key => " debug.toString(Key, extraBlank)
                if Value is Number || Value is String
                    String_Text .= "`n  " extraBlank "Value => " debug.toString(Value, extraBlank)
                else
                    String_Text .= "`n  " extraBlank "Value => " debug.toString(Value, extraBlank "  ")
            }
            
            return String_Text
        }
        
        else if TText = "Integer"
            return "Type: Integer => " Text
        
        else if TText = "String"
            return "Type: String => " Format('"{}"', Text)
        
        else if TText = "Float"
            return "Type: Float => " Round(Text, this.FloatPos)
        
        else if Text is Func
        {
            String_Text := "Type: Func`n" extraBlank
            String_Text .= "  Name => " Text.Name
            String_Text .= "`n  "  extraBlank "IsBuiltIn => " Text.IsBuiltIn
            String_Text .= "`n  "  extraBlank "IsVariadic => " Text.IsVariadic
            String_Text .= "`n  "  extraBlank "MinParams => " Text.MinParams
            String_Text .= "`n  "  extraBlank "MaxParams => " Text.MaxParams
            
            return String_Text
        }
        
        else if Text is Class
        {
            String_Text := "Type: Class => " Text.Prototype.__Class "`n" extraBlank
            
            if ObjOwnPropCount(Text) < 1
                return String_Text "  Empty"
            
            Object_Enum := Text.OwnProps()
            Object_Enum(&Key)
            Value := Text.%Key%
            if !(Value is Number || Value is String) && type(Value) != "Prototype"
            {
                String_Text .= "  PropName => " Key
                String_Text .=  "`n  " extraBlank debug.toString(Value, extraBlank "  ")
            }
            else if type(Value) != "Prototype"
            {
                String_Text .= "  PropName => " Key
                String_Text .= "`n  " extraBlank "PropValue => " debug.toString(Value, extraBlank)
            }
            
            while Object_Enum(&Key)
            {
                Value := Text.%Key%
                if !(Value is Number || Value is String) && type(Value) != "Prototype"
                {
                    String_Text .= "`n`n  " extraBlank "PropName => " Key
                    String_Text .= "`n  " extraBlank debug.toString(Value, extraBlank "  ")
                }
                else if type(Value) != "Prototype"
                {
                    String_Text .= "`n`n  " extraBlank "PropName => " Key
                    String_Text .= "`n  " extraBlank "PropValue => " debug.toString(Value, extraBlank)
                }
            }
            
            if ObjOwnPropCount(Text.Prototype) < 1
                return String_Text "  Empty"
            
            Class_Enum := Text.Prototype.OwnProps()
            Class_Enum(&Key)
            Value := Text.Prototype.%Key%
            String_Text .= "`n  " extraBlank "Prototype:`n    " extraBlank "PropName => " Key
            if (Value is Number || Value is String)
                String_Text .= "`n    " extraBlank "PropValue => " debug.toString(Value, extraBlank)
            else
                String_Text .= "`n    " extraBlank "PropValue => " debug.toString(Value, extraBlank "    ")
            
            while Class_Enum(&Key)
            {
                Value := Text.Prototype.%Key%
                String_Text .= "`n`n    " extraBlank "PropName => " Key
                if (Value is Number || Value is String)
                    String_Text .= "`n    " extraBlank "PropValue => " debug.toString(Value, extraBlank)
                else
                    String_Text .= "`n    " extraBlank "PropValue => " debug.toString(Value, extraBlank "    ")
            }
            
            return String_Text
        }
        
        else if Text is Object
        {
            String_Text := Format("Type: {}`n", TText)
            
            if ObjOwnPropCount(Text) < 1
                return String_Text "  Empty"
            
            String_Text .= extraBlank
            Object_Enum := Text.OwnProps()
            Object_Enum(&Key)
            Value := Text.%Key%
            String_Text .= "  " extraBlank "PropName => " debug.toString(Key, extraBlank)
            if (Value is Number || Value is String)
                String_Text .= "`n  " extraBlank "PropValue => " debug.toString(Value, extraBlank)
            else
                String_Text .= "`n  " extraBlank "PropValue => " debug.toString(Value, extraBlank "  ")
            
            while Object_Enum(&Key)
            {
                Value := Text.%Key%
                String_Text .= "`n`n  " extraBlank "PropName => " debug.toString(Key, extraBlank)
                if (Value is Number || Value is String)
                    String_Text .= "`n  " extraBlank "PropValue => " debug.toString(Value, extraBlank)
                else
                    String_Text .= "`n  " extraBlank "PropValue => " debug.toString(Value, extraBlank "  ")
            }
            
            return String_Text
        }
        
        else
            return "Type: " TText
    }
    
    static isVar(_string)
    {
        try
        {
            lst_name := strsplit(_string, ".")
            tmp := %lst_name[1]%
            loop lst_name.length - 1
                tmp := tmp.%lst_name[a_index + 1]%
            return true
        }
        catch
            return false
    }
}

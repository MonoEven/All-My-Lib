; Author: Mono
; Time: 2022.09.08
; Version: 1.0.0

Class XA
{
    Static XA_Save(Arr, BaseName := "Base")
    {
        Tmp := (Type(Arr) == "Numahk.NDArray") ? "Array" : Type(Arr)
        q := Chr(34)
        OutVar := "<?xml version=" q "1.0" q " encoding=" q "UTF-8" q "?>`n<" BaseName " type=" q Tmp q ">`n" XA.XA_ArrayToXML(Arr) "`n</" BaseName ">"
        
        Return OutVar
    }
    
    Static XA_Load(XMLText, Opt := -1)
    {
        Local XMLObj, XMLRoot, Root1, Root2
        
        if Opt == -1
            XMLText := FileRead(XMLText)
        
        XMLObj := XA.XA_LoadXML(&XMLText)
        XMLObj := XMLObj.SelectSingleNode("/*")
        
        if (IsObject(XMLObj))
        {
            XMLRoot   := XMLObj.NodeName
            CurType := ""
            Try CurType := XMLObj.GetAttribute("type")
            OutputArray := XA.XA_XMLToArray(XMLObj.ChildNodes, , CurType)
            
            Return OutputArray
        }
        
        else
            Return ""
    }
    
    Static XA_XMLToArray(Nodes, NodeName:="", CurType:="")
    {
        if (!IsSet(Obj) And CurType = "Array")
            Obj := []
        
        else if (!IsSet(Obj) And CurType = "Map")
            Obj := Map()
        
        else if (!IsSet(Obj))
            Obj := ""
        
        For Node in Nodes
        {
            if (Node.NodeName != "#Text")
            {
                if (Node.NodeName == "Invalid_Name" && Node.GetAttribute("ahk") == "True")
                    NodeName := Node.GetAttribute("id")
                else
                    NodeName := Node.NodeName
            }
            
            else
            {
                if (CurType = "String")
                    Obj := String(Node.NodeValue)
                
                else if (CurType = "Integer")
                    Obj := Integer(Node.NodeValue)
                
                else if (CurType = "Float")
                    Obj := Float(Node.NodeValue)
                
                else
                    Obj := Node.NodeValue
            }
            
            if Node.hasChildNodes
            {
                prevSib := ""
                Try prevSib := Node.previousSibling.NodeName

                nextSib := ""
                Try  nextSib := Node.nextSibling.NodeName

                nextType := ""
                Try nextType := Node.GetAttribute("type")
                
                if ((nextSib = Node.NodeName || Node.NodeName = prevSib) && Node.NodeName != "Invalid_Name" && Node.GetAttribute("ahk") != "True")
                {
                    pN := "", cN := "", nN := ""
                    Try pN := Node.previousSibling.xml
                    Try cN := Node.xml
                    Try nN := Node.nextSibling.xml
                    
                    Throw "Duplicate Node:`r`n`r`nPrev:`r`n" pN "`r`n`r`nCurrent:`r`n" cN "`r`n`r`nNext:`r`n" nN
                }
                
                else
                {
                    if (CurType = "Map")
                        Obj[NodeName] := XA.XA_XMLToArray(Node.ChildNodes, NodeName, nextType)
                    
                    else if (CurType = "Array")
                        Obj.InsertAt(NodeName, XA.XA_XMLToArray(Node.ChildNodes, NodeName, nextType))
                }
            }
        }
        
        Return Obj
    }
    
    Static XA_LoadXML(&Data)
    {
        Obj := ComObject("MSXML2.DOMDocument.6.0")
        Obj.Async := false
        Obj.LoadXML(Data)
        
        Return Obj
    }
    
    Static XA_ArrayToXML(theArray, TabCount:=1, NodeName:="")
    {
        Local TabSpace, ExtraTabSpace, Tag, Val, theXML, Root
        q := Chr(34)
        TabCount++
        TabSpace := "", ExtraTabSpace := "", CurType := ""
        
        if (!IsSet(theXML))
            theXML := ""
        
        if (!IsObject(theArray))
        {
            Root := theArray
            theArray := %theArray%
        }
        
        While (A_Index < TabCount)
        {
            TabSpace .= "`t" 
            ExtraTabSpace := TabSpace . "`t"
        }
         
        For Tag, Val in theArray
        {
            if (!IsObject(Val))
            {
                Tmp := (Type(Val) == "Numahk.NDArray") ? "Array" : Type(Val)
                iTag := "Invalid_Name"
                eTag := XA.XA_XMLEncode(Tag)
                eVal := XA.XA_XMLEncode(Val)
                
                if (XA.XA_InvalidTag(Tag))
                    theXML .= "`n" TabSpace "<" iTag " id=" q eTag q " ahk=" q "True" q " type=" q Tmp q ">" eVal "</" iTag ">"
                
                else
                    theXML .= "`n" TabSpace "<" Tag " type=" q Tmp q ">" eVal "</" Tag ">"
            }
            
            else
            {
                Tmp := (Type(Val) == "Numahk.NDArray") ? "Array" : Type(Val)
                iTag := "Invalid_Name"
                eTag := XA.XA_XMLEncode(Tag)
                aXML := XA.XA_ArrayToXML(Val, TabCount, "")
                
                if (XA.XA_InvalidTag(Tag))
                    theXML .= "`n" TabSpace "<" iTag " id=" q eTag q " ahk=" q "True" q " type=" q Tmp q ">`n" aXML "`n" TabSpace "</" iTag ">"
                
                else
                    theXML .= "`n" TabSpace "<" Tag " type=" q Tmp q ">" "`n" aXML "`n" TabSpace "</" Tag ">"
            }
        } 
        
        theXML := SubStr(theXML, 2)
        
        Return theXML
    }
    
    Static XA_InvalidTag(Tag)
    {
        q := Chr(34)
        Char1      := SubStr(Tag, 1, 1) 
        Chars3     := SubStr(Tag, 1, 3)
        StartChars := "~``!@#$%^&*()_-+={[}]|\:;" q "'<,>.?/1234567890 	`n`r"
        Chars := q "'<>=/ 	`n`r"
        
        Loop Parse StartChars
        {
            if (Char1 = A_LoopField)
                Return 1
        }
        
        Loop Parse Chars
        {
            if (InStr(Tag, A_LoopField))
                Return 1
        }
        
        if (Chars3 = "xml")
            Return 1
        
        else
            Return 0
    }
    
    Static XA_XMLEncode(Text)
    {
        Text := StrReplace(Text,"&","&amp;")
        Text := StrReplace(Text,"<","&lt;")
        Text := StrReplace(Text,">","&gt;")
        Text := StrReplace(Text,Chr(34),"&quot;")
        Text := StrReplace(Text,"'","&apos;")
        Return XA.XA_CleanInvalidChars(Text)
    }
    
    Static XA_CleanInvalidChars(Text, Replace:="")
    {
        Rep := "[^\x09\x0A\x0D\x20-\x{D7FF}\x{E000}-\x{FFFD}\x{10000}-\x{10FFFF}]"
        Return RegExReplace(Text, Rep, Replace)
    }
}
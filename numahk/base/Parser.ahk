#Include <numahk\base\Tokenizer>

Boolean(bool)
{
    if bool = "False"
        Return 0
    Return 1
}

Json_Parser(filename)
{
    if FileExist(filename)
        content := FileRead(filename)
    else
        content := filename
    _tokenizer := Tokenizer(content)
    _parser := Parser(_tokenizer)
    result := _parser.parser()
    
    Return result
}

class Parser
{
    __New(_tokenizer)
    {
        this._tokenizer := _tokenizer
    }
    
    nextToken()
    {
        while (!this._tokenizer.isEof())
        {
            this._tokenizer.nextToken()
            token := this._tokenizer.getCurrToken()
            if (!isSpace(token))
            {
                this.currToken := token
                this.currTokenState := this._tokenizer.getState()
                Break
            }
        }
        this.isEof := this._tokenizer.isEof()
    }
    
    newException()
    {
        Throw Error("语法解析错误，token:【" . this.currToken . "】,state:【" . this.currTokenState . "】", "RuntimeException")
    }
    
    parser()
    {
        this.nextToken()
        if (this.currTokenState = DFAUtil.STATE_SYMBOL)
        {
            if (this.currToken = "[")
            {
                arr := []
                this._array(arr)
                if (this.isEof)
                    return arr
                else
                    this.newException()
            }
            else if (this.currToken = "{")
            {
                mmap := Map()
                this._map(mmap)
                if (this.isEof)
                    return mmap
                else
                    this.newException()
            }
            else
                this.newException()
        }
        else
            this.newException()
    }
    
    _array(arr)
    {
        this.nextToken()
        if (this.currTokenState = DFAUtil.STATE_SYMBOL)
        {
            if (this.currToken = "]")
            {
                this.nextToken()
                Return
            }
        }
        item := this._item()
        arr.push(item)
        this.arrayTail(arr)
        this.nextToken()
    }
    
    arrayTail(arr)
    {
        if (this.currTokenState = DFAUtil.STATE_SYMBOL)
        {
            if (this.currToken = "]")
                Return
            else
            {
                while true
                {
                    if (this.currToken = ",")
                    {
                        this.nextToken()
                        item := this._item()
                        arr.push(item)
                        if (this.currTokenState == DFAUtil.STATE_SYMBOL)
                        {
                            if (this.currToken = "]")
                                Return
                        }
                    }
                    else
                        this.newException()
                }
            }
        }
        else
            this.newException()
    }
    
    _item()
    {
        item := {}
        switch (this.currTokenState)
        {
            case DFAUtil.STATE_NULL_START:
            {
                item := {}
                this.nextToken()
            }
            case DFAUtil.STATE_DIGIT:
            {
                item := Integer(this.currToken)
                this.nextToken()
            }
            case DFAUtil.STATE_NUM:
            {
                item := Float(this.currToken)
                this.nextToken()
            }
            case DFAUtil.STATE_TRUE_START:
            {
                item := Boolean(this.currToken)
                this.nextToken()
            }
            case DFAUtil.STATE_FALSE_START:
            {
                item := Boolean(this.currToken)
                this.nextToken()
            }
            case DFAUtil.STATE_STRING:
            {
                item := this.currToken
                this.nextToken()
            }
            case DFAUtil.STATE_STRING_QUOTE:
            {
                item := Trim(this.currToken, '"')
                this.nextToken()
            }
            case DFAUtil.STATE_STRING_QUOTE_SINGLE:
            {
                item := Trim(this.currToken, "'")
                this.nextToken()
            }
            case DFAUtil.STATE_SYMBOL:
            {
                if (this.currToken = "[")
                {
                    array1 := []
                    this._array(array1)
                    item := array1
                }
                else if (this.currToken = "{")
                {
                    map1 := map()
                    this._map(map1)
                    item := map1
                }
                else
                    this.newException()
            }
            default:
                this.newException()
        }
        Return item
    }
    
    _map(mmap)
    {
        this.nextToken()
        if (this.currTokenState = DFAUtil.STATE_SYMBOL)
        {
            if (this.currToken = "}")
                this.nextToken()
            else
                this.newException()
        }
        else
        {
            this.pair(mmap)
            this.mapTail(mmap)
            this.nextToken()
        }
    }
    
    pair(mmap)
    {
        key := ""
        switch (this.currTokenState)
        {
            case DFAUtil.STATE_STRING:
                key := this.currToken
            case DFAUtil.STATE_STRING_QUOTE:
                key := Trim(this.currToken, '"')
            case DFAUtil.STATE_STRING_QUOTE_SINGLE:
                key := Trim(this.currToken, "'")
            default:
                this.newException()
        }
        this.nextToken()
        if (this.currTokenState = DFAUtil.STATE_SYMBOL)
        {
            if (this.currToken = ":")
            {
                this.nextToken()
                item := this._item()
                mmap[key] := item
                Return
            }
        }
        this.newException()
    }
    
    mapTail(mmap) {
        if (this.currTokenState = DFAUtil.STATE_SYMBOL)
        {
            if (this.currToken = "}")
                Return
            else
            {
                while true
                {
                    if (this.currToken = ",")
                    {
                        this.nextToken()
                        this.pair(mmap)
                        if (this.currTokenState = DFAUtil.STATE_SYMBOL)
                        {
                            if (this.currToken = "}")
                                Return
                        }
                    }
                    else
                        this.newException()
                }
            }
        }
        else
            this.newException()
    }
}
#Include <json\DFAUtil>

class Tokenizer
{
    Static ENTER_STATE_INIT := -1
    
    __Init()
    {
        this.source := ""
        this.currIndex := 0
        this.currToken := ""
        this.eof := 0
        this.enterState := 0
        this.finalState := 0
        DFAUtil.Init()
    }
    
    getCurrToken()
    {
        Return this.currToken
    }
    
    getCurrIndex()
    {
        Return this.currIndex
    }

    getEnterState()
    {
        Return this.enterState
    }

    getFinalState()
    {
        Return this.finalState
    }

    getState()
    {
        switch (this.finalState)
        {
            case DFAUtil.STATE_STRING_QUOTE_END:
                Return DFAUtil.STATE_STRING_QUOTE
            case DFAUtil.STATE_STRING_QUOTE_SINGLE_END:
                Return DFAUtil.STATE_STRING_QUOTE_SINGLE
            case DFAUtil.STATE_FALSE_END:
                Return DFAUtil.STATE_FALSE_START
            case DFAUtil.STATE_NULL_END:
                Return DFAUtil.STATE_NULL_START
            case DFAUtil.STATE_TRUE_END:
                Return DFAUtil.STATE_TRUE_START
            default:
                Return this.finalState
        }
    }

    isEof()
    {
        Return this.eof
    }

    __New(source)
    {
        this.source := Trim(source) . "`n"  ; 最后的换行符是结束的标志
        this.currToken := ""
    }

    nextToken()
    {
        if (this.eof)
            Return
        this.enterState := Tokenizer.ENTER_STATE_INIT
        this.currToken := ""
        state := DFAUtil.STATE_START
        i := this.currIndex
        while i < StrLen(this.source)
        {
            ch := (StrSplit(this.source))[i + 1]
            wordType := DFAUtil.getWordType(ch)
            ; 如果未找到新状态，表示未设置状态，因此当前状态不变(这么做了是为了简化状态表的初始化)
            foundState := DFAUtil.STATES[state + 1][wordType + 1]
            if (foundState != 0)
                state := foundState
            if (this.enterState = Tokenizer.ENTER_STATE_INIT)
                this.enterState := state

            if (state != DFAUtil.STATE_END)
            {
                this.currToken .= ch
                this.currIndex++
                this.finalState := state
            }
            else
                Break
            i++
        }
        if (this.currIndex >= StrLen(this.source) - 1)
            this.eof := true
        i++
    }
}
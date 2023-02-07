init_100_100_array()
{
    tmp := []
    Loop 100
        tmp.push(0)
    arr := tmp.Clone()
    for i in arr
        arr[A_Index] := tmp.Clone()
    Return arr
}

class DFAUtil
{
    Static STATE_START := 0  ; 开始
    Static STATE_END := 1 ; 结束
    Static STATE_STRING := 2 ; 字符串
    Static STATE_STRING_QUOTE := 3 ; 带引号的字符串
    Static STATE_STRING_QUOTE_END := 4 ; 带引号的字符串结束
    Static STATE_STRING_QUOTE_SINGLE := 5 ; 带单引号的字符串
    Static STATE_STRING_QUOTE_SINGLE_END := 6 ; 带单引号的字符串结束
    Static STATE_DIGIT := 7 ; 数字
    Static STATE_SYMBOL := 8 ; 特殊符号
    Static STATE_BREAK := 9 ; 忽略(跳过)


    ; <editor-fold desc="true状态">
    Static STATE_TRUE_START := 10 ; true
    ; 注释掉的可以省略，但是中间的间隔数量一定要算对
    ; STATE_TRUE_R := 11
    ; STATE_TRUE_U := 12
    Static STATE_TRUE_END := 13 ; true结束
    ; </editor-fold>

    ; <editor-fold desc="false状态">
    Static STATE_FALSE_START := 14 ; false开始
    ; 中间的可以省略
    Static STATE_FALSE_END := 18 ; false结束
    ; </editor-fold>

    Static STATE_NUM := 19 ; 数值，float、double等

    ; <editor-fold desc="null状态">
    Static STATE_NULL_START := 20 ; null开始
    ; 中间的可以省略
    Static STATE_NULL_END := 23 ; null结束

    Static STATE_STRING_ESCAPE := 24 ; 转义字符串，就是字符串中出现\n这类字符
    ; </editor-fold>

    ; ==============输入字符类型====================================

    Static WORD_DIGIT := 0 ; 数字
    Static WORD_CHAR := 1 ; 字符
    Static WORD_SYMBOL := 2 ; 符号
    Static WORD_DOT := 3 ; 点号
    Static WORD_QUOTE := 4 ; 引号
    Static WORD_QUOTE_SINGLE := 5 ; 单引号
    Static WORD_SPACE := 6 ; 空白
    Static WORD_MINUS := 7 ; 减号

    Static WORD_T := 8 ; t
    Static WORD_R := 9 ; r
    Static WORD_U := 10 ; u
    Static WORD_E := 11 ; e

    Static WORD_F := 12 ; f
    Static WORD_A := 13 ; a
    Static WORD_L := 14 ; l
    Static WORD_S := 15 ; s
    Static WORD_N := 16 ; n

    Static WORD_BACK_SLASH := 17 ; 反斜杠

    Static START := this.WORD_DIGIT
    Static END := this.WORD_BACK_SLASH

    ; <editor-fold desc="初始化主状态表">
    ; 开始状态
    Static Init()
    {
        DFAUtil.STATES := init_100_100_array()
        DFAUtil.STATES[DFAUtil.STATE_START + 1][DFAUtil.WORD_DIGIT + 1] := DFAUtil.STATE_DIGIT    ; 开始状态 接收 数字 转换为 数字状态
        DFAUtil.STATES[DFAUtil.STATE_START + 1][DFAUtil.WORD_CHAR + 1] := DFAUtil.STATE_STRING    ; 开始状态 接收 字符 转换为 字符串状态
        DFAUtil.STATES[DFAUtil.STATE_START + 1][DFAUtil.WORD_SYMBOL + 1] := DFAUtil.STATE_SYMBOL  ; 开始状态 接收 符号 转换为 符号状态
        DFAUtil.STATES[DFAUtil.STATE_START + 1][DFAUtil.WORD_DOT + 1] := DFAUtil.STATE_STRING     ; 开始状态 接收 . 转换为 字符串状态
        DFAUtil.STATES[DFAUtil.STATE_START + 1][DFAUtil.WORD_QUOTE + 1] := DFAUtil.STATE_STRING_QUOTE  ; 开始状态 接收 引号 转换为 引号字符串状态
        DFAUtil.STATES[DFAUtil.STATE_START + 1][DFAUtil.WORD_QUOTE_SINGLE + 1] := DFAUtil.STATE_STRING_QUOTE_SINGLE ; 开始状态 接收 单引号 转换为 单引号字符串状态
        DFAUtil.STATES[DFAUtil.STATE_START + 1][DFAUtil.WORD_SPACE + 1] := DFAUtil.STATE_BREAK ; 开始状态 接收 空白 转换为 忽略状态
        DFAUtil.STATES[DFAUtil.STATE_START + 1][DFAUtil.WORD_MINUS + 1] := DFAUtil.STATE_DIGIT  ; 开始状态 接收 - 转换为 数字状态

        ; 字符串状态
        DFAUtil.STATES[DFAUtil.STATE_STRING + 1][DFAUtil.WORD_SYMBOL + 1] := DFAUtil.STATE_END
        DFAUtil.STATES[DFAUtil.STATE_STRING + 1][DFAUtil.WORD_SPACE + 1] := DFAUtil.STATE_END

        ; 双引号字符串状态
        DFAUtil.STATES[DFAUtil.STATE_STRING_QUOTE + 1][DFAUtil.WORD_QUOTE + 1] := DFAUtil.STATE_STRING_QUOTE_END
        DFAUtil.STATES[DFAUtil.STATE_STRING_QUOTE + 1][DFAUtil.WORD_BACK_SLASH + 1] := DFAUtil.STATE_STRING_ESCAPE

        ; 单引号字符串状态
        DFAUtil.STATES[DFAUtil.STATE_STRING_QUOTE_SINGLE + 1][DFAUtil.WORD_QUOTE_SINGLE + 1] := DFAUtil.STATE_STRING_QUOTE_SINGLE_END

        ; 数字状态
        DFAUtil.STATES[DFAUtil.STATE_DIGIT + 1][DFAUtil.WORD_DIGIT + 1] := DFAUtil.STATE_DIGIT
        DFAUtil.STATES[DFAUtil.STATE_DIGIT + 1][DFAUtil.WORD_DOT + 1] := DFAUtil.STATE_NUM

        ; 小数状态
        DFAUtil.STATES[DFAUtil.STATE_NUM + 1][DFAUtil.WORD_DIGIT + 1] := DFAUtil.STATE_NUM

        ; true状态
        DFAUtil.addKeyword(DFAUtil.STATE_TRUE_START, DFAUtil.STATE_TRUE_END,  [DFAUtil.WORD_T, DFAUtil.WORD_R, DFAUtil.WORD_U, DFAUtil.WORD_E])
        ; false状态
        DFAUtil.addKeyword(DFAUtil.STATE_FALSE_START, DFAUtil.STATE_FALSE_END, [DFAUtil.WORD_F, DFAUtil.WORD_A,DFAUtil.WORD_L,DFAUtil.WORD_S, DFAUtil.WORD_E])
        ; null状态
        DFAUtil.addKeyword(DFAUtil.STATE_NULL_START, DFAUtil.STATE_NULL_END, [DFAUtil.WORD_N, DFAUtil.WORD_U, DFAUtil.WORD_L, DFAUtil.WORD_L])


        Loop (DFAUtil.End - DFAUtil.Start + 1)
        {
            DFAUtil.STATES[DFAUtil.STATE_STRING_QUOTE_END + 1][A_Index + DFAUtil.Start] := DFAUtil.STATE_END
            DFAUtil.STATES[DFAUtil.STATE_STRING_QUOTE_SINGLE_END + 1][A_Index + DFAUtil.Start] := DFAUtil.STATE_END
            DFAUtil.STATES[DFAUtil.STATE_SYMBOL + 1][A_Index + DFAUtil.Start] := DFAUtil.STATE_END
            DFAUtil.STATES[DFAUtil.STATE_BREAK + 1][A_Index + DFAUtil.Start] := DFAUtil.STATE_END
            DFAUtil.STATES[DFAUtil.STATE_STRING_ESCAPE + 1][A_Index + DFAUtil.Start] := DFAUtil.STATE_STRING_QUOTE

            ; 数值剩余状态处理
            if (DFAUtil.STATES[DFAUtil.STATE_DIGIT + 1][A_Index + DFAUtil.Start] == 0)
                DFAUtil.STATES[DFAUtil.STATE_DIGIT + 1][A_Index + DFAUtil.Start] := DFAUtil.STATE_END

            ; 小数剩余状态处理
            if (DFAUtil.STATES[DFAUtil.STATE_NUM + 1][A_Index + DFAUtil.Start] == 0)
                DFAUtil.STATES[DFAUtil.STATE_NUM + 1][A_Index + DFAUtil.Start] := DFAUtil.STATE_END

            ; start状态针对特点的字母处理
            if (A_Index >= DFAUtil.WORD_T && A_Index <= DFAUtil.WORD_N)
            {
                if (DFAUtil.STATES[DFAUtil.STATE_START + 1][A_Index + DFAUtil.Start] == 0)
                    DFAUtil.STATES[DFAUtil.STATE_START + 1][A_Index + DFAUtil.Start] := DFAUtil.STATE_STRING
            }
        }
        ; </editor-fold>
    }

    Static addKeyword(startState, endState, words)
    {
        wordIndex := 0

        DFAUtil.STATES[DFAUtil.STATE_START + 1][words[++wordIndex] + 1] := startState

        Loop(endState - startState)
            DFAUtil.STATES[A_Index + startState][words[++wordIndex] + 1] := A_Index + startState
        DFAUtil.STATES[endState + 1][DFAUtil.WORD_SPACE + 1] := DFAUtil.STATE_END
        DFAUtil.STATES[endState + 1][DFAUtil.WORD_SYMBOL + 1] := DFAUtil.STATE_END

        Loop(DFAUtil.END - DFAUtil.START + 1)
        {
            index := A_Index + DFAUtil.START
            Loop(endState - startState + 1)
            {
                if (DFAUtil.STATES[A_Index + startState][index] = 0)
                    DFAUtil.STATES[A_Index + startState][index] := DFAUtil.STATE_STRING
            }
        }
    }

    static getWordType(word)
    {
        if (word = ' ' || word = '`n' || word = '`r')
            Return DFAUtil.WORD_SPACE
        if (word = '.')
            Return DFAUtil.WORD_DOT
        if (word == '"')
            Return DFAUtil.WORD_QUOTE
        if (word = "'")
            Return DFAUtil.WORD_QUOTE_SINGLE
        if (word = '{' || word = '}' || word = '[' || word = ']' || word = ':' || word = ',')
            Return DFAUtil.WORD_SYMBOL
        if (word = '-')
            Return DFAUtil.WORD_MINUS
        if (word = '\')
            Return DFAUtil.WORD_BACK_SLASH

        if (word = 'T')
            Return DFAUtil.WORD_T
        if (word = 'R')
            Return DFAUtil.WORD_R
        if (word = 'U')
            Return DFAUtil.WORD_U
        if (word = 'E')
            Return DFAUtil.WORD_E
        if (word = 'F')
            Return DFAUtil.WORD_F
        if (word = 'A')
            Return DFAUtil.WORD_A
        if (word = 'L')
            Return DFAUtil.WORD_L
        if (word = 'S')
            Return DFAUtil.WORD_S
        if (word = 'N')
            Return DFAUtil.WORD_N

        if (isNumber(word))
            Return DFAUtil.WORD_DIGIT
        Return DFAUtil.WORD_CHAR
    }
}
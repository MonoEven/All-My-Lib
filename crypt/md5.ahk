int2bin(n, count := 24)
{
    tmp := []
    
    for y in range(0, count)
    {
        y := count - 1 - y
        tmp.push((n >> y) & 1)
    }
    
    return tmp
}

class MD5
{
    __New(message)
    {
        this.message := StrSplit(message, "")
        this.ciphertext := ""

        this.A := 0x67452301
        this.B := 0xEFCDAB89
        this.C := 0x98BADCFE
        this.D := 0x10325476
        this.init_A := 0x67452301
        this.init_B := 0xEFCDAB89
        this.init_C := 0x98BADCFE
        this.init_D := 0x10325476
        
        ; 设置常数表T
        this.T := [0xD76AA478,0xE8C7B756,0x242070DB,0xC1BDCEEE,0xF57C0FAF,0x4787C62A,0xA8304613,0xFD469501,
                    0x698098D8,0x8B44F7AF,0xFFFF5BB1,0x895CD7BE,0x6B901122,0xFD987193,0xA679438E,0x49B40821,
                    0xF61E2562,0xC040B340,0x265E5A51,0xE9B6C7AA,0xD62F105D,0x02441453,0xD8A1E681,0xE7D3FBC8,
                    0x21E1CDE6,0xC33707D6,0xF4D50D87,0x455A14ED,0xA9E3E905,0xFCEFA3F8,0x676F02D9,0x8D2A4C8A,
                    0xFFFA3942,0x8771F681,0x6D9D6122,0xFDE5380C,0xA4BEEA44,0x4BDECFA9,0xF6BB4B60,0xBEBFBC70,
                    0x289B7EC6,0xEAA127FA,0xD4EF3085,0x04881D05,0xD9D4D039,0xE6DB99E5,0x1FA27CF8,0xC4AC5665,
                    0xF4292244,0x432AFF97,0xAB9423A7,0xFC93A039,0x655B59C3,0x8F0CCC92,0xFFEFF47D,0x85845DD1,
                    0x6FA87E4F,0xFE2CE6E0,0xA3014314,0x4E0811A1,0xF7537E82,0xBD3AF235,0x2AD7D2BB,0xEB86D391]
        
        ; 循环左移位数
        this.s := [7,12,17,22,7,12,17,22,7,12,17,22,7,12,17,22,
                    5,9,14,20,5,9,14,20,5,9,14,20,5,9,14,20,
                    4,11,16,23,4,11,16,23,4,11,16,23,4,11,16,23,
                    6,10,15,21,6,10,15,21,6,10,15,21,6,10,15,21]
        
        this.m := [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,
                    1,6,11,0,5,10,15,4,9,14,3,8,13,2,7,12,
                    5,8,11,14,1,4,7,10,13,0,3,6,9,12,15,2,
                    0,7,14,5,12,3,10,1,8,15,6,13,4,11,2,9]
    }

    ; 附加填充位
    fill_text()
    {
        for i in range(0, this.message.Length)
        {
            c := int2bin(ord(this.message[i + 1]), 8)
            this.ciphertext .= join(c)
        }

        if (mod(strlen(this.ciphertext), 512) != 448)
        {
            if (mod((strlen(this.ciphertext) + 1), 512) != 448)
                this.ciphertext .= '1'
            while (mod(strlen(this.ciphertext), 512) != 448)
                this.ciphertext .= '0'
        }

        length := this.message.Length * 8
        if (length <= 255)
            length := join(int2bin(length, 8))
        else
        {
            length := int2bin(length, 16)
            temp := join(cut(length, 8, 12)) . join(cut(length, 12, 16)) . join(cut(length, 0, 4)) . join(cut(length, 4, 8))
            length := temp
        }

        this.ciphertext .= length
        while (mod(strlen(this.ciphertext), 512) != 0)
            this.ciphertext .= '0'
    }

    ; 分组处理（迭代压缩）
    circuit_shift(x, amount)
    {
        x &= 0xFFFFFFFF
        return ((x << amount) | (x >> (32 - amount))) & 0xFFFFFFFF
    }

    change_pos()
    {
        a := this.A
        b := this.B
        c := this.C
        d := this.D
        this.A := d
        this.B := a
        this.C := b
        this.D := c
    }

    FF(mj, s, ti)
    {
        mj := int(mj, 2)
        temp := this.F(this.B, this.C, this.D) + this.A + mj + ti
        temp := this.circuit_shift(temp, s)
        this.A := mod((this.B + temp), pow(2, 32))
        this.change_pos()
    }

    GG(mj, s, ti)
    {
        mj := int(mj, 2)
        temp := this.G(this.B, this.C, this.D) + this.A + mj + ti
        temp := this.circuit_shift(temp, s)
        this.A := mod((this.B + temp), pow(2, 32))
        this.change_pos()
    }

    HH(mj, s, ti)
    {
        mj := int(mj, 2)
        temp := this.H(this.B, this.C, this.D) + this.A + mj + ti
        temp := this.circuit_shift(temp, s)
        this.A := mod((this.B + temp), pow(2, 32))
        this.change_pos()
    }

    II(mj, s, ti)
    {
        mj := int(mj, 2)
        temp := this.I(this.B, this.C, this.D) + this.A + mj + ti
        temp := this.circuit_shift(temp, s)
        this.A := mod((this.B + temp), pow(2, 32))
        this.change_pos()
    }

    F(X, Y, Z)
    {
        return (X & Y) | ((~X) & Z)
    }
    
    G(X, Y, Z)
    {
        return (X & Z) | (Y & (~Z))
    }
    
    H(X, Y, Z)
    {
        return X ^ Y ^ Z
    }
    
    I(X, Y, Z)
    {
        return Y ^ (X | (~Z))
    }

    group_processing(typed := "lower")
    {
        M := []
        for i in range(0, 16)
        {
            i *= 32
            num := ""
            ciphertext := StrSplit(this.ciphertext, "")
            
            ; 获取每一段的标准十六进制形式
            for j in range(0, 8)
            {
                j *= 4
                temp := cut(cut(ciphertext, i, i + 32), j, j + 4)
                temp := StrSplit(hex(int(join(temp), 2)), "")
                num .= temp[3]
            }
            
            ; 对十六进制进行小端排序
            num := StrSplit(num, "")
            num_tmp := ""
            
            for j in range(0, 4)
            {
                j := 8 - j * 2
                temp := join(cut(num, j - 2, j))
                num_tmp .= temp
            }

            num := ""
            
            for i in range(0, strlen(num_tmp))
                num .= join(int2bin(int(StrSplit(num_tmp, "")[i + 1], 16), 4))
            M.push(num)
        }

        for j in range(0, 4)
        {
            j *= 4
            j += 1
            this.FF(M[this.m[j] + 1], this.s[j], this.T[j])
            this.FF(M[this.m[j + 1] + 1], this.s[j + 1], this.T[j + 1])
            this.FF(M[this.m[j + 2] + 1], this.s[j + 2], this.T[j + 2])
            this.FF(M[this.m[j + 3] + 1], this.s[j + 3], this.T[j + 3])
        }

        for j in range(0, 4)
        {
            j *= 4
            j += 1
            this.GG(M[this.m[16 + j] + 1], this.s[16 + j], this.T[16 + j])
            this.GG(M[this.m[16 + j + 1] + 1], this.s[16 + j + 1], this.T[16 + j + 1])
            this.GG(M[this.m[16 + j + 2] + 1], this.s[16 + j + 2], this.T[16 + j + 2])
            this.GG(M[this.m[16 + j + 3] + 1], this.s[16 + j + 3], this.T[16 + j + 3])
        }


        for j in range(0, 4)
        {
            j *= 4
            j += 1
            this.HH(M[this.m[32 + j] + 1], this.s[32 + j], this.T[32 + j])
            this.HH(M[this.m[32 + j + 1] + 1], this.s[32 + j + 1], this.T[32 + j + 1])
            this.HH(M[this.m[32 + j + 2] + 1], this.s[32 + j + 2], this.T[32 + j + 2])
            this.HH(M[this.m[32 + j + 3] + 1], this.s[32 + j + 3], this.T[32 + j + 3])
        }


        for j in range(0, 4)
        {
            j *= 4
            j += 1
            this.II(M[this.m[48 + j] + 1], this.s[48 + j], this.T[48 + j])
            this.II(M[this.m[48 + j + 1] + 1], this.s[48 + j + 1], this.T[48 + j + 1])
            this.II(M[this.m[48 + j + 2] + 1], this.s[48 + j + 2], this.T[48 + j + 2])
            this.II(M[this.m[48 + j + 3] + 1], this.s[48 + j + 3], this.T[48 + j + 3])
        }

        this.A := mod((this.A + this.init_A), pow(2, 32))
        this.B := mod((this.B + this.init_B), pow(2, 32))
        this.C := mod((this.C + this.init_C), pow(2, 32))
        this.D := mod((this.D + this.init_D), pow(2, 32))
        
        answer := ""
        
        for register in [this.A, this.B, this.C, this.D]
        {
            register := StrSplit(SubStr(hex(register), 3), "")
            
            for i in range(0, 4)
            {
                i := 8 - i * 2
                answer .= join(cut(register, i - 2, i))
            }
        }
        
        if typed == "upper"
            answer := strupper(answer)
        
        return answer
    }
}

; Example
;message := "12316546"
;MD51 := MD5(message)
;MD51.fill_text()
;result1 := MD51.group_processing()
;result2 := MD51.group_processing("upper")
;MsgBox("32位小写MD5加密：" result1)
;MsgBox("32位大写MD5加密：" result2)

; base function
cut(arr, start := 0, end := -1)
{
    if end <= start
        end := arr.Length
    
    tmp := []
    
    Loop arr.Length
    {
        if A_Index < start + 1
            Continue
        if A_Index > end
            Break
        tmp.push(arr[A_Index])
    }
    
    Return tmp
}

hex(value)
{
    Return Format("0x{:x}", value)
}

int(value, base := 10)
{
    num := 0
    arr_value := StrSplit(value, "")
    
    for i in arr_value
    {
        if base <= 10
        {
            num *= base
            num += i
        }
        
        else if base == 16
        {
            num *= base
            tmp := i
            if ord(tmp) >= ord("0") && ord(tmp) <= ord("9")
                num += tmp
            else
                num += ord(strlower(tmp)) - ord("a") + 10
        }
    }
    
    Return num
}

join(arr, interval := "")
{
    tmp := ""
    
    for i in arr
    {
        if Type(i) == "Array"
            tmp .= join(i, interval)
        else
            tmp .= String(i)
    }
    
    Return tmp
}

pow(base, mul)
{
    Return base ** mul
}

range(start, stop)
{
    tmp := []
    loop stop - start
        tmp.push(start + A_Index - 1)
    return tmp
}
#Include <data\debug>
npm := numahk_pos_machine([1,0],[1,1],[2,3])
loop 6
{
debug npm.add()
}

class numahk_pos_machine
{
    __new(init_pos, min_pos, max_pos, flag1 := "", flag2 := "")
    {
        this.flag1 := flag1
        this.flag2 := flag2
        this.flag1_pos := init_pos.clone()
        this.flag2_pos := init_pos.clone()
        this.init_pos := init_pos.clone()
        this.now_pos := init_pos.clone()
        this.max_pos := max_pos
        this.min_pos := min_pos
    }
    
    add(number := 1, flag1 := false, flag2 := false)
    {
        point := -1
        modify := number
        while (point >= -this.init_pos.length)
        {
            this.now_pos[point] += modify
            modify := this.now_pos[point] // (this.max_pos[point] + 1)
            if !modify
            {
                if flag1
                    this.flag1_pos[point] := this.flag1[point] ? 1 : this.now_pos[point]
                if flag2
                    this.flag2_pos[point] := this.flag2[point] ? 1 : this.now_pos[point]
                break
            }
            this.now_pos[point] := mod(this.now_pos[point], this.max_pos[point]) + this.min_pos[point] - 1
            if flag1
                this.flag1_pos[point] := this.flag1[point] ? 1 : this.now_pos[point]
            if flag2
                this.flag2_pos[point] := this.flag2[point] ? 1 : this.now_pos[point]
            point--
        }
        tmp := [this.now_pos, this.now_pos, this.now_pos]
        if flag1
            tmp[2] := this.flag1_pos
        if flag2
            tmp[3] := this.flag2_pos
        if (this.flag1 = 0 || this.flag2 = 0 || flag1 || flag2)
            return tmp
        return this.now_pos
    }
    
    reload()
    {
        this.now_pos := this.init_pos.clone()
    }
}

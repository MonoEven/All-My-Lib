class numahk_pos_machine
{
    __new(init_pos, min_pos, max_pos)
    {
        this.init_pos := init_pos.clone()
        this.now_pos := init_pos.clone()
        this.max_pos := max_pos
        this.min_pos := min_pos
    }
    
    add(number := 1, &change_times := 0)
    {
        change_times := 0
        point := -1
        modify := number
        while (point >= -this.init_pos.length)
        {
            this.now_pos[point] += modify
            modify := this.now_pos[point] // (this.max_pos[point] + 1)
            if !modify
                break
            this.now_pos[point] := mod(this.now_pos[point], this.max_pos[point]) + this.min_pos[point] - 1
            point--
            change_times++
        }
        return this.now_pos
    }
    
    reload()
    {
        this.now_pos := this.init_pos.clone()
    }
}

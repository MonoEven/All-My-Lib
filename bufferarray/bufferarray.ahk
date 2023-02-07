class bufferarray
{
    bufarr := [Buffer(0)]
    ndim := 1
    now_pos := 0
    
    __new(type, value*)
    {
        this.type := type
        this.calctype := this.calc(type)
        this.bufarr[1].size := this.now_pos := this.calctype
        this.bufarr[1].size += value.Length * this.calctype
        
        for i in value
        {
            numput(type, i, this.bufarr[1], this.now_pos)
            this.now_pos += this.calctype
        }
    }
    
    __item[index]
    {
        get => numget(this.bufarr[1], index * this.calctype, this.type)
    }
    
    calc(type)
    {
        switch type
        {
            case "char", "uchar": return 1
            case "short", "ushort": return 2
            case "int", "uint": return 4
            case "float", "double": return 8
        }
    }
    
    __delete()
    {
        for i in this.bufarr
        {
            i.size := 0
            this.bufarr[A_Index] := ""
        }
        this.bufarr := ""
    }
}
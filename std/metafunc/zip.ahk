#Include <std\metafunc\len>
#Include <std\metafunc\iter>

class zip
{
    __new(_iter*)
    {
        this._iter := []
        minnum := len(_iter[1])
        for i in _iter
        {
            if len(i) < minnum
                minnum := len(i)
            this._iter.push(iter(i))
        }
        this.minnum := minnum
    }
    
    __enum(_ := 1)
    {
        this.index := 1
        return fn
        
        fn(var*)
        {
            ret := []
            if this.index > this.minnum
                return false
            for i in this._iter
            {
                i(&tmp)
                ret.push(tmp)
            }
            %var[1]% := ret.__enum()
            this.index++
            return true
        }
    }
}

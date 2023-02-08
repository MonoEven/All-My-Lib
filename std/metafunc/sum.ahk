#Include <std\metafunc\iter>

sum(_iter, start := 0)
{
    ret := start
    
    if ret is map
    {
        for i, j in iter(_iter)
            ret[i] := j
    }
    else
    {
        flag := 1
        for i in iter(_iter)
        {
            if ret is string
                ret .= i
            else if ret is number
                ret += i
            else if ret is array
            {
                try
                    ret.push(i*)
                catch
                    ret.push(i)
            }
            else if hasmethod(ret, "add")
                ret.add(i)
            else
            {
                flag := 0
                break
            }
        }
        if flag
            return ret
        if ret is object
        {
            for i, j in iter(_iter)
                ret.%i% := j
        }
        else
            return "unsumable"
    }
    return ret
}

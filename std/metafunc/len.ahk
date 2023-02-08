len(obj)
{
    if hasmethod(obj, "__len")
        return obj.__len()
    else if obj is array
        return obj.length
    else if obj is comobjarray
        return obj.maxindex + 1
    else if obj is map
        return obj.count
    else if obj is string
        return strlen(obj)
    else if obj is object
        return objownpropcount(obj)
    else
        return "unlenable"
}

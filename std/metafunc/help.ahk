help(obj)
{
    if obj.hasmethod("__help")
        return obj.__help()
    
    return "no help message"
}
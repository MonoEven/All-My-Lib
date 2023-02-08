analy_class(str)
{
    try
    {
        str := (str is string || str is array) ? str : str is func ? str.name : str is class ? str.prototype.__class : str.__class
        lst_str := str is array ? str : strsplit(str, ".")
        if !lst_str.length
            return class
        base_class := %lst_str[1]%
        loop lst_str.length - 1
            base_class := base_class.%lst_str[a_index + 1]%
    }
    catch error as err
        return
    return base_class
}

classname(obj)
{
    class_name := obj is string ? obj : obj is func ? obj.name : obj is class ? obj.prototype.__class : obj.__class
    base_class := analy_class(class_name)
    if base_class is func
        return classname(parent_class(class_name))
    return class_name
}

parent_class(obj)
{
    class_name := obj is string ? obj : obj is func ? obj.name : obj is class ? obj.prototype.__class : obj.__class
    lst_class := strsplit(class_name, ".")
    lst_class.pop()
    return analy_class(lst_class)
}


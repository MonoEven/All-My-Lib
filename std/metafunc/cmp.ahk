cmp(obj1, obj2)
{
    try
        return (obj1 > obj2) ? 1 : (obj1 = obj2) ? 0 : -1
    
    if cmp_classname(obj1) != cmp_classname(obj2)
        return "uncomparable"
    else if hasmethod(obj1, "__cmp")
        return obj1.__cmp(obj2)
    else
        throw error("uncomparable", -1)
    
    cmp_analy_class(str)
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
    
    cmp_classname(obj)
    {
        class_name := obj is string ? obj : obj is func ? obj.name : obj is class ? obj.prototype.__class : obj.__class
        base_class := cmp_analy_class(class_name)
        if base_class is func
            return cmp_classname(cmp_parent_class(class_name))
        return class_name
    }
    
    cmp_parent_class(obj)
    {
        class_name := obj is string ? obj : obj is func ? obj.name : obj is class ? obj.prototype.__class : obj.__class
        lst_class := strsplit(class_name, ".")
        lst_class.pop()
        return cmp_analy_class(lst_class)
    }
}

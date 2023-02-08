on_with_flag := 0
now_with_class := {}

with(_class, &var)
{
    global on_with_flag
    global now_with_class
    if on_with_flag
        throw error("last with func doesn't exit", -1)
    var := _class.__enter()
    now_with_class := _class
    on_with_flag := 1
}

_with()
{
    global on_with_flag
    global now_with_class
    now_with_class.__exit()
    on_with_flag := 0
    now_with_class := {}
}

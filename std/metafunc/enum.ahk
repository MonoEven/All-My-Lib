enum(var*)
{
    last_value := 1
    for i in var
        last_value := enum_set(i, last_value)
}

enum_c(var*)
{
    last_value := 0
    for i in var
        last_value := enum_set(i, last_value)
}

enum_set(&var, value)
{
    var := var ?? value
    return var + 1
}
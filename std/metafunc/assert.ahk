assert(param, err := "")
{
    if !param
        throw Error(err != "" ? err : "AssertionError", -1)
}

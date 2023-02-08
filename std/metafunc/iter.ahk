iter(_iter, args*)
{
    if hasmethod(_iter, "__enum")
        return _iter.__enum(args*)
    else if hasprop(_iter, "array")
        return _iter.array.__enum(args*)
    else if hasmethod(_iter, "ownprops")
        return _iter.ownprops()
    else
        return "uniterable"
}

next(_iter, iternum := 1)
{
    if !(_iter is enumerator) && !(_iter is closure)
        return "uniterable"
    tmplst := []
    tmplst.length := iternum
    reflst := [&tmp1, &tmp2, &tmp3, &tmp4, &tmp5, &tmp6, &tmp7, &tmp8, &tmp9, &tmp10, &tmp11, &tmp12, &tmp13, &tmp14, &tmp15, &tmp16, &tmp17, &tmp18, &tmp19]
    reflst.length := iternum
    _iter(reflst*)
    loop iternum
            tmplst[a_index] := %reflst[A_Index]%
    return tmplst
}

#Include <cpp\cpp>

arr := [12, 2345, 654, 894, 445]
a := malloc.malloc(4)
numput("int64", 2345, a)
stdlib.qsort(numget(objptr(arr), 0x20, "ptr"), 5, 0x10, compare)
msgbox (stdlib.bsearch(a, numget(objptr(arr), 0x20, "ptr"), 5, 0x10, compare2) - numget(objptr(arr), 0x20, "ptr")) // 0x10 + 1

compare(a, b)
{
    return (numget(a, 0, "int64") - numget(b, 0, "int64")) > 0
}

compare2(a, b)
{
    return numget(a, 0, "int64") - numget(b, 0, "int64")
}
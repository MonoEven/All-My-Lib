#Include <cpp\cpp>

; Example1
arr := [5, 2, 3, 700, 8]
stdlib.qsort(numget(objptr(arr), 0x20, "ptr"), 5, 0x10, compare)
loop arr.length
    msgbox arr[a_index]

compare(a, b)
{
    if numget(a, 0, "int64") < numget(b, 0, "int64")
        return -1
    return 1
}

; Example2
cstring.strcpy(a := malloc.malloc(4), "k523")
stdlib.qsort(a, 4, 1, compare2)
msgbox strget(a, , "utf-8")

compare2(a, b)
{
    if numget(a, 0, "char") < numget(b, 0, "char")
        return -1
    return 1
}
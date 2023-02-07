class numahk_const
{
    static __information()
    {
        return format("author: {}`tversion: {}", "mono_even", numahk.__version())
    }
    
    static __version()
    {
        return "2022.12.05-1.0.0-alpha1"
    }
    
    static __get(name, param)
    {
        switch name
        {
            case "int8", "i1": return 0
            case "uint8", "u1": return 1
            case "int16", "i2": return 2
            case "uint16", "u2": return 3
            case "int32", "i4", "int_", "intc": return 4
            case "uint32", "u4": return 5
            case "int64", "i8": return 6
            case "uint64", "u8": return 7
            case "float16", "f2": return 8 ; cannot use
            case "float32", "f", "f4", "float_": return 9
            case "float64", "d", "f8": return 10
            case "float128", "g", "f16": return 11 ; cannot use
            case "complex64", "c8": return 12 ; cannot use
            case "complex128", "c16": return 13 ; cannot use
            case "complex256", "c32": return 14 ; cannot use
            case "bool", "bool_": return 15
            
            case "e": return 2.718281828459045
            case "euler_gamma": return 0.5772156649015329
            case "inf": return "inf"
            case "nan": return "nan"
            case "pi": return 3.141592653589793
            case "tau": return 6.283185307179586
        }
    }
    
    static ahktype(number)
    {
        if number is string
            number := numahk_const.%number%
        switch number
        {
            case 0: return "char"
            case 1: return "uchar"
            case 2: return "short"
            case 3: return "ushort"
            case 4: return "int"
            case 5: return "uint"
            case 6: return "int64"
            case 7: return "uint64"
            case 8: return "float16"
            case 9: return "float"
            case 10: return "double"
            case 11: return "float128"
            case 12: return "complex64"
            case 13: return "complex128"
            case 14: return "complex256"
            case 15: return "char"
        }
    }
    
    static dtype(number)
    {
        switch number
        {
            case 0: return "int8"
            case 1: return "uint8"
            case 2: return "int16"
            case 3: return "uint16"
            case 4: return "int32"
            case 5: return "uint32"
            case 6: return "int64"
            case 7: return "uint64"
            case 8: return "float16"
            case 9: return "float32"
            case 10: return "float64"
            case 11: return "float128"
            case 12: return "complex64"
            case 13: return "complex128"
            case 14: return "complex256"
            case 15: return "bool_"
        }
    }
    
    static arr_to_string(_array, floatpos := 8)
    {
        /* tips
        we provide a method for array to string.
        */
        if _array is array
        {
            if _array.length < 1
                return "[]"
            plus := ""
            text := "[" . numahk_const.arr_to_string(_array[1])
            loop _array.length - 1
                plus .= "," . numahk_const.arr_to_string(_array[a_index + 1])
            text .= plus
            text .= "]"
            return text
        }
        else if (_array is integer) || (_array is string)
            return _array
        else if _array is float
            return round(_array, floatpos)
    }
}

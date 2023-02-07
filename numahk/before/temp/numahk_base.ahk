#Include <_numahk\numahk_const>

class numahk_base
{
    static broadcast(ndarray1, ndarray2, &broadcast_flag)
    {
        max_shape := []
        if ndarray1 is number
        {
            broadcast_flag := [-1, 0]
            nd1_shape := -1
            nd2_shape := ndarray2.shape.clone()
            max_shape := ndarray2.shape.clone()
        }
        else if ndarray2 is number
        {
            broadcast_flag := [0, -1]
            nd2_shape := -1
            nd1_shape := ndarray1.shape.clone()
            max_shape := ndarray1.shape.clone()
        }
        else
        {
            nd1_flag := []
            nd2_flag := []
            nd1_shape := ndarray1.shape.clone()
            nd2_shape := ndarray2.shape.clone()
            if numahk_base.array_property.is_arr_equal(nd1_shape, nd2_shape)
            {
                broadcast_flag := [0, 0]
                return [nd1_shape, nd2_shape, nd1_shape.clone()]
            }
            len := max(nd1_shape.length, nd2_shape.length)
            loop len - nd1_shape.length
                nd1_shape.insertat(1, 1)
            loop len - nd2_shape.length
                nd2_shape.insertat(1, 1)
            loop len
                max_shape.push(max(nd1_shape[a_index], nd2_shape[a_index]))
            for i in nd1_shape
            {
                if i != max_shape[a_index]
                {
                    if i = 1
                        nd1_flag.push(1)
                    else
                        throw error("broadcast error!", -1)
                }
                else
                    nd1_flag.push(0)
            }
            for i in nd2_shape
            {
                if i != max_shape[a_index]
                {
                    if i = 1
                        nd2_flag.push(1)
                    else
                        throw error("broadcast error!", -1)
                }
                else
                    nd2_flag.push(0)
            }
            broadcast_flag := [nd1_flag, nd2_flag]
        }
        return [nd1_shape, nd2_shape, max_shape]
    }
    
    static mcode(hex, argtypes := 0, &code := 0)
    {
        static reg := "^([12]?).*" (c := a_ptrsize = 8 ? "x64" : "x86") ":([A-Za-z\d+/=]+)"
        if (regexmatch(hex, reg, &m))
            hex := m[2], flag := m[1] = "1" ? 4 : m[1] = "2" ? 1 : hex ~= "[+/=]" ? 1 : 4
        else
            flag := hex ~= "[+/=]" ? 1 : 4
        if (!dllcall("crypt32\CryptStringToBinary", "str", hex, "uint", 0, "uint", flag, "ptr", 0, "uint*", &s := 0, "ptr", 0, "ptr", 0))
            return
        code := buffer(s)
        if (dllcall("crypt32\CryptStringToBinary", "str", hex, "uint", 0, "uint", flag, "ptr", code, "uint*", &s, "ptr", 0, "ptr", 0) && dllcall("VirtualProtect", "ptr", code, "uint", s, "uint", 0x40, "uint*", 0))
        {
            args := []
            if (argtypes is array && argtypes.Length)
            {
                args.length := argtypes.length * 2 - 1
                for i, t in argtypes
                    args[i * 2 - 1] := t
            }
            return dllcall.bind(code, args*)
        }
    }
    
    class array_property
    {
        static get_flatten(_array)
        {
            /* tips
            we provide a method for array to flat.
            */
            ret := []
            for i in _array
                numahk_base.array_property.put_value(ret, i)
            return ret
        }
        
        static get_shape(_array)
        {
            /* tips
            In order to achieve higher efficiency, 
            we decided to consider that the input array is standard.
            */
            shape := []
            while _array is array
            {
                shape.push(_array.length)
                _array := _array[1]
            }
            return shape
        }
        
        static get_string(_array, floatpos := 8)
        {
            /* tips
            we provide a method for array to string.
            */
            if _array is array
            {
                if _array.length < 1
                    return "[]"
                plus := ""
                text := "[" . numahk_base.array_property.get_string(_array[1])
                loop _array.length - 1
                    plus .= "," . numahk_base.array_property.get_string(_array[a_index + 1])
                text .= plus
                text .= "]"
                return text
            }
            else if (_array is integer) || (_array is string)
                return _array
            else if _array is float
                return round(_array, floatpos)
        }
        
        static is_arr_equal(_array1, _array2)
        {
            /* tips
            we provide a method to judge array1 is equal to array2 or not.
            */
            if !(_array1 is array)
                return _array1 = _array2
            else if _array1.length != _array2.length
                return false
            loop _array1.length
            {
                if !numahk_base.array_property.is_arr_equal(_array1[a_index], _array2[a_index])
                    return false
            }
            return true
        }
        
        static put_value(_array, value)
        {
            /* tips
            we provide a method for extend an array.
            */
            if value is array
            {
                for i in value
                    numahk_base.array_property.put_value(_array, i)
            }
            else
                _array.push(value)
        }
        
        static shape_to_strides(shape)
        {
            /* tips
            we provide a method to change shape to strides.
            */
            strides := shape.clone()
            strides.push(1)
            strides.removeat(1)
            loop strides.length - 1
                strides[-a_index - 1] *= strides[-a_index]
            return strides
        }
    }
    
    class operator
    {
        static __call(sign, params)
        {
            /*
            void operator_calc_int(int *array1, int *array2, int operator, int length, int *ret_array)
            {
                int i;
                if (operator == 0)
                {
                    for (i = 0; i < length; i++)
                    {
                        *ret_array = *array1 + *array2;
                        array1 += 4;
                        array2 += 4;
                    }
                }
                else if (operator == 1)
                {
                    for (i = 0; i < length; i++)
                    {
                        *ret_array = *array1 - *array2;
                        array1 += 4;
                        array2 += 4;
                    }
                }
                else if (operator == 2)
                {
                    for (i = 0; i < length; i++)
                    {
                        *ret_array = *array1 * *array2;
                        array1 += 4;
                        array2 += 4;
                    }
                }
                else if (operator == 3)
                {
                    for (i = 0; i < length; i++)
                    {
                        *ret_array = *array1 / *array2;
                        array1 += 4;
                        array2 += 4;
                    }
                }
            }
            */
            dtype := params[1].dtype
            sign_type := numahk_const.%"OPERATOR_" StrUpper(sign)%
            operator_calc := (dtype = "int") ? numahk_base.mcode("1,x64:4C8BD24585C0752D4585C90F8EB60000004C8B442428482BCA418BD10F1F4000428B04114103024D8D52104189004883EA0175ECC34183F801752C4585C90F8E830000004C8B442428418BD10F1F40008B01488D4910412B024D8D52104189004883EA0175EAC34183F802752B4585C97E554C8B442428418BD1660F1F4400008B01488D4910410FAF024D8D52104189004883EA0175E9C34183F80375294585C97E24458BC14C8B4C24280F1F4400008B01488D49109941F73A4D8D52104189014983E80175E9C3") : 0
        }
    }
}
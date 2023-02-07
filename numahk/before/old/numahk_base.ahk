#Include <numahk\numahk_null>

class numahk_base
{
    static dynamic_loop(data)
    {
        /* tips
        we provide a method to loop array with unknown length, like[1,2,[3,4],...]
        , to make it to a pos like [[1,2,3,...],[1,2,4,...],...].
        */
        if data.length == 1
        {
            lst_rst := []
            for i in data[1]
                lst_rst.push([i])
            return lst_rst
        }
        max_y_idx := data.length
        row_max_idx := 1
        arr_len := []
        lst_row := []
        lst_rst := []
        arr_idx := [0]
        numahk_base.get_arr_mul(arr_idx, max_y_idx)
        for item in data
        {
            _n := hasprop(item, "length") ? item.length : 1
            arr_len.push(_n)
            hasprop(item, "length") ? lst_row.push(item*) : lst_row.push(item)
            row_max_idx *= _n
        }
        for row_idx in numahk_base.range(0, row_max_idx - 1)
        {
            for y_idx in numahk_base.range(0, max_y_idx - 1)
            {
                _pdt := 1
                for n in numahk_base.range(y_idx + 1, arr_len.length - 1)
                    _pdt *= arr_len[n + 1]
                _offset := 0
                for n in numahk_base.range(0, y_idx - 1)
                    _offset += arr_len[n + 1]
                arr_idx[y_idx + 1] := mod((row_idx // _pdt), arr_len[y_idx + 1]) + _offset
            }
            _lst_tmp := []
            for idx in arr_idx
                _lst_tmp.push(lst_row[idx + 1])
            lst_rst.push(_lst_tmp)
        }
        return lst_rst
    }
    
    static get_arr_flatten(_array)
    {
        /* tips
        we provide a method for array to flat.
        */
        ret := []
        for i in _array
            numahk_base.put_arr_value(ret, i)
        return ret
    }
    
    static get_arr_mul(_array, number)
    {
        /* tips
        we provide a method for array multiply.
        */
        tmp := _array.clone()
        loop floor(Number) - 1
        {
            try
            {
                for i in tmp
                    _array.push(i)
            }
            catch
                _array.length += tmp.length
        }
        return _array
    }
    
    static get_arr_product(_array)
    {
        /* tips
        we provide a method get product of array elements.
        */
        ret := 1
        for i in _array
        {
            if i = 0
                return 0
            ret *= i
        }
        return ret
    }
    
    static get_arr_range(_string, end := numahk_null())
    {
        /* tips
        we provide a method change ":" to array like python do.
        */
        array_range := strsplit(_string, ":")
        array_range[1] := array_range[1] ? array_range[1] : 1
        if !(end is numahk_null)
            array_range[2] := (!array_range[2] || (array_range[2] = -1)) ? end : array_range[2]
        if array_range.length = 3
            array_range[3] := array_range[3] ? array_range[3] : 1
        return numahk_base.range(array_range*).array()
    }
    
    static get_arr_reshape(_array, shape)
    {
        /* tips
        we provide a method for array to reshape.
        */
        len := _array.length
        shape_clone := shape.clone()
        if shape_clone.length = 1
            return _array
        _array_clone := _array.clone()
        tmp := []
        looptimes := shape_clone.removeat(1)
        loop looptimes
        {
            tmp2 := []
            loop numahk_base.get_arr_product(shape_clone)
                tmp2.push(_array_clone.removeat(1))
            tmp.push(numahk_base.get_arr_reshape(tmp2, shape_clone))
        }
        _array.length := 0
        for j in tmp
            _array.push(j)
        return _array
    }
    
    static get_arr_shape(_array)
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
    
    static get_arr_to_string(_array, floatpos := 8)
    {
        /* tips
        we provide a method for array to string.
        */
        if _array is array
        {
            if _array.length < 1
                return "[]"
            plus := ""
            text := "[" . numahk_base.get_arr_to_string(_array[1])
            loop _array.length - 1
                plus .= "," . numahk_base.get_arr_to_string(_array[a_index + 1])
            text .= plus
            text .= "]"
            return text
        }
        else if (_array is integer) || (_array is string)
            return _array
        else if _array is float
            return round(_array, floatpos)
    }
    
    static get_ndarray_index(strides, pos)
    {
        index := 1
        for i in pos
            index += strides[a_index] * (i - 1)
        return index
    }
    
    static get_ndarray_index_with_diff_strides(strides1, strides2, pos1, pos2)
    {
        index1 := numahk_base.get_ndarray_index(strides1, pos1)
        index2 := numahk_base.get_ndarray_index(strides2, pos2)
        return [index1, index2]
    }
    
    static get_ndarray_ndim(ndarray)
    {
        return ndarray.shape.length
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
            if !numahk_base.is_arr_equal(_array1[a_index], _array2[a_index])
                return false
        }
        return true
    }
    
    static is_arr_ascend(_array)
    {
        /* tips
        we provide a method to judge array is ascended or not.
        */
        last := _array[1]
        for i in _array
        {
            if i < last
                return false
        }
        return true
    }
    
    static is_item_in_arr(item, _array)
    {
        for i in _array
        {
            if i = item
                return true
        }
        return false
    }
    
    static put_arr_value(_array, value)
    {
        if value is array
        {
            for i in value
                numahk_base.put_arr_value(_array, i)
        }
        else
            _array.push(value)
    }
    
    static set_arr_standardization(_array, shape := numahk_null())
    {
        /* tips
        we provide a method to normalize array.
        */
        if !(_array is array)
            return
        shape := (shape is numahk_null) ? numahk_base.get_arr_shape(_array) : shape
        if shape.length = 1
        {
            loop shape[1] - _array.length
                _array.push(0)
        }
        loop shape[1] - _array.length
                _array.push(0)
        shape_clone := shape.clone()
        shape_clone.removeat(1)
        loop _array.length
        {
            if shape_clone.length && !(_array[a_index] is array)
                _array[a_index] := [_array[a_index]]
            numahk_base.set_arr_standardization(_array[a_index], shape_clone)
        }
    }
    
    static shape_to_strides(shape)
    {
        /* tips
        we provide a method to change shape to strides.
        */
        strides := shape.clone()
        strides.push(1)
        strides.removeat(1)
        loop strides.length
        {
            if a_index = 1
                strides[-a_index] := 1
            else
                strides[-a_index] *= strides[-a_index + 1]
        }
        return strides
    }
    
    static swap_arr_index(_array, index1, index2)
    {
        /* tips
        we provide a method to swap indexs in array.
        */
        if index1 = index2
            return
        temp := _array[index1]
        _array[index1] := _array[index2]
        _array[index2] := temp
    }
    
    static swap_ndarray_index(ndarray, index1, index2)
    {
        index1 := numahk_base.get_ndarray_index(ndarray.strides, index1)
        index2 := numahk_base.get_ndarray_index(ndarray.strides, index2)
        numahk_base.swap_arr_index(ndarray._data, index1, index2)
    }
    
    class range
    {
        /* tips
        we provide a class to get range_iter like python.
        */
        __new(start, stop := "", step := 1)
        {
            if !step
                throw valueerror("step cannot be 0.")
            if stop == ""
            {
                tmp := start
                start := 1
                stop := tmp
            }
            this.start := start
            this.stop := stop
            if instr(step, "j")
            {
                this.length := max(0, integer(rtrim(step, "j")))
                value_float := (stop - start) / (this.length - 1)
                value_int := (stop - start) // (this.length - 1)
                this.step := (value_float = value_int) ? value_int : value_float
            }
            else
            {
                this.length := max(0, (stop - start) // abs(step) + 1)
                this.step := step
            }
        }
        
        __enum(_)
        {
            this.looptimes := this.length
            this.index := 0
            return fn
            fn(&idx := 0, &value := 0)
            {
                if !this.looptimes
                    return false
                idx := (isset(value)) ? this.start + this.index * this.step : this.index + 1
                value := this.start + this.index * this.step
                this.index++
                return this.looptimes--
            }
        }
        
        array()
        {
            ret := []
            loop this.length
            {
                if this.step > 0
                    ret.push(this.start + (a_index - 1) * this.step)
                else
                    ret.push(this.stop + (a_index - 1) * this.step)
            }
            return ret
        }
    }
}

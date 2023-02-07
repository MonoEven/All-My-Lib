#Include <numahk\numahk_base>
#Include <numahk\numahk_func>
#Include <numahk\numahk_null>
#Include <numahk\numahk_operator>
#Include <numahk\numahk_pos_machine>
#Include <numahk\numahk_timer_machine>

numahk.ndarray([0]).base.defineprop("ndim", {get: numahk_base.get_ndarray_ndim.bind("")})
numahk.ndarray([0]).base.defineprop("T", {get: numahk_func.transpose.bind("")})
class numahk extends numahk_func
{
    /* tips
    numahk start index is 1.
    */
    static __information()
    {
        return format("author: {}`tversion: {}", "mono_even", numahk.__version())
    }
    
    static __version()
    {
        return "2022.11.18-1.0.0-alpha3"
    }
    
    class ndarray
    {
        __new(_array, standardization := false, isflat := false, input_shape := numahk_null())
        {
            if standardization
                numahk_base.set_arr_standardization(_array, input_shape)
            this.shape := isflat ? [_array.length] : numahk_base.get_arr_shape(_array)
            this._data := isflat ? _array : numahk_base.get_arr_flatten(_array)
            this.data := objptr(this._data)
            this.strides := numahk_base.shape_to_strides(this.shape)
        }
        
        __item[pos*]
        {
            get => this.get_method(pos*)
            set => this.set_method(value, pos*)
        }
        
        __enum(_)
        {
            return this._data.__enum(_)
        }
        
        copy()
        {
            return this.clone()
        }
        
        get_method(pos*)
        {
            if pos.length = 1 && !(pos[1] is number || pos[1] is string)
            {
                pos_clone := pos[1] is array ? pos[1] : pos[1]._data
                new_array := []
                for i in pos_clone
                {
                    if i = 1
                        new_array.push(this._data[a_index])
                }
                return numahk.ndarray(new_array, , 1)
            }
            pos_clone := pos.clone()
            while pos_clone.length > this.shape.length
            {
                if pos_clone.pop() != 1
                    throw error("index error!")
            }
            if pos_clone.length = this.shape.length
                return this.get_single_method(pos_clone*)
            ret := []
            len := pos_clone.length
            loop this.shape.length - len
                pos_clone.push(format("1:{}", this.shape[len + a_index]))
            return this.get_single_method(pos_clone*)
        }
        
        get_single_method(pos*)
        {
            array_range := []
            for i in pos
            {
                if instr(i, ":")
                {
                    pos[a_index] := numahk_base.get_arr_range(i, this.shape[a_index])
                    array_range.push(pos[a_index].length)
                }
            }
            if !array_range.length
            {
                index := numahk_base.get_ndarray_index(this.strides, pos)
                return this._data[index]
            }
            ndarray := []
            pos_new := numahk_base.dynamic_loop(pos)
            for i in pos_new
                ndarray.push(this.get_single_method(i*))
            return numahk.ndarray(ndarray, , 1).resize(array_range)
        }
        
        reshape(shape*)
        {
            if shape.length = 1 && shape[1] is array
                shape := shape[1]
            for i in shape
            {
                if i = -1
                    shape[a_index] := this._data.length // abs(numahk_base.get_arr_product(shape))
            }
            ndarray_clone := this.clone()
            ndarray_clone.shape := shape
            ndarray_clone.strides := numahk_base.shape_to_strides(shape)
            return ndarray_clone
        }
        
        resize(shape*)
        {
            if shape.length = 1 && shape[1] is array
                shape := shape[1]
            for i in shape
            {
                if i = -1
                    shape[a_index] := this._data.length // abs(numahk_base.get_arr_product(shape))
            }
            this.shape := shape
            this.strides := numahk_base.shape_to_strides(shape)
            return this
        }
        
        set_method(value, pos*)
        {
            pos_clone := pos.clone()
            while pos_clone.length > this.shape.length
            {
                if pos_clone.pop() != 1
                    throw error("index error!")
            }
            if pos_clone.length = this.shape.length
                return this.set_single_method(pos_clone*)
            ret := []
            len := pos_clone.length
            loop this.shape.length - len
                pos_clone.push(format("1:{}", this.shape[len + a_index]))
            this.set_single_method(value, pos_clone*)
        }
        
        set_single_method(value, pos*)
        {
            array_range := []
            for i in pos
            {
                if instr(i, ":")
                {
                    pos[a_index] := numahk_base.get_arr_range(i, this.shape[a_index])
                    array_range.push(pos[a_index].length)
                }
            }
            if !array_range.length
            {
                index := numahk_base.get_ndarray_index(this.strides, pos)
                this._data[index] := value
                return
            }
            pos_new := numahk_base.dynamic_loop(pos)
            for i in pos_new
                this.set_single_method(value, i*)
        }
    
        swapaxes(axis1, axis2)
        {
            return numahk_func.swapaxes(this, axis1, axis2)
        }
        
        transpose()
        {
            return numahk_func.transpose(this)
        }
        
        tostring()
        {
            return numahk_base.get_arr_to_string(numahk_base.get_arr_reshape(this._data.clone(), this.shape))
        }
        
        ; operator
        add(ndarray)
        {
            return numahk_operator.add(this, ndarray)
        }
        
        div(ndarray)
        {
            return numahk_operator.divide(this, ndarray)
        }
        
        mul(ndarray)
        {
            return numahk_operator.multiply(this, ndarray)
        }
        
        sub(ndarray)
        {
            return numahk_operator.substract(this, ndarray)
        }
    }
    
    ; create numahk.ndarray
    static arange(args*)
    {
        return numahk.ndarray(numahk_base.range(args*).array(), , 1)
    }
    
    static array(_array, standardization := false, isflat := false)
    {
        return numahk.ndarray(_array, standardization, isflat)
    }
    
    static asarray(_array, standardization := false, isflat := false)
    {
        return numahk.ndarray(_array.clone(), standardization, isflat)
    }
    
    static empty(shape)
    {
        shape := shape is array ? shape : [shape]
        new_array := []
        new_array.length := numahk_base.get_arr_product(shape)
        return numahk.ndarray(new_array, , 1).resize(shape)
    }
    
    static empty_like(ndarray)
    {
        shape := ndarray.shape
        new_array := []
        new_array.length := ndarray._data.length
        return numahk.ndarray(new_array, , 1).resize(shape)
    }
    
    static eye(n, m := 0, k := 0)
    {
        new_array := []
        looptimes := m ? m : n
        loop n
        {
            index := a_index
            loop looptimes
            {
                if index != a_index + k
                    new_array.push(0)
                else
                    new_array.push(1)
            }
        }
        return numahk.ndarray(new_array, , 1).resize(n, looptimes)
    }
    
    static identity(n)
    {
        new_array := []
        loop n
        {
            index := a_index
            loop n
            {
                if index != a_index
                    new_array.push(0)
                else
                    new_array.push(1)
            }
        }
        return numahk.ndarray(new_array, , 1).resize(n, n)
    }
    
    static in1d(ndarray, _array, invert := false)
    {
        new_array := []
        for i in ndarray._data
            new_array.push(abs(numahk_base.is_item_in_arr(i, _array) - invert))
        return numahk.ndarray(new_array, , 1)
    }
    
    static linspace(start, stop, num := 50)
    {
        return numahk.ndarray(numahk_base.range([start, stop, num "j"]*).array(), , 1)
    }
    
    static meshgrid(ndarray1, ndarray2)
    {
        nd1_ndarray := ndarray1.reshape(1, -1)
        nd2_ndarray := ndarray2.reshape(-1, 1)
        zeros_ndarray := numahk.zeros([ndarray2._data.length, ndarray1._data.length])
        new_array := numahk.add(nd1_ndarray, zeros_ndarray)._data
        new_array.push(numahk.add(nd2_ndarray, zeros_ndarray)._data*)
        return numahk.ndarray(new_array, , 1).resize([-1, ndarray2._data.length, ndarray1._data.length])
    }
    
    static nums(number, shape)
    {
        shape := shape is array ? shape : [shape]
        new_array := []
        loop numahk_base.get_arr_product(shape)
            new_array.push(number)
        return numahk.ndarray(new_array, , 1).resize(shape)
    }
    
    static nums_like(number, ndarray)
    {
        shape := ndarray.shape
        new_array := []
        loop ndarray._data.length
            new_array.push(number)
        return numahk.ndarray(new_array, , 1).resize(shape)
    }
    
    static ones(shape)
    {
        shape := shape is array ? shape : [shape]
        new_array := []
        loop numahk_base.get_arr_product(shape)
            new_array.push(1)
        return numahk.ndarray(new_array, , 1).resize(shape)
    }
    
    static ones_like(ndarray)
    {
        shape := ndarray.shape
        new_array := []
        loop ndarray._data.length
            new_array.push(1)
        return numahk.ndarray(new_array, , 1).resize(shape)
    }
    
    static zeros(shape)
    {
        shape := shape is array ? shape : [shape]
        new_array := []
        loop numahk_base.get_arr_product(shape)
            new_array.push(0)
        return numahk.ndarray(new_array, , 1).resize(shape)
    }
    
    static zeros_like(ndarray)
    {
        shape := ndarray.shape
        new_array := []
        loop ndarray._data.length
            new_array.push(0)
        return numahk.ndarray(new_array, , 1).resize(shape)
    }
}

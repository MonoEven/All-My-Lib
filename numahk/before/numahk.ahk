#Include <numahk\c_base\c_array>
#Include <numahk\func_base\to_string>

class numahk
{
    static E := 2.718281828459045
    static PI := 3.141592653589793
    static TAU := 6.283185307179586
    static INF := 2 ** 63 - 1
    
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
        __new(_array, dtype := "int", isflat := false)
        {
            this.dtype := dtype
            this.ndim := c_array.array_ndim(_array)
            this.shape := isflat ? [_array.length] : c_array.array_shape(_array)
            this.data := isflat ? _array : c_array.array_flatten(_array, dtype)
            this.strides := c_array.array_strides(this.shape)
        }
        
        all()
        {
            return numahk.all(this.data)
        }
        
        any()
        {
            return numahk.any(this.data)
        }
        
        argmax(axis := -1)
        {
            return numahk.argmax(this, axis, this.dtype)
        }
        
        argmin(axis := -1)
        {
            return numahk.argmin(this, axis, this.dtype)
        }
        
        argpartition(kth, axis := -1)
        {
            
        }
        
        argsort(axis := -1)
        {
            
        }
        
        astype(dtype := "int")
        {
            
        }
        
        byteswap(inplace := false)
        {
            
        }
        
        choose(choices, mode := "raise")
        {
            
        }
        
        clip(min, max)
        {
            
        }
        
        compress(condition, axis := -1)
        {
            
        }
        
        conj()
        {
            
        }
        
        conjugate()
        {
            
        }
        
        copy()
        {
            return this.clone()
        }
        
        cumprod(axis := -1)
        {
            
        }
        
        cumsum(axis := -1)
        {
            
        }
        
        diagonal(offset := 0, axis1 := 0, axis2 := 1)
        {
            
        }
        
        dump(file)
        {
            
        }
        
        dumps()
        {
            
        }
        
        fill(value)
        {
            c_array.array_fill(this.data, value, &dtype)
            this.dtype := (dtype = 0) ? "int" : "float"
            return this
        }
        
        flatten()
        {
            return numahk.ndarray(this.data.clone(), this.dtype, 1)
        }
        
        getfield(dtype := "int", offset := 0)
        {
            
        }
        
        item(args*)
        {
            
        }
        
        itemset(args*)
        {
            
        }
        
        max(axis := -1)
        {
            return numahk.max(this, axis, this.dtype)
        }
        
        mean(axis := -1)
        {
            
        }
        
        min(axis := -1)
        {
            return numahk.min(this, axis, this.dtype)
        }
        
        nonzero()
        {
            
        }
        
        partition(kth, axis := - 1)
        {
            
        }
        
        prod(axis := -1)
        {
            
        }
        
        ptp(axis := -1)
        {
            
        }
        
        put(indices, values, mode := "raise")
        {
            
        }
        
        ravel()
        {
            return this.data
        }
        
        repeat(repeats, axis := -1)
        {
            
        }
        
        reshape(shape*)
        {
            if shape.length = 1 && shape[1] is array
                shape := shape[1]
            tmp := this.clone()
            tmp.data := c_array.array_reshape(tmp.data, this.shape, this.strides, this.dtype)
            for i in shape
            {
                if i = -1
                    shape[a_index] := tmp.data.length // abs(c_array.array_product(shape))
            }
            tmp.shape := shape
            tmp.strides := c_array.array_strides(shape)
            return tmp
        }
        
        resize(shape*)
        {
            if this.shape.length != 1
                throw error("resize only works on single-segment arrays", -1)
            if shape.length = 1 && shape[1] is array
                shape := shape[1]
            for i in shape
            {
                if i = -1
                    shape[a_index] := this.data.length // abs(c_array.array_product(shape))
            }
            this.shape := shape
            this.strides := c_array.array_strides(shape)
            return this
        }
        
        round()
        {
            
        }
        
        searchsorted(v, side := "left")
        {
            
        }
        
        setfield(val, dtype, offset := 0)
        {
            
        }
        
        sort(axis := -1)
        {
            
        }
        
        squeeze(axis := -1)
        {
            
        }
        
        std(axis := -1)
        {
            
        }
        
        sum(axis := -1)
        {
            
        }
        
        swapaxes(axis1, axis2)
        {
            tmp := this.clone()
            c_array.array_swap(tmp.shape, axis1, axis2)
            c_array.array_swap(tmp.strides, axis1, axis2)
            return tmp
        }
        
        take(indices, axis := -1, mode := "raise")
        {
            
        }
        
        tolist()
        {
            
        }
        
        tostring()
        {
            tmp := this.reshape(this.shape)
            ret := array_to_string(tmp.data, tmp.shape)
            ret .= "`ndtype: " this.dtype
            return ret
        }
        
        trace(offset := 0, axis1 := 0, axis2 := 1)
        {
            
        }
        
        transpose(axes*)
        {
            if axes.length = 1 && axes[1] is array
                axes := axes[1]
            tmp := this.clone()
            tmp.shape := c_array.array_idx2value(tmp.shape, axes)
            tmp.strides := c_array.array_idx2value(tmp.strides, axes)
            return tmp
        }
        
        var(axis := -1)
        {
            
        }
    }
    
    static all(_array)
    {
        if hasmethod(_array, "all")
            return _array.all()
        return !c_array.array_empty(_array)
    }
    
    static any(_array)
    {
        if hasmethod(_array, "any")
            return _array.any()
        return c_array.array_contain(_array)
    }
    
    static argmax(_array, axis := -1, dtype := "int")
    {
        if axis = -1
            return c_array.array_maxmethod(_array.data, axis, _array.shape,  _array.strides, dtype)[2]
        new_shape := _array.shape.clone()
        new_shape.removeat(axis)
        return numahk.ndarray(c_array.array_maxmethod(_array.data, axis, _array.shape, _array.strides, dtype)[2], , 1).resize(new_shape)
    }
    
    static argmin(_array, axis := -1, dtype := "int")
    {
        if axis = -1
            return c_array.array_minmethod(_array.data, axis, _array.shape,  _array.strides, dtype)[2]
        new_shape := _array.shape.clone()
        new_shape.removeat(axis)
        return numahk.ndarray(c_array.array_maxmethod(_array.data, axis, _array.shape,  _array.strides, dtype)[2], , 1).resize(new_shape)
    }
    
    static arange(start, stop := "", step := 1)
    {
        ret := c_array.array_range(start, stop, step)
        return numahk.ndarray(ret[1], dtype := (ret[2] = 0) ? "int" : "float", 1)
    }
    
    static argpartition(_array, kth, axis := -1)
    {
        
    }
    
    static array(_array, dtype := "int", isflat := false)
    {
        return numahk.ndarray(_array, dtype, isflat)
    }
    
    static asarray(_array, dtype := "int", isflat := false)
    {
        return numahk.ndarray(_array.clone(), dtype, isflat)
    }
    
    static frommat(mat)
    {
        if !isset(cv2)
            throw error("please include cv2 library.", -1)
        shape := [mat.height, mat.width, mat.channels]
        return numahk.ndarray(c_array.array_copyfromptr(mat.data, mat.total * mat.channels, mat.depth)).resize(shape)
    }
    
    static empty(shape)
    {
        shape := shape is array ? shape : [shape]
        new_array := []
        new_array.length := c_array.array_product(shape)
        return numahk.ndarray(new_array, , 1).resize(shape)
    }
    
    static empty_like(ndarray)
    {
        shape := ndarray.shape
        new_array := []
        new_array.length := ndarray.data.length
        return numahk.ndarray(new_array, , 1).resize(shape)
    }
    
    static linspace(start, stop, num := 50)
    {
        return numahk.arange((start, stop, num "j"), , 1)
    }
    
    static max(_array, axis := -1, dtype := "int")
    {
        if axis = -1
            return c_array.array_maxmethod(_array.data, axis, _array.shape,  _array.strides, dtype)[1]
        new_shape := _array.shape.clone()
        new_shape.removeat(axis)
        return numahk.ndarray(c_array.array_maxmethod(_array.data, axis, _array.shape,  _array.strides, dtype)[1], , 1).resize(new_shape)
    }
    
    static min(_array, axis := -1, dtype := "int")
    {
        if axis = -1
            return c_array.array_minmethod(_array.data, axis, _array.shape,  _array.strides, dtype)[1]
        new_shape := _array.shape.clone()
        new_shape.removeat(axis)
        return numahk.ndarray(c_array.array_maxmethod(_array.data, axis, _array.shape,  _array.strides, dtype)[1], , 1).resize(new_shape)
    }
    
    static nums(number, shape)
    {
        shape := shape is array ? shape : [shape]
        new_array := c_array.array_fill(c_array.array_product(shape), number)
        return numahk.ndarray(new_array, dtype := (dtype = 0) ? "int" : "float", 1).resize(shape)
    }
    
    static nums_like(number, ndarray)
    {
        shape := ndarray.shape
        new_array := c_array.array_fill(ndarray.data.length, number, &dtype)
        return numahk.ndarray(new_array, dtype := (dtype = 0) ? "int" : "float", 1).resize(shape)
    }
    
    static ones(shape)
    {
        return numahk.nums(1, shape)
    }
    
    static ones_like(ndarray)
    {
        return numahk.nums_like(1, ndarray)
    }
    
    static zeros(shape)
    {
        return numahk.nums(0, shape)
    }
    
    static zeros_like(ndarray)
    {
        return numahk.nums_like(0, ndarray)
    }
}

#Include <numahk\base\c_array>
#Include <numahk\base\Generator>
#Include <numahk\base\Parser>

numahk_path := file_path("numahk\dll\Numahk.dll")
if !numahk_path
    throw error("load Numahk.dll error!", -1)
else
    dllcall("LoadLibrary", "str", numahk_path)
numahk_path := file_path("numahk\dll\Numahk.dll")

file_path(filename)
{
    if fileexist(format("{}\lib\{}", regread("HKLM\SOFTWARE\AutoHotkey", "InstallDir", ""), filename))
        return format("{}\lib\{}", regread("HKLM\SOFTWARE\AutoHotkey", "InstallDir", ""), filename)
    else if fileexist(format("{}\lib\{}", A_ScriptDir, filename))
        return format("{}\lib\{}", A_ScriptDir, filename)
    else
        return false
}

AHK_FLAG := 1
DIMS_INTERVAL := ","
FREE_FLAG := 1
IN_DIMS_INTERVAL := ","
NUMAHK_DEFPROP := {}.defineprop
NUMAHK_DELPROP := {}.deleteprop
MAX_NDARRAY_PRINT := 20000
NUMAHK_DEFPROP(numahk.ndarray([]).base, "T", {get: NUMAHK_T})
NUMAHK_DEFPROP(numahk.ndarray([]).base, "flat", {get: NUMAHK_FLATGET, set: (this, value) => NUMAHK_FLATSET(this, value)})

NUMAHK_T(this)
{
    Return numahk.transpose(this)
}

NUMAHK_FLATGET(this)
{
    flat_arr := []
    shape := this.shape.clone()
    loop shape.length
        shape[a_index] := AHK_FLAG
    loop this.size
    {
        flat_arr.push(this[shape*])
        shape[-1] += 1
    }
    return flat_arr
}

NUMAHK_FLATSET(this, value)
{
    dtype := this.dtype
    dtype := numahk.%dtype%
    if !(value is array)
        value := [value]
    value := c_array.array_flatten(value, dtype)
    dllcall("Numahk\NUMAHK_FLAT", "ptr", this.data, "ptr", numget(objptr(value), 0x20, "ptr"), "int", value.length, "int", this.size, "int", dtype)
}

class numahk extends numahk_const
{
    static cv2_map := map("int8", "CV_8SC", "uint8", "CV_8UC", "int16", "CV_16SC", "uint16", "CV_16UC", "int32", "CV_32SC", "uint32", "CV_32UC", "float32", "CV_32FC", "float64", "CV_64FC")
    
    static type_dict := map("int8", 1, "uint8", 1, "int16", 2, "uint16", 2, "int32", 4, "uint32", 4, "int64", 8, "uint64", 8, "float32", 4, "float64", 8, "bool_", 1)
    
    class ndarray
    {
        __new(_array, dtype := numahk.float64, isflat := false, is_c := false, length_c := 0)
        {
            if !is_c
            {
                if (_array is integer) || (_array is float)
                    _array := [_array]
                if _array.length = 0
                {
                    this.data := 0
                    this.dtype := dtype is string ? strlower(dtype) : numahk.dtype(dtype)
                    this.ndim := 0
                    this.shape := []
                    this.size := 0
                    this.itemsize := numahk.type_dict[this.dtype]
                    this.nbytes := 0
                    this.strides := []
                    this.pos_strides := []
                }
                else
                {
                    this.data := c_array.to_c_array(_array, dtype)
                    this.dtype := dtype is string ? strlower(dtype) : numahk.dtype(dtype)
                    this.ndim := c_array.array_ndim(_array)
                    this.shape := isflat ? [_array.length] : c_array.array_shape(_array)
                    this.size := c_array.array_product(this.shape)
                    this.itemsize := numahk.type_dict[this.dtype]
                    this.nbytes := this.size * numahk.type_dict[this.dtype]
                    this.strides := c_array.array_strides(this.shape, this.dtype)
                    this.pos_strides := c_array.array_strides(this.shape, 1)
                }
            }
            else
            {
                this.dtype := dtype is string ? strlower(dtype) : numahk.dtype(dtype)
                this.ndim := 1
                this.data := _array
                this.shape := [length_c]
                this.size := length_c
                this.itemsize := numahk.type_dict[this.dtype]
                this.nbytes := this.size * numahk.type_dict[this.dtype]
                this.strides := c_array.array_strides(this.shape, this.dtype)
                this.pos_strides := c_array.array_strides(this.shape, 1)
            }
        }
        
        __item[pos*]
        {
            get => this.get_single_element(pos*)
            set => this.set_single_element(value, pos*)
        }
        
        get_single_element(pos*)
        {
            if pos.length = 1 && pos[1] is array
                tmp := pos[1]
            else
                tmp := pos.clone()
            tmp2 := this.pos_strides.clone()
            dtype := this.dtype
            dtype := numahk.%dtype%
            ret_ptr := dllcall("Numahk\NDArray_Get", "ptr", this.data, "ptr", numget(objptr(tmp), 0x20, "ptr"), "ptr", numget(objptr(tmp2), 0x20, "ptr"), "int", tmp.length, "int", dtype, "int", AHK_FLAG)
            return numget(ret_ptr, 0, numahk.ahktype(dtype))
        }
        
        set_single_element(value, pos*)
        {
            if pos.length = 1 && pos[1] is array
                tmp := pos[1]
            else
                tmp := pos.clone()
            tmp2 := this.pos_strides.clone()
            tmp3 := [value]
            dtype := this.dtype
            dtype := numahk.%dtype%
            dllcall("Numahk\NDArray_Set", "ptr", this.data, "ptr", numget(objptr(tmp), 0x20, "ptr"), "ptr", numget(objptr(tmp2), 0x20, "ptr"), "ptr", numget(objptr(tmp3), 0x20, "ptr"), "int", tmp.length, "int", dtype, "int", AHK_FLAG)
        }
        
        __delete()
        {
            dtype := this.dtype
            dtype := numahk.%dtype%
            if FREE_FLAG && this.data != 0
                dllcall("Numahk\NDArray_Free", "ptr", this.data, "int", dtype)
        }
        
        add(ndarray)
        {
            return numahk.add(this, ndarray)
        }
        
        all(axis := "")
        {
            return numahk.all(this, axis)
        }
        
        any(axis := "")
        {
            return numahk.any(this, axis)
        }
        
        argmax(axis := "")
        {
            return numahk.argmax(this, axis)
        }
        
        argmin(axis := "")
        {
            return numahk.argmin(this, axis)
        }
        
        argpartition(kth, axis := -1)
        {
            return numahk.argpartition(this, kth, axis)
        }
        
        astype(dtype)
        {
            return numahk.astype(this, dtype)
        }
        
        choose(choices)
        {
            return numahk.choose(this, choices)
        }
        
        clone()
        {
            dtype := this.dtype
            dtype := numahk.%dtype%
            new_data := dllcall("Numahk\NDArray_Copy", "ptr", this.data, "int", this.size, "int", dtype, "int", numahk.type_dict[this.dtype])
            new_ndarray := numahk.ndarray(new_data, dtype, , true, this.size).resize(this.shape)
            new_ndarray.strides := this.strides
            new_ndarray.pos_strides := this.pos_strides
            return new_ndarray
        }
        
        clip(ndarray_min, ndarray_max)
        {
            return numahk.clip(this, ndarray_min, ndarray_max)
        }
        
        compress(condition, axis := "")
        {
            return numahk.compress(condition, this, axis)
        }
        
        copy()
        {
            return this.clone()
        }
        
        cumprod(axis := "")
        {
            return numahk.cumprod(this, axis)
        }
        
        cumsum(axis := "")
        {
            return numahk.cumsum(this, axis)
        }
        
        diag(offset := 0)
        {
            return numahk.diag(this, offset)
        }
        
        diagonal(offset := 0, axis1 := AHK_FLAG, axis2 := AHK_FLAG + 1)
        {
            return numahk.diagonal(this, offset, axis1, axis2)
        }
        
        div(ndarray)
        {
            return numahk.divide(this, ndarray)
        }
        
        dot(ndarray)
        {
            return numahk.dot(this, ndarray)
        }
        
        dump(filename)
        {
            numahk.dump(this, filename)
        }
        
        fill(value)
        {
            return numahk.fill(this, value)
        }
        
        flatten()
        {
            return this.flat
        }
        
        max(axis := "")
        {
            return numahk.max(this, axis)
        }
        
        mean(axis := "")
        {
            return numahk.mean(this, axis)
        }
        
        min(axis := "")
        {
            return numahk.min(this, axis)
        }
        
        mul(ndarray)
        {
            return numahk.multiply(this, ndarray)
        }
        
        partition(kth, axis := -1)
        {
            return numahk.partition(this, kth, axis)
        }
        
        prod(axis := "")
        {
            return numahk.prod(this, axis)
        }
        
        ptp(axis := "")
        {
            return numahk.ptp(this, axis)
        }
        
        put(index, value)
        {
            return numahk.put(this, index, value)
        }
        
        ravel()
        {
            return numahk.ravel(this)
        }
        
        reshape(shape*)
        {
           return numahk.reshape(this, shape*)
        }
        
        resize(shape*)
        {
           return numahk.reshape(this, shape*)
        }
        
        squeeze(axis := "")
        {
            return numahk.squeeze(this, axis)
        }
        
        std(axis := "")
        {
            return numahk.std(this, axis)
        }
        
        sub(ndarray)
        {
            return numahk.subtract(this, ndarray)
        }
        
        sum(axis := "")
        {
            return numahk.sum(this, axis)
        }
        
        swapaxes(axis1, axis2)
        {
            return numahk.swapaxes(this, axis1, axis2)
        }
        
        tolist()
        {
            if fileexist("NUMAHK_NDArray_Print.tmp")
                filedelete("NUMAHK_NDArray_Print.tmp")
            fileappend("", "NUMAHK_NDArray_Print.tmp")
            dtype := this.dtype
            dtype := numahk.%dtype%
            dllcall("Numahk\NDArray_Print", "ptr", this.data, "ptr", numget(objptr(this.shape), 0x20, "ptr"), "int", this.ndim, "int", this.pos_strides[-1], "int", this.size, "int", dtype, "astr", ",", "astr", ",")
            return Json_Parser("NUMAHK_NDArray_Print.tmp")
        }
        
        tojson()
        {
            _json := {shape: this.shape, strides: this.strides, pos_strides: this.pos_strides, size: this.size, nbytes: this.nbytes, dtype: this.dtype, itemsize: this.itemsize, ndim: this.ndim}
            return Json_Generator(_json)
        }
        
        tomat()
        {
            if this.shape.length > 3
                return
            if isset(cv2) && isset(memcpy)
            {
                height := this.shape[1]
                width := this.shape[2]
                depth := this.shape.length = 3 ? this.shape[3] : 1
                bits := numahk.type_dict[this.dtype]
                bytes := height * width * depth * bits
                mat := cv2.mat.zeros(height, width, cv2.%numahk.cv2_map[this.dtype] depth%)
                memcpy(mat.data, this.data, bytes)
                return mat
            }
        }
        
        tostring()
        {
            if this.data = 0
                return "`ntype: numahk.ndarray`n[]`ndtype: " this.dtype
            if this.size > MAX_NDARRAY_PRINT
            {
                if isset(debug)
                    debug "Warning: ndarray size is too large, we can only print the total message about it."
                return format("`ntype: numahk.ndarray`ndata: {}`ndtype: {}`nndim: {}`nshape: {}`nsize: {}`nitemsize: {}`nnbytes: {}`nstrides: {}", this.data, this.dtype, this.ndim, numahk.arr_to_string(this.shape), this.size, this.itemsize, this.nbytes, numahk.arr_to_string(this.strides))
            }
            if fileexist("NUMAHK_NDArray_Print.tmp")
                filedelete("NUMAHK_NDArray_Print.tmp")
            fileappend("", "NUMAHK_NDArray_Print.tmp")
            dtype := this.dtype
            dtype := numahk.%dtype%
            dllcall("Numahk\NDArray_Print", "ptr", this.data, "ptr", numget(objptr(this.shape), 0x20, "ptr"), "int", this.ndim, "int", this.pos_strides[-1], "int", this.size, "int", dtype, "astr", DIMS_INTERVAL, "astr", IN_DIMS_INTERVAL)
            return "`ntype: numahk.ndarray`n" fileread("NUMAHK_NDArray_Print.tmp") "`ndtype: " this.dtype
        }
        
        transpose(axes := "")
        {
            return numahk.transpose(this, axes)
        }
        
        var(axis := "")
        {
            return numahk.var(this, axis)
        }
    }
    
    class random
    {
        static choice(ndarray, shape*)
        {
            if shape.length = 1 && shape[1] is array
                shape := shape[1]
            if !(ndarray is numahk.ndarray)
                ndarray := numahk.ndarray(ndarray)
            if ndarray.ndim != 1
                throw error("ValueError: a must be 1-dimensional", -1)
            dtype := ndarray.dtype
            dtype := numahk.%dtype%
            if shape.length = 0
                return numget(dllcall("Numahk\Random_Choice", "ptr", ndarray.data, "int", ndarray.size, "int", 1, "int", dtype), 0, numahk.ahktype(dtype))
            new_size := c_array.array_product(shape)
            new_data := dllcall("Numahk\Random_Choice", "ptr", ndarray.data, "int", ndarray.size, "int", new_size, "int", dtype)
            return numahk.ndarray(new_data, dtype, , true, new_size).resize(shape)
        }
        
        static normal(loc := 0.0, scale := 1.0, shape*)
        {
            if shape.length = 1 && shape[1] is array
                shape := shape[1]
            if shape.length = 0
                return numget(dllcall("Numahk\Random_Normal", "double", loc, "double", scale, "int", 1), 0, "double")
            new_size := c_array.array_product(shape)
            new_data := dllcall("Numahk\Random_Normal", "double", loc, "double", scale, "int", new_size)
            return numahk.ndarray(new_data, numahk.float64, , true, new_size).resize(shape)
        }
        
        static rand(shape*)
        {
            if shape.length = 1 && shape[1] is array
                shape := shape[1]
            if shape.length = 0
                return numget(dllcall("Numahk\Random_Rand", "int", 1), 0, "double")
            new_size := c_array.array_product(shape)
            new_data := dllcall("Numahk\Random_Rand", "int", new_size)
            return numahk.ndarray(new_data, numahk.float64, , true, new_size).resize(shape)
        }
        
        static randint(start, end, shape*)
        {
            end := end - (1 - AHK_FLAG)
            if shape.length = 1 && shape[1] is array
                shape := shape[1]
            if shape.length = 0
                return numget(dllcall("Numahk\Random_Randint", "int", start, "int", end, "int", 1), 0, "int")
            new_size := c_array.array_product(shape)
            new_data := dllcall("Numahk\Random_Randint", "int", start, "int", end, "int", new_size)
            return numahk.ndarray(new_data, numahk.int32, , true, new_size).resize(shape)
        }
        
        static randn(shape*)
        {
            if shape.length = 1 && shape[1] is array
                shape := shape[1]
            if shape.length = 0
                return numget(dllcall("Numahk\Random_Randn", "int", 1), 0, "double")
            new_size := c_array.array_product(shape)
            new_data := dllcall("Numahk\Random_Randn", "int", new_size)
            return numahk.ndarray(new_data, numahk.float64, , true, new_size).resize(shape)
        }
        
        static seed(seed)
        {
            dllcall("Numahk\Random_Seed", "double", seed)
        }
    }
    
    static add(ndarray1, ndarray2)
    {
        if (ndarray1 is number) && (ndarray2 is number)
            return ndarray1 + ndarray2
        if ndarray1 is number
        {
            if !(ndarray2 is numahk.ndarray)
                ndarray2 := numahk.ndarray(ndarray2)
            ndarray1_dtype := ndarray1 is float ? numahk.float64 : numahk.int32
            ndarray1 := numahk.ndarray(ndarray1, ndarray1_dtype)
            ndarray1_shape := ndarray1.shape.clone()
            loop ndarray2.ndim - 1
                ndarray1_shape.insertat(1, 1)
            strides := c_array.array_strides(ndarray1_shape, 1)
            ndarray1_data := dllcall("Numahk\NUMAHK_BROADCAST", "ptr", ndarray1.data, "ptr", numget(objptr(ndarray1_shape), 0x20, "ptr"), "ptr", numget(objptr(ndarray2.shape), 0x20, "ptr"), "ptr", numget(objptr(strides), 0x20, "ptr"), "int", ndarray2.ndim, "int", ndarray1_dtype, "int", 0)
            ndarray2_data := ndarray2.data
            ndarray2_dtype := ndarray2.dtype
            ndarray2_dtype := numahk.%ndarray2_dtype%
            length := ndarray2.size
            shape := ndarray2.shape
        }
        else if ndarray2 is number
        {
            if !(ndarray1 is numahk.ndarray)
                ndarray1 := numahk.ndarray(ndarray1)
            ndarray2_dtype := ndarray2 is float ? numahk.float64 : numahk.int32
            ndarray2 := numahk.ndarray(ndarray2, ndarray2_dtype)
            ndarray2_shape := ndarray2.shape.clone()
            loop ndarray1.ndim - 1
                ndarray2_shape.insertat(1, 1)
            strides := c_array.array_strides(ndarray2_shape, 1)
            ndarray2_data := dllcall("Numahk\NUMAHK_BROADCAST", "ptr", ndarray2.data, "ptr", numget(objptr(ndarray2_shape), 0x20, "ptr"), "ptr", numget(objptr(ndarray1.shape), 0x20, "ptr"), "ptr", numget(objptr(strides), 0x20, "ptr"), "int", ndarray1.ndim, "int", ndarray2_dtype, "int", 0)
            ndarray1_data := ndarray1.data
            ndarray1_dtype := ndarray1.dtype
            ndarray1_dtype := numahk.%ndarray1_dtype%
            length := ndarray1.size
            shape := ndarray1.shape
        }
        else
        {
            if !(ndarray1 is numahk.ndarray)
                ndarray1 := numahk.ndarray(ndarray1)
            if !(ndarray2 is numahk.ndarray)
                ndarray2 := numahk.ndarray(ndarray2)
            ndarray1 := ndarray1.copy()
            ndarray2 := ndarray2.copy()
            numahk.broadcast(ndarray1, ndarray2)
            ndarray1_data := ndarray1.data
            ndarray1_dtype := ndarray1.dtype
            ndarray1_dtype := numahk.%ndarray1_dtype%
            ndarray2_data := ndarray2.data
            ndarray2_dtype := ndarray2.dtype
            ndarray2_dtype := numahk.%ndarray2_dtype%
            length := ndarray1.size
            shape := ndarray2.shape
        }
        new_dtype := numahk.dtype_dev(ndarray1_dtype, ndarray2_dtype)
        new_data := dllcall("Numahk\NDArray_Add", "ptr", ndarray1_data, "ptr", ndarray2_data, "int", ndarray1_dtype, "int", ndarray2_dtype, "int", length, "int", new_dtype)
        return numahk.ndarray(new_data, new_dtype, , true, length).resize(shape)
    }
    
    static any(ndarray, axis := "")
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if axis = ""
        {
            dtype := ndarray.dtype
            dtype := numahk.%dtype%
            shape := ndarray.shape.clone()
            new_data := dllcall("Numahk\NDArray_Any_", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", dtype)
            return numget(new_data, 0, "char")
        }
        axis := numahk.axis_dev(ndarray.ndim, axis)
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        shape := ndarray.shape.clone()
        new_data := dllcall("Numahk\NDArray_Any", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ndarray.pos_strides[axis + 1], "int", axis, "int", dtype)
        shape.removeat(axis + 1)
        length_c := c_array.array_product(shape)
        return numahk.ndarray(new_data, numahk.bool_, , true, length_c).resize(shape)
    }
    
    static all(ndarray, axis := "")
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if axis = ""
        {
            dtype := ndarray.dtype
            dtype := numahk.%dtype%
            shape := ndarray.shape.clone()
            new_data := dllcall("Numahk\NDArray_All_", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", dtype)
            return numget(new_data, 0, "char")
        }
        axis := numahk.axis_dev(ndarray.ndim, axis)
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        shape := ndarray.shape.clone()
        new_data := dllcall("Numahk\NDArray_All", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ndarray.pos_strides[axis + 1], "int", axis, "int", dtype)
        shape.removeat(axis + 1)
        length_c := c_array.array_product(shape)
        return numahk.ndarray(new_data, numahk.bool_, , true, length_c).resize(shape)
    }
    
    static arange(start := "", stop := "", step := "", dtype := numahk.float64)
    {
        if start = ""
            throw error("TypeError: arange() requires stop to be specified.")
        else if stop = ""
        {
            start := AHK_FLAG
            stop := start
            step := 1
        }
        else if step = ""
            step := 1
        data := dllcall("Numahk\NUMAHK_RANGE", "double", start, "double", stop, "double", step, "int", dtype)
        length_c := floor((stop - start) / step)
        return numahk.ndarray(data, dtype, , true, length_c)
    }
    
    static argmax(ndarray, axis := "")
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if axis = ""
        {
            dtype := ndarray.dtype
            dtype := numahk.%dtype%
            shape := ndarray.shape.clone()
            new_data := dllcall("Numahk\NDArray_Argmax_", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", dtype, "int", AHK_FLAG)
            return numget(new_data, 0, "int64")
        }
        axis := numahk.axis_dev(ndarray.ndim, axis)
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        shape := ndarray.shape.clone()
        new_data := dllcall("Numahk\NDArray_Argmax", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ndarray.pos_strides[axis + 1], "int", axis, "int", dtype, "int", AHK_FLAG)
        shape.removeat(axis + 1)
        length_c := c_array.array_product(shape)
        return numahk.ndarray(new_data, numahk.int64, , true, length_c).resize(shape)
    }
    
    static argmin(ndarray, axis := "")
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if axis = ""
        {
            dtype := ndarray.dtype
            dtype := numahk.%dtype%
            shape := ndarray.shape.clone()
            new_data := dllcall("Numahk\NDArray_Argmin_", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", dtype, "int", AHK_FLAG)
            return numget(new_data, 0, "int64")
        }
        axis := numahk.axis_dev(ndarray.ndim, axis)
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        shape := ndarray.shape.clone()
        new_data := dllcall("Numahk\NDArray_Argmin", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ndarray.pos_strides[axis + 1], "int", axis, "int", dtype, "int", AHK_FLAG)
        shape.removeat(axis + 1)
        length_c := c_array.array_product(shape)
        return numahk.ndarray(new_data, numahk.int64, , true, length_c).resize(shape)
    }
    
    static argpartition(ndarray, kth, axis := -1)
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if ndarray.ndim = 1
        {
            ndarray := ndarray.T
            axis := -1
        }
        kth := numahk.axis_dev(ndarray.ndim, kth, true)
        axis := numahk.axis_dev(ndarray.ndim, axis)
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        shape := ndarray.shape.clone()
        if kth >= shape[axis + 1]
            throw error(format("ValueError: kth(={}) out of bounds ({})", kth + AHK_FLAG, shape[axis]))
        new_data := dllcall("Numahk\NDArray_Argpartition", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ndarray.pos_strides[axis + 1], "int", kth, "int", axis, "int", dtype)
        return numahk.ndarray(new_data, numahk.int64, , true, ndarray.size).resize(shape)
    }
    
    static argsort(ndarray, axis := -1)
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if ndarray.ndim = 1
        {
            ndarray := ndarray.T
            axis := -1
        }
        axis := numahk.axis_dev(ndarray.ndim, axis)
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        shape := ndarray.shape.clone()
        kth := shape[axis + 1] - 1
        new_data := dllcall("Numahk\NDArray_Argpartition", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ndarray.pos_strides[axis + 1], "int", kth, "int", axis, "int", dtype)
        return numahk.ndarray(new_data, numahk.int64, , true, ndarray.size).resize(shape)
    }
    
    static array(_array, dtype := numahk.float64, isflat := false, is_c := false, length_c := 0)
    {
        return numahk.ndarray(_array, dtype, isflat, is_c, length_c)
    }
    
    static astype(ndarray, dtype)
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        old_dtype := ndarray.dtype
        old_dtype := numahk.%old_dtype%
        new_data := dllcall("Numahk\NDArray_Change", "ptr", ndarray.data, "int", ndarray.size, "int", old_dtype, "int", dtype)
        new_ndarray := numahk.ndarray(new_data, dtype, , true, ndarray.size).resize(ndarray.shape)
        new_ndarray.strides := ndarray.strides
        new_ndarray.pos_strides := ndarray.pos_strides
        return new_ndarray
    }
    
    static axis_dev(ndim, axis, pass := false)
    {
        if axis < 0
            new_axis := ndim - abs(axis)
        else
            new_axis := axis - AHK_FLAG
        if (new_axis > ndim - AHK_FLAG) && !pass
            throw error(format("numahk.AxisError: axis {} is out of bounds for array of dimension {}", axis, ndim))
        return new_axis
    }
    
    static broadcast(ndarray1, ndarray2)
    {
        new_shape := (ndarray1.ndim > ndarray2.ndim) ? ndarray1.shape.clone() : ndarray2.shape.clone()
        flag := dllcall("Numahk\NUMAHK_NEWSHAPE", "ptr", numget(objptr(ndarray1.shape), 0x20, "ptr"), "ptr", numget(objptr(ndarray2.shape), 0x20, "ptr"), "ptr", numget(objptr(new_shape), 0x20, "ptr"), "int", ndarray1.ndim, "int", ndarray2.ndim)
        if !flag
            throw error(format("ValueError: shape mismatch: objects cannot be broadcast to a single shape.`nMismatch is between ndarray1 with shape {} and ndarray2 with shape {}.", numahk.arr_to_string(ndarray1.shape), numahk.arr_to_string(ndarray2.shape)))
        ndarray1_shape := ndarray1.shape.clone()
        ndarray2_shape := ndarray2.shape.clone()
        loop new_shape.length - ndarray1.ndim
            ndarray1_shape.insertat(1, 1)
        loop new_shape.length - ndarray2.ndim
            ndarray2_shape.insertat(1, 1)
        strides := c_array.array_strides(ndarray1_shape, 1)
        dtype := ndarray1.dtype
        dtype := numahk.%dtype%
        ndarray1.data := dllcall("Numahk\NUMAHK_BROADCAST", "ptr", ndarray1.data, "ptr", numget(objptr(ndarray1_shape), 0x20, "ptr"), "ptr", numget(objptr(new_shape), 0x20, "ptr"), "ptr", numget(objptr(strides), 0x20, "ptr"), "int", new_shape.length, "int", dtype, "int", 1)
        ndarray1.ndim := new_shape.length
        ndarray1.shape := new_shape.clone()
        ndarray1.size := c_array.array_product(ndarray1.shape)
        ndarray1.itemsize := numahk.type_dict[ndarray1.dtype]
        ndarray1.nbytes := ndarray1.size * numahk.type_dict[ndarray1.dtype]
        ndarray1.strides := c_array.array_strides(ndarray1.shape, ndarray1.dtype)
        ndarray1.pos_strides := c_array.array_strides(ndarray1.shape, 1)
        strides := c_array.array_strides(ndarray2_shape, 1)
        dtype := ndarray2.dtype
        dtype := numahk.%dtype%
        ndarray2.data := dllcall("Numahk\NUMAHK_BROADCAST", "ptr", ndarray2.data, "ptr", numget(objptr(ndarray2_shape), 0x20, "ptr"), "ptr", numget(objptr(new_shape), 0x20, "ptr"), "ptr", numget(objptr(strides), 0x20, "ptr"), "int", new_shape.length, "int", dtype, "int", 1)
        ndarray2.ndim := new_shape.length
        ndarray2.shape := new_shape.clone()
        ndarray2.size := c_array.array_product(ndarray2.shape)
        ndarray2.itemsize := numahk.type_dict[ndarray2.dtype]
        ndarray2.nbytes := ndarray1.size * numahk.type_dict[ndarray2.dtype]
        ndarray2.strides := c_array.array_strides(ndarray2.shape, ndarray2.dtype)
        ndarray2.pos_strides := c_array.array_strides(ndarray2.shape, 1)
    }
    
    static choose(ndarray, choices)
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if !(choices is array)
            throw error(format("TypeError: object of type '{}' has no length", type(choices)))
        if (ndarray.dtype = "float32") || (ndarray.dtype = "float64")
            throw error(format("TypeError: Cannot cast array data from dtype('{}') to dtype('int64') according to the rule 'safe'", ndarray.dtype))
        if (ndarray.max() - AHK_FLAG >= choices.length) || (ndarray.min() - AHK_FLAG < 0)
            throw error("ValueError: invalid entry in choice array")
        for i in choices
        {
            new_shape := ndarray.shape
            if !(i is numahk.ndarray)
                i := numahk.array(i, numahk.int64)
            n_i := i.astype(numahk.int64)
            i_shape := n_i.shape.clone()
            loop new_shape.length - i.ndim
                i_shape.insertat(1, 1)
            strides := c_array.array_strides(i_shape, 1)
            dtype := n_i.dtype
            dtype := numahk.%dtype%
            choices[a_index] := dllcall("Numahk\NUMAHK_BROADCAST", "ptr", n_i.data, "ptr", numget(objptr(i_shape), 0x20, "ptr"), "ptr", numget(objptr(new_shape), 0x20, "ptr"), "ptr", numget(objptr(strides), 0x20, "ptr"), "int", new_shape.length, "int", dtype, "int", 0)
        }
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        new_data := dllcall("Numahk\NDArray_Choose", "ptr", ndarray.data, "ptr", numget(objptr(choices), 0x20, "ptr"), "int", ndarray.size, "int", dtype, "int", AHK_FLAG)
        return numahk.ndarray(new_data, numahk.int32, , true, ndarray.size).resize(ndarray.shape)
    }
    
    static clip(ndarray, ndarray_min, ndarray_max)
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        ndarray_min := (ndarray_min > ndarray_max) ? ndarray_max : ndarray_min
        new_data := dllcall("Numahk\NDArray_Clip", "ptr", ndarray.data, "double", ndarray_min, "double", ndarray_max, "int", ndarray.size, "int", dtype)
        return numahk.ndarray(new_data, dtype, , true, ndarray.size).resize(ndarray.shape)
    }
    
    static compress(condition, ndarray, axis := "")
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        condition := condition.clone()
        if !(condition is array) || c_array.array_ndim(condition) > 1
            throw error("ValueError: condition must be a 1-d array")
        if axis = ""
        {
            new_array := []
            new_size := 0
            for i in condition
            {
                if i != 0
                {
                    new_array.push(ndarray.flat[a_index])
                    new_size++
                }
            }
            return numahk.ndarray(new_array, ndarray.dtype)
        }
        axis := numahk.axis_dev(ndarray.ndim, axis)
        c_length := condition.length
        loop c_length - ndarray.shape[axis + 1]
            condition.pop()
        loop ndarray.shape[axis + 1] - c_length
            condition.push(0)
        flag := 0
        for i in condition
        {
            if i != 0
                flag++
        }
        axis_shape := ndarray.shape.clone()
        for i in axis_shape
        {
            if a_index != axis + 1
                axis_shape[a_index] := 1
        }
        strides := c_array.array_strides(axis_shape, 1)
        condition := numahk.ndarray(condition, numahk.bool_).resize(axis_shape)
        new_data := dllcall("Numahk\NUMAHK_BROADCAST", "ptr", condition.data, "ptr", numget(objptr(axis_shape), 0x20, "ptr"), "ptr", numget(objptr(ndarray.shape), 0x20, "ptr"), "ptr", numget(objptr(strides), 0x20, "ptr"), "int", ndarray.ndim, "int", numahk.bool_, "int", 0)
        new_shape := ndarray.shape.clone()
        new_shape[axis + 1] := flag
        length_c := c_array.array_product(new_shape)
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        new_data := dllcall("Numahk\NDArray_Compress", "ptr", ndarray.data, "ptr", new_data, "int", length_c, "int", ndarray.size, "int", dtype)
        return numahk.ndarray(new_data, dtype, , true, length_c).resize(new_shape)
    }
    
    static cumprod(ndarray, axis := "")
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if axis = ""
        {
            dtype := ndarray.dtype
            dtype := numahk.%dtype%
            shape := ndarray.shape.clone()
            new_data := dllcall("Numahk\NDArray_Cumprod_", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ndarray.pos_strides[-1], "int", dtype)
            return numahk.ndarray(new_data, dtype, , true, ndarray.size).resize(shape)
        }
        axis := numahk.axis_dev(ndarray.ndim, axis)
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        shape := ndarray.shape.clone()
        new_data := dllcall("Numahk\NDArray_Cumprod", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ndarray.pos_strides[axis + 1], "int", axis, "int", dtype)
        return numahk.ndarray(new_data, dtype, , true, ndarray.size).resize(shape)
    }
    
    static cumsum(ndarray, axis := "")
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if axis = ""
        {
            dtype := ndarray.dtype
            dtype := numahk.%dtype%
            shape := ndarray.shape.clone()
            new_data := dllcall("Numahk\NDArray_Cumsum_", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ndarray.pos_strides[-1], "int", dtype)
            return numahk.ndarray(new_data, dtype, , true, ndarray.size).resize(shape)
        }
        axis := numahk.axis_dev(ndarray.ndim, axis)
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        shape := ndarray.shape.clone()
        new_data := dllcall("Numahk\NDArray_Cumsum", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ndarray.pos_strides[axis + 1], "int", axis, "int", dtype)
        return numahk.ndarray(new_data, dtype, , true, ndarray.size).resize(shape)
    }
    
    static diag(ndarray, offset := 0)
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if (ndarray.ndim > 2) || (ndarray.ndim <= 0)
            throw error("ValueError: Input must be 1- or 2-d.")
        if ndarray.ndim = 2
            return numahk.diagonal(ndarray, offset)
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        length := ndarray.size + abs(offset)
        _offset := (offset < 0) ? length * abs(offset) : offset
        new_data := dllcall("Numahk\NDArray_Diag", "ptr", ndarray.data, "int", ndarray.size, "int", length, "int", _offset, "int", dtype)
        return numahk.ndarray(new_data, dtype, , true, length * length).resize([length, length])
    }
    
    static diagonal(ndarray, offset := 0, axis1 := AHK_FLAG, axis2 := AHK_FLAG + 1)
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if offset < 0
            return numahk.diagonal(ndarray, abs(offset), axis2, axis1)
        if ndarray.ndim < 2
            throw error("ValueError: diag requires an array of at least two dimensions")
        shape := ndarray.shape.clone()
        if ndarray.ndim == 2
        {
            shape.push(1)
            ndarray := ndarray.reshape(shape)
            axis1 := AHK_FLAG
            axis2 := AHK_FLAG + 1
        }
        axis1 := numahk.axis_dev(ndarray.ndim, axis1)
        axis2 := numahk.axis_dev(ndarray.ndim, axis2)
        if axis1 = axis2
            throw error("ValueError: axis1 and axis2 cannot be the same")
        flag := axis1 > axis2
        new_shape := [shape.removeat(axis1 + 1), shape.removeat(axis2 + flag)]
        strides := ndarray.pos_strides.clone()
        new_strides := [strides.removeat(axis1 + 1), strides.removeat(axis2 + flag)]
        new_shape[2] -= offset
        axis_length := min(new_shape*)
        if axis_length <= 0
            return numahk.array([])
        length := c_array.array_product(shape) * axis_length
        jump_step := 0
        for i in new_strides
            jump_step += i
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        new_data := dllcall("Numahk\NDArray_Diagonal", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "ptr", numget(objptr(strides), 0x20, "ptr"), "int", shape.length, "int", jump_step, "int", axis_length, "int", length, "int", offset * new_strides[2], "int", dtype)
        shape.push(axis_length)
        return numahk.ndarray(new_data, dtype, , true, length).resize(shape)
    }
    
    static divide(ndarray1, ndarray2)
    {
        if ndarray2 is number && ndarray2 = 0
            throw error("RuntimeWarning: divide by zero encountered in divide")
        if (ndarray1 is number) && (ndarray2 is number)
            return ndarray1 / ndarray2
        if ndarray1 is number
        {
            if !(ndarray2 is numahk.ndarray)
                ndarray2 := numahk.ndarray(ndarray2)
            ndarray1_dtype := ndarray1 is float ? numahk.float64 : numahk.int32
            ndarray1 := numahk.ndarray(ndarray1, ndarray1_dtype)
            ndarray1_shape := ndarray1.shape.clone()
            loop ndarray2.ndim - 1
                ndarray1_shape.insertat(1, 1)
            strides := c_array.array_strides(ndarray1_shape, 1)
            ndarray1_data := dllcall("Numahk\NUMAHK_BROADCAST", "ptr", ndarray1.data, "ptr", numget(objptr(ndarray1_shape), 0x20, "ptr"), "ptr", numget(objptr(ndarray2.shape), 0x20, "ptr"), "ptr", numget(objptr(strides), 0x20, "ptr"), "int", ndarray2.ndim, "int", ndarray1_dtype, "int", 0)
            ndarray2_data := ndarray2.data
            ndarray2_dtype := ndarray2.dtype
            ndarray2_dtype := numahk.%ndarray2_dtype%
            length := ndarray2.size
            shape := ndarray2.shape
        }
        else if ndarray2 is number
        {
            if !(ndarray1 is numahk.ndarray)
                ndarray1 := numahk.ndarray(ndarray1)
            ndarray2_dtype := ndarray2 is float ? numahk.float64 : numahk.int32
            ndarray2 := numahk.ndarray(ndarray2, ndarray2_dtype)
            ndarray2_shape := ndarray2.shape.clone()
            loop ndarray1.ndim - 1
                ndarray2_shape.insertat(1, 1)
            strides := c_array.array_strides(ndarray2_shape, 1)
            ndarray2_data := dllcall("Numahk\NUMAHK_BROADCAST", "ptr", ndarray2.data, "ptr", numget(objptr(ndarray2_shape), 0x20, "ptr"), "ptr", numget(objptr(ndarray1.shape), 0x20, "ptr"), "ptr", numget(objptr(strides), 0x20, "ptr"), "int", ndarray1.ndim, "int", ndarray2_dtype, "int", 0)
            ndarray1_data := ndarray1.data
            ndarray1_dtype := ndarray1.dtype
            ndarray1_dtype := numahk.%ndarray1_dtype%
            length := ndarray1.size
            shape := ndarray1.shape
        }
        else
        {
            if !(ndarray1 is numahk.ndarray)
                ndarray1 := numahk.ndarray(ndarray1)
            if !(ndarray2 is numahk.ndarray)
                ndarray2 := numahk.ndarray(ndarray2)
            ndarray1 := ndarray1.copy()
            ndarray2 := ndarray2.copy()
            numahk.broadcast(ndarray1, ndarray2)
            ndarray1_data := ndarray1.data
            ndarray1_dtype := ndarray1.dtype
            ndarray1_dtype := numahk.%ndarray1_dtype%
            ndarray2_data := ndarray2.data
            ndarray2_dtype := ndarray2.dtype
            ndarray2_dtype := numahk.%ndarray2_dtype%
            length := ndarray1.size
            shape := ndarray2.shape
        }
        if !ndarray2.all()
            throw error("RuntimeWarning: divide by zero encountered in divide")
        new_dtype := numahk.dtype_dev(ndarray1_dtype, ndarray2_dtype)
        new_data := dllcall("Numahk\NDArray_Divide", "ptr", ndarray1_data, "ptr", ndarray2_data, "int", ndarray1_dtype, "int", ndarray2_dtype, "int", length, "int", new_dtype)
        return numahk.ndarray(new_data, new_dtype, , true, length).resize(shape)
    }
    
    static dot(ndarray1, ndarray2)
    {
        total_flag := 0
        if (ndarray1 is number) || (ndarray2 is number)
            return numahk.mul(ndarray1, ndarray2)
        if !(ndarray1 is numahk.ndarray)
            ndarray1 := numahk.ndarray(ndarray1)
        if !(ndarray2 is numahk.ndarray)
            ndarray2 := numahk.ndarray(ndarray2)
        if (ndarray1.ndim = 1) && (ndarray2.ndim = 1)
            return numahk.multiply(ndarray1, ndarray2)
        if ndarray2.ndim = 1
        {
            total_flag := 1
            ndarray2 := ndarray2.reshape([ndarray2.size, 1])
        }
        if ndarray1.shape[-1] != ndarray2.shape[-2]
            throw error(format("ValueError: shapes {} and {} not aligned: {} (dim {}) != {} (dim {})", numahk.arr_to_string(ndarray1.shape), numahk.arr_to_string(ndarray2.shape), ndarray1.shape[-1], ndarray1.ndim + AHK_FLAG - 1, ndarray2.shape[-2], ndarray2.ndim + AHK_FLAG - 2))
        arr_length := ndarray1.shape[-1]
        ndarray1_dtype := ndarray1.dtype
        ndarray1_dtype := numahk.%ndarray1_dtype%
        ndarray2_dtype := ndarray2.dtype
        ndarray2_dtype := numahk.%ndarray2_dtype%
        dtype := numahk.dtype_dev(ndarray1_dtype, ndarray2_dtype)
        shape1 := ndarray1.shape.clone()
        shape1.removeat(-1)
        strides1 := ndarray1.pos_strides.clone()
        jump_step1 := strides1.removeat(-1)
        shape2 := ndarray2.shape.clone()
        shape2.removeat(-2)
        strides2 := ndarray2.pos_strides.clone()
        jump_step2 := strides2.removeat(-2)
        new_shape := []
        new_shape.push(shape1*)
        if !total_flag
            new_shape.push(shape2*)
        new_data := dllcall("Numahk\NDArray_Dot", "ptr", ndarray1.data, "ptr", ndarray2.data, "ptr", numget(objptr(shape1), 0x20, "ptr"), "ptr", numget(objptr(shape2), 0x20, "ptr"), "ptr", numget(objptr(strides1), 0x20, "ptr"), "ptr", numget(objptr(strides2), 0x20, "ptr"), "int", shape1.length, "int", shape2.length, "int", jump_step1, "int", jump_step2, "int", arr_length, "int", ndarray1_dtype, "int", ndarray2_dtype, "int", dtype)
        return numahk.ndarray(new_data, dtype, , true, c_array.array_product(new_shape)).resize(new_shape)
    }
    
    static dtype_dev(dtype1, dtype2)
    {
        if dtype1 = dtype2
            return dtype1
        dtype1 := (dtype1 = numahk.bool_) ? numahk.int8 : dtype1
        dtype2 := (dtype2 = numahk.bool_) ? numahk.int8 : dtype2
        _dtype1 := max(dtype1, dtype2)
        _dtype2 := min(dtype1, dtype2)
        if _dtype1 < numahk.float32
        {
            if mod(_dtype1, 2)
            {
                if _dtype1 < numahk.uint64
                    return mod(_dtype2, 2) ? _dtype1 : _dtype1 + 1
                return mod(_dtype2, 2) ? _dtype1 : numahk.float64
            }
            return _dtype1
        }
        if _dtype1 = numahk.float64
            return _dtype1
        return (_dtype2 < numahk.int32) ? _dtype1 : numahk.float64
    }
    
    static dump(ndarray, filename)
    {
        filename := strreplace(filename, ".pk")
        if fileexist(filename ".pk")
        {
            filedelete(filename ".pk")
            filedelete(filename "_ref.json")
        }
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        fileappend(ndarray.tojson(), filename "_ref.json")
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        dllcall("Numahk\NDArray_Dump", "ptr", ndarray.data, "int", ndarray.size, "int", dtype, "astr", filename ".pk")
    }
    
    static fill(ndarray, value)
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        ndarray.flat := value
        return ndarray
    }
    
    static full(shape, value, dtype := numahk.float64)
    {
        return numahk.nums(value, shape, dtype)
    }
    
    static full_like(ndarray, value, dtype := ndarray.dtype)
    {
        return numahk.nums_like(value, ndarray, dtype)
    }
    
    static load(filename)
    {
        filename := fileexist(filename) ? filename : fileexist(filename ".pk") ? filename ".pk" : fileexist(filename ".naz") ? filename ".naz" :  fileexist(filename ".nax") ? filename ".nax" : [filename]
        if filename is array
            throw error(format("FileNotFoundError: [Errno 2] No such file or directory: {}", filename[1]))
        if instr(filename, ".pk")
        {
            state := Json_Parser(strreplace(filename, ".pk") "_ref.json")
            dtype := state["dtype"]
            dtype := numahk.%dtype%
            new_data := dllcall("Numahk\NDArray_Load", "int", state["size"], "int", dtype, "astr", filename)
            ndarray := numahk.ndarray(new_data, state["dtype"], , true, state["size"]).resize(state["shape"])
            ndarray.strides := state["strides"]
            ndarray.pos_strides := state["pos_strides"]
            return ndarray
        }
    }
    
    static max(ndarray, axis := "")
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if axis = ""
        {
            dtype := ndarray.dtype
            dtype := numahk.%dtype%
            shape := ndarray.shape.clone()
            new_data := dllcall("Numahk\NDArray_Max_", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", dtype)
            return numget(new_data, 0, numahk.ahktype(dtype))
        }
        axis := numahk.axis_dev(ndarray.ndim, axis)
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        shape := ndarray.shape.clone()
        new_data := dllcall("Numahk\NDArray_Max", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ndarray.pos_strides[axis + 1], "int", axis, "int", dtype)
        shape.removeat(axis + 1)
        length_c := c_array.array_product(shape)
        return numahk.ndarray(new_data, dtype, , true, length_c).resize(shape)
    }
    
    static mean(ndarray, axis := "")
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if axis = ""
        {
            dtype := ndarray.dtype
            dtype := numahk.%dtype%
            shape := ndarray.shape.clone()
            new_data := dllcall("Numahk\NDArray_Mean_", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", dtype)
            return numget(new_data, 0, numahk.ahktype(dtype))
        }
        axis := numahk.axis_dev(ndarray.ndim, axis)
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        shape := ndarray.shape.clone()
        new_data := dllcall("Numahk\NDArray_Mean", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ndarray.pos_strides[axis + 1], "int", axis, "int", dtype)
        shape.removeat(axis + 1)
        length_c := c_array.array_product(shape)
        return numahk.ndarray(new_data, dtype, , true, length_c).resize(shape)
    }
    
    static min(ndarray, axis := "")
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if axis = ""
        {
            dtype := ndarray.dtype
            dtype := numahk.%dtype%
            shape := ndarray.shape.clone()
            new_data := dllcall("Numahk\NDArray_Min_", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", dtype)
            return numget(new_data, 0, numahk.ahktype(dtype))
        }
        axis := numahk.axis_dev(ndarray.ndim, axis)
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        shape := ndarray.shape.clone()
        new_data := dllcall("Numahk\NDArray_Min", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ndarray.pos_strides[axis + 1], "int", axis, "int", dtype)
        shape.removeat(axis + 1)
        length_c := c_array.array_product(shape)
        return numahk.ndarray(new_data, dtype, , true, length_c).resize(shape)
    }
    
    static multiply(ndarray1, ndarray2)
    {
        if (ndarray1 is number) && (ndarray2 is number)
            return ndarray1 * ndarray2
        if ndarray1 is number
        {
            if !(ndarray2 is numahk.ndarray)
                ndarray2 := numahk.ndarray(ndarray2)
            ndarray1_dtype := ndarray1 is float ? numahk.float64 : numahk.int32
            ndarray1 := numahk.ndarray(ndarray1, ndarray1_dtype)
            ndarray1_shape := ndarray1.shape.clone()
            loop ndarray2.ndim - 1
                ndarray1_shape.insertat(1, 1)
            strides := c_array.array_strides(ndarray1_shape, 1)
            ndarray1_data := dllcall("Numahk\NUMAHK_BROADCAST", "ptr", ndarray1.data, "ptr", numget(objptr(ndarray1_shape), 0x20, "ptr"), "ptr", numget(objptr(ndarray2.shape), 0x20, "ptr"), "ptr", numget(objptr(strides), 0x20, "ptr"), "int", ndarray2.ndim, "int", ndarray1_dtype, "int", 0)
            ndarray2_data := ndarray2.data
            ndarray2_dtype := ndarray2.dtype
            ndarray2_dtype := numahk.%ndarray2_dtype%
            length := ndarray2.size
            shape := ndarray2.shape
        }
        else if ndarray2 is number
        {
            if !(ndarray1 is numahk.ndarray)
                ndarray1 := numahk.ndarray(ndarray1)
            ndarray2_dtype := ndarray2 is float ? numahk.float64 : numahk.int32
            ndarray2 := numahk.ndarray(ndarray2, ndarray2_dtype)
            ndarray2_shape := ndarray2.shape.clone()
            loop ndarray1.ndim - 1
                ndarray2_shape.insertat(1, 1)
            strides := c_array.array_strides(ndarray2_shape, 1)
            ndarray2_data := dllcall("Numahk\NUMAHK_BROADCAST", "ptr", ndarray2.data, "ptr", numget(objptr(ndarray2_shape), 0x20, "ptr"), "ptr", numget(objptr(ndarray1.shape), 0x20, "ptr"), "ptr", numget(objptr(strides), 0x20, "ptr"), "int", ndarray1.ndim, "int", ndarray2_dtype, "int", 0)
            ndarray1_data := ndarray1.data
            ndarray1_dtype := ndarray1.dtype
            ndarray1_dtype := numahk.%ndarray1_dtype%
            length := ndarray1.size
            shape := ndarray1.shape
        }
        else
        {
            if !(ndarray1 is numahk.ndarray)
                ndarray1 := numahk.ndarray(ndarray1)
            if !(ndarray2 is numahk.ndarray)
                ndarray2 := numahk.ndarray(ndarray2)
            ndarray1 := ndarray1.copy()
            ndarray2 := ndarray2.copy()
            numahk.broadcast(ndarray1, ndarray2)
            ndarray1_data := ndarray1.data
            ndarray1_dtype := ndarray1.dtype
            ndarray1_dtype := numahk.%ndarray1_dtype%
            ndarray2_data := ndarray2.data
            ndarray2_dtype := ndarray2.dtype
            ndarray2_dtype := numahk.%ndarray2_dtype%
            length := ndarray1.size
            shape := ndarray2.shape
        }
        new_dtype := numahk.dtype_dev(ndarray1_dtype, ndarray2_dtype)
        new_data := dllcall("Numahk\NDArray_Multiply", "ptr", ndarray1_data, "ptr", ndarray2_data, "int", ndarray1_dtype, "int", ndarray2_dtype, "int", length, "int", new_dtype)
        return numahk.ndarray(new_data, new_dtype, , true, length).resize(shape)
    }
    
    static nums(number, shape, dtype := numahk.float64)
    {
        shape := shape is array ? shape : [shape]
        length_c := c_array.array_product(shape)
        new_data := dllcall("Numahk\NUMAHK_NUMS", "int", number, "int", length_c, "int", dtype)
        return numahk.ndarray(new_data, dtype, , true, length_c).resize(shape)
    }
    
    static nums_like(number, ndarray, dtype := ndarray.dtype)
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if dtype is string
            dtype := numahk.%dtype%
        shape := ndarray.shape
        return numahk.nums(number, shape, dtype)
    }
    
    static ones(shape, dtype := numahk.float64)
    {
        return numahk.nums(1, shape, dtype)
    }
    
    static ones_like(ndarray, dtype := ndarray.dtype)
    {
        return numahk.nums_like(1, ndarray, dtype)
    }
    
    static partition(ndarray, kth, axis := -1)
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if ndarray.ndim = 1
        {
            ndarray := ndarray.T
            axis := -1
        }
        kth := numahk.axis_dev(ndarray.ndim, kth, true)
        axis := numahk.axis_dev(ndarray.ndim, axis)
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        shape := ndarray.shape.clone()
        if kth >= shape[axis + 1]
            throw error(format("ValueError: kth(={}) out of bounds ({})", kth + AHK_FLAG, shape[axis]))
        new_data := dllcall("Numahk\NDArray_Partition", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ndarray.pos_strides[axis + 1], "int", kth, "int", axis, "int", dtype)
        return numahk.ndarray(new_data, dtype, , true, ndarray.size).resize(shape)
    }
    
    static prod(ndarray, axis := "")
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if axis = ""
        {
            dtype := ndarray.dtype
            dtype := numahk.%dtype%
            shape := ndarray.shape.clone()
            new_data := dllcall("Numahk\NDArray_Prod_", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", dtype)
            return numget(new_data, 0, numahk.ahktype(dtype))
        }
        axis := numahk.axis_dev(ndarray.ndim, axis)
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        shape := ndarray.shape.clone()
        new_data := dllcall("Numahk\NDArray_Prod", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ndarray.pos_strides[axis + 1], "int", axis, "int", dtype)
        shape.removeat(axis + 1)
        length_c := c_array.array_product(shape)
        return numahk.ndarray(new_data, dtype, , true, length_c).resize(shape)
    }
    
    static ptp(ndarray, axis := "")
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        return numahk.subtract(ndarray.max(axis), ndarray.min(axis))
    }
    
    static put(ndarray, index, value)
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if index is array
        {
            for i in index
                numahk.put(ndarray, i, value)
            return ndarray
        }
        if index - AHK_FLAG >= ndarray.size
            throw error(format("IndexError: index {} is out of bounds for axis 0 with size {}", index, ndarray.size))
        dtype := ndarray.dtype
        numput(numahk.ahktype(numahk.%dtype%), value, ndarray.data, (index - AHK_FLAG) * numahk.type_dict[dtype])
        return ndarray
    }
    
    static ravel(ndarray)
    {
        return ndarray.flat
    }
    
    static repeat(ndarray, repeats, axis := "")
    {
        
    }
    
    static reshape(ndarray, shape*)
    {
        _flag := 0
        if shape.length = 1 && shape[1] is array
            shape := shape[1]
        if c_array.array_equal(shape, ndarray.shape)
            return ndarray
        for i in shape
        {
            if i = -1
            {
                _flag++
                shape[a_index] := ndarray.size // abs(c_array.array_product(shape))
            }
            if _flag > 1
                throw error("can only specify one unknown dimension")
        }
        if c_array.array_product(shape) != ndarray.size
            throw error(format("ValueError: cannot reshape array of size {} into shape {}", ndarray.size, numahk.arr_to_string(shape)))
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        new_data := dllcall("Numahk\NUMAHK_RESHAPE", "int", ndarray.data, "int", ndarray.size, "int", ndarray.pos_strides[-1], "int", dtype)
        new_ndarray := numahk.ndarray(new_data, dtype, , true, ndarray.size)
        new_ndarray.ndim := shape.length
        new_ndarray.shape := shape
        new_ndarray.strides := c_array.array_strides(shape, ndarray.dtype)
        new_ndarray.pos_strides := c_array.array_strides(shape, 1)
        return new_ndarray
    }
    
    static resize(ndarray, shape*)
    {
        return numahk.reshape(ndarray, shape*)
    }
    
    static searchsorted(ndarray, value, side := "left")
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        side := (side = "left") ? 0 : 1
        new_ndarray := numahk.sort(ndarray.reshape(-1))
        dtype := new_ndarray.dtype
        dtype := numahk.%dtype%
        return dllcall("Numahk\NDArray_Searchsorted", "ptr", new_ndarray.data, "double", value, "int", side, "int", new_ndarray.size, "int", dtype)
    }
    
    static sort(ndarray, axis := -1)
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if ndarray.ndim = 1
        {
            ndarray := ndarray.T
            axis := -1
        }
        axis := numahk.axis_dev(ndarray.ndim, axis)
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        shape := ndarray.shape.clone()
        kth := shape[axis + 1] - 1
        new_data := dllcall("Numahk\NDArray_Partition", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ndarray.pos_strides[axis + 1], "int", kth, "int", axis, "int", dtype)
        return numahk.ndarray(new_data, dtype, , true, ndarray.size).resize(shape)
    }
    
    static squeeze(ndarray, axis := "")
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        shape := ndarray.shape.clone()
        if axis = ""
        {
            flag := 0
            for i in shape
            {
                if i = 1
                {
                    ndarray.shape.removeat(a_index - flag)
                    flag++
                }
            }
        }
        else
        {
            axis := numahk.array(axis, numahk.int32).sort().flat
            flag := 0
            for i in axis
            {
                i := numahk.axis_dev(ndarray.ndim, i)
                if shape[i + 1] = 1
                {
                    ndarray.shape.removeat(i + 1 - flag)
                    flag++
                }
            }
        }
        ndarray.ndim := ndarray.shape.length
        ndarray.strides := c_array.array_strides(ndarray.shape, ndarray.dtype)
        ndarray.pos_strides := c_array.array_strides(ndarray.shape, 1)
        return ndarray
    }
    
    static std(ndarray, axis := "", ddof := 0)
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        else
            ndarray := ndarray.astype(numahk.float64)
        if axis = ""
        {
            shape := ndarray.shape.clone()
            new_data := dllcall("Numahk\NDArray_Std_", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ddof, "int", numahk.float64)
            return numget(new_data, 0, "double")
        }
        axis := numahk.axis_dev(ndarray.ndim, axis)
        shape := ndarray.shape.clone()
        new_data := dllcall("Numahk\NDArray_Std", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ddof, "int", ndarray.pos_strides[axis + 1], "int", axis, "int", numahk.float64)
        shape.removeat(axis + 1)
        length_c := c_array.array_product(shape)
        return numahk.ndarray(new_data, numahk.float64, , true, length_c).resize(shape)
    }
    
    static subtract(ndarray1, ndarray2)
    {
        if (ndarray1 is number) && (ndarray2 is number)
            return ndarray1 - ndarray2
        if ndarray1 is number
        {
            if !(ndarray2 is numahk.ndarray)
                ndarray2 := numahk.ndarray(ndarray2)
            ndarray1_dtype := ndarray1 is float ? numahk.float64 : numahk.int32
            ndarray1 := numahk.ndarray(ndarray1, ndarray1_dtype)
            ndarray1_shape := ndarray1.shape.clone()
            loop ndarray2.ndim - 1
                ndarray1_shape.insertat(1, 1)
            strides := c_array.array_strides(ndarray1_shape, 1)
            ndarray1_data := dllcall("Numahk\NUMAHK_BROADCAST", "ptr", ndarray1.data, "ptr", numget(objptr(ndarray1_shape), 0x20, "ptr"), "ptr", numget(objptr(ndarray2.shape), 0x20, "ptr"), "ptr", numget(objptr(strides), 0x20, "ptr"), "int", ndarray2.ndim, "int", ndarray1_dtype, "int", 0)
            ndarray2_data := ndarray2.data
            ndarray2_dtype := ndarray2.dtype
            ndarray2_dtype := numahk.%ndarray2_dtype%
            length := ndarray2.size
            shape := ndarray2.shape
        }
        else if ndarray2 is number
        {
            if !(ndarray1 is numahk.ndarray)
                ndarray1 := numahk.ndarray(ndarray1)
            ndarray2_dtype := ndarray2 is float ? numahk.float64 : numahk.int32
            ndarray2 := numahk.ndarray(ndarray2, ndarray2_dtype)
            ndarray2_shape := ndarray2.shape.clone()
            loop ndarray1.ndim - 1
                ndarray2_shape.insertat(1, 1)
            strides := c_array.array_strides(ndarray2_shape, 1)
            ndarray2_data := dllcall("Numahk\NUMAHK_BROADCAST", "ptr", ndarray2.data, "ptr", numget(objptr(ndarray2_shape), 0x20, "ptr"), "ptr", numget(objptr(ndarray1.shape), 0x20, "ptr"), "ptr", numget(objptr(strides), 0x20, "ptr"), "int", ndarray1.ndim, "int", ndarray2_dtype, "int", 0)
            ndarray1_data := ndarray1.data
            ndarray1_dtype := ndarray1.dtype
            ndarray1_dtype := numahk.%ndarray1_dtype%
            length := ndarray1.size
            shape := ndarray1.shape
        }
        else
        {
            if !(ndarray1 is numahk.ndarray)
                ndarray1 := numahk.ndarray(ndarray1)
            if !(ndarray2 is numahk.ndarray)
                ndarray2 := numahk.ndarray(ndarray2)
            ndarray1 := ndarray1.copy()
            ndarray2 := ndarray2.copy()
            numahk.broadcast(ndarray1, ndarray2)
            ndarray1_data := ndarray1.data
            ndarray1_dtype := ndarray1.dtype
            ndarray1_dtype := numahk.%ndarray1_dtype%
            ndarray2_data := ndarray2.data
            ndarray2_dtype := ndarray2.dtype
            ndarray2_dtype := numahk.%ndarray2_dtype%
            length := ndarray1.size
            shape := ndarray2.shape
        }
        new_dtype := numahk.dtype_dev(ndarray1_dtype, ndarray2_dtype)
        new_data := dllcall("Numahk\NDArray_Subtract", "ptr", ndarray1_data, "ptr", ndarray2_data, "int", ndarray1_dtype, "int", ndarray2_dtype, "int", length, "int", new_dtype)
        return numahk.ndarray(new_data, new_dtype, , true, length).resize(shape)
    }
    
    static sum(ndarray, axis := "")
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        if axis = ""
        {
            dtype := ndarray.dtype
            dtype := numahk.%dtype%
            shape := ndarray.shape.clone()
            new_data := dllcall("Numahk\NDArray_Sum_", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", dtype)
            return numget(new_data, 0, numahk.ahktype(dtype))
        }
        axis := numahk.axis_dev(ndarray.ndim, axis)
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        shape := ndarray.shape.clone()
        new_data := dllcall("Numahk\NDArray_Sum", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ndarray.pos_strides[axis + 1], "int", axis, "int", dtype)
        shape.removeat(axis + 1)
        length_c := c_array.array_product(shape)
        return numahk.ndarray(new_data, dtype, , true, length_c).resize(shape)
    }
    
    static swapaxes(ndarray, axis1, axis2)
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        axes := []
        for i in ndarray.shape
            axes.push(a_index - 1 + AHK_FLAG)
        axis1 := numahk.axis_dev(ndarray.ndim, axis1)
        axis2 := numahk.axis_dev(ndarray.ndim, axis2)
        tmp := axes[axis1 + 1]
        axes[axis1 + 1] := axes[axis2 + 1]
        axes[axis2 + 1] := tmp
        return numahk.transpose(ndarray, axes)
    }
    
    static transpose(ndarray, axes := "")
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        dtype := ndarray.dtype
        dtype := numahk.%dtype%
        ndim := ndarray.ndim
        shape := ndarray.shape.clone()
        strides := ndarray.pos_strides.clone()
        if axes = ""
        {
            axes := []
            for i in shape
                axes.insertat(1, a_index - 1 + AHK_FLAG)
        }
        try
        {
            if axes.length != shape.length
                throw error("ValueError: axes don't match array")
        }
        catch
            throw error("TypeError: transpose takes array arguments but other types were given")
        new_shape := []
        new_strides := []
        for i in axes
        {
            new_shape.push(shape[numahk.axis_dev(ndim, i) + 1])
            new_strides.push(strides[numahk.axis_dev(ndim, i) + 1])
        }
        new_data := dllcall("Numahk\NDArray_Transpose", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", new_strides[-1], "int", dtype)
        return numahk.ndarray(new_data, dtype, , true, ndarray.size).resize(new_shape)
    }
    
    static var(ndarray, axis := "", ddof := 0)
    {
        if !(ndarray is numahk.ndarray)
            ndarray := numahk.ndarray(ndarray)
        else
            ndarray := ndarray.astype(numahk.float64)
        if axis = ""
        {
            shape := ndarray.shape.clone()
            new_data := dllcall("Numahk\NDArray_Var_", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ddof, "int", numahk.float64)
            return numget(new_data, 0, "double")
        }
        axis := numahk.axis_dev(ndarray.ndim, axis)
        shape := ndarray.shape.clone()
        new_data := dllcall("Numahk\NDArray_Var", "ptr", ndarray.data, "ptr", numget(objptr(shape), 0x20, "ptr"), "int", shape.length, "int", ddof, "int", ndarray.pos_strides[axis + 1], "int", axis, "int", numahk.float64)
        shape.removeat(axis + 1)
        length_c := c_array.array_product(shape)
        return numahk.ndarray(new_data, numahk.float64, , true, length_c).resize(shape)
    }
    
    static zeros(shape, dtype := numahk.float64)
    {
        return numahk.nums(0, shape, dtype)
    }
    
    static zeros_like(ndarray, dtype := ndarray.dtype)
    {
        return numahk.nums_like(0, ndarray, dtype)
    }
}

#Include <_numahk\numahk_base>
#Include <_numahk\numahk_const>
#Include <data\debug>

class numahk
{
    class ndarray
    {
        __new(_array, dtype := numahk_const.DEFAULT_DTYPE, isflat := false)
        {
            this.dtype := dtype
            this.shape := isflat ? [_array.length] : numahk_base.array_property.get_shape(_array)
            this.ndim := this.shape.length
            this.data := isflat ? objptr(_array) : objptr(numahk_base.array_property.get_flatten(_array))
            this.strides := numahk_base.array_property.shape_to_strides(this.shape)
        }
    }
}
a := numahk.ndarray([1,2,3], , 1)
b := numahk.ndarray([[4],[5],[6]], , 1)
debug numahk_base.broadcast(a, b, &c := 0)
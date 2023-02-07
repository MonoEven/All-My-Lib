#Include <numahk\numahk_base>
#Include <numahk\numahk_null>
#Include <numahk\numahk_operator>
#Include <numahk\numahk_pos_machine>

class numahk_func extends numahk_operator
{
    static swapaxes(ndarray, axis1, axis2)
    {
        len := ndarray.shape.length
        new_array := []
        new_array.length := ndarray._data.length
        now_shape := ndarray.shape
        swap_shape := ndarray.shape.clone()
        now_strides := ndarray.strides
        min_pos := []
        loop len
            min_pos.push(1)
        now_pos := min_pos.clone()
        now_pos[-1] -= 1
        max_pos := ndarray.shape.clone()
        numahk_base.swap_arr_index(swap_shape, axis1, axis2)
        swap_strides := numahk_base.shape_to_strides(swap_shape)
        npm := numahk_pos_machine(now_pos, min_pos, max_pos)
        loop ndarray._data.length
        {
            now_pos := npm.add()
            swap_pos := now_pos.clone()
            numahk_base.swap_arr_index(swap_pos, axis1, axis2)
            pos_all := numahk_base.get_ndarray_index_with_diff_strides(now_strides, swap_strides, now_pos, swap_pos)
            new_array[pos_all[2]] := ndarray._data[pos_all[1]]
        }
        return numahk.array(new_array).resize(swap_shape)
    }
    
    static transpose(ndarray)
    {
        len := ndarray.shape.length
        new_array := []
        new_array.length := ndarray._data.length
        if len = 1
            return ndarray.resize([ndarray.shape[1], 1])
        now_shape := ndarray.shape
        swap_shape := ndarray.shape.clone()
        now_strides := ndarray.strides
        min_pos := []
        loop len
            min_pos.push(1)
        now_pos := min_pos.clone()
        now_pos[-1] -= 1
        max_pos := ndarray.shape.clone()
        point := 1
        loop (len // 2)
        {
            numahk_base.swap_arr_index(swap_shape, point, len - point + 1)
            point++
        }
        swap_strides := numahk_base.shape_to_strides(swap_shape)
        npm := numahk_pos_machine(now_pos, min_pos, max_pos)
        loop ndarray._data.length
        {
            now_pos := npm.add()
            swap_pos := now_pos.clone()
            point := 1
            loop (len // 2)
            {
                numahk_base.swap_arr_index(swap_pos, point, len - point + 1)
                point++
            }
            pos_all := numahk_base.get_ndarray_index_with_diff_strides(now_strides, swap_strides, now_pos, swap_pos)
            new_array[pos_all[2]] := ndarray._data[pos_all[1]]
        }
        return numahk.array(new_array).resize(swap_shape)
    }
}
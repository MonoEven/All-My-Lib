#Include <numahk\machine_base\pos_machine>

DIMS_INTERVAL := ","
IN_DIMS_INTERVAL := ","

array_to_string(_array, shape, float_pos := 8)
{
    min_pos := []
    max_pos := shape.clone()
    ret_string := ""
    loop shape.length
    {
        min_pos.push(1)
        ret_string .= "["
    }
    npm := numahk_pos_machine(min_pos, min_pos, max_pos)
    loop _array.length
    {
        npm.add(1, &change_times)
        ret_string .= print_number(_array[a_index])
        loop change_times
            ret_string .= "]"
        ret_string .= change_times ? DIMS_INTERVAL : IN_DIMS_INTERVAL
        loop change_times
            ret_string .= "["
    }
    return rtrim(rtrim(ret_string, "["), ",")
    
    print_number(_number, float_pos := 8)
    {
        if _number is integer
            return _number
        else
            return round(_number, float_pos)
    }
}

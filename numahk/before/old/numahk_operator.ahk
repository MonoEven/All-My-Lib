#Include <numahk\numahk_base>
#Include <numahk\numahk_null>
#Include <numahk\numahk_pos_machine>

if !isset(numahk)
    throw error("numahk should be included!")
class numahk_operator
{
    static broadcast(ndarray1, ndarray2, &broadcast_flag)
    {
        max_shape := []
        if ndarray1 is number
        {
            broadcast_flag := [-1, 0]
            max_shape := ndarray2.shape
        }
        else if ndarray2 is number
        {
            broadcast_flag := [0, -1]
            max_shape := ndarray1.shape
        }
        else
        {
            nd1_flag := []
            nd2_flag := []
            nd1_shape := ndarray1.shape.clone()
            nd2_shape := ndarray2.shape.clone()
            if numahk_base.is_arr_equal(nd1_shape, nd2_shape)
            {
                broadcast_flag := [0, 0]
                return nd1_shape
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
            ndarray1.resize(nd1_shape)
            ndarray2.resize(nd2_shape)
            broadcast_flag := [nd1_flag, nd2_flag]
        }
        return max_shape
    }
    
    static broadcast_pos(pos, flag)
    {
        for i in flag
        {
            if i = 1
                pos[a_index] := 1
        }
        return pos
    }
    
    static add(ndarray1, ndarray2)
    {
        ndarray1 := ndarray1.clone()
        ndarray2 := ndarray2.clone()
        broadcast_shape := numahk_operator.broadcast(ndarray1, ndarray2, &broadcast_flag := [])
        new_ndarray := []
        min_pos := []
        loop broadcast_shape.length
            min_pos.push(1)
        now_pos := min_pos.clone()
        now_pos[-1] -= 1
        max_pos := broadcast_shape.clone()
        npm := numahk_pos_machine(now_pos, min_pos, max_pos, broadcast_flag*)
        nd1_flag := broadcast_flag[1]
        nd1_bool := nd1_flag is array
        nd2_flag := broadcast_flag[2]
        nd2_bool := nd2_flag is array
        loop numahk_base.get_arr_product(broadcast_shape)
        {
            pos_all := npm.add(1, nd1_bool, nd2_bool)
            now_pos := pos_all[1]
            tmp := (nd1_flag = -1) ? ndarray1 : ndarray1[pos_all[2]*]
            tmp += (nd2_flag = -1) ? ndarray2 : ndarray2[pos_all[3]*]
            new_ndarray.push(tmp)
        }
        return numahk.array(new_ndarray, , 1).resize(broadcast_shape)
    }
    
    static divide(ndarray1, ndarray2)
    {
        ndarray1 := ndarray1.clone()
        ndarray2 := ndarray2.clone()
        broadcast_shape := numahk_operator.broadcast(ndarray1, ndarray2, &broadcast_flag := [])
        new_ndarray := []
        min_pos := []
        loop broadcast_shape.length
            min_pos.push(1)
        now_pos := min_pos.clone()
        now_pos[-1] -= 1
        max_pos := broadcast_shape.clone()
        npm := numahk_pos_machine(now_pos, min_pos, max_pos, broadcast_flag*)
        nd1_flag := broadcast_flag[1]
        nd1_bool := nd1_flag is array
        nd2_flag := broadcast_flag[2]
        nd2_bool := nd2_flag is array
        loop numahk_base.get_arr_product(broadcast_shape)
        {
            pos_all := npm.add(1, nd1_bool, nd2_bool)
            now_pos := pos_all[1]
            tmp := (nd1_flag = -1) ? ndarray1 : ndarray1[pos_all[2]*]
            tmp /= (nd2_flag = -1) ? ndarray2 : ndarray2[pos_all[3]*]
            new_ndarray.push(tmp)
        }
        return numahk.array(new_ndarray, , 1).resize(broadcast_shape)
    }
    
    static multiply(ndarray1, ndarray2)
    {
        ndarray1 := ndarray1.clone()
        ndarray2 := ndarray2.clone()
        broadcast_shape := numahk_operator.broadcast(ndarray1, ndarray2, &broadcast_flag := [])
        new_ndarray := []
        min_pos := []
        loop broadcast_shape.length
            min_pos.push(1)
        now_pos := min_pos.clone()
        now_pos[-1] -= 1
        max_pos := broadcast_shape.clone()
        npm := numahk_pos_machine(now_pos, min_pos, max_pos, broadcast_flag*)
        nd1_flag := broadcast_flag[1]
        nd1_bool := nd1_flag is array
        nd2_flag := broadcast_flag[2]
        nd2_bool := nd2_flag is array
        loop numahk_base.get_arr_product(broadcast_shape)
        {
            pos_all := npm.add(1, nd1_bool, nd2_bool)
            now_pos := pos_all[1]
            tmp := (nd1_flag = -1) ? ndarray1 : ndarray1[pos_all[2]*]
            tmp *= (nd2_flag = -1) ? ndarray2 : ndarray2[pos_all[3]*]
            new_ndarray.push(tmp)
        }
        return numahk.array(new_ndarray, , 1).resize(broadcast_shape)
    }
    
    static substract(ndarray1, ndarray2)
    {
        ndarray1 := ndarray1.clone()
        ndarray2 := ndarray2.clone()
        broadcast_shape := numahk_operator.broadcast(ndarray1, ndarray2, &broadcast_flag := [])
        new_ndarray := []
        min_pos := []
        loop broadcast_shape.length
            min_pos.push(1)
        now_pos := min_pos.clone()
        now_pos[-1] -= 1
        max_pos := broadcast_shape.clone()
        npm := numahk_pos_machine(now_pos, min_pos, max_pos, broadcast_flag*)
        nd1_flag := broadcast_flag[1]
        nd1_bool := nd1_flag is array
        nd2_flag := broadcast_flag[2]
        nd2_bool := nd2_flag is array
        loop numahk_base.get_arr_product(broadcast_shape)
        {
            pos_all := npm.add(1, nd1_bool, nd2_bool)
            now_pos := pos_all[1]
            tmp := (nd1_flag = -1) ? ndarray1 : ndarray1[pos_all[2]*]
            tmp -= (nd2_flag = -1) ? ndarray2 : ndarray2[pos_all[3]*]
            new_ndarray.push(tmp)
        }
        return numahk.array(new_ndarray, , 1).resize(broadcast_shape)
    }
}
#Include <numahk\c_base\native>

class c_array
{
    static array_broadcast(_array, arr_shape, shape, dtype := "int")
    {
        /*
        void broadcast(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)
        {
            Array* arr = (Array*)aParam[0]->object;
            if (aParam[0]->symbol == SYM_VAR)
                arr = (Array*)aParam[0]->var->mObject;
            Array* arr_shape = (Array*)aParam[1]->object;
            if (aParam[1]->symbol == SYM_VAR)
                arr_shape = (Array*)aParam[1]->var->mObject;
            Array* arr_strides = (Array*)aParam[2]->object;
            if (aParam[2]->symbol == SYM_VAR)
                arr_strides = (Array*)aParam[2]->var->mObject;
            Array* flag = (Array*)aParam[3]->object;
            if (aParam[3]->symbol == SYM_VAR)
                flag = (Array*)aParam[3]->var->mObject;
            Array* flag_pos = (Array*)aParam[4]->object;
            if (aParam[4]->symbol == SYM_VAR)
                flag_pos = (Array*)aParam[4]->var->mObject;
            Array* max_pos = (Array*)aParam[5]->object;
            if (aParam[5]->symbol == SYM_VAR)
                max_pos = (Array*)aParam[5]->var->mObject;
            Array* min_pos = (Array*)aParam[6]->object;
            if (aParam[6]->symbol == SYM_VAR)
                min_pos = (Array*)aParam[6]->var->mObject;
            Array* now_pos = (Array*)aParam[7]->object;
            if (aParam[7]->symbol == SYM_VAR)
                now_pos = (Array*)aParam[7]->var->mObject;
            Array* ret = (Array*)aParam[8]->object;
            if (aParam[8]->symbol == SYM_VAR)
                ret = (Array*)aParam[8]->var->mObject;
            auto dtype = aParam[9]->var->mContentsInt64;
            auto length = ret->mLength;
            auto len = max_pos->mLength;
            int modify, point, i, arr_idx;
            point = 0;
            while (point < len)
            {
                auto& p = flag->mItem[point];
                p.symbol = SYM_INTEGER;
                p.n_int64 = (arr_shape->mItem[point].n_int64 == max_pos->mItem[point].n_int64) ? 0 : 1;
                point++;
            }
            for (i = 0; i < length; i++)
            {
                modify = 1;
                point = 0;
                while (point < len)
                {
                    now_pos->mItem[point].n_int64 += modify;
                    modify = now_pos->mItem[point].n_int64 / (max_pos->mItem[point].n_int64 + 1);
                    if (modify == 0)
                    {
                        flag_pos->mItem[point].n_int64 = (flag->mItem[point].n_int64 == 1) ? 1 : now_pos->mItem[point].n_int64;
                        break;
                    }
                    now_pos->mItem[point].n_int64 = now_pos->mItem[point].n_int64 % max_pos->mItem[point].n_int64 + min_pos->mItem[point].n_int64 - 1;
                    flag_pos->mItem[point].n_int64 = (flag->mItem[point].n_int64 == 1) ? 1 : now_pos->mItem[point].n_int64;
                    point++;
                }
                arr_idx = 0;
                point = 0;
                while (point < len)
                {
                    arr_idx += arr_strides->mItem[point].n_int64 * (flag_pos->mItem[point].n_int64 - 1);
                    point++;
                }
                auto& p = ret->mItem[i];
                p.symbol = (dtype == 0) ? SYM_INTEGER : SYM_FLOAT;
                (dtype == 0) ? p.n_int64 = arr->mItem[arr_idx].n_int64 : p.n_double = arr->mItem[arr_idx].n_double;
            }
        }
        */
        if c_array.array_equal(arr_shape, shape)
            return _array.clone()
        dtype := (dtype = "int") ? 0 : 1
        tmp := arr_shape
        arr_shape := c_array.array_fill(shape.length, 1)
        for i in tmp
        {
            tmp2 := tmp[-a_index]
            if (tmp2 != shape[-a_index]) && tmp2 != 1
                    throw error("broadcast error!", -1)
            arr_shape[a_index] := tmp2
        }
        arr_strides := c_array.array_strides(c_array.array_flip(arr_shape.clone()))
        c_array.array_flip(arr_strides)
        flag := []
        flag.length := shape.length
        max_pos :=  c_array.array_flip(shape.clone())
        flag_pos := c_array.array_fill(max_pos.length, 1)
        min_pos := c_array.array_fill(max_pos.length, 1)
        now_pos := c_array.array_fill(max_pos.length, 1)
        now_pos[1] -= 1
        ret := []
        ret.length := c_array.array_product(max_pos)
        _mcode := "2,x64:SIlcJAhVVldBVEFVQVZBV0iD7DBIiwJBuAQAAABIiwhIiQwkRDlAEHUHSIsJSIkMJEiLQghMixBEOUAQdQNNixJIi0IQSIsISImMJIgAAABEOUAQdQtIiwlIiYwkiAAAAEiLQhhIixhEOUAQdQNIixtIi0IgTIsYRDlAEHUDTYsbSItCKEiLOEQ5QBB1A0iLP0iLQjBIiwhIiUwkeEQ5QBB1CEiLCUiJTCR4SItCOEyLKEQ5QBB1BE2LbQBIi0JATIsgRDlAEHUETYskJEiLQkhBvgEAAACLdyhBi2wkKEiLCEiLAUiJRCQIhfZ0QUUzyUSL9kyLQyAz0kPHRAEIAQAAAEiLRyBJi0ogSYsEAUk5BAkPlcJLiRQBTY1JEEmD7gF10EiLRCQIQb4BAAAAhe0PhFYBAABI99hIiWwkEEyLxUUb/0H330UD/kUzyUGLxkUz0kUz9oX2D4T2AAAARTPASYtNIEiYSgEEAUmLTSBIi0cgSIlMJCBKiywBSYsEAEiJRCQYSI1IAUiLxUiZSPf5SIlEJCiFwHRpSItEJHhIi0ggSIvFSJlI93wkGEqLDAFI/8lIA9FIi0wkIEqJFAG6AQAAAEiLSyBJORQIdQSLyusISYtFIEmLDABJi0MgRAPyTAPSSYkMAEmDwBBIi0QkKEQ79g+CZv///0G+AQAAAOsdSItDIEG+AQAAAE05NABJi0MgSQ9E7k0D0kqJLNBIi4QkiAAAADPSTYtDIEyL1kiLSCBMK8FBiwQIQSvGD68BSI1JEAPQTSvWdetMi0QkEOsGM9JEjXIBSYtMJCBIY8JIixQkSMHgBEWJfAkISANCIEiLAEmJBAlJg8EQTSvGTIlEJBAPhcH+//9Ii1wkcEiDxDBBX0FeQV1BXF9eXcM="
        fn := native.func(_mcode, 10, 10)
        fn(_array, arr_shape, arr_strides, flag, flag_pos, max_pos, min_pos, now_pos, ret, dtype)
        return ret
    }
    
    static array_contain(_array)
    {
        /*
        void contain(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)
        {
            Array* arr = (Array*)aParam[0]->object;
            if (aParam[0]->symbol == SYM_VAR)
                arr = (Array*)aParam[0]->var->mObject;
            Array* ret = (Array*)aParam[1]->object;
            if (aParam[1]->symbol == SYM_VAR)
                ret = (Array*)aParam[1]->var->mObject;
            auto len = arr->mLength;
            for (int i = 0; i < len; i++)
            {
                if (arr->mItem[i].symbol != SYM_MISSING)
                {
                    auto& p = ret->mItem[0];
                    p.symbol = SYM_INTEGER;
                    p.n_int64 = 1;
                    return;
                }
            }
            auto& p = ret->mItem[0];
            p.symbol = SYM_INTEGER;
            p.n_int64 = 0;
        }
        */
        ret := []
        ret.length := 1
        _mcode := "2,x64:SIsCg3gQBEyLCHUDTYsJSItCCIN4EARMiwB1A02LAEGLUSgzyYXSdBdJi0EgSIPACIM4A3Ud/8FIg8AQO8py8UmLQCBIxwAAAAAAx0AIAQAAAMNJi0AgSMcAAQAAAMdACAEAAADD"
        fn := native.func(_mcode, 2, 2)
        fn(_array, ret)
        return ret[1]
    }
    
    static array_copyfromptr(ptr, length, _type := 0)
    {
        /*
        void copyfromptr(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)
        {
            Array* ret = (Array*)aParam[0]->object;
            if (aParam[0]->symbol == SYM_VAR)
                ret = (Array*)aParam[0]->var->mObject;
            auto len = ret->mLength;
            int ptr = aParam[1]->var->mContentsInt64;
            auto dtype = aParam[2]->var->mContentsInt64;
            auto _type = aParam[3]->var->mContentsInt64;
            for (int i = 0; i < len; i++)
            {
                auto& p = ret->mItem[i];
                p.symbol = (dtype == 2) ? SYM_FLOAT : SYM_INTEGER;
                (dtype == 2) ? p.n_double = *(double*)(ptr + _type * i) : (dtype == 1) ? p.n_int64 = *(int*)(ptr + _type * i) : p.n_int64 = *(unsigned char*)(ptr + _type * i);
            }
        }
        */
        switch _type
        {
            case 0, 2:
                dtype := 0
            case 1, 3, 4:
                dtype := 1
            case 5, 6:
                dtype := 2
        }
        switch _type
        {
            case 0, 1:
                _type := 1
            case 2, 3:
                _type := 2
            case 4, 5:
                _type := 4
            case 6:
                _type := 8
        }
        ret := []
        ret.length := length
        _mcode := "2,x64:QFNVQVZIg+wQSIsCg3gQBEyLEHUDTYsSSItCEEWLcihIiwhIi0IYSIspSIsISIsZRYX2D4TMAQAASItCCDPSRIvCSIsITGMZSIP9AXU2RYvOSYtKIE2NQBBIi8NID6/CQcdECPgBAAAASP/CSmMEGEmJRAjwSYPpAXXWSIPEEEFeXVvDSIl8JDhMiWwkCESL6kGD/gQPghgBAABIiXQkMEGNRvxIg/0CTIlkJECL8kyJPCRAD5TGvwIAAAD/xsHoAv/ATIvKRIv4RI0shQAAAABJi0ogTI1n/0iLw0kPr8BMD6/jQYl0CQhIg/0CdUpKiwQYSYkECUmLSiBBiXQJGEuLBBxJiUQJEEiLx0mLSiBID6/DQYl0CShKiwQYSYlECSBIjUcBSYtKIEgPr8NBiXQJOEqLBBjrTEIPtgQYSYkECUmLSiBBiXQJGEMPtgQcSYlECRBIi8dJi0ogSA+vw0GJdAkoQg+2BBhJiUQJIEiNRwFJi0ogSA+vw0GJdAk4Qg+2BBhJiUQJMEmDwARJg8FASIPHBEmD7wEPhTH///9MizwkTItkJEBIi3QkMEU77nNISIP9AkmLyA+UwkjB4QT/wkUr9UGL/k2LSiBIi8NJD6/AQolUCQhIg/0CdQZKiwQY6wVCD7YEGEqJBAlJ/8BIg8EQSIPvAXXOSIt8JDhMi2wkCEiDxBBBXl1bww=="
        fn := native.func(_mcode, 4, 4)
        fn(ret, ptr, dtype, _type)
        return ret
    }
    
    static array_empty(_array)
    {
        /*
        void empty(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)
        {
            Array* arr = (Array*)aParam[0]->object;
            if (aParam[0]->symbol == SYM_VAR)
                arr = (Array*)aParam[0]->var->mObject;
            Array* ret = (Array*)aParam[1]->object;
            if (aParam[1]->symbol == SYM_VAR)
                ret = (Array*)aParam[1]->var->mObject;
            auto len = arr->mLength;
            for (int i = 0; i < len; i++)
            {
                if (arr->mItem[i].symbol == SYM_MISSING)
                {
                    auto& p = ret->mItem[0];
                    p.symbol = SYM_INTEGER;
                    p.n_int64 = 1;
                    return;
                }
            }
            auto& p = ret->mItem[0];
            p.symbol = SYM_INTEGER;
            p.n_int64 = 0;
        }
        */
        ret := []
        ret.length := 1
        _mcode := "2,x64:SIsCg3gQBEyLCHUDTYsJSItCCIN4EARMiwB1A02LAEGLUSgzyYXSdBdJi0EgSIPACIM4A3Qd/8FIg8AQO8py8UmLQCBIxwAAAAAAx0AIAQAAAMNJi0AgSMcAAQAAAMdACAEAAADD"
        fn := native.func(_mcode, 2, 2)
        fn(_array, ret)
        return ret[1]
    }
    
    static array_equal(_array1, _array2, dtype := "int")
    {
        /*
        void equal(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)
        {
            Array* arr1 = (Array*)aParam[0]->object;
            if (aParam[0]->symbol == SYM_VAR)
                arr1 = (Array*)aParam[0]->var->mObject;
            Array* arr2 = (Array*)aParam[1]->object;
            if (aParam[1]->symbol == SYM_VAR)
                arr2 = (Array*)aParam[1]->var->mObject;
            Array* ret = (Array*)aParam[2]->object;
            if (aParam[2]->symbol == SYM_VAR)
                ret = (Array*)aParam[2]->var->mObject;
            auto len1 = arr1->mLength;
            auto len2 = arr2->mLength;
            auto dtype = aParam[3]->var->mContentsInt64;
            if (len1 != len2)
            {
                auto& p = ret->mItem[0];
                p.symbol = SYM_INTEGER;
                p.n_int64 = 0;
                return;
            }
            for (int i = 0; i < len1; i++)
            {
                if ((dtype == 0) ? (arr1->mItem[i].n_int64 != arr2->mItem[i].n_int64) : (arr1->mItem[i].n_double != arr2->mItem[i].n_double))
                {
                    auto& p = ret->mItem[0];
                    p.symbol = SYM_INTEGER;
                    p.n_int64 = 0;
                    return;
                }
            }
            auto& p = ret->mItem[0];
            p.symbol = SYM_INTEGER;
            p.n_int64 = 1;
        }
        */
        dtype := (dtype = "int") ? 0 : 1
        ret := []
        ret.length := 1
        _mcode := "2,x64:SIlcJAhIiXwkEEiLAoN4EARMixB1A02LEkiLQgiDeBAETIsIdQNNiwlIi0IQg3gQBEyLGHUDTYsbSItCGEGLWihIiwhIizlBO1kodB1Ji0MgSMcAAAAAAMdACAEAAABIi1wkCEiLfCQQw0UzwIXbdDsz0kiF/3USSYtBIEmLSiBIiwQCSDkECusUSYtCIEmLSSDyDxAEAmYPLgQKeq91rUH/wEiDwhBEO8Nyx0mLQyBIi1wkCEiLfCQQSMcAAQAAAMdACAEAAADD"
        fn := native.func(_mcode, 4, 4)
        fn(_array1, _array2, ret, dtype)
        return ret[1]
    }
    
    static array_fill(length, number, &dtype := 0)
    {
        /*
        void fill(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)
        {
            Array* arr = (Array*)aParam[0]->object;
            if (aParam[0]->symbol == SYM_VAR)
                arr = (Array*)aParam[0]->var->mObject;
            auto len = arr->mLength;
            auto dtype = aParam[2]->var->mContentsInt64;
            for (int i = 0; i < len; i++)
            {
                auto& p = arr->mItem[i];
                p.symbol = (dtype == 0) ? SYM_INTEGER : SYM_FLOAT;
                (dtype == 0) ? p.n_int64 = aParam[1]->var->mContentsInt64 : p.n_double = aParam[1]->var->mContentsDouble;
            }
        }
        */
        dtype := number is integer ? 0 : 1
        _mcode := "2,x64:QFNIiwJMi9qDeBAETIsQdQNNixJIi0IQQYtaKEiLCIXbD4QjAQAARTPATDkBdStEi8tJi1IgTY1AEEHHRBD4AQAAAEmLQwhIiwhIiwFJiUQQ8EmD6QF12lvDg/sED4K0AAAAjUP8SIl0JBDB6AL/wEiJfCQYSYv4i/BEjQSFAAAAAEyNDIUAAAAAZg8fRAAASYtSIEiNf0DHRBfIAgAAAEmLQwhIiwhIiwFIiUQXwEmLUiDHRDrYAgAAAEmLQwhIiwhIiwFIiUQ60EmLUiDHRDroAgAAAEmLQwhIiwhIiwFIiUQ64EmLUiDHRDr4AgAAAEmLQwhIiwhIiwFIiUQ68EiD7gF1ikiLfCQYSIt0JBBEO8NyBVvDTYvIScHhBEEr2ESLw0mLUiBNjUkQQcdEEfgCAAAASYtDCEiLCEiLAUmJRBHwSYPoAXXaW8M="
        fn := native.func(_mcode, 3, 3)
        if length is array
            _array := length
        else
        {
            _array := []
            _array.length := length
        }
        fn(_array, number, dtype)
        return _array
    }
    
    static array_flatten(_array, dtype := "int")
    {
        /*
        void flatten(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)
        {
            Array* arr = (Array*)aParam[0]->object;
            if (aParam[0]->symbol == SYM_VAR)
                arr = (Array*)aParam[0]->var->mObject;
            Array* max_pos = (Array*)aParam[1]->object;
            if (aParam[1]->symbol == SYM_VAR)
                max_pos = (Array*)aParam[1]->var->mObject;
            Array* min_pos = (Array*)aParam[2]->object;
            if (aParam[2]->symbol == SYM_VAR)
                min_pos = (Array*)aParam[2]->var->mObject;
            Array* now_pos = (Array*)aParam[3]->object;
            if (aParam[3]->symbol == SYM_VAR)
                now_pos = (Array*)aParam[3]->var->mObject;
            Array* ret = (Array*)aParam[4]->object;
            if (aParam[4]->symbol == SYM_VAR)
                ret = (Array*)aParam[4]->var->mObject;
            auto dtype = aParam[5]->var->mContentsInt64;
            auto length = ret->mLength;
            auto len = max_pos->mLength;
            int modify, point, i, idx;
            Array* tmp;
            for (i = 0; i < length; i++)
            {
                modify = 1;
                point = 0;
                while (point < len)
                {
                    now_pos->mItem[point].n_int64 += modify;
                    modify = now_pos->mItem[point].n_int64 / (max_pos->mItem[point].n_int64 + 1);
                    if (modify == 0)
                        break;
                    now_pos->mItem[point].n_int64 = now_pos->mItem[point].n_int64 % max_pos->mItem[point].n_int64 + min_pos->mItem[point].n_int64 - 1;
                    point++;
                }
                tmp = arr;
                point = len - 1;
                while (point > 0)
                {
                    idx = now_pos->mItem[point].n_int64 - 1;
                    tmp = (Array*)tmp->mItem[idx].object;
                    point--;
                }
                idx = now_pos->mItem[0].n_int64 - 1;
                auto& p = ret->mItem[i];
                p.symbol = (dtype == 0) ? SYM_INTEGER : SYM_FLOAT;
                (dtype == 0) ? p.n_int64 = tmp->mItem[idx].n_int64 : p.n_double = tmp->mItem[idx].n_double;
            }
        }
        */
        dtype := (dtype = "int") ? 0 : 1
        shape := c_array.array_shape(_array)
        max_pos :=  c_array.array_flip(shape.clone())
        min_pos := c_array.array_fill(max_pos.length, 1)
        now_pos := c_array.array_fill(max_pos.length, 1)
        now_pos[1] -= 1
        ret := []
        ret.length := c_array.array_product(max_pos)
        _mcode := "2,x64:QFZBVUFWQVdIg+w4SIsCg3gQBEiLCEiJDCR1B0iLCUiJDCRIi0IIg3gQBEyLKHUETYttAEiLQhCDeBAETIs4dQNNiz9Ii0IYg3gQBEiLMHUDSIs2SItCIIN4EARMixhMiVwkeHUITYsbTIlcJHhIi0IoTWN1KEiLCEiLEUGLSyhIiVQkEIXJD4QkAQAASIlcJGBEi9Ez20iJbCQwSIXSSIl8JChMiWQkIE2NZv8PlcNIiUwkCP/DiVwkaDP/Dx8ARTPJvQEAAABFhfZ0YkUzwEiLTiBIY8VJAQQISYtFIEyLXiBNixQAS4scGEiLw0iZSY1KAUj3+UiL6IXAdCNJi08gSIvDSJlB/8FJ9/pI/8pKAxQBS4kUGEmDwBBFO85yr0yLVCQITItcJHiLXCRoTIsMJE2LxE2F5H4wSYvUSMHiBEgDViBmZg8fhAAAAAAASGMKSI1S8EmLQSBIA8lJ/8hMi0zI8E2FwH/lSItGIEmLUyBIYwCJXBcISAPASYtJIEiLRMHwSIkEF0iDxxBJg+oBTIlUJAgPhSP///9Mi2QkIEiLfCQoSItsJDBIi1wkYEiDxDhBX0FeQV1eww=="
        fn := native.func(_mcode, 6, 6)
        fn(_array, max_pos, min_pos, now_pos, ret, dtype)
        return ret
    }
    
    static array_flip(_array, dtype := "int")
    {
        /*
        void flip(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)
        {
            Array* arr = (Array*)aParam[0]->object;
            if (aParam[0]->symbol == SYM_VAR)
                arr = (Array*)aParam[0]->var->mObject;
            auto len = arr->mLength;
            auto dtype = aParam[1]->var->mContentsInt64;
            int temp_int;
            double temp_double;
            for (int i = 0; i < len / 2; i++)
            {
                if (dtype == 0)
                {
                    temp_int = arr->mItem[i].n_int64;
                    arr->mItem[i].n_int64 = arr->mItem[len - i - 1].n_int64;
                    arr->mItem[len - i - 1].n_int64 = temp_int;
                }
                else
                {
                    temp_double = arr->mItem[i].n_double;
                    arr->mItem[i].n_double = arr->mItem[len - i - 1].n_double;
                    arr->mItem[len - i - 1].n_double = temp_double;
                }
            }
        }
        */
        dtype := (dtype = "int") ? 0 : 1
        _mcode := "2,x64:SIlcJBhXSIsCg3gQBEyLEHUDTYsSQYt6KEG5AAAAAIvf0esPhGoBAABIi0IISIsITDkJdUJFi9kPH4QAAAAAAE2LQiBNjVsQi9dBK9FB/8H/yktjTAPwSAPSSYsE0EuJRAPwSYtCIEiJDNBEO8ty0EiLXCQgX8OD+wQPgtkAAABIiWwkEI1r/USNXf9IiXQkGEHB6wJJi/FB/8NJweMCkEmLUiBIjXZARIvHRSvBQYPBBPIPEEQWwEGNSP9IA8lIiwTKSIlEFsBJi0Ig8g8RBMhBjUj+SYtSIEgDyUiLBMryDxBEFtBIiUQW0EmLQiDyDxEEyEGNSP1Ji1IgSAPJSIsEyvIPEEQy4EiJRDLgSYtCIPIPEQTIQY1I/EmLUiBIA8lIiwTK8g8QRDLwSIlEMvBJi0Ig8g8RBMhEO80Pgl3///9Ii3QkGEiLbCQQRDvLcgpIi1wkIF/DTYvZScHjBEmLUiBNjVsQi89BK8lB/8H/yfJBDxBEE/BIA8lIiwTKSYlEE/BJi0Ig8g8RBMhEO8tyzUiLXCQgX8M="
        fn := native.func(_mcode, 2, 2)
        fn(_array, dtype)
        return _array
    }
    
    static array_idx2value(_array, index, dtype := "int")
    {
        dtype := (dtype = "int") ? 0 : 1
        ret := []
        ret.length := _array.length
        _mcode := "2,x64:SIlcJBhWSIsCg3gQBEyLEHUDTYsSSItCCIN4EARMixh1A02LG0iLQhCDeBAESIsYdQNIixtIi0IYQYtyKEiLCIX2D4RyAQAARTPATDkBdTtEi85Ii1MgTY1AEEHHRBD4AQAAAEmLQyBJi0wA8EmLQiBIA8lIi0zI8EmJTBDwSYPpAXXPSItcJCBew4P+BA+C6AAAAI1G/EiJbCQQwegC/8BIiXwkGEmL+IvoRI0EhQAAAABMjQyFAAAAAA8fRAAASItTIEiNf0DHRBfIAgAAAEmLQyBIi0wHwEmLQiBIA8lIi0zI8EiJTBfASItTIMdEF9gCAAAASYtDIEiLTAfQSYtCIEgDyUiLTMjwSIlMF9BIi1Mgx0QX6AIAAABJi0MgSItMB+BJi0IgSAPJSItMyPBIiUwX4EiLUyDHRBf4AgAAAEmLQyBIi0wH8EmLQiBIA8lIi0zI8EiJTBfwSIPtAQ+FWv///0iLfCQYSItsJBBEO8ZyCkiLXCQgXsNNi8hJweEEQSvwRIvGSItTIE2NSRBBx0QR+AIAAABJi0MgSYtMAfBJi0IgSAPJSItMyPBJiUwR8EmD6AF1z0iLXCQgXsM="
        fn := native.func(_mcode, 4, 4)
        fn(_array, index, ret, dtype)
        return ret
    }
    
    static array_maxmin(_array1, _array2, dtype := "int", _type := "max")
    {
        /*
        void maxmin(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)
        {
            Array* arr1 = (Array*)aParam[0]->object;
            if (aParam[0]->symbol == SYM_VAR)
                arr1 = (Array*)aParam[0]->var->mObject;
            Array* arr2 = (Array*)aParam[1]->object;
            if (aParam[1]->symbol == SYM_VAR)
                arr2 = (Array*)aParam[1]->var->mObject;
            Array* ret = (Array*)aParam[2]->object;
            if (aParam[2]->symbol == SYM_VAR)
                ret = (Array*)aParam[2]->var->mObject;
            auto len = arr1->mLength;
            auto dtype = aParam[3]->var->mContentsInt64;
            auto _type = aParam[4]->var->mContentsInt64;
            for (int i = 0; i < len; i++)
            {
                auto& p = ret->mItem[i];
                p.symbol = (dtype == 0) ? SYM_INTEGER : SYM_FLOAT;
                (_type == 0) ? (dtype == 0) ? p.n_int64 = max(arr1->mItem[i].n_int64, arr2->mItem[i].n_int64) : p.n_double = max(arr1->mItem[i].n_double, arr2->mItem[i].n_double) : (dtype == 0) ? p.n_int64 = min(arr1->mItem[i].n_int64, arr2->mItem[i].n_int64) : p.n_double = min(arr1->mItem[i].n_double, arr2->mItem[i].n_double);
            }
        }
        */
        _type := (_type = "max") ? 0 : 1
        dtype := (dtype = "int") ? 0 : 1
        length := max(_array1.length, _array2.length)
        _input_array1 := _array1.clone()
        _input_array2 := _array2.clone()
        loop length - _array1.length
            _input_array1.insertat(1, 1)
        loop length - _array2.length
            _input_array2.insertat(1, 1)
        ret := []
        ret.length := length
        _mcode := "2,x64:SIlcJCBVVldBVUiLAoN4EARIixh1A0iLG0iLQgiDeBAESIs4dQNIiz9Ii0IQg3gQBEiLMHUDSIs2SItCGESLayhIiwhIiylFhe0PhH8CAABIi0IgRTPJSIsITDkJdWtIhe1Fi9lFi9VBD5XDQf/DkEyLRiBHiVwBCEiF7XUdSItHIEmLFAFIi0MgSYsMAUg7ykgPTspLiQwB6xpIi0MgSItPIPJCDxAECPJBD18ECfJDDxEEAUmDwRBJg+oBdbFIi1wkQEFdX15dw0yJZCQoRYvhQYP9BA+CiAEAAEyJdCQwQY1F/EiF7UyJfCQ4RYvxTYvZQQ+VxsHoAkH/xv/ARIv4RI0khQAAAABMjRSFAAAAAEyLRiBHiXQDCEiF7Q+FlQAAAEiLRyBJixQDSItDIEmLDANIO8pID03KS4kMA0yLRiBHiXQDGEiLRyBJi1QDEEiLQyBKi0wYEEg7ykgPTcpLiUwDEEyLRiBHiXQDKEiLRyBJi1QDIEiLQyBJi0wDIEg7ykgPTcpLiUwDIEyLRiBHiXQDOEiLRyBJi1QDMEiLQyBJi0wDMEg7ykgPTcpLiUwDMOmMAAAASItDIEiLTyDyQg8QBBjyQQ9dBAvyQw8RBANIi1YgRYl0ExhIi0MgSItPIPJCDxBEGBDyQQ9dRAsQ8kEPEUQTEEiLViBFiXQTKEiLQyBIi08g8kIPEEQYIPJBD11ECyDyQQ8RRBMgSItWIEWJdBM4SItDIEiLTyDyQg8QRBgw8kEPXUQLMPJBDxFEEzBJg8NASYPvAQ+Fv/7//0yLfCQ4TIt0JDBFO+VzaOsDTYvRSIXtQQ+VwUnB4gRB/8FFK+xFi91Mi0YgR4lMAghIhe11HUiLRyBJixQCSItDIEmLDAJIO8pID03KS4kMAusaSItDIEiLTyDyQQ8QBALyQQ9dBAryQw8RBAJJg8IQSYPrAXWxTItkJChIi1wkQEFdX15dww=="
        fn := native.func(_mcode, 5, 5)
        fn(_input_array1, _input_array2, ret, dtype, _type)
        return ret
    }
    
    static array_maxmethod(_array, axis := -1, shape := [], strides := [], dtype := "int")
    {
        /*
        void maxarr(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)
        {
            Array* arr = (Array*)aParam[0]->object;
            if (aParam[0]->symbol == SYM_VAR)
                arr = (Array*)aParam[0]->var->mObject;
            Array* ret = (Array*)aParam[1]->object;
            if (aParam[1]->symbol == SYM_VAR)
                ret = (Array*)aParam[1]->var->mObject;
            auto dtype = aParam[2]->var->mContentsInt64;
            auto length = arr->mLength;
            int flag, tmp_index, tmp_int;
            double tmp_double;
            (dtype == 0) ? tmp_int = arr->mItem[0].n_int64 : tmp_double = arr->mItem[0].n_double;
            tmp_index = 1;
            for (int i = 1; i < length; i++)
            {
                flag = (dtype == 0) ? tmp_int < arr->mItem[i].n_int64 : tmp_double < arr->mItem[i].n_double;
                if (flag)
                {
                    (dtype == 0) ? tmp_int = arr->mItem[i].n_int64 : tmp_double = arr->mItem[i].n_double;
                    tmp_index = i + 1;
                }
            }
            auto& p = ret->mItem[0];
            p.symbol = (dtype == 0) ? SYM_INTEGER : SYM_FLOAT;
            (dtype == 0) ? p.n_int64 = tmp_int : p.n_double = tmp_double;
            auto& q = ret->mItem[1];
            q.symbol = SYM_INTEGER;
            q.n_int64 = tmp_index;
        }
        */
        /*
        void maxmethod(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)
        {
            Array* arr = (Array*)aParam[0]->object;
            if (aParam[0]->symbol == SYM_VAR)
                arr = (Array*)aParam[0]->var->mObject;
            Array* max_pos = (Array*)aParam[1]->object;
            if (aParam[1]->symbol == SYM_VAR)
                max_pos = (Array*)aParam[1]->var->mObject;
            Array* min_pos = (Array*)aParam[2]->object;
            if (aParam[2]->symbol == SYM_VAR)
                min_pos = (Array*)aParam[2]->var->mObject;
            Array* now_pos = (Array*)aParam[3]->object;
            if (aParam[3]->symbol == SYM_VAR)
                now_pos = (Array*)aParam[3]->var->mObject;
            Array* _max = (Array*)aParam[4]->object;
            if (aParam[4]->symbol == SYM_VAR)
                _max = (Array*)aParam[4]->var->mObject;
            Array* max_index = (Array*)aParam[5]->object;
            if (aParam[5]->symbol == SYM_VAR)
                max_index = (Array*)aParam[5]->var->mObject;
            Array* strides = (Array*)aParam[6]->object;
            if (aParam[6]->symbol == SYM_VAR)
                strides = (Array*)aParam[6]->var->mObject;
            Array* tmp_index = (Array*)aParam[7]->object;
            if (aParam[7]->symbol == SYM_VAR)
                tmp_index = (Array*)aParam[7]->var->mObject;
            Array* tmp_strides = (Array*)aParam[8]->object;
            if (aParam[8]->symbol == SYM_VAR)
                tmp_strides = (Array*)aParam[8]->var->mObject;
            auto dtype = aParam[10]->var->mContentsInt64;
            auto length = arr->mLength;
            auto len = max_pos->mLength;
            auto axis = len - aParam[9]->var->mContentsInt64;
            int modify, point, i, idx, tmp, flag;
            for (i = 0; i < length; i++)
            {
                modify = 1;
                point = 0;
                while (point < len)
                {
                    now_pos->mItem[point].n_int64 += modify;
                    modify = now_pos->mItem[point].n_int64 / (max_pos->mItem[point].n_int64 + 1);
                    if (modify == 0)
                        break;
                    now_pos->mItem[point].n_int64 = now_pos->mItem[point].n_int64 % max_pos->mItem[point].n_int64 + min_pos->mItem[point].n_int64 - 1;
                    point++;
                }
                idx = 0;
                point = 0;
                while (point < len)
                {
                    idx += strides->mItem[point].n_int64 * (now_pos->mItem[point].n_int64 - 1);
                    point++;
                }
                tmp = 0;
                point = 0;
                while (point < len)
                {
                    tmp += tmp_strides->mItem[point].n_int64 * (now_pos->mItem[point].n_int64 - 1);
                    point++;
                }
                if (_max->mItem[tmp].symbol != SYM_MISSING)
                {
                    tmp_index->mItem[tmp].n_int64++;
                    flag = (dtype == 0) ? _max->mItem[tmp].n_int64 < arr->mItem[idx].n_int64 : _max->mItem[tmp].n_double < arr->mItem[idx].n_double;
                    if (flag)
                    {
                        (dtype == 0) ? _max->mItem[tmp].n_int64 = arr->mItem[idx].n_int64 : _max->mItem[tmp].n_double = arr->mItem[idx].n_double;
                        max_index->mItem[tmp].n_int64 = tmp_index->mItem[tmp].n_int64;
                    }
                }
                else
                {
                    auto& p = _max->mItem[tmp];
                    p.symbol = (dtype == 0) ? SYM_INTEGER : SYM_FLOAT;
                    (dtype == 0) ? p.n_int64 = arr->mItem[idx].n_int64 : p.n_double = arr->mItem[idx].n_double;
                    auto& q = max_index->mItem[tmp];
                    q.symbol = SYM_INTEGER;
                    q.n_int64 = 1;
                    auto& r = tmp_index->mItem[tmp];
                    r.symbol = SYM_INTEGER;
                    r.n_int64 = 1;
                }
            }
        }
        */
        if axis = -1
        {
            dtype := (dtype = "int") ? 0 : 1
            _mcode := "2,x64:SIlcJAhIiXwkGEiLAoN4EARMiwB1A02LAEiLQgiDeBAETIsIdQNNiwlIi0IQQYt4KEiLCEmLQCBMixFNhdJ1C0SLAPIPEEwkEOsJ8g8QCESLRCQQuwEAAACL0zv7dkhIjUgQRTPbTYXSdQxJY8BIOwFBD5zD6wzyDxABZg8vwUEPl8NFhdt0FU2F0nUFRIsB6wTyDxAJjVoBi9PrAv/CSIPBEDvXcrxJi1EgSYvCSPfYG8n32f/BiUoITYXSdQhJY8BIiQLrBPIPEQpJi0kgSIt8JBhIY8NIi1wkCMdBGAEAAABIiUEQww=="
            ret := []
            ret.length := 2
            fn := native.func(_mcode, 3, 3)
            fn(_array, ret, dtype)
            return ret
        }
        else
        {
            dtype := (dtype = "int") ? 0 : 1
            strides := (strides.length) ? strides.clone() : c_array.array_strides(shape.clone())
            c_array.array_flip(strides)
            tmp_shape := shape.clone()
            tmp_shape[axis] := 1
            tmp_strides := c_array.array_strides(tmp_shape)
            tmp_strides[axis] := 0
            c_array.array_flip(tmp_strides)
            max_pos :=  c_array.array_flip(shape.clone())
            min_pos := c_array.array_fill(max_pos.length, 1)
            now_pos := c_array.array_fill(max_pos.length, 1)
            now_pos[1] -= 1
            _max := []
            _max.length := _array.length // shape[axis]
            max_index := []
            max_index.length := _max.length
            tmp_index := []
            tmp_index.length := _max.length
            _mcode := "2,x64:SIlcJAhVVldBVEFVQVZBV0iD7CBIiwJBuQQAAABMixhEOUgQdQNNixtIi0IITIs4RDlIEHUDTYs/SItCEEiLCEiJTCR4RDlIEHUISIsJSIlMJHhIi0IYSIswRDlIEHUDSIs2SItCIEiLKEQ5SBB1BEiLbQBIi0IoTIswTIk0JEQ5SBB1B02LNkyJNCRIi0IwTIsATIlEJGhEOUgQdQhNiwBMiUQkaEiLQjhIixhEOUgQdQNIixtIi0JATIsgTIlkJAhEOUgQdQlNiyQkTIlkJAhBg3soAEiLQlBBi38oSIsITIspTIlsJBgPhpoBAABBi0MoSIlEJBBFM8lBugEAAACF/3RqTIt0JHhFM8BIi04gSWPCSQEECEmLRyBMi2YgTYssAEuLBCBImUmNTQFI9/lMi9CFwHQkS4sEIEH/wUmLTiBImUn3/Uj/ykoDFAFLiRQgSYPAEEQ7z3KxTIs0JEyLZCQITItEJGhMi2wkGEUz0oX/dCpJi0ggTIvPSItWIEyLx0gr0YsECv/ID68BSI1JEEQD0EmD6QF16zPS6wkz0kyLx4X/dCFJi0wkIEyLTiBMK8lBiwQJ/8gPrwFIjUkQA9BJg+gBdetMi00gSGPSSAPSTWPCTQPAQYN80QgDdFFIi0MgM8lI/wTQTItNIE2LUyBNhe11DUuLBMJJOQTRD5zB6w/yQw8QBMJmQQ8vBNEPl8GFyXRfS4sEwkmJBNFIi0MgSYtOIEiLBNBIiQTR60VJi8VI99gbyffZ/8FBiUzRCEmLQyBKiwTASYkE0UmLRiDHRNAIAQAAAEjHBNABAAAASItDIMdE0AgBAAAASMcE0AEAAABIg2wkEAFMi0QkaA+Fb/7//0iLXCRgSIPEIEFfQV5BXUFcX15dww=="
            fn := native.func(_mcode, 11, 11)
            fn(_array, max_pos, min_pos, now_pos, _max, max_index, strides, tmp_index, tmp_strides, axis, dtype)
            return [_max, max_index]
        }
    }
    
    static array_minmethod(_array, axis := -1, shape := [], strides := [], dtype := "int")
    {
        /*
        void minarr(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)
        {
            Array* arr = (Array*)aParam[0]->object;
            if (aParam[0]->symbol == SYM_VAR)
                arr = (Array*)aParam[0]->var->mObject;
            Array* ret = (Array*)aParam[1]->object;
            if (aParam[1]->symbol == SYM_VAR)
                ret = (Array*)aParam[1]->var->mObject;
            auto dtype = aParam[2]->var->mContentsInt64;
            auto length = arr->mLength;
            int flag, tmp_index, tmp_int;
            double tmp_double;
            (dtype == 0) ? tmp_int = arr->mItem[0].n_int64 : tmp_double = arr->mItem[0].n_double;
            tmp_index = 1;
            for (int i = 1; i < length; i++)
            {
                flag = (dtype == 0) ? tmp_int > arr->mItem[i].n_int64 : tmp_double > arr->mItem[i].n_double;
                if (flag)
                {
                    (dtype == 0) ? tmp_int = arr->mItem[i].n_int64 : tmp_double = arr->mItem[i].n_double;
                    tmp_index = i + 1;
                }
            }
            auto& p = ret->mItem[0];
            p.symbol = (dtype == 0) ? SYM_INTEGER : SYM_FLOAT;
            (dtype == 0) ? p.n_int64 = tmp_int : p.n_double = tmp_double;
            auto& q = ret->mItem[1];
            q.symbol = SYM_INTEGER;
            q.n_int64 = tmp_index;
        }
        */
        /*
        void minmethod(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)
        {
            Array* arr = (Array*)aParam[0]->object;
            if (aParam[0]->symbol == SYM_VAR)
                arr = (Array*)aParam[0]->var->mObject;
            Array* max_pos = (Array*)aParam[1]->object;
            if (aParam[1]->symbol == SYM_VAR)
                max_pos = (Array*)aParam[1]->var->mObject;
            Array* min_pos = (Array*)aParam[2]->object;
            if (aParam[2]->symbol == SYM_VAR)
                min_pos = (Array*)aParam[2]->var->mObject;
            Array* now_pos = (Array*)aParam[3]->object;
            if (aParam[3]->symbol == SYM_VAR)
                now_pos = (Array*)aParam[3]->var->mObject;
            Array* _min = (Array*)aParam[4]->object;
            if (aParam[4]->symbol == SYM_VAR)
                _min = (Array*)aParam[4]->var->mObject;
            Array* min_index = (Array*)aParam[5]->object;
            if (aParam[5]->symbol == SYM_VAR)
                min_index = (Array*)aParam[5]->var->mObject;
            Array* strides = (Array*)aParam[6]->object;
            if (aParam[6]->symbol == SYM_VAR)
                strides = (Array*)aParam[6]->var->mObject;
            Array* tmp_index = (Array*)aParam[7]->object;
            if (aParam[7]->symbol == SYM_VAR)
                tmp_index = (Array*)aParam[7]->var->mObject;
            Array* tmp_strides = (Array*)aParam[8]->object;
            if (aParam[8]->symbol == SYM_VAR)
                tmp_strides = (Array*)aParam[8]->var->mObject;
            auto dtype = aParam[10]->var->mContentsInt64;
            auto length = arr->mLength;
            auto len = max_pos->mLength;
            auto axis = len - aParam[9]->var->mContentsInt64;
            int modify, point, i, idx, tmp, flag;
            for (i = 0; i < length; i++)
            {
                modify = 1;
                point = 0;
                while (point < len)
                {
                    now_pos->mItem[point].n_int64 += modify;
                    modify = now_pos->mItem[point].n_int64 / (max_pos->mItem[point].n_int64 + 1);
                    if (modify == 0)
                        break;
                    now_pos->mItem[point].n_int64 = now_pos->mItem[point].n_int64 % max_pos->mItem[point].n_int64 + min_pos->mItem[point].n_int64 - 1;
                    point++;
                }
                idx = 0;
                point = 0;
                while (point < len)
                {
                    idx += strides->mItem[point].n_int64 * (now_pos->mItem[point].n_int64 - 1);
                    point++;
                }
                tmp = 0;
                point = 0;
                while (point < len)
                {
                    tmp += tmp_strides->mItem[point].n_int64 * (now_pos->mItem[point].n_int64 - 1);
                    point++;
                }
                if (_min->mItem[tmp].symbol != SYM_MISSING)
                {
                    tmp_index->mItem[tmp].n_int64++;
                    flag = (dtype == 0) ? _min->mItem[tmp].n_int64 > arr->mItem[idx].n_int64 : _min->mItem[tmp].n_double > arr->mItem[idx].n_double;
                    if (flag)
                    {
                        (dtype == 0) ? _min->mItem[tmp].n_int64 = arr->mItem[idx].n_int64 : _min->mItem[tmp].n_double = arr->mItem[idx].n_double;
                        min_index->mItem[tmp].n_int64 = tmp_index->mItem[tmp].n_int64;
                    }
                }
                else
                {
                    auto& p = _min->mItem[tmp];
                    p.symbol = (dtype == 0) ? SYM_INTEGER : SYM_FLOAT;
                    (dtype == 0) ? p.n_int64 = arr->mItem[idx].n_int64 : p.n_double = arr->mItem[idx].n_double;
                    auto& q = min_index->mItem[tmp];
                    q.symbol = SYM_INTEGER;
                    q.n_int64 = 1;
                    auto& r = tmp_index->mItem[tmp];
                    r.symbol = SYM_INTEGER;
                    r.n_int64 = 1;
                }
            }
        }
        */
        if axis = -1
        {
            dtype := (dtype = "int") ? 0 : 1
            _mcode := "2,x64:SIlcJAhIiXwkGEiLAoN4EARMiwB1A02LAEiLQgiDeBAETIsIdQNNiwlIi0IQQYt4KEiLCEmLQCBMixFNhdJ1C0SLAPIPEEQkEOsJ8g8QAESLRCQQuwEAAACL0zv7dkRIjUgQRTPbTYXSdQxJY8BIOwFBD5/D6whmDy8BQQ+Xw0WF23QVTYXSdQVEiwHrBPIPEAGNWgGL0+sC/8JIg8EQO9dywEmLUSBJi8JI99gbyffZ/8GJSghNhdJ1CEljwEiJAusE8g8RAkmLSSBIi3wkGEhjw0iLXCQIx0EYAQAAAEiJQRDD"
            ret := []
            ret.length := 2
            fn := native.func(_mcode, 3, 3)
            fn(_array, ret, dtype)
            return ret
        }
        else
        {
            dtype := (dtype = "int") ? 0 : 1
            strides := (strides.length) ? strides.clone() : c_array.array_strides(shape.clone())
            c_array.array_flip(strides)
            tmp_shape := shape.clone()
            tmp_shape[axis] := 1
            tmp_strides := c_array.array_strides(tmp_shape)
            tmp_strides[axis] := 0
            c_array.array_flip(tmp_strides)
            max_pos :=  c_array.array_flip(shape.clone())
            min_pos := c_array.array_fill(max_pos.length, 1)
            now_pos := c_array.array_fill(max_pos.length, 1)
            now_pos[1] -= 1
            _min := []
            _min.length := _array.length // shape[axis]
            min_index := []
            min_index.length := _min.length
            tmp_index := []
            tmp_index.length := _min.length
            _mcode := "2,x64:SIlcJAhVVldBVEFVQVZBV0iD7CBIiwJBuQQAAABMixhEOUgQdQNNixtIi0IITIs4RDlIEHUDTYs/SItCEEiLCEiJTCR4RDlIEHUISIsJSIlMJHhIi0IYSIswRDlIEHUDSIs2SItCIEiLKEQ5SBB1BEiLbQBIi0IoTIswTIk0JEQ5SBB1B02LNkyJNCRIi0IwTIsATIlEJGhEOUgQdQhNiwBMiUQkaEiLQjhIixhEOUgQdQNIixtIi0JATIsgTIlkJAhEOUgQdQlNiyQkTIlkJAhBg3soAEiLQlBBi38oSIsITIspTIlsJBgPhpoBAABBi0MoSIlEJBBFM8lBugEAAACF/3RqTIt0JHhFM8BIi04gSWPCSQEECEmLRyBMi2YgTYssAEuLBCBImUmNTQFI9/lMi9CFwHQkS4sEIEH/wUmLTiBImUn3/Uj/ykoDFAFLiRQgSYPAEEQ7z3KxTIs0JEyLZCQITItEJGhMi2wkGEUz0oX/dCpJi0ggTIvPSItWIEyLx0gr0YsECv/ID68BSI1JEEQD0EmD6QF16zPS6wkz0kyLx4X/dCFJi0wkIEyLTiBMK8lBiwQJ/8gPrwFIjUkQA9BJg+gBdetMi00gSGPSSAPSTWPCTQPAQYN80QgDdFFIi0MgM8lI/wTQTItNIE2LUyBNhe11DUuLBMJJOQTRD5/B6w/yQQ8QBNFmQw8vBMIPl8GFyXRfS4sEwkmJBNFIi0MgSYtOIEiLBNBIiQTR60VJi8VI99gbyffZ/8FBiUzRCEmLQyBKiwTASYkE0UmLRiDHRNAIAQAAAEjHBNABAAAASItDIMdE0AgBAAAASMcE0AEAAABIg2wkEAFMi0QkaA+Fb/7//0iLXCRgSIPEIEFfQV5BXUFcX15dww=="
            fn := native.func(_mcode, 11, 11)
            fn(_array, max_pos, min_pos, now_pos, _min, min_index, strides, tmp_index, tmp_strides, axis, dtype)
            return [_min, min_index]
        }
    }
    
    static array_ndim(_array)
    {
        /*
        void ndim(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)
        {
            Array* arr = (Array*)aParam[0]->object;
            if (aParam[0]->symbol == SYM_VAR)
                arr = (Array*)aParam[0]->var->mObject;
            Array* ret = (Array*)aParam[1]->object;
            if (aParam[1]->symbol == SYM_VAR)
                ret = (Array*)aParam[1]->var->mObject;
            int ndim = 1;
            Array* tmp = arr;
            while (tmp->mItem[0].symbol == SYM_OBJECT)
            {
                tmp = (Array*)tmp->mItem[0].object;
                ndim++;
            }
            auto& p = ret->mItem[0];
            p.symbol = SYM_INTEGER;
            p.n_int64 = ndim;
        }
        */
        ret := []
        ret.length := 1
        _mcode := "2,x64:SIsCg3gQBEiLCHUDSIsJSItCCIN4EARMiwB1A02LAEiLQSC6AQAAAIN4CAV1EWaQSIsA/8JIi0Agg3gIBXTxSYtIIEhjwsdBCAEAAABIiQHD"
        fn := native.func(_mcode, 2, 2)
        fn(_array, ret)
        return ret[1]
    }
    
    static array_sort(_array, _type := "ascend", dtype := "int")
    {
        _type := (_type = "ascend") ? 0 : 1
        dtype := (dtype = "int") ? 0 : 1
        index := c_array.array_range(1, _array.length)[1]
        stack := []
        stack.length := _array.length
        _mcode := "2,x64:SIlcJAhVVldBVEFVQVZBV0iD7EBIiwKDeBAESIs4dQNIiz9Ii0IIg3gQBEyLCEyJTCQIdQhNiwlMiUwkCEiLQhCDeBAESIsITIvBSIlMJBB1CEyLAUyJRCQQiwFBvwIAAABNi3AgiYQkiAAAAEiLQhhEi6wkiAAAAPIPEIwkiAAAAEyJdCQYSIsIizGLTyhBx0YIAQAAAP/JSccGAAAAAEmLQCAPEEAQSGPBQQ8RBkHHRggBAAAASYkGZg8fRAAASYtQIE2Lz0iLTyBJweEESYPpEEyJfCQ4SYPH/kyJTCQgSYvfSMHjBEpjBApMi+BIiVwkKEgDwExjFBpEiZQkmAAAAEGNav+F9nUGRIsswesF8g8QDMFJi8JNi9pIiUQkME071A+P7gAAAESLtCSIAAAATYvCSGPdScHgBEyL00nB4gQz0kWF9nUYhfZ1DEljxUk5BAgPnsLrJWZBDy8MCOsahfZ1DEljxUk5BAgPncLrDfJBDxAECGYPL8EPk8JMi8mF0nRd/8VI/8NJg8IQSTvbdE9KiwQBhfZ1EkpjDBFLiQQRSItHIEmJDADrFPJDDxAEEUuJBBFIi0cg8kEPEQQATItMJAhJi1EgSosEAkpjDBJKiQQSSYtBIEmJDABIi08gSf/DSYPAEE073A+OUP///0yLRCQQTIt0JBhMi0wkIESLlCSYAAAASYtQIEiLXCQoSItEJDCNTf9EO9F9Nw8QBBNMi3wkOEEPEQZJiQZBx0YIAQAAAEmLQCBBDxAEAUhjwUEPEQZBx0YIAQAAAEmJBkmLUCCNRQFBO8R9N0mLz0iYSAPJSYPHAg8QBMpBDxEGQcdGCAEAAABJiQZJi0AgDxBEyBBBDxEGQcdGCAEAAABNiSZNhf8PhSH+//9Ii5wkgAAAAEiDxEBBX0FeQV1BXF9eXcM="
        fn := native.func(_mcode, 5, 5)
        fn(_array, index, stack, _type, dtype)
        return [_array, index]
    }
    
    static array_product(_array, dtype := "int")
    {
        /*
        void product(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)
        {
            Array* arr = (Array*)aParam[0]->object;
            if (aParam[0]->symbol == SYM_VAR)
                arr = (Array*)aParam[0]->var->mObject;
            auto len = arr->mLength;
            auto dtype = aParam[2]->var->mContentsInt64;
            Array* ret = (Array*)aParam[1]->object;
            if (aParam[1]->symbol == SYM_VAR)
                ret = (Array*)aParam[1]->var->mObject;
            auto& q = ret->mItem[0];
            q.symbol = (dtype == 0) ? SYM_INTEGER : SYM_FLOAT;
            (dtype == 0) ? q.n_int64 = arr->mItem[0].n_int64 : q.n_double = arr->mItem[0].n_double;
            for (int i = 1; i < len; i++)
                (dtype == 0) ? q.n_int64 *= arr->mItem[i].n_int64 : q.n_double *= arr->mItem[i].n_double;
        }
        */
        dtype := (dtype = "int") ? 0 : 1
        ret := []
        ret.length := 1
        _mcode := "2,x64:SIPsCEiLAoN4EARMiwh1A02LCUiLQhBFi1EoSIsISItCCEyLAYN4EARIixB1A0iLEkiLUiAzwE2FwA+VwP/AiUIISYtBIEiLAEiJAkGD+gEPhucAAABNhcB1KEG4EAAAAEH/ykmLQSBNjUAQSIsKSg+vTADwSIkKSYPqAXXmSIPECMNBjUL/QbsBAAAAg/gED4J+AAAA8g8QAkGNQvvB6AJFjUMP/8BIiRwki9hEjRyFAQAAAEiNDIUBAAAADx8ASYtBIE2NQEDyQg9ZRADA8g8RAkmLQSDyQg9ZRADQ8g8RAkmLQSDyQQ9ZRADg8g8RAkmLQSDyQQ9ZRADw8g8RAkiD6wF1ukiLHCRFO9pyCEiDxAjDSYvLSMHhBEUr00WLwkmLQSBIjUkQ8g8QRAHw8g9ZAvIPEQJJg+gBdeRIg8QIww=="
        fn := native.func(_mcode, 3, 3)
        fn(_array, ret, dtype)
        return ret[1]
    }
    
    static array_range(start, stop := "", step := 1)
    {
        /*
        void range(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)
        {
            Array* ret = (Array*)aParam[0]->object;
            if (aParam[0]->symbol == SYM_VAR)
                ret = (Array*)aParam[0]->var->mObject;
            auto len = ret->mLength;
            auto dtype = aParam[3]->var->mContentsInt64;
            auto start = (dtype == 0) ? aParam[1]->var->mContentsInt64 : (double)aParam[1]->var->mContentsInt64;
            auto step = (dtype == 0) ? aParam[2]->var->mContentsInt64 : aParam[2]->var->mContentsDouble;
            for (int i = 0; i < len; i++)
            {
                auto& p = ret->mItem[i];
                p.symbol = (dtype == 0) ? SYM_INTEGER : SYM_FLOAT;
                (dtype == 0) ? p.n_int64 = start : p.n_double = start;
                start += step;
            }
        }
        */
        if !step
            throw error("step cann't be 0.", -1)
        if stop == ""
        {
            tmp := start
            start := 1
            stop := tmp
        }
        if instr(step, "j")
        {
            length := max(0, integer(rtrim(step, "j")))
            value_float := (stop - start) / (length - 1)
            value_int := (stop - start) // (length - 1)
            step := (value_float = value_int) ? value_int : value_float
        }
        else
            length := max(0, (stop - start) // abs(step) + 1)
        ret := []
        ret.length := length
        _mcode := "2,x64:SIsCg3gQBEyLAHUDTYsASItCGA9XwEWLUChIiwhIi0IITIsJSIsISItCEPJIDyoBSIsITYXJdQoPV8nySA8qCesE8g8QCUWF0g+E/AAAADPSTYXJdS5Ni8oPH4AAAAAASYtIIPJIDyzAx0QKCAEAAADyD1jBSIkECkiDwhBJg+kBdd3DQYP6BA+CkQAAAEGNQvxMi8rB6AL/wESL2I0UhQAAAABIjQyFAAAAAA8fQABJi0AgQcdEAQgCAAAA8kEPEQQB8g9YwUmLQCBCx0QIGAIAAADyQg8RRAgQ8g9YwUmLQCBCx0QIKAIAAADyQg8RRAgg8g9YwUmLQCBCx0QIOAIAAADyQg8RRAgwSYPBQPIPWMFJg+sBdZdBO9JyBMNIi8pIweEERCvSQYvSSYtAIPIPEQQB8g9YwcdEAQgCAAAASIPBEEiD6gF14cM="
        fn := native.func(_mcode, 4, 4)
        fn(ret, start, step, dtype := (step is integer) ? 0 : 1)
        return [ret, dtype]
    }
    
    static array_reshape(_array, shape, strides, dtype := "int")
    {
        /*
        void reshape(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)
        {
            Array* arr = (Array*)aParam[0]->object;
            if (aParam[0]->symbol == SYM_VAR)
                arr = (Array*)aParam[0]->var->mObject;
            Array* max_pos = (Array*)aParam[1]->object;
            if (aParam[1]->symbol == SYM_VAR)
                max_pos = (Array*)aParam[1]->var->mObject;
            Array* min_pos = (Array*)aParam[2]->object;
            if (aParam[2]->symbol == SYM_VAR)
                min_pos = (Array*)aParam[2]->var->mObject;
            Array* now_pos = (Array*)aParam[3]->object;
            if (aParam[3]->symbol == SYM_VAR)
                now_pos = (Array*)aParam[3]->var->mObject;
            Array* ret = (Array*)aParam[4]->object;
            if (aParam[4]->symbol == SYM_VAR)
                ret = (Array*)aParam[4]->var->mObject;
            Array* tmp_strides = (Array*)aParam[5]->object;
            if (aParam[5]->symbol == SYM_VAR)
                tmp_strides = (Array*)aParam[5]->var->mObject;
            auto dtype = aParam[6]->var->mContentsInt64;
            auto length = ret->mLength;
            auto len = max_pos->mLength;
            int modify, point, i, idx;
            for (i = 0; i < length; i++)
            {
                modify = 1;
                point = 0;
                while (point < len)
                {
                    now_pos->mItem[point].n_int64 += modify;
                    modify = now_pos->mItem[point].n_int64 / (max_pos->mItem[point].n_int64 + 1);
                    if (modify == 0)
                        break;
                    now_pos->mItem[point].n_int64 = now_pos->mItem[point].n_int64 % max_pos->mItem[point].n_int64 + min_pos->mItem[point].n_int64 - 1;
                    point++;
                }
                idx = 0;
                point = 0;
                while (point < len)
                {
                    idx += tmp_strides->mItem[point].n_int64 * (now_pos->mItem[point].n_int64 - 1);
                    point++;
                }
                auto& p = ret->mItem[i];
                p.symbol = (dtype == 0) ? SYM_INTEGER : SYM_FLOAT;
                (dtype == 0) ? p.n_int64 = arr->mItem[idx].n_int64 : p.n_double = arr->mItem[idx].n_double;
            }
        }
        */
        if c_array.array_equal(c_array.array_strides(shape), strides)
            return _array
        dtype := (dtype = "int") ? 0 : 1
        max_pos :=  c_array.array_flip(shape.clone())
        min_pos := c_array.array_fill(max_pos.length, 1)
        now_pos := c_array.array_fill(max_pos.length, 1)
        now_pos[1] -= 1
        tmp_strides := strides.clone()
        c_array.array_flip(tmp_strides)
        ret := []
        ret.length := _array.length
        _mcode := "2,x64:SIlcJAhVVldBVEFVQVZBV0iD7CBIiwK5BAAAAEiLODlIEHUDSIs/SItCCEyLEDlIEHUDTYsSSItCEEyLODlIEHUDTYs/SItCGEyLGDlIEHUDTYsbSItCIEyLCDlIEHUDTYsJSItCKEiLMDlIEHUDSIs2QYN5KABIi0IwQYtqKEiLCEiLAUiJRCQYD4brAAAARYtpKEj32EUb9kH33kH/xkSJdCRoRTPARTPkx0QkeAEAAACF7XRzTIt0JHgz20mLSyBJY8ZIAQQLSYtLIEmLQiBIiUwkEEiLFAtIiwQDSIlEJAhIiRQkSI1IAUiLwkiZSPf5TIvwhcB0K0iLBCRB/8RJi08gSJlI93wkCEiLRCQQSP/KSAMUGUiJFANIg8MQRDvlcplEi3QkaDPShe10IkiLTiBMi+VJi1sgSCvZiwQL/8gPrwFIjUkQA9BJg+wBdexJi0kgSGPCSMHgBEWJdAgISANHIEiLAEmJBAhJg8AQSYPtAQ+FLf///0iLXCRgSIPEIEFfQV5BXUFcX15dww=="
        fn := native.func(_mcode, 7, 7)
        fn(_array, max_pos, min_pos, now_pos, ret, tmp_strides, dtype)
        return ret
    }
    
    static array_shape(_array)
    {
        /*
        void shape(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)
        {
            Array* arr = (Array*)aParam[0]->object;
            if (aParam[0]->symbol == SYM_VAR)
                arr = (Array*)aParam[0]->var->mObject;
            Array* ret = (Array*)aParam[1]->object;
            if (aParam[1]->symbol == SYM_VAR)
                ret = (Array*)aParam[1]->var->mObject;
            int idx = 0;
            Array* tmp = arr;
            while (tmp->mItem[0].symbol == SYM_OBJECT)
            {
                auto& p = ret->mItem[idx];
                p.symbol = SYM_INTEGER;
                p.n_int64 = tmp->mLength;
                tmp = (Array*)tmp->mItem[0].object;
                idx++;
            }
            auto& p = ret->mItem[idx];
            p.symbol = SYM_INTEGER;
            p.n_int64 = tmp->mLength;
        }
        */
        shape := []
        shape.length := c_array.array_ndim(_array)
        _mcode := "2,x64:SIsCg3gQBEyLAHUDTYsASItCCIN4EARIixB1A0iLEkmLQCBFM8mDeAgFdTJFi9GQSItKIE2NUhBB/8FCx0QR+AEAAABBi0AoSolEEfBJi0AgTIsASYtAIIN4CAV00kljyUjB4QRIA0ogx0EIAQAAAEGLQChIiQHD"
        fn := native.func(_mcode, 2, 2)
        fn(_array, shape)
        return shape
    }
    
    static array_strides(shape)
    {
        /*
        void strides(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)
        {
            Array* shape = (Array*)aParam[0]->object;
            if (aParam[0]->symbol == SYM_VAR)
                shape = (Array*)aParam[0]->var->mObject;
            Array* ret = (Array*)aParam[1]->object;
            if (aParam[1]->symbol == SYM_VAR)
                ret = (Array*)aParam[1]->var->mObject;
            auto len = shape->mLength;
            auto& p = ret->mItem[len - 1];
            p.symbol = SYM_INTEGER;
            p.n_int64 = 1;
            for (int i = len - 2; i >= 0; i--)
            {
                auto& p = ret->mItem[i];
                p.symbol = SYM_INTEGER;
                p.n_int64 = ret->mItem[i + 1].n_int64 * shape->mItem[i + 1].n_int64;
            }
        }
        */
        strides := []
        strides.length := shape.length
        _mcode := "2,x64:SIlcJAhIiXwkEEiLAoN4EARIixh1A0iLG0iLQgiDeBAETIsYdQNNixuLUyiNQv6NSv9IY/hIweEESQNLIMdBCAEAAABIxwEBAAAAhcB4NkyNVwFJweIETYtDIE2NUvBDx0QQCAEAAABJi0MgSItLIEmLVAIQSg+vVBEQSIPvAUuJFBB50kiLXCQISIt8JBDD"
        fn := native.func(_mcode, 2, 2)
        fn(shape, strides)
        return strides
    }
    
    static array_swap(_array, index1, index2, dtype := "int")
    {
        dtype := (dtype = "int") ? 0 : 1
        _mcode := "2,x64:SIsCTIvag3gQBEyLAHUDTYsASItCCEiLCEiLQhBJi1AgTIsJSIsITQPJSYtDGEyLEUiLCE0D0kiDOQBKi0TS8HUUSmNMyvBKiUTK8EmLQCBKiUzQ8MPyQg8QRMrwSolEyvBJi0Ag8kIPEUTQ8MM="
        fn := native.func(_mcode, 4, 4)
        fn(_array, index1, index2, dtype)
        return _array
    }
}

#Include <numahk\base\const>
#Include <numahk\base\native>

class c_array
{
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
    
    static array_flatten(_array, dtype := numahk_const.float64)
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
            Array* now_pos = (Array*)aParam[2]->object;
            if (aParam[2]->symbol == SYM_VAR)
                now_pos = (Array*)aParam[2]->var->mObject;
            Array* ret = (Array*)aParam[3]->object;
            if (aParam[3]->symbol == SYM_VAR)
                ret = (Array*)aParam[3]->var->mObject;
            auto dtype = aParam[4]->var->mContentsInt64;
            auto length = ret->mLength;
            auto len = max_pos->mLength;
            int modify, point, i, idx;
            Array* tmp;
            for (i = 0; i < length; i++)
            {
                point = 0;
                while (point < len)
                {
                    now_pos->mItem[point].n_int64 += 1;
                    if (now_pos->mItem[point].n_int64 < (max_pos->mItem[point].n_int64 + 1))
                        break;
                    now_pos->mItem[point].n_int64 = 1;
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
                if (dtype == 0)
                {
                    p.symbol = SYM_INTEGER;
                    p.n_int64 = (tmp->mItem[idx].symbol == SYM_INTEGER) ? tmp->mItem[idx].n_int64 : (__int64)tmp->mItem[idx].n_double;
                }
                else
                {
                    p.symbol = SYM_FLOAT;
                    p.n_double = (tmp->mItem[idx].symbol == SYM_FLOAT) ? tmp->mItem[idx].n_double : (double)tmp->mItem[idx].n_int64;
                }
            }
        }
        */
        switch dtype
        {
            case 0,1,2,3,4,5,6,7,15: dtype := 0
            case 8,9,10,11,12,13,14: dtype := 1
        }
        shape := c_array.array_shape(_array)
        max_pos :=  c_array.array_flip(shape.clone())
        now_pos := c_array.array_fill(max_pos.length, 1)
        now_pos[1] -= 1
        ret := []
        ret.length := c_array.array_product(max_pos)
        _mcode := "2,x64:SIlcJBhIiXwkIEFUQVZBV0iLAoN4EARMizB1A02LNkiLQgiDeBAESIs4dQNIiz9Ii0IQg3gQBEyLGHUDTYsbSItCGIN4EARMizh1A02LP0iLQiBIY18oSIsITIshQYtPKIXJD4QVAQAASIlsJCBFM9JIiXQkKIvpSI1z/w8fQABFM8CF23Q6M9IPH4AAAAAASYtDIEj/BAJIi0cgTYtLIEiLDAJI/8FKOQwKfBRKxwQKAQAAAEH/wEiDwhBEO8Nyz02LzkyLxkiF9n4vSIvWSMHiBEkDUyBmDx+EAAAAAABIYwpIjVLwSYtBIEgDyUn/yEyLTMjwTYXAf+VJi0MgSYtXIEhjCEgDyU2F5HUsQcdEEggBAAAASYtBIIN8yPgBdQtMi0TI8E2JBBLrOfJMDyxEyPBNiQQS6yxBx0QSCAIAAABJi0Egg3zI+AJ1CPIPEETI8OsKD1fA8kgPKkTI8PJBDxEEEkmDwhBIg+0BD4UM////SIt0JChIi2wkIEiLXCQwSIt8JDhBX0FeQVzD"
        fn := native.func(_mcode, 5, 5)
        fn(_array, max_pos, now_pos, ret, dtype)
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
    
    static array_strides(shape, dtype)
    {
        _dict := map("int8",1,"uint8",1,"int16",2,"uint16",2,"int32",4,"uint32",4,"int64",8,"uint64",8,"float32",4,"float64",8,"bool_",1)
        dtype := (dtype is string) ? _dict[dtype] : dtype
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
            p.n_int64 = aParam[2]->var->mContentsInt64;
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
        _mcode := "2,x64:SIlcJAhIiXwkEEiLAkyLyoN4EARIizh1A0iLP0iLQgiDeBAETIsYdQNNixtEi0coQY1Q/0jB4gRJA1Mgx0IIAQAAAEmLQRBIiwhIiwFIiQJBjUD+SGPYhcB4NkiNQwFIweAETYtLIEiNQPBBx0QBCAEAAABJi0sgSItXIEyLRAgQTA+vRBAQSIPrAU2JBAF50kiLXCQISIt8JBDD"
        fn := native.func(_mcode, 3, 3)
        fn(shape, strides, dtype)
        return strides
    }
    
    static to_c_array(_array, dtype := numahk_const.float64)
    {
        if dtype is string
            dtype := numahk_const.%dtype%
        if c_array.array_ndim(_array) = 1
            return dllcall("Numahk\NDArray_Init", "ptr", numget(objptr(_array), 0x20, "int"), "int", _array.length, "int", dtype, "ptr")
        else
        {
            tmp := c_array.array_flatten(_array, dtype)
            ret := dllcall("Numahk\NDArray_Init", "ptr", numget(objptr(tmp), 0x20, "int"), "int", tmp.length, "int", dtype, "ptr")
            tmp := []
            return ret
        }
    }
}
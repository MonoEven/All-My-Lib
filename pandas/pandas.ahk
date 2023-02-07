; Author: Mono
; Time: 2022.11.08
; Version: 1.0.0

#Include <numahk\numahk>

class pandas
{
    ; csv
    static read_csv(filename, options*)
    {
        
    }
    
    class DataFrame
    {
        static print_sep := "          "
        ; Basic
        __new(data, index := 1.._, columns := 1.._, copy := false)
        {
            global _pandas_DataFrame_tmp_var
            this.columns := []
            this.data := this.to_ndarray(data)
            _pandas_DataFrame_tmp_var := this.data.shape[1]
            this.idx := range((1._._pandas_DataFrame_tmp_var).range*).array()
            if index != 1.._
            {
                for i in index
                {
                    if A_Index > this.idx.length
                        break
                    this.idx[A_Index] := i
                }
            }
            _pandas_DataFrame_tmp_var := this.data.shape[2]
            _columns := range((1._._pandas_DataFrame_tmp_var).range*).array()
            if columns != 1.._
            {
                for i in columns
                {
                    if A_Index > _columns.length
                        break
                    _columns[A_Index] := i
                }
            }
            for i in this.columns
            {
                if A_Index > _columns.length
                    break
                _columns[A_Index] := i
            }
            this.columns := _columns
        }
        
        get_single_loc(index)
        {
            _index := (index is number) ? index : this.idx.index(index)
            ret := ""
            if _index = -1
                return "cann't find name: {}".format(index)
            for i in this.data[_index]
                ret .= "{}`t{}`n".format(this.columns[A_Index], i)
            ret .= "name: {}".format(this.idx[_index])
            return ret
        }
        
        get_loc(index)
        {
            ret := "DataFrame: "
            if !(index is array)
                ret .= "`n{}".format(this.get_single_loc(index))
            else
            {
                for i in index
                    ret .= "`n{}".format(this.get_single_loc(i))
            }
            return ret
        }
        
        loc[index]
        {
            get => this.get_loc(index)
        }
        
        to_ndarray(data)
        {
            if type(data) = "Numahk.NDArray"
                data := numahk.array(data)
            else if type(data) = "Array"
                data := numahk.array(data)
            else if type(data) = "Map"
            {
                tmp_data := []
                for i, j in data
                {
                    this.columns.push(i)
                    tmp_data.push(j)
                }
                data := numahk.array(tmp_data).T
            }
            else if type(data) = "Object"
            {
                tmp_data := []
                for i, j in data.ownprops()
                {
                    this.columns.push(i)
                    tmp_data.push(j)
                }
                data := numahk.array(tmp_data).T
            }
            return data
        }
        
        tostring()
        {
            ret := "DataFrame: `n "
            for i in this.columns
                ret .= "`t{}".format(i)
            for i in this.idx
            {
                ret .= "`n{}".format(i)
                for j in this.data[A_Index]
                    ret .= "`t{}{}".format(j, pandas.DataFrame.print_sep)
            }
            return ret
        }
    }
    
    class open
    {
        __new(filename, flags, encoding := "utf-8")
        {
            this.filename := filename
            this.flags := flags
            this.encoding := encoding
        }
        
        __enter()
        {
            this.file := fileopen(this.filename, this.flags, this.encoding)
            return this.file
        }
        
        __exit()
        {
            this.file.close()
        }
    }
}

data := {
  calories: [420, 380, 390],
  duration: [50, 40, 45]
}
df := pandas.DataFrame(data, ["day1", "day2", "day3"])
debug df.data
debug df.loc[["day", "day1", "day4"]]
debug df
with pandas.open(A_Desktop "\test.ahk", "r"), &f
debug f.readline()
_with()
class byref
{
    __new(var)
    {
        err := error("", 3)
        regmatch := "byref\((.*?)\)"
        regexmatch(err.stack, regmatch, &var)
        this.var_name := var[1]
        this.isvar := ""
        this.initvar := this.get(&flag)
        this.isvar := flag
    }
    
    get(&flag := true)
    {
        if this.isvar == "" || this.isvar
        {
            try
            {
                lst_name := strsplit(this.var_name, ".")
                tmp := %lst_name[1]%
                loop lst_name.length - 1
                    tmp := tmp.%lst_name[a_index + 1]%
                flag := true
                return tmp
            }
            catch
                flag := false
        }
        else
            throw error(this.var_name " is not a var")
    }
    
    set(value)
    {
        global
        if !this.isvar
            throw error(this.var_name " is not a var")
        lst_name := strsplit(this.var_name, ".")
        if lst_name.length == 1
            %lst_name[1]% := value
        else
        {
            tmp := %lst_name[1]%
            loop lst_name.length - 2
                tmp := tmp.%lst_name[a_index + 1]%
            tmp.%lst_name[-1]% := value
        }
        before_value := this.initvar
        this.initvar := value
        return before_value
    }
}

class num_ber
{
    class hello
    {
        static var := 1
    }
}

b := byref(num_ber.hello.var)

add(num)
{
    num.set(num.get() + 1)
}

add(b)
msgbox num_ber.hello.var

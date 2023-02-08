#Include <data\debug>

class vector extends array
{
    _type := "any"
    static type := "any"
    
    __new(param*)
    {
        if (param.length == 1) && (param[1] is vector)
        {
            this._type := param[1]._type
            this.push(param[1]*)
        }
        else if vector.type = "any"
            this.push(param*)
        else
        {
            this._type := vector.type
            if (param[1] is integer) && this.istype(param[2])
            {
                loop param[1]
                    this.push(param[2])
            }
            else
                this.push(param*)
        }
        vector.type := "any"
    }
    
    at(index)
    {
        return this[index]
    }
    
    check()
    {
        for i in this
        {
            if !this.istype(i)
                return false
        }
        return true
    }
    
    empty()
    {
        return this.length == 0
    }
    
    equal(vec)
    {
        for i in vec
        {
            if i != this[A_Index]
                return false
        }
        return true
    }
    
    error(number := 1, errmsg := -1)
    {
        switch number
        {
            case 1: throw TypeError(format("Type {} needed, but {} got.", this._type, errmsg))
        }
    }
    
    istype(data)
    {
        _type_map := map("char*", "string", "double", "float", "int", "integer", "str", "string")
        if this._type = "char"
        {
            if strlen(data) = 1 && ord("a") <= ord(data) && ord(data) <= ord("z")
                return true
            return false
        }
        else if _type_map.has(this._type)
            return data is this.quote(_type_map[this._type])
        else
            return data is this.quote(this._type)
    }
    
    pop_back()
    {
        data := this.pop()
        return data
    }
    
    push_back(data)
    {
        if !this.istype(data)
            this.error(1, type(data))
        this.push(data)
    }
    
    quote(classname)
    {
        classarr := strsplit(classname, ".")
        tmp := %classarr[1]%
        loop classarr.length - 1
            tmp := tmp.%classarr[2]%
        return tmp
    }
    
    size()
    {
        return this.length
    }
    
    tostring()
    {
        tmp := this.clone()
        if tmp.length < 1
            tmp.insertat(1, "")
        plus := ""
        text := "type: vector`n"
        text .= format("value_type: {}`n", this._type)
        text .= "value: [" . debug.tostring(tmp[1])
        Loop tmp.length - 1
            plus .= "," . debug.tostring(tmp[A_Index + 1])
        text .= plus
        text .= "]"
        return text
    }
    
    static settype(_type := "any")
    {
        vector.type := _type
    }
}

vector_char(param*)
{
    vector.type := "char"
    return vector(param*)
}

vector_double(param*)
{
    vector.type := "double"
    return vector(param*)
}

vector_float(param*)
{
    vector.type := "float"
    return vector(param*)
}

vector_int(param*)
{
    vector.type := "int"
    return vector(param*)
}

vector_str(param*)
{
    vector.type := "string"
    return vector(param*)
}
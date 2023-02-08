#Include <std\init>

class wmi
{
    class wmi_enum
    {
        __init()
        {
            this.wmi := comobjget("winmgmts:")
        }
        
        __new(wmi_name, wmi_enum)
        {
            this.wmi_name := wmi_name
            this.wmi_enum := wmi_enum
        }
    
        __get(name, params)
        {
            if this.wmi_enum.count = 1
            {
                for i in this.wmi_enum
                    return i.%name%
            }
            wmi_ret_arr := []
            for i in this.wmi_enum
                wmi_ret_arr.push(i.%name%)
            return wmi_ret_arr
        }
        
        enum()
        {
            return this.wmi_enum
        }
    }
    
    __init()
    {
        this.wmi := comobjget("winmgmts:")
    }
    
    __new(wmi_name)
    {
        this.com_object := this.wmi.instancesof(wmi_name)
        this.wmi_name := wmi_name
    }
    
    __get(name, params)
    {
        if name = "_"
            return wmi.wmi_enum(this.wmi_name, this.select(name))  
        if !params.length
            return this.get_method(name)
        wmi_des := format("{}={}", name, params[1])
        return wmi.wmi_enum(this.wmi_name, this.select(wmi_des))
    }
    
    __call(name, params)
    {
        if name = "_"
            return wmi.wmi_enum(this.wmi_name, this.select(name))  
        if !params.length
            return this.get_method(name)
        wmi_des := format("{}={}", name, params[1])
        return wmi.wmi_enum(this.wmi_name, this.select(wmi_des))
    }
    
    __len()
    {
        return this.com_object.count
    }
    
    __item[prop_name]
    {
        get => this.get_method(prop_name)
    }
    
    enum()
    {
        return this.select("_")
    }
    
    get_method(prop_name)
    {
        if this.com_object.count = 1
            {
                for i in this.com_object
                    return i.%prop_name%
            }
            wmi_ret_arr := []
            for i in this.com_object
                wmi_ret_arr.push(i.%prop_name%)
            return wmi_ret_arr
    }
    
    select(description)
    {
        if description = "_"
            return this.wmi.execquery(format("select * from {}", this.wmi_name))
        wmi_sql := format("select * from {} where {}", this.wmi_name, description)
        return this.wmi.execquery(wmi_sql)
    }
    
    tostring()
    {
        return format("wmi_name={}", this.wmi_name)
    }
    
    static __version()
    {
        return "1.0.0"
    }
}
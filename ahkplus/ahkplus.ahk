class ahkplus
{
    static defprop := (this, args*) => any.defineprop.bind(args*)()
    static delprop := (this, args*) => any.deleteprop.bind(args*)()
    
    static defprops(obj, props)
    {
        for name, value in props.ownprops()
        {
            if ahkplus.isdesc(value)
                ahkplus.defprop(obj, name, value)
            else
                ahkplus.defprop(obj, name, {value: value})
        }
    }
    
    static deref(ref_var)
    {
        if ref_var is varref
            return strget(numget(objptr(ref_var), (a_ptrsize = 4) ? 64 : 56, 'ptr'))
    }
    
    static freeze(obj)
    {
        newObj := {}
        for propname in obj.ownprops()
        {
            desc := obj.getownpropdesc(propname)
            if hasprop(desc, "call")
            {
                ahkplus.defprop(newObj, propname, desc)
                continue
            }
            if hasprop(desc, "set")
                ahkplus.delprop(desc, "set")
            if hasprop(desc, "get")
            {
                ahkplus.defprop(newObj, propname, desc)
                continue
            }
            if hasprop(desc, "value")
                desc := {get: ((this, value) => value).bind(, desc.value)}
            if !hasprop(desc, "get")
                desc := {get: ((this) => "")}
            ahkplus.defprop(newObj, propname, desc)
        }
        return newObj
    }
    
    static hookcall(obj, func_type := 0, hook_name := "last_hook")
    {
        if !obj.hasprop("call")
            return false
        if (obj is class && obj.call.hasprop(hook_name)) || obj.hasprop(hook_name)
            return true
        if obj is class
        {
            obj := obj.call
            func_type := 1
        }
        if obj.hasprop("call")
        {
            switch func_type
            {
                case 0:
                {
                    try
                    {
                        ahkplus.defprop(obj, hook_name, {value: []})
                        ahkplus.defprop(obj, "call", {call: (fn, args*) => (tmp := (func.prototype.call)(obj, args*), obj.last_hook := args, tmp)})
                        return true
                    }
                }
                case 1:
                {
                    try
                    {
                        ahkplus.defprop(obj, hook_name, {value: []})
                        ahkplus.defprop(obj, "call", {call: (fn, cls, args*) => (tmp := (func.prototype.call)(obj, cls, args*), obj.last_hook := args, tmp)})
                        return true
                    }
                }
            }
        }
        return false
    }
    
    static isdesc(desc)
    {
        static names := ["get", "set", "value", "call"]
        static array_in(child, array)
        {
            for value in array
            {
                if value = child
                    return true
            }
            return false
        }
        flags := map()
        if !(desc is object) || !objownpropcount(desc)
            return false
        for name, value in desc.ownprops()
        {
            if !array_in(name, names)
                return false
            else
            {
                if name != "value" && !(value is func)
                    return false
                flags[name] := true
            }
            if flags.has("value") && (flags.has("get") || flags.has("set"))
                return false
            if flags.has("call") && flags.count > 1
                return false
        }
        return true
    }
    
    static unbind(boundfunc)
    {
        unbind_array := [boundfunc]
        if boundfunc is func and boundfunc.__class = "boundfunc"
        {
            while unbind_array[1].isvariadic && !unbind_array[1].isbuiltin
            {
                tmp_array := [objfromptraddref(numget(objptr(unbind_array[1]), 5 * a_ptrsize + 0x10, "ptr")), objfromptraddref(numget(objptr(unbind_array[1]), 7 * a_ptrsize + 0x10, "ptr"))*]
                unbind_array[1] := tmp_array.removeat(1)
                unbind_array.insertat(2, tmp_array*)
            }
        }
        return unbind_array
    }
    
    static unhook(obj, hook_name := "last_hook")
    {
        if !obj.hasprop("call")
            return true
        if (obj is class && !obj.call.hasprop(hook_name)) || (!obj is class && !obj.hasprop(hook_name))
            return true
        if obj is class
        {
            try
            {
                obj.call.%hook_name% := unset
                ahkplus.delprop(obj.call, hook_name)
                ahkplus.defprop(obj.call, "call", {call: (fn, cls, args*) => (func.prototype.call)(obj.call, cls, args*)})
                return true
            }
        }
        else if obj.hasprop("call")
        {
            try
            {
                obj.call.%hook_name% := unset
                ahkplus.delprop(obj, hook_name)
                ahkplus.defprop(obj, "call", {call: (fn, args*) => (func.prototype.call)(obj, args*)})
                return true
            }
        }
        return false
    }
    
    static __get(name, param)
    {
        try
        {
            if %name% is class
                return ahkplus.any(%name%.prototype)
        }
    }
    
    class any
    {
        __new(class)
        {
            this.class := class
        }
        
        self
        {
            get => this.class
        }
        
        register(name, func, type := "call")
        {
            try
            {
                ahkplus.defprop(this.self, name, {%type%: func})
                return true
            }
            return false
        }
        
        unregister(name)
        {
            try
            {
                ahkplus.delprop(this.self, name)
                return true
            }
            return false
        }
        
        static register(name, func, type := "call")
        {
            try
            {
                ahkplus.defprop(any.prototype, name, {%type%: func})
                return true
            }
            return false
        }
        
        static unregister(name)
        {
            try
            {
                ahkplus.delprop(any.prototype, name)
                return true
            }
            return false
        }
    }
}

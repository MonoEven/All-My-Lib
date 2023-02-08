#Include <tkinter\tk>
#Include <tkinter\tcl>
; #Include <tkinter\twapi>
#Include <thread\thread>

class tkinter extends ttk
{
    static total_func := []
    
    static func_dev(index_param, init_param := tkinter.None(), params*)
    {
        map_param := map()
        if !(init_param is tkinter.None)
        {
            for index, param in index_param
                map_param[param] := init_param[index]
        }
        for index, param in params
        {
            if param is map
            {
                for key, value in param
                {
                    if key = "bg"
                        key := "background"
                    else if key = "fg"
                        key := "foreground"
                    map_param[key] := value
                }
            }
            else if param is object
            {
                for key, value in param.ownprops()
                {
                    if key = "bg"
                        key := "background"
                    else if key = "fg"
                        key := "foreground"
                    map_param[key] := value
                }
            }
            else
            {
                if index > index_param.length
                    continue
                map_param[index_param[index]] := param
            }
        }
        return map_param
    }
    
    static options_dev(map_options, _tk := tkinter.None(), func_name := "")
    {
        options := ""
        for key, value in map_options
        {
            if value is string && strreplace(strreplace(strreplace(strreplace(value, "n"), "e"), "w"), "s")
                value := "```"" value "```""
            else if value is func
            {
                if key = "command" && !(_tk is tkinter.None)
                {
                    tmp := callbackcreate(value, "cdel")
                    tkinter.total_func.push(tmp)
                    _tk.script .= format("`nTcl.Tcl_CreateCommand(root.interp, `"func_name{}`", {}, 0, 0)", func_name, tmp)
                    value := "[func_name" func_name "]"
                }
                else
                    value := value.name
            }
            else if value is array
            {
                tmp := "```""
                for i in value
                    tmp .= i " "
                tmp := substr(tmp, 1, strlen(tmp) - 1)
                tmp .= "```""
                value := tmp
            }
            options .= format(" -{} {}", key, value)
        }
        return options
    }
    
    class None
    {
        
    }
    
    class Pack
    {
        
    }
    
    class Tk
    {
        __new(params*)
        {
            this.interp := Tcl.Tcl_CreateInterp()
            map_param := tkinter.func_dev(["screenName", "baseName", "className", "useTk", "sync", "use"], [tkinter.None(), tkinter.None(), 'Tk', true, false, tkinter.None()], params*)
            this.script := format("
            (
            #Include <tkinter\tkinter>
            root := object()
            root.base := tkinter.Tk.ProtoType
            root.interp := {}
            Tcl.Tcl_Init(root.interp)
            Tk.Tk_Init(root.interp)
            root.tkinter_topwin := Tk.Tk_MainWindow(root.interp)
            root.tkinter_topwin_title := "tkinter"
            )", this.interp)
            this.config := map()
            this.widgets := map()
            this.redraw_flag := false
        }
        
        __item[key]
        {
            get
            {
                if key = "bg"
                    key := "background"
                else if key = "fg"
                    key := "foreground"
                return this.config.has(key) ? this.config[key] : tkinter.None()
            }
            set => this.configure(map(key, value))
        }
        
        __call(name, param)
        {
            if substr(name, 1, 6) = "winfo_"
            {
                Tcl.Tcl_Eval(this.interp, format("set tmp_tkinter_winfo [winfo {} . ]", substr(name, 7)))
                return integer(Tcl.Tcl_GetVar(this.interp, "tmp_tkinter_winfo", 0))
            }
        }
        
        attributes(type, typeattr)
        {
            if this.hasprop("threadId")
            {
                Tcl.Tcl_Eval(this.interp, format("wm attributes . {} {}", type, typeattr))
                return
            }
            this.script .= format("`nTcl.Tcl_Eval(root.interp, `"wm attributes . {} {}`")", type, typeattr)
        }
        
        configure(param*)
        {
            this.config := tkinter.func_dev(["class", "compound", "cursor", "image", "style", "takefocus", "text", "textvariable", "underline", "width"].push(["anchor", "background", "font", "foreground", "justify", "padding", "relief", "wraplength"]*), , param*)
            script := tkinter.options_dev(this.config)
            if this.hasprop("threadId")
            {
                Tcl.Tcl_Eval(this.interp, format(". configure{}", script))
                return
            }
            script := format("`nTcl.Tcl_Eval(root.interp, `". configure{}`")", script)
            this.script .= script
        }
        
        deiconify()
        {
            if this.hasprop("threadId")
                Tcl.Tcl_Eval(this.interp, "wm deiconify . ")
            else
                this.script .= "`nTcl.Tcl_Eval(root.interp, `"wm deiconify . `")"
        }
        
        geometry(newGeometry := tkinter.None())
        {
            if !(newGeometry is tkinter.None)
            {
                if this.hasprop("threadId")
                {
                    Tcl.Tcl_Eval(this.interp, format("wm geometry . {}", strreplace(newGeometry, "*", "x")))
                    return
                }
                this.script .= format("`nTcl.Tcl_Eval(root.interp, `"wm geometry . {}`")", strreplace(newGeometry, "*", "x"))
            }
        }
        
        iconbitmap(bitmap := tkinter.None(), default := tkinter.None())
        {
            if !(default is tkinter.None)
            {
                if this.hasprop("threadId")
                {
                    Tcl.Tcl_Eval(this.interp, format("wm iconbitmap . -default `"{}`"", strreplace(default, "\", "/")))
                    return
                }
                this.script .= format("`nTcl.Tcl_Eval(root.interp, `"wm iconbitmap . -default ```"{}```"`")", strreplace(default, "\", "/"))
            }
            else if !(bitmap is tkinter.None)
            {
                if this.hasprop("threadId")
                {
                    Tcl.Tcl_Eval(this.interp, format("wm iconbitmap . `"{}`"", strreplace(bitmap, "\", "/")))
                    return
                }
                this.script .= format("`nTcl.Tcl_Eval(root.interp, `"wm iconbitmap . ```"{}```"`")", strreplace(bitmap, "\", "/"))
            }
        }
        
        iconify()
        {
            if this.hasprop("threadId")
                Tcl.Tcl_Eval(this.interp, "wm iconify . ")
            else
                this.script .= "`nTcl.Tcl_Eval(root.interp, `"wm iconify . `")"
        }
        
        mainloop(sleeptimes := 100)
        {
            if this.hasprop("threadId")
            {
                Tcl.Tcl_Eval(this.interp, "update idletasks")
                return
            }
            script := ""
            for key, value in this.widgets
                script .= value
            this.threadId := ahkThread.newThread(this.script script "`nTcl.Tcl_Eval(root.interp, `"vwait forever`")")
            sleep(sleeptimes)
        }
        
        maxsize(width, heigth)
        {
            if this.hasprop("threadId")
            {
                Tcl.Tcl_Eval(this.interp, format("wm maxsize . {} {}", width, heigth))
                return
            }
            this.script .= format("`nTcl.Tcl_Eval(root.interp, `"wm maxsize . {} {}`")", width, heigth)
        }
        
        minsize(width, heigth)
        {
            if this.hasprop("threadId")
            {
                Tcl.Tcl_Eval(this.interp, format("wm minsize . {} {}", width, heigth))
                return
            }
            this.script .= format("`nTcl.Tcl_Eval(root.interp, `"wm minsize . {} {}`")", width, heigth)
        }
        
        protocol(name, funcname)
        {
            if funcname is func
            {
                tmp := callbackcreate(funcname, "cdel")
                tkinter.total_func.push(tmp)
                funcname := funcname.name
                if this.hasprop("threadId")
                    Tcl.Tcl_CreateCommand(this.interp, funcname, tmp, 0, 0)
                else
                    this.script .= format("`nTcl.Tcl_CreateCommand(root.interp, `"{}`", {}, 0, 0)", funcname, tmp)
            }
            if this.hasprop("threadId")
            {
                Tcl.Tcl_Eval(this.interp, format("wm protocol . {} {}", name, funcname))
                return
            }
            this.script .= format("`nTcl.Tcl_Eval(root.interp, `"wm protocol . {} {}`")", name, funcname)
        }
        
        redraw(close_flag := true, sleeptimes := 100)
        {
            if this.hasprop("threadId")
            {
                if !this.redraw_flag
                {
                    Tcl.Tcl_Eval(this.interp, "update")
                    return
                }
                else
                {
                    if close_flag
                        winclose(this.winfo_id())
                    try
                        Tcl.Tcl_DeleteInterp(this.interp)
                    this.interp := Tcl.Tcl_CreateInterp()
                    this.script := regexreplace(this.script, "root.interp := \d+", "root.interp := " this.interp)
                }
            }
            script := ""
            for key, value in this.widgets
                script .= value
            this.threadId := ahkThread.newThread(this.script script "`nTcl.Tcl_Eval(root.interp, `"vwait forever`")")
            sleep(sleeptimes)
        }
        
        resizable(flag1, flag2)
        {
            if this.hasprop("threadId")
            {
                Tcl.Tcl_Eval(this.interp, format("wm resizable . {} {}", flag1, flag2))
                return
            }
            this.script .= format("`nTcl.Tcl_Eval(root.interp, `"wm resizable . {} {}`")", flag1, flag2)
        }
        
        update(sleeptimes := 100)
        {
            if this.hasprop("threadId")
            {
                Tcl.Tcl_Eval(this.interp, "update")
                return
            }
            script := ""
            for key, value in this.widgets
                script .= value
            this.threadId := ahkThread.newThread(this.script script "`nTcl.Tcl_Eval(root.interp, `"vwait forever`")")
            sleep(sleeptimes)
        }
        
        update_idletasks(sleeptimes := 100)
        {
            if this.hasprop("threadId")
            {
                for key, value in this.widgets
                {
                    if !value[1]
                    {
                        for subfunc in value[-1]
                            subfunc()
                    }
                }
                Tcl.Tcl_Eval(this.interp, "update idletasks")
                return
            }
            script := ""
            for key, value in this.widgets
                script .= value[1]
            this.threadId := ahkThread.newThread(this.script script "`nTcl.Tcl_Eval(root.interp, `"vwait forever`")")
            sleep(sleeptimes)
        }
        
        state(statetype)
        {
            if this.hasprop("threadId")
            {
                Tcl.Tcl_Eval(this.interp, format("wm state . {}", statetype))
                return
            }
            this.script .= format("`nTcl.Tcl_Eval(root.interp, `"wm state . {}`")", statetype)
        }
        
        title(string := tkinter.None())
        {
            if !(string is tkinter.None)
            {
                if this.hasprop("threadId")
                {
                    Tcl.Tcl_Eval(this.interp, format("wm title . `"{}`"", string))
                    this.tkinter_topwin_title := string
                    return
                }
                this.script .= format("`n
                (
                Tcl.Tcl_Eval(root.interp, "wm title . ``"{}``"")
                root.tkinter_topwin_title := "{}"
                )", string, string)
            }
            else
            {
                if this.hasprop("threadId")
                {
                    Tcl.Tcl_Eval(this.interp, format("wm title . `"{}`"", this.tkinter_topwin_title))
                    return
                }
                this.script .= "`nTcl.Tcl_Eval(root.interp, `"wm title . `" root.tkinter_topwin_title)"
            }
        }
    }
}

class ttk
{
    class Button extends ttk.Widget
    {
        static extra := 0
        
        __new(master, param*)
        {
            this.map_param := tkinter.func_dev(["class", "compound", "cursor", "image", "style", "takefocus", "text", "textvariable", "underline", "width"].push(["command", "default"]*), , param*)
            this.master := master
            this.name := "button" ttk.Button.extra++
            script := "ttk::button ." this.name tkinter.options_dev(this.map_param, this.master, this.name)
            if this.master.hasprop("threadId")
                this.master.redraw_flag := true
            this.script := format("`nTcl.Tcl_Eval(root.interp, `"{}`")", script)
            this.master.widgets[this.name] := this.script
        }
        
        configure(param*)
        {
            this.config := tkinter.func_dev(["class", "compound", "cursor", "image", "style", "takefocus", "text", "textvariable", "underline", "width"].push(["command", "default"]*), , param*)
            script := tkinter.options_dev(this.config, this.master, this.name)
            if this.master.hasprop("threadId")
                this.master.redraw_flag := true
            script := format("`nTcl.Tcl_Eval(root.interp, `".{} configure{}`")", this.name, script)
            this.script .= script
            this.master.widgets[this.name] := this.script
        }
    }
    
    class Label extends ttk.Widget
    {
        static extra := 0
        
        __new(master, param*)
        {
            map_param := tkinter.func_dev(["class", "compound", "cursor", "image", "style", "takefocus", "text", "textvariable", "underline", "width"].push(["anchor", "background", "font", "foreground", "justify", "padding", "relief", "wraplength"]*), , param*)
            this.master := master
            this.name := "label" ttk.Label.extra++
            script := "ttk::label ." this.name tkinter.options_dev(map_param)
            if this.master.hasprop("threadId")
                this.master.redraw_flag := true
            this.script := format("`nTcl.Tcl_Eval(root.interp, `"{}`")", script)
            this.master.widgets[this.name] := this.script
        }
        
        configure(param*)
        {
            this.config := tkinter.func_dev(["class", "compound", "cursor", "image", "style", "takefocus", "text", "textvariable", "underline", "width"].push(["anchor", "background", "font", "foreground", "justify", "padding", "relief", "wraplength"]*), , param*)
            script := tkinter.options_dev(this.config)
            if this.master.hasprop("threadId")
                this.master.redraw_flag := true
            script := format("`nTcl.Tcl_Eval(root.interp, `".{} configure{}`")", this.name, script)
            this.script .= script
            this.master.widgets[this.name] := this.script
        }
    }
    
    class Widget
    {
        __item[key]
        {
            get
            {
                if key = "bg"
                    key := "background"
                else if key = "fg"
                    key := "foreground"
                return this.config.has(key) ? this.config[key] : tkinter.None()
            }
            set => this.configure(map(key, value))
        }
        
        __call(name, param)
        {
            if substr(name, 1, 6) = "winfo_"
            {
                Tcl.Tcl_Eval(this.master.interp, format("set tmp_tkinter_winfo [winfo {} .{}]", substr(name, 7), this.name))
                return integer(Tcl.Tcl_GetVar(this.master.interp, "tmp_tkinter_winfo", 0))
            }
        }
        
        grid(param*)
        {
            map_param := tkinter.func_dev(["column", "columnspan", "in", "in_", "ipadx", "ipady", "padx", "pady", "row", "rowspan", "sticky"], , param*)
            script := "grid ." this.name tkinter.options_dev(map_param)
            if this.master.hasprop("threadId")
                this.master.redraw_flag := true
            this.script .= format("`nTcl.Tcl_Eval(root.interp, `"{}`")", script)
            this.master.widgets[this.name] := this.script
        }
    }
}

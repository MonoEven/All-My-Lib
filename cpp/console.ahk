class console
{
    default_args := { w: 700, h: 500, win_name: "console" }
    
    __new(args := {})
    {
        this.args_update(this.default_args, args)
        def_obj := this.default_args
        this.gui := gui("+resize", def_obj.win_name)
        this.gui.setfont("s11","Courier New")
        this.edit := this.gui.add("edit", format("veditBox xs y+0 w{1} h{2} multi", def_obj.w, def_obj.h))
    }
    
    args_update(default_args, args)
    {
        if !(args is object)
            return
        
        for i, j in args.ownprops()
            default_args.%i% := j
    }
}
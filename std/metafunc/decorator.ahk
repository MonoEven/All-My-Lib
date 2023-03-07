decorator(base, _func)
{
    static defprop := {}.defineprop
    defprop(_func, "call", {call: base((func.prototype.call).bind(_func))})
}

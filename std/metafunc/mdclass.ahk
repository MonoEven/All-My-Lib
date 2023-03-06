mdclass(classname, superclass := "", staticAttribute := map(), protoAttribute := map())
{
    static defprop := {}.defineprop
    newclass := class()
    newclass.prototype := superclass = "" ? {__class: classname} : {__class: superclass.prototype.__class "." classname}
    defprop(newclass, "call", {call: (self) => {base: self.prototype}})
    if superclass != ""
        superclass.%classname% := newclass
    for key, value in staticAttribute
        newclass.%key% := value
    for key, value in protoAttribute
        newclass.prototype.%key% := value
    return newclass
}

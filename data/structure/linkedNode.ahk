#Include <data\debug>

class linkedNode
{
    next := 0
    value := 0
    
    __new(value := notype())
    {
        this.value := value
    }
    
    find(value)
    {
        p := this
        while (p && p.value != value)
            p := p.next
        
        return p
    }
    
    remove(value)
    {
        p := this.find(value)
        q := this
        while q.next.value != value
            q := q.next
        q.next := p.next
    }
    
    tostring()
    {
        text := ">> type: linkedNode`n"
        pos := this
        text .= ">> value: "
        while pos
        {
            text .= debug.tostring(pos.value) "-->"
            pos := pos.next
        }
        text .= "NULL"
        
        return text
    }
}
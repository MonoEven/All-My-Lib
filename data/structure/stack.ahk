#Include <data\debug>
#Include <data\structure\linkedNode>

class stack
{
    head := linkedNode()
    length := 0
    
    isempty()
    {
        if !this.head.next
            return true
        
        return false
    }
    
    pop()
    {
        if this.isempty()
            debug(">> stack is empty.`n>> please push some values.")
        else
        {
            node := this.head.next
            value := node.value
            this.head.next := this.head.next.next
            this.length--
            
            return value
        }
    }
    
    push(value)
    {
        node := linkedNode(value)
        node.next := this.head.next
        this.head.next := node
        this.length++
    }
    
    size()
    {
        return this.length
    }
    
    top()
    {
        return this.head.next.value
    }
    
    tostring()
    {
        text := ">> type: stack`n"
        pos := this.head.next
        plus := ""
        text .= ">> value: [" . debug.tostring(this.head.next.value)
        pos := pos.next
        while pos
        {
            plus .= "," . debug.tostring(pos.value)
            pos := pos.next
        }
        text .= plus
        text .= "]"
        
        return text
    }
}
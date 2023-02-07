#Include <data\debug>
#Include <data\structure\linkedNode>

class queue
{
    head := 0
    tail := 0
    
    enque(value)
    {
        node := linkedNode(value)
        
        if !this.tail
        {
            this.tail := node
            this.head := this.tail
        }
        else
        {
            this.tail.next := node
            this.tail := node
        }
    }
    
    deque()
    {
        if this.isempty()
            debug(">> deque is empty.`n>> please enque some values.")
        else
        {
            value := this.head.value
            this.head := this.head.next
            if !this.head
                this.tail := 0
            
            return value
        }
    }
    
    front()
    {
        return this.head.value
    }
    
    isempty()
    {
        if !this.head
            return true
        
        return false
    }
    
    tostring()
    {
        text := ">> type: deque`n"
        pos := this.head
        plus := ""
        text .= ">> value: [" . debug.tostring(this.head.value)
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
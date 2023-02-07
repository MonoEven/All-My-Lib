#Include <data\debug>
#Include <data\structure\linkedNode>

class hashtable
{
    hash := array()
    p := 2
    
    __new(hasharr := array())
    {
        if hasharr.length
            this.create(hasharr)
    }
    
    create(hasharr)
    {
        this.p := this.nextprime(hasharr.length)
        this.hash.length := this.p
        this.hash.default := 0
        for i in hasharr
            this.insert(i)
    }
    
    find(value)
    {
        index := this.hashindex(value)
        p := this.hash[index]
        if !p
            return false
        
        return p.find(value)
    }
    
    hashindex(value)
    {
        return mod(value, this.p) + 1
    }
    
    insert(value)
    {
        index := this.hashindex(value)
        s := linkedNode()
        s.value := value
        s.next := this.hash[index]
        this.hash[index] := s
    }
    
    isprime(n)
    {
        if n == 2
            return true
        
        if n <= 1 || !mod(n, 2)
            return false
        
        q := sqrt(n)
        i := 3
        while i <= q
        {
            if !mod(n, i)
                return false
            
            i += 2
        }
        
        return true
    }
    
    nextprime(n)
    {
        while true
        {
            if this.isprime(n)
                return n
            
            n++
        }
    }
    
    remove(value)
    {
        p := this.find(value)
        if !p
        {
            debug(format(">> value {} isn't in the hashtable.", value))
            
            return false
        }
        
        index := this.hashindex(value)
        q := this.hash[index]
        if (q.value == p.value)
        {
            this.hash[index] := q.next
            
            return true
        }
        q.remove(value)
        
        return true
    }
    
    tostring()
    {
        text := ">> type: hashtable`n"
        text .= ">> value: "
        loop this.p
        {
            text .= format("{}: ", A_Index - 1)
            p := this.hash[A_Index]
            while p
            {
                text .= p.value "-->"
                p := p.next
            }
            text .= "NULL`n"
        }
        
        return text
    }
}

/* test example
a := hashtable([19, 14, 23, 01, 68, 20, 84, 27, 55, 11, 10, 79])
debug(a)
a.remove(30)
debug(a)
*/
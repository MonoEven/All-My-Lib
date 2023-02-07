#Include <data\debug>

class binaryHeap
{
    heap := array()
    capacity := 0
    size := 0
    type := "max"
    
    __new(capacity := 0)
    {
        this.capacity := capacity
        this.size := 0
        this.heap.length := this.capacity
    }
    
    down(start, end)
    {
        c := start
        temp := this.heap[c]
        l := 2 * c
        while (l <= end)
        {
            flag := (this.type = "max") ? (this.heap[l] < this.heap[l + 1]) : (this.heap[l] > this.heap[l + 1])
            if (l < end && flag)
                l++
            flag := (this.type = "max") ? (temp >= this.heap[l]) : (temp <= this.heap[l])
            if flag
                break
            else
            {
                this.heap[c] := this.heap[l]
                c := l
                l *= 2
            }
        }
        this.heap[c] := temp
    }
    
    getIndex(value)
    {
        loop this.size
        {
            if this.heap[A_Index] == value
                return A_Index
            
            return -1
        }
    }
    
    insert(value)
    {
        if (this.size == this.capacity)
        {
            debug(">> heap is full.`n>> please expand the heap.")
            
            return false
        }
        
        this.heap[++this.size] := value
        this.up(this.size)
        
        return true
    }
    
    remove(value)
    {
        index := this.getIndex(value)
        if(index == -1)
        {
            debug(format(">> cann't find value {} in the heap.", value))
            
            return false
        }
        this.heap[index] := this.heap[this.size--]
        this.down(index, this.size) 
        
        return true
    }
    
    tostring()
    {
        text := ">> type: heap`n"
        plus := ""
        text .= ">> value: [" debug.tostring(this.heap[1])
        
        loop this.size - 1
            plus .= "," . debug.tostring(this.heap[A_Index])
        
        text .= plus
        text .= "]"
        
        return text
    }
    
    up(start)
    {
        c := start
        temp := this.heap[c]
        p := c // 2
        while (p > 0)
        {
            flag := (this.type = "max") ? (temp <= this.heap[p]) : (temp >= this.heap[p])
            if flag
                break
            else
            {
                this.heap[c] := this.heap[p]
                c := p
                p //= 2
            } 
        }
        this.heap[c] := temp
    }
}

/* test example
tree := binaryHeap(20)
typeflag := (tree.type = "max") ? "大" : "小"
debug("usage: 1.插入元素  2.删除元素  3.打印最大堆  4.退出")
while true
{
    op := inputbox(format("1.插入元素`n2.删除元素`n3.打印最{}堆`n4.退出`n", typeflag)).value
    if !op
        break
    debug(op)
    if (op==1)
    {
        e := inputbox("输入元素值").value
        if !e
            continue
        debug("输入元素值: " e)
        flag := tree.insert(e)
        debug("---------------")
        debug("插入元素")
        if (flag)
            debug("成功!")
        else
            debug("失败!")
        debug("---------------")
    }
    else if (op==2)
    {
        e := inputbox("输入元素值").value
        if !e
            continue
        debug("输入元素值: " e)
        flag := tree.remove(e)
        debug("---------------")
        debug("删除元素")
        if (flag)
            debug("成功!")
        else
            debug("失败!")
        debug("---------------")			
    }
    else if (op==3)
    {
        debug("---------------")
        debug(tree)
        debug("---------------")
    }
    else
        break
}
*/
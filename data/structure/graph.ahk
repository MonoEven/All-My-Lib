#Include <data\debug>

class vertex
{
    value := 0
    adj := 0
    
    __new(value := notype())
    {
        this.value := value
    }
    
    static create(value)
    {
        vtx := vertex()
        vtx.value := value
        
        return vtx
    }
}

class vertex_adjs
{
    v := vertex()
    next := 0
    
    static create(v)
    {
        v_adj := vertex_adjs()
        v_adj.v := v
        
        return v_adj
    }
    
    static insert(v, adj)
    {
        v_adj := v.adj
        if v_adj
        {
            while v_adj.next
                v_adj := v_adj.next
            v_adj.next := vertex_adjs.create(adj)
        }
        else
            v.adj := vertex_adjs.create(adj)
    }
}

class graph
{
    vxs := array()
    
    tostring()
    {
        text := ">> type: graph`n"
        text .= ">> value: "
        loop this.vxs.length
        {
            v := this.vxs[A_Index]
            text .= format("Vertex[{}]: {} --->", A_Index, v.value)
            adj := v.adj
            while adj
            {
                text .= format(" [{}] ", adj.v.value)
                adj := adj.next
            }
            text .= "`n"
        }
        
        return text
    }
}

/* test example
g := graph()
g.vxs.length := 5
loop 5
    g.vxs[A_Index] := vertex.create(A_Index)
; connect 1 -> 2, 1 -> 4
vertex_adjs.insert(g.vxs[1], g.vxs[2])
vertex_adjs.insert(g.vxs[1], g.vxs[4])

; connect 2 -> 1, 2 -> 3, 2 -> 5, 2 -> 4
vertex_adjs.insert(g.vxs[2], g.vxs[1])
vertex_adjs.insert(g.vxs[2], g.vxs[3])
vertex_adjs.insert(g.vxs[2], g.vxs[5])
vertex_adjs.insert(g.vxs[2], g.vxs[4])

; connect 3 -> 2, 3 -> 5
vertex_adjs.insert(g.vxs[3], g.vxs[2])
vertex_adjs.insert(g.vxs[3], g.vxs[5])

; connect 4 -> 1, 4 -> 2, 4 -> 5
vertex_adjs.insert(g.vxs[4], g.vxs[1])
vertex_adjs.insert(g.vxs[4], g.vxs[2])
vertex_adjs.insert(g.vxs[4], g.vxs[5])

; connect 5 -> 4, 5 -> 2, 5 -> 3
vertex_adjs.insert(g.vxs[5], g.vxs[4])
vertex_adjs.insert(g.vxs[5], g.vxs[2])
vertex_adjs.insert(g.vxs[5], g.vxs[4])

debug(g)
*/
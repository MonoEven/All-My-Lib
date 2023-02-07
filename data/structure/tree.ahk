#Include <data\debug>
#Include <data\structure\queue>

class binaryTree
{
    left := notype()
    right := notype()
    value := notype()
    traversal := "preorder"
    contains_null := 1
    
    static create(levelorder)
    {
        root := binaryTree()
        q := queue()
        q.enque(root)
        i := 2
        size := levelorder.length
        cur := root
        cur.value := levelorder[1]
        while (!q.isempty() && i <= size)
        {
            cur := q.front()
            q.deque()
            if levelorder[i] != "NULL"
            {
                left := binaryTree()
                left.value := levelorder[i]
                cur.left := left
                q.enque(left)
            }
            if (i + 1 <= size)
            {
                i++
                if levelorder[i] != "NULL"
                {
                    right := binaryTree()
                    right.value := levelorder[i]
                    cur.right := right
                    q.enque(right)
                }
            }
            i++
        }
        
        return root
    }
    
    static inpost2tree(inorder, postorder)
    {
        if inorder.length and postorder.length
        {
            tmp := []
            for i in postorder
                tmp.insertat(1, i)
            postorder := tmp
            index := [0]
            d := map()
            loop inorder.Length
                d[inorder[A_Index]] := A_Index - 1
            
            return binaryTree.inpostdfs(inorder, postorder, 0, postorder.Length - 1, d, index)
        }
    }
            
    static inpostdfs(inorder, postorder, start, end, d, index)
    {
        if start <= end
        {
            root := binaryTree()
            root.value := postorder[index[1] + 1]
            mid := d[postorder[index[1] + 1]]
            index[1] += 1
            root.right := binaryTree.inpostdfs(inorder, postorder, mid + 1, end, d, index)
            root.left := binaryTree.inpostdfs(inorder, postorder, start, mid - 1, d, index)
            
            return root
        }
        
        return notype()
    }
    
    static inorder(root)
    {
        if (root is notype)
            return "NULL,"
        
        text := binaryTree.inorder(root.left)
        text .= format("{},", root.value)
        text .= binaryTree.inorder(root.right)
        
        return text
    }
    
    static levelorder(root)
    {
        if (root is notype)
            return "NULL,"
        
        text := ""
        q := queue()
        if !(root is notype)
            q.enque(root)
        while !q.isempty()
        {
            front := q.front()
            q.deque()
            if !(front is notype)
            {
                text .= format("{},", front.value)
                if !(front.left is notype)
                    q.enque(front.left)
                if !(front.right is notype)
                    q.enque(front.right)
            }
        }
        
        return text
    }
    
    static postorder(root)
    {
        if (root is notype)
            return "NULL,"
        
        text := binaryTree.postorder(root.left)
        text .= binaryTree.postorder(root.right)
        text .= format("{},", root.value)
        
        return text
    }
    
    static prein2tree(preorder, inorder)
    {
        preindex := [0]
        ind := map()
        for i, v in inorder
            ind[v] := i - 1
        root := binaryTree.preindc(0, preorder.length - 1, preorder, inorder, ind, preindex)
        
        return root
    }
    
    static preindc(start, end, preorder, inorder, ind, preindex)
    {
        if start <= end
        {
            mid := ind[preorder[preindex[1] + 1]]
            preindex[1] += 1
            root := binaryTree()
            root.value := inorder[mid + 1]
            root.left := binaryTree.preindc(start, mid - 1, preorder, inorder, ind, preindex)
            root.right := binaryTree.preindc(mid + 1, end, preorder, inorder, ind, preindex)
            
            return root
        }
        
        return notype()
    }
    
    static preorder(root)
    {
        if (root is notype)
            return "NULL,"
        
        text := format("{},", root.value)
        text .= binaryTree.preorder(root.left)
        text .= binaryTree.preorder(root.right)
        
        return text
    }
    
    degrees()
    {
        return (this.value is notype) ? 0 : this.left.degrees() + this.right.degrees() + 1
    }
    
    find(value)
    {
        if (this.value is notype)
            return notype()
        
        if (this.value == value)
            return this
        
        if !(this.left is notype)
        {
            lret := this.left.find(value)
            if !(lret is notype)
                return lret
        }
        
        if !(this.right is notype)
        {
            rret := this.right.find(value)
            if !(rret is notype)
                return rret
        }
        
        return notype()
    }
    
    height()
    {
        if (this.value is notype)
            return 0
        
        lt := this.left.height
        rt := this.right.height
        
        return lt > rt ? lt + 1 : rt + 1
    }
    
    iscomplete()
    {
        q := queue()
        if !(this.value is notype)
            q.enque(this)
        while !q.isempty()
        {
            front := q.front()
            q.deque()
            if (front is notype)
                break
            q.enque(front.left)
            q.enque(front.right)
        }
        while !q.isempty()
        {
            front := q.front()
            q.deque()
            if !(front is notype)
                return false
        }
        
        return true
    }
    
    isempty()
    {
        if (this.value is notype)
            return true
        
        return false
    }
    
    leafnodes()
    {
        return (this.value is notype) ? 0 : (this.left is notype and this.right is notype) ? 1 : this.left.leafnodes() + this.right.leafnodes()
    }
    
    kdegrees(k)
    {
        return (this.value is notype) ? 0 : (k == 1) ? 1 : this.left.kdegrees(k - 1) + this.right.kdegrees(k - 1)
    }
    
    remove(value, debugflag := 1)
    {
        if (this.find(value) is notype)
        {
            if debugflag
                debug(format(">> value {} isn't in the tree.", value))
        }
        else
        {
            if this.value == value
            {
                this.value := notype()
                this.left := notype()
                this.right := notype()
            }
            else if !((this.left is notype) && (this.right is notype))
            {
                try
                {
                    if this.left.value == value
                    {
                        this.left := notype()
                        
                        return
                    }
                }
                try
                {
                    if this.right.value == value
                    {
                        this.right := notype()
                        
                        return
                    }
                }
                if !(this.left is notype)
                    this.left.remove(value, 0)
                if !(this.right is notype)
                    this.right.remove(value, 0)
            }
        }
    }
    
    tostring()
    {
        text := ">> type: binaryTree`n"
        text .= format(">> traversal method: {}`n", this.traversal)
        ret := binaryTree.%this.traversal%(this)
        ret := substr(ret, 1, strlen(ret) - 1)
        text .= format(">> value: [{}]", ret)
        if !this.contains_null
        {
            text := strreplace(text, ",NULL", "")
            text := strreplace(text, "NULL,", "")
            text := strreplace(text, "NULL", "")
        }
        
        return text
    }
}

class binarySearchTree extends binaryTree
{
    static insertnode(root, node)
    {
        if (root.value > node.value)
        {
            if (root.left is notype)
                root.left := node
            else
                binarySearchTree.insertnode(root.left, node)
        }
        if (root.value < node.value)
        {
            if (root.right is notype)
                root.right := node
            else
                binarySearchTree.insertnode(root.right, node)
        }
    }
    
    insert(value)
    {
        node := binarySearchTree()
        node.value := value
        if this.value is notype
            this.value := value
        else
            binarySearchTree.insertnode(this, node)
            
        return this
    }
}

class binaryTreadTree extends binaryTree
{
    
}

class trieNode
{
    path := 0
    end := 0
    map := array()

    __new()
    {
        this.path := 0
        this.end := 0
        this.map.length := 26
        this.map.default := 0
    }
}

class trie
{
    root := 0
    
    __new()
    {
        this.root := trieNode()
    }
    
    insert(word)
    {
        word := strlower(word)
        if (!strlen(word))
            return
        
        chs := strsplit(word)
        node := this.root
        node.path++
        index := 0
        loop chs.length
        {
            index := ord(chs[A_Index]) - ord('a') + 1
            if (!node.map[index])
                node.map[index] := trieNode()
            node := node.map[index]
            node.path++
        }
        node.end++
    }
    
    delete(word)
    {
        if (this.search(word))
        {
            chs := strsplit(word)
            node := this.root
            node.path--
            index := 0
            loop chs.length
            {
                index := ord(chs[A_Index]) - ord('a') + 1
                node.map[index].path--
                node := node.map[index]
            }
            node.end--
        }
    }
    
    search(word)
    {
        word := strlower(word)
        if (!strlen(word))
            return false
        
        chs := strsplit(word)
        node := this.root
        index := 0
        loop chs.length
        {
            index := ord(chs[A_Index]) - ord('a') + 1
            if (!node.map[index])
                return false
            node := node.map[index]
        }
        
        return node.end != 0
    }
    
    prefixNumber(pre)
    {
        pre := strlower(pre)
        if (!strlen(pre))
            return 0
        
        chs := strsplit(pre)
        node := this.root
        index := 0
        loop chs.length
        {
            index := ord(chs[A_Index]) - ord('a') + 1
            if (!node.map[index])
                return 0
            node := node.map[index]
        }
        
        return node.path
    }
}

/* test example
n1 := binaryTree()
n2 := binaryTree()
n3 := binaryTree()
n4 := binaryTree()
n5 := binaryTree()
n6 := binaryTree()
n1.value := 1
n2.value := 2
n3.value := 3
n4.value := 4
n5.value := 5
n6.value := 6
n1.left := n2
n1.right := n4
n2.left := n3
n2.right := notype()
n3.left := notype()
n3.right := notype()
n4.left := n5
n4.right := n6
n5.left := notype()
n5.right := notype()
n6.left := notype()
n6.right := notype()
n7 := n1.find(6)
debug(n1)
n1.contains_null := 0
debug(n1)
n1.traversal := "levelorder"
debug(n1)
debug(n7)
debug(n1.iscomplete())
debug(n7.iscomplete())
a := binaryTree.create([5, 3, 6, 2, 4, "NULL", "NULL", 1])
a.traversal := "levelorder"
debug(a)
a.remove(6)
debug(a)

b := binarySearchTree()
b.insert(10)
b.insert(20)
b.insert(30)
b.insert(40)
debug(b)
*/
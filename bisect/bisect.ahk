Class Bisect
{
    Static Bisect := Bisect.Bisect_Right
    Static Insort := Bisect.Insort_Right
    
    Static Bisect_Left(a, x, lo := 1, hi := "")
    {
        lo := lo - 1
        
        if lo < 0
            throw ValueError('lo must be non-negative')
        
        if hi == ""
            hi := a.Length
        
        while lo < hi
        {
            mid := (lo + hi) // 2
            
            if a[mid + 1] < x
                lo := mid + 1
            
            else
                hi := mid
        }
        
        return lo + 1
    }
    
    Static Bisect_Right(a, x, lo := 1, hi := "")
    {
        lo := lo - 1
        
        if lo < 0
            throw ValueError('lo must be non-negative')
        
        if hi == ""
            hi := a.Length
        
        while lo < hi
        {
            mid := (lo + hi) // 2
            
            if x < a[mid + 1]
                hi := mid
            
            else
                lo := mid + 1
        }
        
        return lo + 1
    }
    
    Static Insort_Left(a, x, lo := 1, hi := "")
    {
        lo := Bisect.Bisect_Left(a, x, lo, hi)
        a.InsertAt(lo, x)
    }
    
    Static Insort_Right(a, x, lo := 1, hi := "")
    {
        lo := Bisect.Bisect_Right(a, x, lo, hi)
        a.InsertAt(lo, x)
    }
}
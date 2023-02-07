class filehash
{
    static getvalue(filewhere, type := "SHA1", ret := "common")
    {
        if (type != "MACTripleDES") && (type != "MD5") && (type != "RIPEMD160") && (type != "SHA1") && (type != "SHA256") && (type != "SHA384") && (type != "SHA512")
            return (ret = "full") ? this.sha1(filewhere) : this.sha1(filewhere)["Hash"]
        else
            return (ret = "full") ? this.%type%(filewhere) : this.%type%(filewhere)["Hash"]
    }
    
    static mactripledes(filewhere)
    {
        tmpfile := A_NowUTC ".txt"
        runwait(format("powershell Get-FileHash {}\test.ahk -Algorithm MACTripleDES| Format-List > {}", A_Desktop, tmpfile), , "hide")
        
        return this.retanly(tmpfile)
    }
    
    static md5(filewhere)
    {
        tmpfile := A_NowUTC ".txt"
        runwait(format("powershell Get-FileHash {}\test.ahk -Algorithm MD5| Format-List > {}", A_Desktop, tmpfile), , "hide")
        
        return this.retanly(tmpfile)
    }
    
    static ripemd160(filewhere)
    {
        tmpfile := A_NowUTC ".txt"
        runwait(format("powershell Get-FileHash {} -Algorithm RIPEMD160| Format-List > {}", filewhere, tmpfile), , "hide")
        
        return this.retanly(tmpfile)
    }
    
    static sha1(filewhere)
    {
        tmpfile := A_NowUTC ".txt"
        runwait(format("powershell Get-FileHash {} -Algorithm SHA1| Format-List > {}", filewhere, tmpfile), , "hide")
        
        return this.retanly(tmpfile)
    }
    
    static sha256(filewhere)
    {
        tmpfile := A_NowUTC ".txt"
        runwait(format("powershell Get-FileHash {} -Algorithm SHA256| Format-List > {}", filewhere, tmpfile), , "hide")
        
        return this.retanly(tmpfile)
    }
    
    static sha384(filewhere)
    {
        tmpfile := A_NowUTC ".txt"
        runwait(format("powershell Get-FileHash {} -Algorithm SHA384| Format-List > {}", filewhere, tmpfile), , "hide")
        
        return this.retanly(tmpfile)
    }
    
    static sha512(filewhere)
    {
        tmpfile := A_NowUTC ".txt"
        runwait(format("powershell Get-FileHash {} -Algorithm SHA512| Format-List > {}", filewhere, tmpfile), , "hide")
        
        return this.retanly(tmpfile)
    }
    
    static retanly(tmpfile)
    {
        ret := map()
        if fileexist(tmpfile)
        {
            filehash := fileread(tmpfile)
            ret_arr := strsplit(filehash, "`r`n")
            for i in ret_arr
            {
                if isalpha(i)
                    continue
                tmp := strsplit(i, ":", , 2)
                ret[trim(tmp[1])] := trim(tmp[2])
            }
            filedelete(tmpfile)
        }
        
        return ret
    }
}
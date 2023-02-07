class nt
{
    static O_RDONLY := 0x0
    static O_WRONLY := 0x1
    static O_APPEND := 0x2
    static O_RDWR := 0x3
    static O_EOLN := 0x4
    static O_EOLR := 0x8

    static S_RDONLY := 0x100
    static S_WRONLY := 0x200
    static S_RDWR := 0x400
    
    static linesep := "`r`n"
    static name := "nt"
    static pathsep := ";"
}

class os extends nt
{
    static curdir := os.path.split(a_scriptdir)[2]
    
    static chdir(path)
    {
        try
        {
            setworkingdir(path)
            return true
        }
        catch OSError
            return false
    }
    
    static close(fd)
    {
        return fd.close()
    }
    
    static getcwd()
    {
        return a_workingdir
    }
    
    static listdir(name)
    {
        dir_list := []
        loop files, name "\*.*", "df"
            dir_list.push(a_loopfilename)
        return dir_list
    }
    
    static mkdir(name)
    {
        try
        {
            dircreate(name)
            return true
        }
        catch OSError
            return false
    }
    
    static makedirs(name, exist_ok := false)
    {
        tmp := os.path.split(name)
        head := tmp[1]
        tail := tmp[2]
        if !tail
        {
            tmp := os.path.split(head)
            head := tmp[1]
            tail := tmp[2]
        }
        if head && tail && !os.path.exists(head)
        {
            try
                os.makedirs(head, exist_ok)
            cdir := os.curdir
            if tail == cdir
                return
        }
        try
            os.mkdir(name)
        catch as err
        {
            if !exist_ok || !os.path.isdir(name)
                throw OSError(err.message)
        }
    }
    
    static open(name, mode, encoding := "utf-8")
    {
        return fileopen(name, mode, encoding)
    }
    
    static remove(name)
    {
        try
            filedelete(name)
        catch as err
            throw OSError(err.message)
    }
    
    static removedirs(name)
    {
        os.rmdir(name)
        tmp := os.path.split(name)
        head := tmp[1]
        tail := tmp[2]
        if !tail
        {
            tmp := os.path.split(head)
            head := tmp[1]
            tail := tmp[2]
        }
        while head && tail
        {
            try
                os.rmdir(head)
            catch
                break
            tmp := os.path.split(head)
            head := tmp[1]
            tail := tmp[2]
        }
    }
    
    static rename(src, dst)
    {
        try
            filemove(src, dst)
        catch as err
            throw OSError(err.message)
    }
    
    static renames(old, new)
    {
        tmp := os.path.split(new)
        head := tmp[1]
        tail := tmp[2]
        if head && tail && !os.path.exists(head)
            os.makedirs(head)
        os.rename(old, new)
        tmp := os.path.split(old)
        head := tmp[1]
        tail := tmp[2]
        if head && tail
        {
            try
                os.removedirs(head)
        }
    }
    
    static rmdir(name)
    {
        try
            dirdelete(name)
        catch as err
            throw OSError(err.message)
    }
    
    static stat(name)
    {
        mode := 0
        ino := 0
        dev := 0
        nlink := 0
        uid := 0
        gid := 0
        size := 0
        atime := 0
        mtime := 0
        ctime := 0
        return os.stat_result(mode, ino, dev, nlink, uid, gid, size, atime, mtime, ctime)
    }
    
    static write(fd, content)
    {
        return fd.write(content)
    }
    
    class path
    {
        static exists(name)
        {
            return !!direxist(name)
        }
        
        static isdir(name)
        {
            splitpath(name, &dir)
            return !!dir
        }
        
        static split(name)
        {
            name := strreplace(name, "\", "/")
            while instr(name, "//")
                name := strreplace(name, "//", "/")
            lst_name := strsplit(name, "/")
            lastpath := lst_name[-1]
            subdirpath := substr(name, 1, strlen(name) - strlen(lastpath) - 1)
            return [subdirpath, lastpath]
        }
    }
    
    class stat_result
    {
        __new(mode, ino, dev, nlink, uid, gid, size, atime, mtime, ctime)
        {
            this.mode := mode
            this.ino := ino
            this.dev := dev
            this.nlink := nlink
            this.uid := uid
            this.gid := gid
            this.size := size
            this.atime := atime
            this.mtime := mtime
            this.ctime := ctime
        }
        
        toString()
        {
            return format("os.stat_result(st_mode={}, st_ino={}, st_dev={}, st_nlink={}, st_uid={}, st_gid={}, st_size={}, st_atime={}, st_mtime={}, st_ctime={})", this.mode, this.ino, this.dev, this.nlink, this.uid, this.gid, this.size, this.atime, this.mtime, this.ctime)
        }
    }
}

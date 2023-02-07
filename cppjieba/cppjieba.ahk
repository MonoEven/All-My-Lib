flag := cppJieba.file("cppjieba/dll/Jieba.dll")
if flag
    dllcall("LoadLibrary", "str", flag)
else
    throw error("load dll failure.")

class cppJieba
{
    static segFlag := "/"
    
    static file(filename)
    {
        if !filename
            return false
        if fileexist(filename)
            return filename
        else if fileexist(format("{}\lib\{}", regread("HKLM\SOFTWARE\AutoHotkey", "InstallDir", ""), filename))
            return format("{}\lib\{}", regread("HKLM\SOFTWARE\AutoHotkey", "InstallDir", ""), filename)
        else if fileexist(format("{}\lib\{}", a_scriptdir, filename))
            return format("{}\lib\{}", a_scriptdir, filename)
        else
            return false
    }
    
    __new(DICT_PATH := cppJieba.file("cppjieba/dict/jieba.dict.utf8"), HMM_PATH := cppJieba.file("cppjieba/dict/hmm_model.utf8"), USER_DICT_PATH := cppJieba.file("cppjieba/dict/user.dict.utf8"), IDF_PATH := cppJieba.file("cppjieba/dict/idf.utf8"), STOP_WORD_PATH := cppJieba.file("cppjieba/dict/stop_words.utf8"))
    {
        if !DICT_PATH
            throw error("load DICT_PATH failure.")
        if !HMM_PATH
            throw error("load HMM_PATH failure.")
        if !USER_DICT_PATH
            throw error("load USER_DICT_PATH failure.")
        if !IDF_PATH
            throw error("load IDF_PATH failure.")
        if !STOP_WORD_PATH
            throw error("load STOP_WORD_PATH failure.")
        this.DICT_PATH := cppJieba.strToUtf8(DICT_PATH)
        this.HMM_PATH := cppJieba.strToUtf8(HMM_PATH)
        this.USER_DICT_PATH := cppJieba.strToUtf8(USER_DICT_PATH)
        this.IDF_PATH := cppJieba.strToUtf8(IDF_PATH)
        this.STOP_WORD_PATH := cppJieba.strToUtf8(STOP_WORD_PATH)
        this.loadFlag := false
    }
    
    load()
    {
        this.cppJieba := dllcall("Jieba.dll\init", "ptr", this.DICT_PATH, "ptr", this.HMM_PATH, "ptr", this.USER_DICT_PATH, "ptr", this.IDF_PATH, "ptr", this.STOP_WORD_PATH)
        this.loadFlag := true
    }
    
    cut(str, cut_all := false, hmm_flag := true, segFlag := cppJieba.segFlag)
    {
        lst_str := strsplit(regexreplace(str, "[\pP‘’“”]", "，"), "，")
        if !this.loadFlag
            this.load()
        for i in lst_str
        {
            if !i
                continue
            cutStr := cppJieba.strToUtf8(i)
            if cut_all
                ret .= strget(dllcall("Jieba.dll\cut_all", "ptr", this.cppJieba, "ptr", cutStr, "ptr", cppJieba.strToUtf8(segFlag)), , "utf-8") "/"
            else
                ret .= strget(dllcall("Jieba.dll\cut", "ptr", this.cppJieba, "ptr", cutStr, "int", hmm_flag, "ptr", cppJieba.strToUtf8(segFlag)), , "utf-8") "/"
        }
        return substr(ret, 1, strlen(ret) - 1)
    }
    
    cut_for_search(str, hmm_flag := true, segFlag := cppJieba.segFlag)
    {
        lst_str := strsplit(regexreplace(str, "[\pP‘’“”]", "，"), "，")
        if !this.loadFlag
            this.load()
        for i in lst_str
        {
            if !i
                continue
            cutStr := cppJieba.strToUtf8(i)
            ret .= strget(dllcall("Jieba.dll\cut_for_search", "ptr", this.cppJieba, "ptr", cutStr, "int", hmm_flag, "ptr", cppJieba.strToUtf8(segFlag)), , "utf-8") "/"
        }
        return substr(ret, 1, strlen(ret) - 1)
    }
    
    free()
    {
        try
            dllcall("Jieba.dll\free_jieba", "ptr", this.cppJieba)
    }
    
    load_userdict(path)
    {
        this.cppJieba := dllcall("Jieba.dll\init", "ptr", this.DICT_PATH, "ptr", this.HMM_PATH, "ptr", cppJieba.strToUtf8(path), "ptr", this.IDF_PATH, "ptr", this.STOP_WORD_PATH)
        this.loadFlag := true
    }
    
    __delete()
    {
        this.free()
    }
    
    static strToUtf8(str)
    {
        buf := Buffer(strput(str, "utf-8"))
        strput(str, buf, "utf-8")
        return buf
    }
}
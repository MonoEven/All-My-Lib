#Include <java\base>

class CharacterUtil
{
    static reSkip := Pattern.compile("(\d+\.\d+|[a-zA-Z0-9]+)")
    
    static connectors := ['+', '#', '&', '.', '_', '-']
    
    static isChineseLetter(ch)
    {
        ch := ord(ch)
        if (ch >= 0x4E00 && ch <= 0x9FA5)
            return true
        return false
    }
    
    static isEnglishLetter(ch)
    {
        ch := ord(ch)
        if ((ch >= 0x0041 && ch <= 0x005A) || (ch >= 0x0061 && ch <= 0x007A))
            return true
        return false
    }
    
    static isDigit(ch)
    {
        ch := ord(ch)
        if (ch >= 0x0030 && ch <= 0x0039)
            return true
        return false
    }
    
    static isConnector(ch)
    {
        for connector in CharacterUtil.connectors
        {
            if (ch == connector)
                return true
        }
        return false
    }
    
    static ccFind(ch)
    {
        if (CharacterUtil.isChineseLetter(ch))
            return true
        if (CharacterUtil.isEnglishLetter(ch))
            return true
        if (CharacterUtil.isDigit(ch))
            return true
        if (CharacterUtil.isConnector(ch))
            return true
        return false
    }
    
    static regularize(input)
    {
        _input := ord(input)
        if (_input == 12288)
            return chr(32)
        else if (_input > 65280 && _input < 65375)
            return chr(_input - 65248)
        else if (_input >= ord('A') && _input <= ord('Z'))
            return chr(_input += 32)
        return input
    }
}

class DictSegment
{
    static charMap := HashMap(), charMap.capacity := 16
    
    static ARRAY_LENGTH_LIMIT := 3
    
    __new(nodeChar := Java.Null())
    {
        this.storeSize := 0
        this.nodeState := 0
        this.childrenArray := Java.Null()
        this.childrenMap := Java.Null()
        if (nodeChar is Java.Null)
            throw IllegalArgumentException("Parameter is null exception, character cannot be null.")
        this.nodeChar := nodeChar
    }
    
    compareTo(o)
    {
        if ord(this.nodeChar) == ord(o.nodeChar)
            return 0
        else if ord(this.nodeChar) > ord(o.nodeChar)
            return 1
        else if ord(this.nodeChar) < ord(o.nodeChar)
            return -1
    }
    
    disableSegment(charArray)
    {
        this.fillSegment(charArray, 0, charArray.length, 0)
    }
    
    fillSegment(charArray, begin := 0, length := charArray.length, enabled := 1)
    {
        beginChar := charArray[begin + 1]
        keyChar := DictSegment.charMap.get(beginChar)
        if (keyChar is Java.Null)
        {
            DictSegment.charMap.put(beginChar, beginChar)
            keyChar := beginChar
        }
        
        ds := this.lookforSegment(keyChar, enabled)
        if !(ds is Java.Null)
        {
            if (length > 1)
                ds.fillSegment(charArray, begin + 1, length - 1, enabled)
            else if (length == 1)
                ds.nodeState := enabled
        }
    }
    
    getChildrenArray()
    {
        if (this.childrenArray is Java.Null)
        {
            this.childrenArray := []
            this.childrenArray.length := DictSegment.ARRAY_LENGTH_LIMIT
        }
        return this.childrenArray
    }
    
    getChildrenMap()
    {
        if (this.childrenMap is Java.Null)
            this.childrenMap := HashMap()
        return this.childrenMap
    }
    
    getNodeChar()
    {
        return this.nodeChar
    }
    
    hasNextNode()
    {
        return this.storeSize > 0
    }
    
    lookforSegment(keyChar, create)
    {
        ds := Java.Null()
        
        if (this.storeSize <= DictSegment.ARRAY_LENGTH_LIMIT)
        {
            segmentArray := this.getChildrenArray()
            keySegment := DictSegment(keyChar)
            position := Arrays.binarySearch(segmentArray, 0, this.storeSize, keySegment, "nodeChar", "ord")
            if (position >= 0)
                ds := segmentArray[position + 1]
            
            if (ds is Java.Null && create == 1)
            {
                ds := keySegment
                if (this.storeSize < DictSegment.ARRAY_LENGTH_LIMIT)
                {
                    segmentArray[this.storeSize + 1] := ds
                    this.storeSize++
                    Arrays.sort(segmentArray, 0, this.storeSize, "nodeChar", "ord")
                }
                else
                {
                    segmentMap := this.getChildrenMap()
                    this.migrate(segmentArray, segmentMap)
                    segmentMap.put(keyChar, ds)
                    this.storeSize++
                    this.childrenArray := Java.Null()
                }
            }
        }
        else
        {
            segmentMap := this.getChildrenMap()
            ds := segmentMap.get(keyChar)
            if (ds is Java.Null && create == 1)
            {
                ds := DictSegment(keyChar)
                segmentMap.put(keyChar, ds)
                this.storeSize++
            }
        }
        return ds
    }
    
    match(charArray, begin := 0, length := charArray.length, searchHit := Java.Null())
    {
        if searchHit is Java.Null
        {
            searchHit := Hit()
            searchHit.setBegin(begin)
        }
        else
            searchHit.setUnmatch()
        searchHit.setEnd(begin)
        
        keyChar := charArray[begin + 1]
        ds := Java.Null()
        
        segmentArray := this.childrenArray
        segmentMap := this.childrenMap
        
        if !(segmentArray is Java.Null)
        {
            keySegment := DictSegment(keyChar)
            position := Arrays.binarySearch(segmentArray, 0, this.storeSize, keySegment, "nodeChar", "ord")
            if (position >= 0)
                ds := segmentArray[position + 1]
        }
        else if !(segmentMap is Java.Null)
            ds := segmentMap.get(keyChar)
        
        if !(ds is Java.Null)
        {
            if (length > 1)
                return ds.match(charArray, begin + 1, length - 1, searchHit)
            else if (length == 1)
            {
                if (ds.nodeState == 1)
                    searchHit.setMatch()
                if (ds.hasNextNode())
                {
                    searchHit.setPrefix()
                    searchHit.setMatchedDictSegment(ds)
                }
                return searchHit
            }
        }
        return searchHit
    }
    
    migrate(segmentArray, segmentMap)
    {
        for segment in segmentArray
        {
            if !(segment is Java.Null)
                segmentMap.put(segment.nodeChar, segment)
        }
    }
}

class FinalSeg
{
    static singleInstance := Java.Null()
    
    static PROB_EMIT := "prob_emit.txt"
    
    static states := ['B', 'M', 'E', 'S']
    
    static MIN_FLOAT := -3.14e100
    
    static getInstance()
    {
        if FinalSeg.singleInstance is Java.Null
        {
            FinalSeg.singleInstance := FinalSeg()
            FinalSeg.singleInstance.loadModel()
        }
        return FinalSeg.singleInstance
    }
    
    loadModel()
    {
        s := a_tickcount
        FinalSeg.prevStatus := HashMap()
        FinalSeg.prevStatus.put('B', ['E', 'S'])
        FinalSeg.prevStatus.put('M', ['M', 'B'])
        FinalSeg.prevStatus.put('S', ['S', 'E'])
        FinalSeg.prevStatus.put('E', ['B', 'M'])
        
        FinalSeg.start := HashMap()
        FinalSeg.start.put('B', -0.26268660809250016)
        FinalSeg.start.put('E', -3.14e+100)
        FinalSeg.start.put('M', -3.14e+100)
        FinalSeg.start.put('S', -1.4652633398537678)
        
        FinalSeg.trans := HashMap()
        transB := HashMap()
        transB.put('E', -0.510825623765990)
        transB.put('M', -0.916290731874155)
        FinalSeg.trans.put('B', transB)
        transE := HashMap()
        transE.put('B', -0.5897149736854513)
        transE.put('S', -0.8085250474669937)
        FinalSeg.trans.put('E', transE)
        transM := HashMap()
        transM.put('E', -0.33344856811948514)
        transM.put('M', -1.2603623820268226)
        FinalSeg.trans.put('M', transM)
        transS := HashMap()
        transS.put('B', -0.7211965654669841)
        transS.put('S', -0.6658631448798212)
        FinalSeg.trans.put('S', transS)
        
        try
            _is := Java.getResourceAsStream("jieba", FinalSeg.PROB_EMIT)
        catch
            throw IOException(format("{}: load model failure!", FinalSeg.PROB_EMIT))
        br := _is
        FinalSeg.emit := HashMap()
        values := Java.Null()
        while !br.ateof
        {
            line := br.readline()
            tokens := strsplit(line, "`t")
            if tokens.length == 1
            {
                values := HashMap()
                FinalSeg.emit.put(substr(tokens[1], 1, 1), values)
            }
            else
                values.put(substr(tokens[1], 1, 1), 1.0)
        }
        _is.close()
        return format("model load finished, time elapsed {} ms.", a_tickcount - s)
    }
    
    cut(sentence, tokens)
    {
        chinese := StringBuilder()
        other := StringBuilder()
        sentence := strsplit(sentence)
        for ch in sentence
        {
            if (CharacterUtil.isChineseLetter(ch))
            {
                if (other.length() > 0)
                {
                    this.processOtherUnknownWords(other.toString(), tokens)
                    other := StringBuilder()
                }
                chinese.append(ch)
            }
            else
            {
                if (chinese.length() > 0)
                {
                    this.viterbi(chinese.toString(), tokens)
                    chinese := StringBuilder()
                }
                other.append(ch)
            }
        }
        if (chinese.length() > 0)
            this.viterbi(chinese.toString(), tokens)
        else
            this.processOtherUnknownWords(other.toString(), tokens)
    }
    
    viterbi(sentence, tokens)
    {
        v := ArrayList()
        path := HashMap()
        
        v.add(HashMap())
        for state in FinalSeg.states
        {
            emP := FinalSeg.emit.get(state).get(substr(sentence, 1, 1))
            if emP is Java.Null
                emP := FinalSeg.MIN_FLOAT
            v.get(0).put(state, FinalSeg.start.get(state) + emP)
            path.put(state, Node(state, Java.Null()))
        }
        
        loop strlen(sentence) - 1
        {
            i := a_index
            vv := HashMap()
            v.add(vv)
            newPath := HashMap()
            for y in FinalSeg.states
            {
                emp := FinalSeg.emit.get(y).get(substr(sentence, i + 1, 1))
                if (emp is Java.Null)
                    emp := FinalSeg.MIN_FLOAT
                candidate := Java.Null()
                for y0 in FinalSeg.prevStatus.get(y)
                {
                    tranp := FinalSeg.trans.get(y0).get(y)
                    if (tranp is Java.Null)
                        tranp := FinalSeg.MIN_FLOAT
                    tranp += (emp + v.get(i - 1).get(y0))
                    if (candidate is Java.Null)
                        candidate := Pair(y0, tranp)
                    else if (candidate.freq <= tranp)
                    {
                        candidate.freq := tranp
                        candidate.key := y0
                    }
                }
                vv.put(y, candidate.freq)
                newPath.put(y, Node(y, path.get(candidate.key)))
            }
            path := newPath
        }
        probE := v.get(strlen(sentence) - 1).get('E')
        probS := v.get(strlen(sentence) - 1).get('S')
        posList := ArrayList()
        if (probE < probS)
            win := path.get('S')
        else
            win := path.get('E')
        while !(win is Java.Null)
        {
            posList.add(win.value)
            win := win.parent
        }
        Collections.reverse(posList)
        
        begin := 0
        next := 0
        loop strlen(sentence)
        {
            i := a_index - 1
            pos := posList.get(i)
            if (pos == 'B')
                begin := i
            else if (pos == 'E')
            {
                tokens.add(substr(sentence, begin + 1, i + 1 - begin))
                next := i + 1
            }
            else if (pos == 'S')
            {
                tokens.add(substr(sentence, i + 1, 1))
                next := i + 1
            }
        }
        if (next < strlen(sentence))
            tokens.add(substr(sentence, next + 1))
    }
    
    processOtherUnknownWords(other, tokens)
    {
        mat := CharacterUtil.reSkip.matcher(other)
        offset := 0
        while (mat.find())
        {
            if (mat.start() > offset)
                tokens.add(substr(other, offset + 1, mat.start() - offset))
            tokens.add(mat.group())
            offset := mat.end()
        }
        if (offset < strlen(other))
            tokens.add(substr(other, offset + 1))
    }
}

class Hit
{
    static UNMATCH := 0x00000000
    
    static MATCH := 0x00000001
    
    static PREFIX := 0x00000010
    
    hitState := Hit.UNMATCH
    
    matchedDictSegment := Java.Null()
    
    begin := Java.Null()
    
    end := Java.Null()
    
    isMatch()
    {
        return (this.hitState & Hit.MATCH) > 0
    }
    
    setMatch()
    {
        this.hitState := (this.hitState | Hit.MATCH)
    }
    
    isPrefix()
    {
        return (this.hitState & Hit.PREFIX) > 0
    }
    
    setPrefix()
    {
        this.hitState := (this.hitState | Hit.PREFIX)
    }
    
    isUnmatch()
    {
        return this.hitState == Hit.UNMATCH
    }
    
    setUnmatch()
    {
        this.hitState := Hit.UNMATCH
    }
    
    getMatchedDictSegment()
    {
        return Hit.matchedDictSegment
    }
    
    setMatchedDictSegment(matchedDictSegment)
    {
        this.matchedDictSegment := matchedDictSegment
    }
    
    getBegin()
    {
        return this.begin
    }
    
    setBegin(begin)
    {
        this.begin := begin
    }
    
    getEnd()
    {
        return this.end
    }
    
    setEnd(end)
    {
        this.end := end
    }
}

class JiebaSegmenter
{
    static wordDict := WordDictionary.getInstance()
    
    static finalSeg := FinalSeg.getInstance()
    
    addWord(word)
    {
        if word is string
            JiebaSegmenter.wordDict.addWord(word)
        else
        {
            try
            {
                for words in word
                    JiebaSegmenter.wordDict.addWord(words)
            }
        }
    }
    
    calc(sentence, dag)
    {
        N := strlen(sentence)
        route := HashMap()
        route.put(N, Pair(0, 0.0))
        loop N
        {
            i := N - a_index
            candidate := Java.Null()
            for x in dag.get(i)
            {
                freq := JiebaSegmenter.wordDict.getFreq(substr(sentence, i + 1, x + 1 - i)) + route.get(x + 1).freq
                if (candidate is Java.Null)
                    candidate := Pair(x, freq)
                else if (candidate.freq < freq)
                {
                    candidate.freq := freq
                    candidate.key := x
                }
            }
            route.put(i, candidate)
        }
        return route
    }
    
    createDAG(sentence)
    {
        dag := HashMap()
        trie := JiebaSegmenter.wordDict.getTrie()
        chars := strsplit(sentence)
        N := chars.length
        i := 0
        j := 0
        while (i < N)
        {
            hit := trie.match(chars, i, j - i + 1)
            if (hit.isPrefix() || hit.isMatch())
            {
                if (hit.isMatch())
                {
                    if (!dag.containsKey(i))
                    {
                        value := ArrayList()
                        dag.put(i, value)
                        value.add(j)
                    }
                    else
                        dag.get(i).add(j)
                }
                j += 1
                if (j >= N)
                {
                    i += 1
                    j := i
                }
            }
            else
            {
                i += 1
                j := i
            }
        }
        loop N
        {
            i := a_index - 1
            if (!dag.containsKey(i))
            {
                value := ArrayList()
                value.add(i)
                dag.put(i, value)
            }
        }
        return dag
    }
    
    initUserDict(paths)
    {
        if !(paths is array)
            paths := [paths]
        JiebaSegmenter.wordDict.init(paths)
    }
    
    process(paragraph, mode, onlyResults := false, punctuationFlag := true)
    {
        if !punctuationFlag
            paragraph := regexreplace(paragraph, "[\pP‘’“”]")
        tokens := ArrayList()
        sb := StringBuilder()
        offset := 0
        loop strlen(paragraph)
        {
            i := a_index - 1
            ch := CharacterUtil.regularize(substr(paragraph, i + 1, 1))
            if (CharacterUtil.ccFind(ch))
                sb.append(ch)
            else
            {
                if (sb.length() > 0)
                {
                    if (mode == SegMode.SEARCH)
                    {
                        for word in this.sentenceProcess(sb.toString())
                        {
                            tokens.add(SegToken(word, offset, offset + strlen(word)))
                            offset += strlen(word)
                        }
                    }
                    else
                    {
                        for token in this.sentenceProcess(sb.toString())
                        {
                            if (strlen(token) > 2)
                            {
                                loop strlen(token) - 1
                                {
                                    j := a_index - 1
                                    gram2 := substr(token, j + 1, 2)
                                    if (JiebaSegmenter.wordDict.containsWord(gram2))
                                        tokens.add(SegToken(gram2, offset + j, offset + j + 2))
                                }
                            }
                            if (strlen(token) > 3)
                            {
                                loop strlen(token) - 2
                                {
                                    j := a_index - 1
                                    gram3 := substr(token, j + 1, 3)
                                    if (JiebaSegmenter.wordDict.containsWord(gram3))
                                        tokens.add(SegToken(gram3, offset + j, offset + j + 3))
                                }
                            }
                            tokens.add(SegToken(token, offset, offset + strlen(token)))
                            offset += strlen(token)
                        }
                    }
                    sb := StringBuilder()
                    offset := i
                }
                if (JiebaSegmenter.wordDict.containsWord(substr(paragraph, i + 1, 1)))
                {
                    tokens.add(SegToken(substr(paragraph, i + 1, 1), offset, offset + 1))
                    offset++
                }
                else
                {
                    tokens.add(SegToken(substr(paragraph, i + 1, 1), offset, offset + 1))
                    offset++
                }
            }
        }
        if (sb.length() > 0)
        {
            if (mode == SegMode.SEARCH)
            {
                for token in this.sentenceProcess(sb.toString())
                {
                    tokens.add(SegToken(token, offset, offset + strlen(token)))
                    offset += strlen(token)
                }
            }
            else
            {
                for token in this.sentenceProcess(sb.toString())
                {
                    if (strlen(token) > 2)
                    {
                        loop strlen(token) - 1
                        {
                            j := a_index - 1
                            gram2 := substr(token, j + 1, 2)
                            if (JiebaSegmenter.wordDict.containsWord(gram2))
                                tokens.add(SegToken(gram2, offset + j, offset + j + 2))
                        }
                    }
                    if (strlen(token) > 3)
                    {
                        loop strlen(token) - 2
                        {
                            j := a_index - 1
                            gram3 := substr(token, j + 1, 3)
                            if (JiebaSegmenter.wordDict.containsWord(gram3))
                                tokens.add(SegToken(gram3, offset + j, offset + j + 3))
                        }
                    }
                    tokens.add(SegToken(token, offset, offset + strlen(token)))
                    offset += strlen(token)
                }
            }
        }
        if onlyResults
        {
            loop tokens.arr.length
                tokens.arr[a_index] := tokens.arr[a_index].word
            return tokens
        }
        return tokens
    }
    
    sentenceProcess(sentence)
    {
        tokens := ArrayList()
        N := strlen(sentence)
        dag := this.createDAG(sentence)
        route := this.calc(sentence, dag)
        
        x := 0
        y := 0
        sb := StringBuilder()
        while (x < N)
        {
            y := route.get(x).key + 1
            lWord := substr(sentence, x + 1, y - x)
            if (y - x == 1)
                sb.append(lWord)
            else
            {
                if (sb.length() > 0)
                {
                    buf := sb.toString()
                    sb := StringBuilder()
                    if (strlen(buf) == 1)
                        tokens.add(buf)
                    else
                    {
                        if (JiebaSegmenter.wordDict.containsWord(buf))
                            tokens.add(buf)
                        else
                            JiebaSegmenter.finalSeg.cut(buf, tokens)
                    }
                }
                tokens.add(lWord)
            }
            x := y
        }
        buf := sb.toString()
        if (strlen(buf) > 0)
        {
            if (strlen(buf) == 1)
                tokens.add(buf)
            else
            {
                if (JiebaSegmenter.wordDict.containsWord(buf))
                    tokens.add(buf)
                else
                    JiebaSegmenter.finalSeg.cut(buf, tokens)
            }
        }
        return tokens
    }
}

class Keyword
{
    __new(name, tfidfvalue)
    {
        this.name := name
		this.tfidfvalue := round(tfidfvalue * 10000) / 10000
    }
    
    compareTo(o)
    {
        return this.tfidfvalue - o.tfidfvalue > 0 ? -1 : 1
    }
}

class Node
{
    __new(value, parent)
    {
        this.value := value
        this.parent := parent
    }
}

class Pair
{
    __new(key, freq)
    {
        this.key := key
        this.freq := freq
    }
    
    toString()
    {
        return "Candidate [key=" this.key ", freq=" this.freq "]"
    }
}

class SegMode
{
    static INDEX := 0
    
    static SEARCH := 1
}

class SegToken
{
    __new(word, startOffset, endOffset)
    {
        this.word := word
        this.startOffset := startOffset
        this.endOffset := endOffset
    }
    
    toString()
    {
        return "[" this.word ", " this.startOffset ", " this.endOffset "]"
    }
}

class WordDictionary
{
    static singleton := Java.Null()
    
    static separator := " "
    
    static MAIN_DICT := "dict.txt"
    
    static USER_DICT_SUFFIX := ".dict"
    
    __new()
    {
        this.freqs := HashMap()
        this.loadedPath := ArrayList()
        this.minFreq := 1.7976931348623157E308
        this.total := 0.0
        this.loadDict()
    }
    
    addWord(word)
    {
        if !(word is Java.Null) && trim(word)
        {
            key := strlower(trim(word))
            this._dict.fillSegment(strsplit(key))
            return key
        }
        else
            return Java.Null()
    }
    
    containsWord(word)
    {
        return this.freqs.containsKey(word)
    }
    
    getFreq(key)
    {
        if (this.containsWord(key))
            return this.freqs.get(key)
        else
            return this.minFreq
    }
    
    getTrie()
    {
        return this._dict
    }
    
    init(paths)
    {
        load_results := []
        for path in paths
        {
            if (!this.loadedPath.contains(path))
            {
                try
                {
                    load_results.push("initialize user dictionary: " path)
                    WordDictionary.singleton.loadUserDict(path)
                    this.loadedPath.add(path)
                }
                catch
                    load_results.push(format("{}: load user dict failure!", path))
            }
        }
        return load_results
    }
    
    loadDict()
    {
        this._dict := DictSegment(chr(0))
        try
            _is := Java.getResourceAsStream("jieba", WordDictionary.MAIN_DICT)
        catch
            throw IOException(format("{}: load failure!", WordDictionary.MAIN_DICT))
        br := _is
        s := a_tickcount
        while !br.ateof
        {
            line := br.readLine()
            tmp_tokens := strsplit(line, WordDictionary.separator)
            tokens := []
            for str in tmp_tokens
            {
                if str
                    tokens.push(str)
            }
            if (tokens.length < 2)
                continue
            word := tokens[1]
            freq := tokens[2]
            this.total += freq
            word := this.addWord(word)
            this.freqs.put(word, freq)
        }
        for entrykey, entryvalue in this.freqs
        {
            this.freqs[entrykey] := ln(entryvalue / this.total)
            this.minFreq := min(entryvalue, this.minFreq)
        }
        _is.close()
        if isset(debug) && debug is class
            debug format("main dict load finished, time elapsed {} ms", a_tickcount - s)
        return format("main dict load finished, time elapsed {} ms", a_tickcount - s)
    }
    
    loadUserDict(userDict, charset := "utf-8", separator := " ")
    {
        try
            br := Java.getResourceAsStream("jieba", userDict)
        catch
            throw IOException(format("{}: load user dict failure!", userDict))
        s := a_tickcount
        count := 0
        while !br.ateof
        {
            line := br.readLine()
            tmp_tokens := strsplit(line, separator)
            tokens := []
            for str in tmp_tokens
            {
                if !str
                    tokens.push(str)
            }
            if (tokens.length < 1)
                continue
            word := tokens[1]
            freq := 3.0
            if (tokens.length == 2)
                freq := tokens[2]
            word := this.addWord(word)
            this.freqs.put(word, ln(freq / this.total))
            count++
        }
        br.close()
        if isset(debug) && debug is class
            debug format("user dict {} load finished, tot words: {}, time elapsed : {}ms", userDict, count, a_tickcount - s)
        return format("user dict {} load finished, tot words: {}, time elapsed : {}ms", userDict, count, a_tickcount - s)
    }
    
    resetDict()
    {
    	this._dict := DictSegment(chr(0))
    	this.freqs.clear()
    }
    
    static getInstance()
    {
        if WordDictionary.singleton is Java.Null
        {
            WordDictionary.singleton := WordDictionary()
            return WordDictionary.singleton
        }
        return WordDictionary.singleton
    }
}

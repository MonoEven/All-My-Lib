; Author: Mono Even
; Time: 2023.02.06

class cs
{
    static ahk_flag := true
    
    static code := "
    (
        using System;
        using System.Collections;
        using System.Text;
        using System.Threading;
        using System.Runtime.InteropServices;
        using Microsoft.JScript;
        using Microsoft.JScript.Vsa;
        
        class CS_ArrayList
        {
            public ArrayList Init()
            {
                return new ArrayList();
            }
            
            public void Add(ArrayList array, params Object[] param)
            {
                foreach (Object i in param)
                    array.Add(i);
            }
            
            public void AddRange(ArrayList array, params ArrayList[] param)
            {
                foreach (ArrayList i in param)
                    array.AddRange(i);
            }
            
            public bool Contains(ArrayList array, Object item)
            {
                return array.Contains(item);
            }
            
            public ArrayList GetRange(ArrayList array, int index, int count)
            {
                return array.GetRange(index, count);
            }
            
            public int IndexOf(ArrayList array, Object item)
            {
                return array.IndexOf(item);
            }
            
            public void Insert(ArrayList array, int index, Object item)
            {
                array.Insert(index, item);
            }
            
            public void InsertRange(ArrayList array, int index, ArrayList item)
            {
                array.InsertRange(index, item);
            }
            
            public void Remove(ArrayList array, Object item)
            {
                array.Remove(item);
            }
            
            public void RemoveAt(ArrayList array, int index)
            {
                array.RemoveAt(index);
            }
            
            public void RemoveRange(ArrayList array, int index, int count)
            {
                array.RemoveRange(index, count);
            }
            
            public void SetRange(ArrayList array, int index, ArrayList item)
            {
                array.SetRange(index, item);
            }
        }
        
        class CS_BitArray
        {
            public BitArray Init(int number)
            {
                byte[] tmp = BitConverter.GetBytes(number);
                return new BitArray(tmp);
            }
            
            public BitArray And(BitArray source, BitArray target)
            {
                return source.And(target);
            }
            
            public bool Get(BitArray source, int index)
            {
                return source.Get(index);
            }
            
            public BitArray Or(BitArray source, BitArray target)
            {
                return source.Or(target);
            }
            
            public void Set(BitArray source, int index, bool value)
            {
                source.Set(index, value);
            }
            
            public void SetAll(BitArray source, bool value)
            {
                source.SetAll(value);
            }
            
            public ArrayList ToArrayList(BitArray source)
            {
                ArrayList array = new ArrayList();
                array.AddRange(source);
                return array;
            }
            
            public bool[] ToArray(BitArray source)
            {
                bool[] tmp = new bool[source.Length];
                source.CopyTo(tmp, 0);
                return tmp;
            }
            
            public int ToInt(BitArray source)
            {
                int res = 0;
                for (int i = source.Count - 1; i >= 0; i--)
                    res = source[i] ? res + (1 << i) : res;
                return res;
            }
            
            public string ToStr(BitArray source)
            {
                StringBuilder res = new StringBuilder();
                for (int i = source.Count - 1; i >= 0; i--)
                    res.Append(source[i] ? 1 : 0);
                return res.ToString();
            }
            
            public BitArray Xor(BitArray source, BitArray target)
            {
                return source.Xor(target);
            }
        }
        
        class CS_Hashtable
        {
            public Hashtable Init()
            {
                return new Hashtable();
            }
            
            public void Add(Hashtable table, Object key, Object value)
            {
                table.Add(key, value);
            }
            
            public bool ContainsKey(Hashtable table, Object key)
            {
                return table.ContainsKey(key);
            }
            
            public bool ContainsValue(Hashtable table, Object value)
            {
                return table.ContainsValue(value);
            }
            
            public ArrayList Keys(Hashtable table)
            {
                ArrayList array = new ArrayList();
                array.AddRange(table.Keys);
                return array;
            }
            
            public ArrayList Values(Hashtable table)
            {
                ArrayList array = new ArrayList();
                array.AddRange(table.Values);
                return array;
            }
            
            public void Remove(Hashtable table, Object key)
            {
                table.Remove(key);
            }
        }
        
        class CS_Queue
        {
            public Queue Init()
            {
                return new Queue();
            }
            
            public bool Contains(Queue queue, Object obj)
            {
                return queue.Contains(obj);
            }
            
            public void Enqueue(Queue queue, Object obj)
            {
                queue.Enqueue(obj);
            }
            
            public ArrayList ToArrayList(Queue queue)
            {
                ArrayList array = new ArrayList();
                array.AddRange(queue);
                return array;
            }
        }
        
        class CS_Stack
        {
            public Stack Init()
            {
                return new Stack();
            }
            
            public bool Contains(Stack stack, Object obj)
            {
                return stack.Contains(obj);
            }
            
            public void Push(Stack stack, Object obj)
            {
                stack.Push(obj);
            }
            
            public ArrayList ToArrayList(Stack stack)
            {
                ArrayList array = new ArrayList();
                array.AddRange(stack);
                return array;
            }
        }
        
        class CS_StringBuilder
        {            
            public StringBuilder Init(string source)
            {
                StringBuilder builder = new StringBuilder(source);
                return builder;
            }
            
            public void Append(StringBuilder builder, string source, int looptimes)
            {
                for (int i = 0; i < looptimes; i++)
                    builder.Append(source);
            }
            
            public void AppendStringBuilder(StringBuilder builder, StringBuilder source, int looptimes)
            {
                for (int i = 0; i < looptimes; i++)
                    builder.Append(source);
            }
            
            public void AppendFormat(StringBuilder builder, string source, int looptimes, params Object[] format)
            {
                for (int i = 0; i < looptimes; i++)
                    builder.AppendFormat(source, format);
            }
            
            public void AppendStringBuilderFormat(StringBuilder builder, StringBuilder source, int looptimes, params Object[] format)
            {
                string tmp_source = source.ToString();
                for (int i = 0; i < looptimes; i++)
                    builder.AppendFormat(tmp_source, format);
            }
            
            public void Insert(StringBuilder builder, string source, int pos, int looptimes)
            {
                for (int i = 0; i < looptimes; i++)
                    builder.Insert(pos, source);
            }
            
            public void InsertStringBuilder(StringBuilder builder, StringBuilder source, int pos, int looptimes)
            {
                string tmp_source = source.ToString();
                for (int i = 0; i < looptimes; i++)
                    builder.Insert(pos, tmp_source);
            }
            
            public void Remove(StringBuilder builder, int start, int length, int looptimes)
            {
                for (int i = 0; i < looptimes; i++)
                    builder.Remove(start, length);
            }
            
            public void Replace(StringBuilder builder, string haystack, string needle, int looptimes)
            {
                for (int i = 0; i < looptimes; i++)
                    builder.Replace(haystack, needle);
            }
        }
        
        class CS_Thread
        {
            public Thread Start(int fn)
            {
                Thread childThread = new Thread((obj) => BindNoParamFuncVoid(fn));
                childThread.Start(fn);
                return childThread;
            }
            
            public void End(Thread thread)
            {
                thread.Abort();
            }
            
            delegate void CFuncDelegateVoid();
            public void BindNoParamFuncVoid(int CFunc)
            {
                CFuncDelegateVoid func = (CFuncDelegateVoid)Marshal.GetDelegateForFunctionPointer((IntPtr)CFunc, typeof(CFuncDelegateVoid));
                func();
            }
        }
        
        class CS_Func
        {
            public Object Eval(string eval)
            {
                return Microsoft.JScript.Eval.JScriptEvaluate(eval, Microsoft.JScript.Vsa.VsaEngine.CreateEngine());
            }
        }
    )"
    
    static ref := "
    (Join|
        System.dll
        Microsoft.JScript.dll
    )"
    
    static asm := cs.CLR_CompileCS(cs.code, cs.ref)
    
    static ComArrayMake(array)
    {
        comArray := ComObjArray(VT_VARIANT := 12, array.length)
        for i in array
            comArray[a_index - 1] := i
        return comArray
    }
    
    class ArrayList
    {
        static obj := cs.CLR_CreateObject(cs.asm, "CS_ArrayList")
        
        capacity
        {
            get => this.array.Capacity
            set => this.array.Capacity := value
        }
        
        count
        {
            get => this.array.Count
        }
        
        length
        {
            get => this.array.Count
        }
        
        __new(arr := "")
        {
            if type(arr) = "ArrayList"
                this.array := arr
            else if arr is cs.ArrayList
                this.array := arr.array
            else
                this.array := cs.ArrayList.obj.Init()
        }
        
        __item[index]
        {
            get => this.array[index - cs.ahk_flag]
            set => this.array[index - cs.ahk_flag] := value
        }
        
        add(obj*)
        {
            cs.ArrayList.obj.Add(this.array, obj*)
            return this
        }
        
        addRange(arrayList)
        {
            if !(arrayList is cs.ArrayList)
                arrayList := cs.ArrayList(arrayList)
            cs.ArrayList.obj.AddRange(this.array, arrayList.array)
            return this
        }
        
        clear()
        {
            this.array.Clear()
            return this
        }
        
        contains(item)
        {
            return cs.ArrayList.obj.Contains(this.array, item)
        }
        
        getRange(index, count)
        {
            index -= cs.ahk_flag
            return cs.ArrayList(cs.ArrayList.obj.GetRange(this.array, index, count))
        }
        
        indexOf(item)
        {
            return cs.ArrayList.obj.IndexOf(this.array, item) + cs.ahk_flag
        }
        
        insert(index, obj)
        {
            index -= cs.ahk_flag
            cs.ArrayList.obj.Insert(this.array, index, obj)
            return this
        }
        
        insertRange(index, arrayList)
        {
            index -= cs.ahk_flag
            if !(arrayList is cs.ArrayList)
                arrayList := cs.ArrayList(arrayList)
            cs.ArrayList.obj.InsertRange(this.array, index, arrayList.array)
            return this
        }
        
        remove(obj)
        {
            cs.ArrayList.obj.Remove(this.array, obj)
            return this
        }
        
        removeAt(index)
        {
            index -= cs.ahk_flag
            cs.ArrayList.obj.RemoveAt(this.array, index)
            return this
        }
        
        removeRange(index, count)
        {
            index -= cs.ahk_flag
            cs.ArrayList.obj.RemoveRange(this.array, index, count)
            return this
        }
        
        reverse()
        {
            this.array.Reverse()
            return this
        }
        
        setRange(index, arrayList)
        {
            index -= cs.ahk_flag
            if !(arrayList is cs.ArrayList)
                arrayList := cs.ArrayList(arrayList)
            cs.ArrayList.obj.SetRange(this.array, index, arrayList.array)
            return this
        }
        
        sort()
        {
            this.array.sort()
            return this
        }
        
        toArray()
        {
            return [this.array*]
        }
        
        trimToSize()
        {
            this.array.TrimToSize()
            return this
        }
        
        __delete()
        {
            this.clear()
            this.array := ""
        }
    }
    
    class BitArray
    {
        static obj := cs.CLR_CreateObject(cs.asm, "CS_BitArray")
        
        count
        {
            get => this.bitarray.Count
        }
        
        length
        {
            get => this.bitarray.Length
            set => this.bitarray.Length := value
        }
        
        __new(bitarray := 0)
        {
            if type(bitarray) = "Bitarray"
                this.bitarray := bitarray
            else if bitarray is cs.Bitarray
                this.bitarray := bitarray.bitarray
            else
                this.bitarray := cs.Bitarray.obj.Init(bitarray)
        }
        
        __item[index]
        {
            get => this.bitarray[index - cs.ahk_flag]
            set => this.bitarray[index - cs.ahk_flag] := value
        }
        
        and(value)
        {
            if !(value is cs.BitArray)
                value := cs.BitArray(value)
            return cs.BitArray(cs.BitArray.obj.And(this.bitarray, value.bitarray))
        }
        
        get(index)
        {
            index -= cs.ahk_flag
            return cs.BitArray.obj.Get(this.bitarray, index)
        }
        
        not()
        {
            return cs.BitArray(this.bitarray.Not())
        }
        
        or(value)
        {
            if !(value is cs.BitArray)
                value := cs.BitArray(value)
            return cs.BitArray(cs.BitArray.obj.Or(this.bitarray, value.bitarray))
        }
        
        set(index, value)
        {
            index -= cs.ahk_flag
            return cs.BitArray.obj.Set(this.bitarray, index, value)
        }
        
        setAll(value)
        {
            return cs.BitArray.obj.SetAll(this.bitarray, value)
        }
        
        toArray()
        {
            return [cs.BitArray.obj.ToArray(this.bitarray)*]
        }
        
        toArrayList()
        {
            return cs.ArrayList(cs.BitArray.obj.ToArrayList(this.bitarray))
        }
        
        toInt()
        {
            return cs.BitArray.obj.ToInt(this.bitarray)
        }
        
        toString()
        {
            return ltrim(cs.BitArray.obj.ToStr(this.bitarray), 0)
        }
        
        xor(value)
        {
            if !(value is cs.BitArray)
                value := cs.BitArray(value)
            return cs.BitArray(cs.BitArray.obj.Xor(this.bitarray, value.bitarray))
        }
        
        __delete()
        {
            this.bitarray.Length := 0
            this.bitarray := ""
        }
    }
    
    class Func
    {
        static obj := cs.CLR_CreateObject(cs.asm, "CS_Func")
        
        eval(_string)
        {
            return cs.Func.obj.Eval(_string)
        }
    }
    
    class Hashtable
    {
        static obj := cs.CLR_CreateObject(cs.asm, "CS_Hashtable")
        
        count
        {
            get => this.table.Count
        }
        
        length
        {
            get => this.table.Count
        }
        
        keys
        {
            get => cs.ArrayList(cs.Hashtable.obj.Keys(this.table))
        }
        
        values
        {
            get => cs.ArrayList(cs.Hashtable.obj.Values(this.table))
        }
        
        __new(table := "")
        {
            if type(table) = "Hashtable"
                this.table := table
            else if table is cs.Hashtable
                this.table := table.table
            else
                this.table := cs.Hashtable.obj.Init()
        }
        
        __item[key]
        {
            get => this.table[key]
            set => this.table[key] := value
        }
        
        add(key, value)
        {
            cs.Hashtable.obj.Add(this.table, key, value)
            return this
        }
        
        clear()
        {
            this.table.Clear()
            return this
        }
        
        containsKey(key)
        {
            return cs.Hashtable.obj.ContainsKey(this.table, key)
        }
        
        containsValue(value)
        {
            return cs.Hashtable.obj.ContainsValue(this.table, value)
        }
        
        remove(key)
        {
            cs.Hashtable.obj.Remove(this.table, key)
            return this
        }
        
        __delete()
        {
            this.clear()
            this.table := ""
        }
    }
    
    class Queue
    {
        static obj := cs.CLR_CreateObject(cs.asm, "CS_Queue")
        
        count
        {
            get => this.queue.Count
        }
        
        length
        {
            get => this.queue.Count
        }
        
        __new(queue := "")
        {
            if type(queue) = "Queue"
                this.queue := queue
            else if queue is cs.Queue
                this.queue := queue.queue
            else
                this.queue := cs.Queue.obj.Init()
        }
        
        clear()
        {
            this.queue.Clear()
            return this
        }
        
        contains(obj)
        {
            return cs.Queue.obj.Contains(this.queue, obj)
        }
        
        dequeue()
        {
            return this.queue.Dequeue()
        }
        
        enqueue(obj)
        {
            cs.Queue.obj.Enqueue(this.queue, obj)
            return this
        }
        
        toArray()
        {
            return [this.queue.ToArray()*]
        }
        
        toArrayList()
        {
            return cs.ArrayList(cs.Queue.obj.ToArrayList(this.queue))
        }
        
        __delete()
        {
            this.clear()
            this.queue := ""
        }
    }
    
    class Stack
    {
        static obj := cs.CLR_CreateObject(cs.asm, "CS_Stack")
        
        count
        {
            get => this.stack.Count
        }
        
        length
        {
            get => this.stack.Count
        }
        
        __new(stack := "")
        {
            if type(stack) = "Stack"
                this.stack := stack
            else if stack is cs.Stack
                this.stack := stack.stack
            else
                this.stack := cs.Stack.obj.Init()
        }
        
        clear()
        {
            this.stack.Clear()
            return this
        }
        
        contains(obj)
        {
            return cs.Stack.obj.Contains(this.stack, obj)
        }
        
        peek()
        {
            return this.stack.Peek()
        }
        
        pop()
        {
            return this.stack.Pop()
        }
        
        push(obj)
        {
            cs.Stack.obj.Push(this.stack, obj)
            return this
        }
        
        toArray()
        {
            return [this.stack.ToArray()*]
        }
        
        toArrayList()
        {
            return cs.ArrayList(cs.Stack.obj.ToArrayList(this.stack))
        }
        
        __delete()
        {
            this.clear()
            this.stack := ""
        }
    }
    
    class StringBuilder
    {
        static obj := cs.CLR_CreateObject(cs.asm, "CS_StringBuilder")
        
        count
        {
            get => this.builder.Length
        }
        
        length
        {
            get => this.builder.Length
            set => this.builder.Length := value
        }
        
        __new(_string := "")
        {
            if type(_string) = "StringBuilder"
                this.builder := _string
            else if _string is cs.StringBuilder
                this.builder := _string.builder
            else if _string is string || _string is number
                this.builder := cs.StringBuilder.obj.Init(_string)
            else
                this.builder := cs.StringBuilder.obj.Init("")
        }
        
        __item[index]
        {
            get => chr(this.builder[index - cs.ahk_flag])
            set => this.builder[index - cs.ahk_flag] := ord(value)
        }
        
        append(_string, looptimes := 1)
        {
            if _string is string || _string is number
                cs.StringBuilder.obj.Append(this.builder, _string, looptimes)
            else if type(_string) = "StringBuilder"
                cs.StringBuilder.obj.AppendStringBuilder(this.builder, _string, looptimes)
            else if _string is cs.StringBuilder
                cs.StringBuilder.obj.AppendStringBuilder(this.builder, _string.builder, looptimes)
            return this
        }
        
        appendFormat(_string, looptimes := 1, format*)
        {
            if _string is string || _string is number
                cs.StringBuilder.obj.AppendFormat(this.builder, _string, looptimes, format*)
            else if type(_string) = "StringBuilder"
                cs.StringBuilder.obj.AppendStringBuilderFormat(this.builder, _string, looptimes, format*)
            else if _string is cs.StringBuilder
                cs.StringBuilder.obj.AppendStringBuilderFormat(this.builder, _string.builder, looptimes, format*)
            return this
        }
        
        charAt(index)
        {
            return this.builder[index - cs.ahk_flag]
        }
        
        insert(pos, _string, looptimes := 1)
        {
            pos -= cs.ahk_flag
            if _string is string || _string is number
                cs.StringBuilder.obj.Insert(this.builder, _string, pos, looptimes)
            else if type(_string) = "StringBuilder"
                cs.StringBuilder.obj.InsertStringBuilder(this.builder, _string, pos, looptimes)
            else if _string is cs.StringBuilder
                cs.StringBuilder.obj.InsertStringBuilder(this.builder, _string.builder, pos, looptimes)
            return this
        }
        
        remove(start, length, looptimes := 1)
        {
            start -= cs.ahk_flag
            cs.StringBuilder.obj.Remove(this.builder, start, length, looptimes)
            return this
        }
        
        replace(haystack, needle := "", looptimes := 1)
        {
            cs.StringBuilder.obj.Replace(this.builder, haystack, needle, looptimes)
            return this
        }
        
        toString()
        {
            return this.builder.ToString()
        }
        
        __delete()
        {
            this.builder.Length := 0
            this.builder := ""
        }
    }
    
    class Thread
    {
        static obj := cs.CLR_CreateObject(cs.asm, "CS_Thread")
        
        __new()
        {
            this.threadpool := []
            this.funcpool := []
        }
        
        start(fn)
        {
            func := callbackcreate(fn)
            this.funcpool.push(func)
            thread := cs.Thread.obj.Start(func)
            this.threadpool.push(thread)
            return thread
        }
        
        end(index := this.threadpool.length)
        {
            cs.Thread.obj.End(this.threadpool[index])
            this.threadpool.removeat(index)
            this.funcpool.removeat(index)
        }
        
        __delete()
        {
            while this.threadpool.length
                this.end()
        }
    }
    
    static CLR_LoadLibrary(AssemblyName, AppDomain:=0)
    {
        if !AppDomain
            AppDomain := cs.CLR_GetDefaultDomain()
        try
            return AppDomain.Load_2(AssemblyName)
        static null := ComValue(13,0)
        args := ComObjArray(0xC, 1),  args[0] := AssemblyName
        typeofAssembly := AppDomain.GetType().Assembly.GetType()
        try
            return typeofAssembly.InvokeMember_3("LoadWithPartialName", 0x158, null, null, args)
        catch
            return typeofAssembly.InvokeMember_3("LoadFrom", 0x158, null, null, args)
    }

    static CLR_CreateObject(Assembly, TypeName, Args*)
    {
        if !(argCount := Args.Length)
            return Assembly.CreateInstance_2(TypeName, true)
        
        vargs := ComObjArray(0xC, argCount)
        Loop argCount
            vargs[A_Index-1] := Args[A_Index]
        
        static Array_Empty := ComObjArray(0xC,0), null := ComValue(13,0)
        
        return Assembly.CreateInstance_3(TypeName, true, 0, null, vargs, null, Array_Empty)
    }

    static CLR_CompileCS(Code, References:="", AppDomain:=0, FileName:="", CompilerOptions:="")
    {
        return cs.CLR_CompileAssembly(Code, References, "System", "Microsoft.CSharp.CSharpCodeProvider", AppDomain, FileName, CompilerOptions)
    }

    static CLR_CompileVB(Code, References:="", AppDomain:=0, FileName:="", CompilerOptions:="")
    {
        return cs.CLR_CompileAssembly(Code, References, "System", "Microsoft.VisualBasic.VBCodeProvider", AppDomain, FileName, CompilerOptions)
    }

    static CLR_StartDomain(&AppDomain, BaseDirectory:="")
    {
        static null := ComValue(13,0)
        args := ComObjArray(0xC, 5), args[0] := "", args[2] := BaseDirectory, args[4] := ComValue(0xB,false)
        AppDomain := cs.CLR_GetDefaultDomain().GetType().InvokeMember_3("CreateDomain", 0x158, null, null, args)
    }

    ; ICorRuntimeHost::UnloadDomain
    static CLR_StopDomain(AppDomain) => ComCall(20, cs.CLR_Start(), "ptr", ComObjValue(AppDomain))

    ; NOTE: IT IS NOT NECESSARY TO CALL THIS FUNCTION unless you need to load a specific version.
    static CLR_Start(Version:="") ; returns ICorRuntimeHost*
    {
        static RtHst := 0
        ; The simple method gives no control over versioning, and seems to load .NET v2 even when v4 is present:
        ; return RtHst ? RtHst : (RtHst:=COM_CreateObject("CLRMetaData.CorRuntimeHost","{CB2F6722-AB3A-11D2-9C40-00C04FA30A3E}"), DllCall(NumGet(NumGet(RtHst+0)+40),"uint",RtHst))
        if RtHst
            return RtHst
        if Version = ""
            Loop Files EnvGet("SystemRoot") "\Microsoft.NET\Framework" (A_PtrSize=8?"64":"") "\*","D"
                if (FileExist(A_LoopFilePath "\mscorlib.dll") && StrCompare(A_LoopFileName, Version) > 0)
                    Version := A_LoopFileName
        static CLSID_CorRuntimeHost := cs.CLR_GUID("{CB2F6723-AB3A-11D2-9C40-00C04FA30A3E}")
        static IID_ICorRuntimeHost  := cs.CLR_GUID("{CB2F6722-AB3A-11D2-9C40-00C04FA30A3E}")
        DllCall("mscoree\CorBindToRuntimeEx", "wstr", Version, "ptr", 0, "uint", 0
            , "ptr", CLSID_CorRuntimeHost, "ptr", IID_ICorRuntimeHost
            , "ptr*", &RtHst:=0, "hresult")
        ComCall(10, RtHst) ; Start
        return RtHst
    }

    ;
    ; INTERNAL FUNCTIONS
    ;

    static CLR_GetDefaultDomain()
    {
        ; ICorRuntimeHost::GetDefaultDomain
        static defaultDomain := (
            ComCall(13, cs.CLR_Start(), "ptr*", &p:=0),
            ComObjFromPtr(p)
        )
        return defaultDomain
    }

    static CLR_CompileAssembly(Code, References, ProviderAssembly, ProviderType, AppDomain:=0, FileName:="", CompilerOptions:="")
    {
        if !AppDomain
            AppDomain := cs.CLR_GetDefaultDomain()
        
        asmProvider := cs.CLR_LoadLibrary(ProviderAssembly, AppDomain)
        codeProvider := asmProvider.CreateInstance(ProviderType)
        codeCompiler := codeProvider.CreateCompiler()

        asmSystem := (ProviderAssembly="System") ? asmProvider : cs.CLR_LoadLibrary("System", AppDomain)

        ; Convert | delimited list of references into an array.
        Refs := References is String ? StrSplit(References, "|", " `t") : References
        aRefs := ComObjArray(8, Refs.Length)
        Loop Refs.Length
            aRefs[A_Index-1] := Refs[A_Index]
        
        ; Set parameters for compiler.
        prms := cs.CLR_CreateObject(asmSystem, "System.CodeDom.Compiler.CompilerParameters", aRefs)
        , prms.OutputAssembly          := FileName
        , prms.GenerateInMemory        := FileName=""
        , prms.GenerateExecutable      := SubStr(FileName,-4)=".exe"
        , prms.CompilerOptions         := CompilerOptions
        , prms.IncludeDebugInformation := true
        
        ; Compile!
        compilerRes := codeCompiler.CompileAssemblyFromSource(prms, Code)
        
        if error_count := (errors := compilerRes.Errors).Count
        {
            error_text := ""
            Loop error_count
                error_text .= ((e := errors.Item[A_Index-1]).IsWarning ? "Warning " : "Error ") . e.ErrorNumber " on line " e.Line ": " e.ErrorText "`n`n"
            throw Error("Compilation failed",, "`n" error_text)
        }
        ; Success. Return Assembly object or path.
        return FileName="" ? compilerRes.CompiledAssembly : compilerRes.PathToAssembly
    }

    ; Usage 1: pGUID := static CLR_GUID(&GUID, "{...}")
    ; Usage 2: GUID := static CLR_GUID("{...}"), pGUID := GUID.Ptr
    static CLR_GUID(a, b:=unset)
    {
        DllCall("ole32\IIDFromString"
            , "wstr", sGUID := IsSet(b) ? b : a
            , "ptr", GUID := Buffer(16,0), "hresult")
        return IsSet(b) ? GUID.Ptr : GUID
    }
}

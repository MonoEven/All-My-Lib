/*
***********************************************************************
 * @description create native functions or methods from mcode,
 * load ahk modules(write by c/c++) as native classes or fuctions.
 * @author thqby
 * @date 2022/02/27
 * @version 1.1.6
 **********************************************************************
 */

class native extends func
{
	static prototype.caches := map()

	; Auto free the NativeFunc object memory, because destructor is overridden, ahk will not free the memory.
	; Freeing memory before func obj is released can cause invalid reads and writes to memory.
	; Delayed free memory, the memory of the last function is freed when the function object is released.
	__delete()
    {
		numput('ptr', pthis := objptr(this), objptr(this.base.caches[''] := buffer()), 3 * A_PtrSize + 8)
		try this.base.caches.delete(numget(pthis + 6 * A_PtrSize + 16, 'ptr'))
	}

	; Provides a way for modules to call ahk objects
	static __get(name, params) => params.length ? %name%[params*] : %name%
	static __call(name, params)
    {
		if name = 'throw'
        {
			if len := params.length
            {
				msg := params[1], extra := len > 1 ? params[2] : '', errobj := len > 2 ? %params[3]% : msg is Integer ? oserror : error
				throw errobj(msg, -1, extra)
			}
			throw error('An exception occurred', -1)
		}
		return %name%(params*)
	}

	; create c/c++ function from mcode, and return the function address
	static mcode(hex)
    {
		static reg := "^([12]?).*" (A_PtrSize = 8 ? "x64" : "x86") ":([A-Za-z\d+/=]+)"
		if (regexmatch(hex, reg, &m))
			hex := m[2], flag := m[1] = "1" ? 4 : m[1] = "2" ? 1 : hex ~= "[+/=]" ? 1 : 4
		else
            flag := hex ~= "[+/=]" ? 1 : 4
		if (!dllcall("crypt32\CryptStringToBinary", "str", hex, "uint", 0, "uint", flag, "ptr", 0, "uint*", &s := 0, "ptr", 0, "ptr", 0))
			throw oserror(A_LastError)
		if (dllcall("crypt32\CryptStringToBinary", "str", hex, "uint", 0, "uint", flag, "ptr", p := (code := buffer(s)).Ptr, "uint*", &s, "ptr", 0, "ptr", 0) && dllcall("VirtualProtect", "ptr", code, "uint", s, "uint", 0x40, "uint*", 0))
			return (this.prototype.caches[p] := code, p)
		throw oserror(A_LastError)
	}

	/**
	 * Generate a func object with native code
	 * @param BIF Function addresses, `void funcname(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)`
	 * @param MinParams The number of required parameters
	 * @param ParamCount The number of maximum parameters, ParamCount = 255 if the function is variadic
	 * @param OutputVars The array that contains one-based indexs of outputvars, up to seven
	 * @param FID Function ID, `aResultToken.func->mFID`, for code sharing: this function's ID in the group of functions which share the same c++ function
	 */
	static func(bif, minparams := 0, paramcount := 0, outputvars := 0, fid := 0)
    {
		static p__init := objptr(Any.__Init), size := 8 * A_PtrSize + 16
		if bif is string
			bif := this.mcode(bif)
		; copy a func object memory
		sbif := buffer(outputvars ? size + 7 : size, 0), dllcall('RtlMoveMemory', 'ptr', sbif, 'ptr', p__init, 'uint', size)
		obif := objfromptr(sbif.Ptr)
		if isvariadic := paramcount == 255
			paramcount := minparams
		else paramcount := max(minparams, paramcount)
		; init func refcount and base obj
		numput('uint', 1, 'uint', 0, 'ptr', objptraddref(native.prototype), sbif, A_PtrSize)
		; init func infos
		numput('ptr', strptr('User-bif'), 'int', paramcount, 'int', minparams, 'int', isvariadic, sbif, 3 * A_PtrSize + 8)
		numput('ptr', bif, 'ptr', fid, sbif, 6 * A_PtrSize + 16)
		if outputvars
        {
			numput('ptr', s := sbif.Ptr + size, sbif, 5 * A_PtrSize + 16)	; mOutputVars
			loop min(outputvars.length, 7)	; MAX_FUNC_OUTPUT_VAR = 7
				s := numput('uchar', outputvars[A_Index], s)
		}
		numput('ptr', 0, 'ptr', 0, objptr(sbif), 3 * A_PtrSize + 8) ; Avoid the memory of func object be freed when buffer is released
		return obif
	}

	/**
	 * Generate a method with native code, is same with `native.func`
	 * @param base The base of instance
	 */
	static method(base, bim, mit, minparams := 0, paramcount := 0, mid := 0)
    {
		static pownprops := objptr({}.OwnProps), size := 9 * A_PtrSize + 16, nameoffset := 3 * A_PtrSize + 8
		if bim is string
			bim := this.mcode(bim)
		sbim := buffer(size, 0), dllcall('RtlMoveMemory', 'ptr', sbim, 'ptr', pownprops, 'uint', size)
		obim := objfromptr(sbim.ptr), isvariadic := paramcount == 255
		switch mit, false
        {
			case 'call', 2: ++minparams, paramcount := isvariadic ? minparams : max(minparams, paramcount + 1), numput('ptr', strptr('User-bim'), sbim, nameoffset), mit := 2
			case 'set', 1: minparams += 2, paramcount += 2, mit := 1, numput('ptr', strptr('User-bim.Set'), sbim, nameoffset)
			case 'get', 0: ++minparams, paramcount := max(minparams, paramcount + 1), numput('ptr', strptr('User-bim.Get'), sbim, nameoffset), mit := 0
		}
		numput('uint', 1, 'uint', 0, 'ptr', objptraddref(native.prototype), sbim, A_PtrSize)
		numput('int', max(minparams, paramcount), 'int', minparams, 'int', isvariadic, sbim, 4 * A_PtrSize + 8)
		numput('ptr', bim, 'ptr', base, 'uchar', mid, 'uchar', mit, sbim, 6 * A_PtrSize + 16)
		numput('ptr', 0, 'ptr', 0, objptr(sbim), 3 * A_PtrSize + 8)
		return obim
	}

	/**
	 * Defines a new own property with native code, is similar with `obj.DefineProp`
	 * @param obj Any object
	 * @param name The name of the property
	 * @param desc An object with one of following own properties, or both `Get` and `Set`
	 * 
	 * `Call, Get, Set`: an object with `bim` property and optional properties `minparams`, `paramcount`, `outputvars`, `mid`, is same with the parameters of `BuiltInFunc`
	 * 
	 * `bim`: `void (IObject::* ObjectMethod)(ResultToken& aResultToken, int aID, int aFlags, ExprTokenType* aParam[], int aParamCount)`
	 */
	static defineprop(obj, name, desc)
    {
		descobj := {}, baseobj := objptr(obj.base)
		for mit in ['call', 'set', 'get']
			if desc.hasownprop(mit)
            {
				t := desc.%mit%, minparams := paramcount := mid := 0, bim := t.bim
				for k in ['minparams', 'paramcount', 'mid']
					if t.hasownprop(k)
						%k% := t.%k%
				descobj.%mit% := this.method(baseobj, bim, mit, minparams, paramcount, mid)
			}
		obj.defineprop(name, descobj)
	}

	/**
	 * Create a class with constructor function address
	 * @param ctor constructor function address, `void funcname(ResultToken &aResultToken, ExprTokenType *aParam[], int aParamCount)`
	 * 
	 * constructor function used to create an object
	 */
	static class(name, ctor := 0, fid := 0)
    {
		cls := class(), cls.prototype := { base: object.prototype, __class: name }
		if ctor
			cls.defineprop('Call', {call: this.func(ctor, 1, 255, 0, fid)})
		return cls
	}

	/**
	 * Load a dll file with the specified format to create native functions and classes
	 * @param path ahk module path
	 * @param load_symbols Load symbols that specific names, will overwrite existing global classes
	 * @param loader Create native functions and classes based on the information provided by the module, or do it in the module
	 * @param provider Used to provide the ahk objects required by the module
	 */
	static loadmodule(path, load_symbols := 0, loader := 0, provider := 0)
    {
		if !(module := dllcall('LoadLibrary', 'str', path, 'ptr'))
			throw oserror(A_LastError)
		module_load_addr := dllcall('GetProcAddress', 'ptr', module, 'astr', 'ahk2_module_load', 'ptr') || dllcall('GetProcAddress', 'ptr', module, 'ptr', 1, 'ptr')
		if !module_load_addr
			throw error('Export function not found')
		if load_symbols
        {
			t := map(), t.casesense := false
			for k in load_symbols
				t[k] := true
			load_symbols := t
		}
		if !p := dllcall(module_load_addr, 'ptr', objptr(loader || default_loader), 'ptr', objptr(provider || native), 'cdecl ptr')
			throw error('Load module fail', -1, oserror(A_LastError).Message)
		return objfromptr(p)

		default_loader(count, addr)
        {
			static size := 2 * A_PtrSize + 16
			symbols := map(), symbols.casesense := false, symbols.defineprop('__call', { call: (s, n, p) => s[n](p*) })
			loop count
            {
				name := strget(pname := numget(addr, 'ptr'))
				if load_symbols && !load_symbols.Has(name)
                {
					addr += size
					continue
				}
				funcaddr := numget(addr += A_PtrSize, 'ptr')
				minparams := numget(addr += A_PtrSize, 'uchar')
				maxparams := numget(addr += 1, 'uchar')
				id := numget(addr += 1, 'ushort')
				if member_count := numget(addr += 2, 'uint')
                {
					try
                    {
						if !load_symbols || !isobject(symbol := %name%)
							throw
						symbols[name] := symbol
						if !symbol.hasownprop('prototype')
							symbol.prototype := this.class(name, 0).prototype
						if funcaddr
							symbol.defineprop('Call', {call: me := this.func(funcaddr, 1, maxparams + 1, 0, id)}), numput('ptr', pname, objptr(me), 3 * A_PtrSize + 8)
					}
                    catch
						symbols[name] := symbol := this.class(name, funcaddr, id)
					pmem := numget(addr += 4, 'ptr')
				}
				staticmembers := {}, members := {}
				loop member_count
                {
					name := strget(pname := numget(pmem, 'ptr'))
					method := numget(pmem += A_PtrSize, 'ptr')
					id := numget(pmem += A_PtrSize, 'uchar')
					mit := numget(pmem += 1, 'uchar')
					minparams := numget(pmem += 1, 'uchar')
					maxparams := numget(pmem += 1, 'uchar')
					namearr := strsplit(name, '.')
					if mit < 2 && namearr.length > 2
						namearr.pop()
					name := namearr.pop()
					sub := mit = 2 ? 'call' : mit = 1 ? 'set' : 'get'
					if namearr.length < 2
						mems := staticmembers, pbase := objptr(symbol.base)
					else
						mems := members, pbase := objptr(symbol.prototype.base)
					if !mems.hasownprop(name)
						t := mems.%name% := {}
					else t := mems.%name%
					t.%sub% := me := this.method(pbase, method, mit, minparams, maxparams, id)
					numput('ptr', pname, objptr(me), 3 * A_PtrSize + 8)
					pmem += A_PtrSize - 3
				}
                else
                {
					symbols[name] := symbol := this.func(funcaddr, minparams, maxparams, 0, id)
					numput('ptr', pname, objptr(symbol), 3 * A_PtrSize + 8)
					if numget(addr += 4, 'uchar')	; set mOutputVars
						numput('ptr', addr, objptr(symbol), 5 * A_PtrSize + 16)
				}
				if member_count
                {
					if symbol == map	; Break circular references if map has define native funcs
						OnExit(onexitapp.Bind(map(map, [staticmembers*], map.prototype, [members*])))
					for name, desc in staticmembers.ownprops()
						symbol.defineprop(name, desc)
					symbol := symbol.prototype
					for name, desc in members.ownprops()
						symbol.defineprop(name, desc)
				}
				addr += 8
			}
			return symbols

			onexitapp(todels, *)
            {
				for o, arr in todels
                {
					for n in arr
						try o.deleteprop(n)
                }
			}
		}
	}
    
    static mdfunc(fn, sig, prototype := 0)
    {
		static p_mdfunc := objptr(msgbox), size := 10 * A_PtrSize + 16
		static mdtypes :=
        {
			void: 0,
			int8: 1,
			uint8: 2,
			int16: 3,
			uint16: 4,
			int32: 5,
			uint32: 6,
			int64: 7,
			uint64: 8,
			float64: 9,
			float32: 10,
			string: 11,
			object: 12,
			variant: 13,
			bool32: 14,
			resulttype: 15,
			fresult: 16,
			params: 17,
			optional: 0x80,
			retval: 0x81,
			out: 0x82,
			; thiscall,
			uintptr: A_PtrSize = 8 ? 8 : 6,
			intptr: A_PtrSize = 8 ? 7 : 5,
		}
		if fn is string
			fn := this.mcode(fn)
		; copy a func object memory
		smdf := buffer(size, 0), dllcall('RtlMoveMemory', 'ptr', smdf, 'ptr', p_mdfunc, 'uint', size)
		p := numput('ptr', fn, smdf, 6 * A_PtrSize + 16), ac := pc := minparams := 0
		if prototype
			numput('char', 1, numput('ptr', isobject(prototype) ? objptr(prototype) : prototype, p) + A_PtrSize + 3), ac := pc := minparams := 1
		isvariadic := false, maxresulttokens := 0
		if sig is array
        {
			if sig.length > 1
				ret := sig.removeat(1), smdf.size += sig.length, ret is string && ret := mdtypes.%ret%
			else ret := 0
			opt := false, retval := false, out := 0
			loop sig.length
            {
				c := sig[A_Index]
				if c is String
					sig[A_Index] := c := mdtypes.%c%
				numput('uchar', c, smdf, size + A_Index - 1)
				if c >= 128
                {
					if c = 128
						opt := true
					else if c = 0x82
						out := c
					else if c = 0x81
						retval := true
					continue
				}
				if A_PtrSize = 4 && c >= 7 && c <= 9 && !out && !opt
					ac++
				ac++
				if c = 17
					isvariadic := true
				else if !retval
                {
					++pc
					if !opt && pc - 1 = minparams
						minparams := pc
					if c = 13 && out
						++MaxResultTokens
				}
				opt := false, retval := false, out := 0
			}
			numput('ptr', smdf.ptr + size, 'uchar', ret, 'uchar', ac, 'uchar', sig.length, smdf, 8 * A_PtrSize + 16)
		}
        else throw
		paramcount := pc
		obif := objfromptr(smdf.ptr)
		; init func refcount and base obj
		numput('uint', 1, 'uint', 0, 'ptr', objptraddref(native.prototype), smdf, A_PtrSize)
		; init func infos
		numput('ptr', strptr('User-MdFunc'), 'int', paramcount, 'int', minparams, 'int', isvariadic, smdf, 3 * A_PtrSize + 8)
		numput('ptr', 0, 'ptr', 0, objptr(smdf), 3 * A_PtrSize + 8)	; Avoid the memory of func object be freed when buffer is released
		return obif
	}
}

native_mcode(hex, argtypes := 0, &code := 0)
{
	static reg := "^([12]?).*" (c := a_ptrsize = 8 ? "x64" : "x86") ":([A-Za-z\d+/=]+)"
	if (regexmatch(hex, reg, &m))
		hex := m[2], flag := m[1] = "1" ? 4 : m[1] = "2" ? 1 : hex ~= "[+/=]" ? 1 : 4
	else
		flag := hex ~= "[+/=]" ? 1 : 4
	if (!dllcall("crypt32\CryptStringToBinary", "str", hex, "uint", 0, "uint", flag, "ptr", 0, "uint*", &s := 0, "ptr", 0, "ptr", 0))
		return
	code := buffer(s)
	if (dllcall("crypt32\CryptStringToBinary", "str", hex, "uint", 0, "uint", flag, "ptr", code, "uint*", &s, "ptr", 0, "ptr", 0) && dllcall("VirtualProtect", "ptr", code, "uint", s, "uint", 0x40, "uint*", 0))
    {
		args := []
		if (argtypes is array && argtypes.Length)
        {
			args.length := argtypes.length * 2 - 1
			for i, t in argtypes
				args[i * 2 - 1] := t
		}
		return dllcall.bind(code, args*)
	}
}
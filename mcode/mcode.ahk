#Include <data\debug>

/*
/FAc /O2 /D "_UNICODE" /D "UNICODE"
*/
mcode_from_godbolt(godbolt_text)
{
	mcode := ""
	loop parse godbolt_text, "`n", "`r"
		if regexmatch(A_LoopField, '^  [\da-f]{5,}(( [\da-f]{2})+)(?=( |$))', &m) || regexmatch(A_LoopField, '^\s+(([\da-f]{2} )+) ', &m)
			mcode .= strreplace(m[1], ' ')
	if dllcall("crypt32\CryptStringToBinary", "Str", mcode, "UInt", 0, "UInt", 8, "Ptr", 0, "Uint*", &s := 0, "Ptr", 0, "Ptr", 0) &&
		dllcall("Crypt32.dll\CryptStringToBinary", "Str", mcode, "UInt", 0, "UInt", 8, "Ptr", p := Buffer(s), "Uint*", &s, "Ptr", 0, "Ptr", 0) &&
		dllcall("crypt32\CryptBinaryToString", "Ptr", p, "UInt", s, "UInt", 0x40000001 , "Ptr", 0, "Uint*", &nSize := 0) &&
        (varsetstrcapacity(&varout, nSize << 1), dllcall("crypt32\CryptBinaryToString", "Ptr", p, "UInt", s, "UInt", 0x40000001 , "Str", varout, "Uint*", &nSize))
		return (varsetstrcapacity(&varout, -1), varout)
	return mcode
}
debug "2,x64:" mcode_from_godbolt("
(
aResultToken$ = 8
aParam$ = 16
aParamCount$ = 24
void ahkMemset(ResultToken &,ExprTokenType * * const,int) PROC ; ahkMemset, COMDAT
  00000 48 8b 42 10        mov   rax, QWORD PTR [rdx+16]
  00004 4c 8b ca   mov         r9, rdx
  00007 48 8b 08   mov         rcx, QWORD PTR [rax]
  0000a 48 8b 42 08        mov   rax, QWORD PTR [rdx+8]
  0000e 4c 63 01   movsxd      r8, DWORD PTR [rcx]
  00011 48 8b 10   mov         rdx, QWORD PTR [rax]
  00014 49 8b 01   mov         rax, QWORD PTR [r9]
  00017 8b 12        mov         edx, DWORD PTR [rdx]
  00019 48 8b 08   mov         rcx, QWORD PTR [rax]
  0001c 48 8b 09   mov         rcx, QWORD PTR [rcx]
  0001f e9 00 00 00 00     jmp     memset
void ahkMemset(ResultToken &,ExprTokenType * * const,int) ENDP ; ahkMemset
  )")
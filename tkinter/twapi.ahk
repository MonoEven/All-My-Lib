flag := Twapi.dll_file("tkinter\lib\twapi.dll")
if flag
    dllcall("LoadLibrary", "str", flag)
else
    throw error("twapi.dll is not existed.")

class Twapi
{
    static dll_file(dll_name)
    {
        if !dll_name
            return false
        if fileexist(dll_name)
            return dll_name
        else if fileexist(format("{}\lib\{}", regread("HKLM\SOFTWARE\AutoHotkey", "InstallDir", ""), dll_name))
            return format("{}\lib\{}", regread("HKLM\SOFTWARE\AutoHotkey", "InstallDir", ""), dll_name)
        else if fileexist(format("{}\lib\{}", a_scriptdir, dll_name))
            return format("{}\lib\{}", a_scriptdir, dll_name)
        else
            return false
    }
    
    static strBuffer(str, encoding := "utf-8")
    {
        buf := buffer(strput(str, encoding))
        strput(str, buf, encoding)
        return buf
    }
    
    static IPAddrObjFromDWORD(param*)
    {
        dllcall("twapi\IPAddrObjFromDWORD")
    }
    
    static IPAddrObjToDWORD(param*)
    {
        dllcall("twapi\IPAddrObjToDWORD")
    }
    
    static MemLifoAlloc(param*)
    {
        dllcall("twapi\MemLifoAlloc")
    }
    
    static MemLifoClose(param*)
    {
        dllcall("twapi\MemLifoClose")
    }
    
    static MemLifoCopy(param*)
    {
        dllcall("twapi\MemLifoCopy")
    }
    
    static MemLifoExpandLast(param*)
    {
        dllcall("twapi\MemLifoExpandLast")
    }
    
    static MemLifoInit(param*)
    {
        dllcall("twapi\MemLifoInit")
    }
    
    static MemLifoPopMark(param*)
    {
        dllcall("twapi\MemLifoPopMark")
    }
    
    static MemLifoPushFrame(param*)
    {
        dllcall("twapi\MemLifoPushFrame")
    }
    
    static MemLifoPushMark(param*)
    {
        dllcall("twapi\MemLifoPushMark")
    }
    
    static MemLifoResizeLast(param*)
    {
        dllcall("twapi\MemLifoResizeLast")
    }
    
    static MemLifoShrinkLast(param*)
    {
        dllcall("twapi\MemLifoShrinkLast")
    }
    
    static MemLifoValidate(param*)
    {
        dllcall("twapi\MemLifoValidate")
    }
    
    static MemLifoZeroes(param*)
    {
        dllcall("twapi\MemLifoZeroes")
    }
    
    static ObjAppendElement(param*)
    {
        dllcall("twapi\ObjAppendElement")
    }
    
    static ObjCastToCStruct(param*)
    {
        dllcall("twapi\ObjCastToCStruct")
    }
    
    static ObjCharLength(param*)
    {
        dllcall("twapi\ObjCharLength")
    }
    
    static ObjDecrArrayRefs(param*)
    {
        dllcall("twapi\ObjDecrArrayRefs")
    }
    
    static ObjDecrRefs(param*)
    {
        dllcall("twapi\ObjDecrRefs")
    }
    
    static ObjDecryptPassword(param*)
    {
        dllcall("twapi\ObjDecryptPassword")
    }
    
    static ObjDecryptUnicode(param*)
    {
        dllcall("twapi\ObjDecryptUnicode")
    }
    
    static ObjDictGet(param*)
    {
        dllcall("twapi\ObjDictGet")
    }
    
    static ObjDictPut(param*)
    {
        dllcall("twapi\ObjDictPut")
    }
    
    static ObjDuplicate(param*)
    {
        dllcall("twapi\ObjDuplicate")
    }
    
    static ObjEmptyList(param*)
    {
        dllcall("twapi\ObjEmptyList")
    }
    
    static ObjEncryptUnicode(param*)
    {
        dllcall("twapi\ObjEncryptUnicode")
    }
    
    static ObjFromACE(param*)
    {
        dllcall("twapi\ObjFromACE")
    }
    
    static ObjFromACL(param*)
    {
        dllcall("twapi\ObjFromACL")
    }
    
    static ObjFromArgvA(param*)
    {
        dllcall("twapi\ObjFromArgvA")
    }
    
    static ObjFromBSTR(param*)
    {
        dllcall("twapi\ObjFromBSTR")
    }
    
    static ObjFromBoolean(param*)
    {
        dllcall("twapi\ObjFromBoolean")
    }
    
    static ObjFromByteArray(param*)
    {
        dllcall("twapi\ObjFromByteArray")
    }
    
    static ObjFromCStruct(param*)
    {
        dllcall("twapi\ObjFromCStruct")
    }
    
    static ObjFromCY(param*)
    {
        dllcall("twapi\ObjFromCY")
    }
    
    static ObjFromDECIMAL(param*)
    {
        dllcall("twapi\ObjFromDECIMAL")
    }
    
    static ObjFromDouble(param*)
    {
        dllcall("twapi\ObjFromDouble")
    }
    
    static ObjFromEXPAND_SZW(param*)
    {
        dllcall("twapi\ObjFromEXPAND_SZW")
    }
    
    static ObjFromEmptyString(param*)
    {
        dllcall("twapi\ObjFromEmptyString")
    }
    
    static ObjFromFILETIME(param*)
    {
        dllcall("twapi\ObjFromFILETIME")
    }
    
    static ObjFromGUID(param*)
    {
        dllcall("twapi\ObjFromGUID")
    }
    
    static ObjFromIP_ADDR_STRING(param*)
    {
        dllcall("twapi\ObjFromIP_ADDR_STRING")
    }
    
    static ObjFromIPv6Addr(param*)
    {
        dllcall("twapi\ObjFromIPv6Addr")
    }
    
    static ObjFromLSA_UNICODE_STRING(param*)
    {
        dllcall("twapi\ObjFromLSA_UNICODE_STRING")
    }
    
    static ObjFromLUID(param*)
    {
        dllcall("twapi\ObjFromLUID")
    }
    
    static ObjFromLong(param*)
    {
        dllcall("twapi\ObjFromLong")
    }
    
    static ObjFromMultiSz(param*)
    {
        dllcall("twapi\ObjFromMultiSz")
    }
    
    static ObjFromOpaque(param*)
    {
        dllcall("twapi\ObjFromOpaque")
    }
    
    static ObjFromPIDL(param*)
    {
        dllcall("twapi\ObjFromPIDL")
    }
    
    static ObjFromPOINT(param*)
    {
        dllcall("twapi\ObjFromPOINT")
    }
    
    static ObjFromRECT(param*)
    {
        dllcall("twapi\ObjFromRECT")
    }
    
    static ObjFromRegValue(param*)
    {
        dllcall("twapi\ObjFromRegValue")
    }
    
    static ObjFromRegValueCooked(param*)
    {
        dllcall("twapi\ObjFromRegValueCooked")
    }
    
    static ObjFromSECURITY_DESCRIPTOR(param*)
    {
        dllcall("twapi\ObjFromSECURITY_DESCRIPTOR")
    }
    
    static ObjFromSID(param*)
    {
        dllcall("twapi\ObjFromSID")
    }
    
    static ObjFromSIDNoFail(param*)
    {
        dllcall("twapi\ObjFromSIDNoFail")
    }
    
    static ObjFromSOCKADDR(param*)
    {
        dllcall("twapi\ObjFromSOCKADDR")
    }
    
    static ObjFromSOCKADDR_address(param*)
    {
        dllcall("twapi\ObjFromSOCKADDR_address")
    }
    
    static ObjFromSYSTEMTIME(param*)
    {
        dllcall("twapi\ObjFromSYSTEMTIME")
    }
    
    static ObjFromString(param*)
    {
        dllcall("twapi\ObjFromString")
    }
    
    static ObjFromStringLimited(param*)
    {
        dllcall("twapi\ObjFromStringLimited")
    }
    
    static ObjFromStringN(param*)
    {
        dllcall("twapi\ObjFromStringN")
    }
    
    static ObjFromTIME_ZONE_INFORMATION(param*)
    {
        dllcall("twapi\ObjFromTIME_ZONE_INFORMATION")
    }
    
    static ObjFromUCHARHex(param*)
    {
        dllcall("twapi\ObjFromUCHARHex")
    }
    
    static ObjFromULONGHex(param*)
    {
        dllcall("twapi\ObjFromULONGHex")
    }
    
    static ObjFromULONGLONG(param*)
    {
        dllcall("twapi\ObjFromULONGLONG")
    }
    
    static ObjFromULONGLONGHex(param*)
    {
        dllcall("twapi\ObjFromULONGLONGHex")
    }
    
    static ObjFromUSHORTHex(param*)
    {
        dllcall("twapi\ObjFromUSHORTHex")
    }
    
    static ObjFromUUID(param*)
    {
        dllcall("twapi\ObjFromUUID")
    }
    
    static ObjFromUnicode(param*)
    {
        dllcall("twapi\ObjFromUnicode")
    }
    
    static ObjFromUnicodeLimited(param*)
    {
        dllcall("twapi\ObjFromUnicodeLimited")
    }
    
    static ObjFromUnicodeN(param*)
    {
        dllcall("twapi\ObjFromUnicodeN")
    }
    
    static ObjFromUnicodeNoTrailingSpace(param*)
    {
        dllcall("twapi\ObjFromUnicodeNoTrailingSpace")
    }
    
    static ObjFromVARIANT(param*)
    {
        dllcall("twapi\ObjFromVARIANT")
    }
    
    static ObjFromWideInt(param*)
    {
        dllcall("twapi\ObjFromWideInt")
    }
    
    static ObjGetElements(param*)
    {
        dllcall("twapi\ObjGetElements")
    }
    
    static ObjGetResult(param*)
    {
        dllcall("twapi\ObjGetResult")
    }
    
    static ObjIncrRefs(param*)
    {
        dllcall("twapi\ObjIncrRefs")
    }
    
    static ObjListIndex(param*)
    {
        dllcall("twapi\ObjListIndex")
    }
    
    static ObjListLength(param*)
    {
        dllcall("twapi\ObjListLength")
    }
    
    static ObjListReplace(param*)
    {
        dllcall("twapi\ObjListReplace")
    }
    
    static ObjNewDict(param*)
    {
        dllcall("twapi\ObjNewDict")
    }
    
    static ObjNewList(param*)
    {
        dllcall("twapi\ObjNewList")
    }
    
    static ObjSetResult(param*)
    {
        dllcall("twapi\ObjSetResult")
    }
    
    static ObjSetStaticResult(param*)
    {
        dllcall("twapi\ObjSetStaticResult")
    }
    
    static ObjToACE(param*)
    {
        dllcall("twapi\ObjToACE")
    }
    
    static ObjToArgvA(param*)
    {
        dllcall("twapi\ObjToArgvA")
    }
    
    static ObjToArgvW(param*)
    {
        dllcall("twapi\ObjToArgvW")
    }
    
    static ObjToBSTR(param*)
    {
        dllcall("twapi\ObjToBSTR")
    }
    
    static ObjToBoolean(param*)
    {
        dllcall("twapi\ObjToBoolean")
    }
    
    static ObjToByteArray(param*)
    {
        dllcall("twapi\ObjToByteArray")
    }
    
    static ObjToCHAR(param*)
    {
        dllcall("twapi\ObjToCHAR")
    }
    
    static ObjToCY(param*)
    {
        dllcall("twapi\ObjToCY")
    }
    
    static ObjToDECIMAL(param*)
    {
        dllcall("twapi\ObjToDECIMAL")
    }
    
    static ObjToDouble(param*)
    {
        dllcall("twapi\ObjToDouble")
    }
    
    static ObjToEnum(param*)
    {
        dllcall("twapi\ObjToEnum")
    }
    
    static ObjToFILETIME(param*)
    {
        dllcall("twapi\ObjToFILETIME")
    }
    
    static ObjToGUID(param*)
    {
        dllcall("twapi\ObjToGUID")
    }
    
    static ObjToGUID_NULL(param*)
    {
        dllcall("twapi\ObjToGUID_NULL")
    }
    
    static ObjToIDispatch(param*)
    {
        dllcall("twapi\ObjToIDispatch")
    }
    
    static ObjToLPVOID(param*)
    {
        dllcall("twapi\ObjToLPVOID")
    }
    
    static ObjToLPWSTR_NULL_IF_EMPTY(param*)
    {
        dllcall("twapi\ObjToLPWSTR_NULL_IF_EMPTY")
    }
    
    static ObjToLPWSTR_WITH_NULL(param*)
    {
        dllcall("twapi\ObjToLPWSTR_WITH_NULL")
    }
    
    static ObjToLSASTRINGARRAY(param*)
    {
        dllcall("twapi\ObjToLSASTRINGARRAY")
    }
    
    static ObjToLSA_UNICODE_STRING(param*)
    {
        dllcall("twapi\ObjToLSA_UNICODE_STRING")
    }
    
    static ObjToLUID(param*)
    {
        dllcall("twapi\ObjToLUID")
    }
    
    static ObjToLUID_NULL(param*)
    {
        dllcall("twapi\ObjToLUID_NULL")
    }
    
    static ObjToLong(param*)
    {
        dllcall("twapi\ObjToLong")
    }
    
    static ObjToMemLifoArgvW(param*)
    {
        dllcall("twapi\ObjToMemLifoArgvW")
    }
    
    static ObjToMultiSz(param*)
    {
        dllcall("twapi\ObjToMultiSz")
    }
    
    static ObjToMultiSzEx(param*)
    {
        dllcall("twapi\ObjToMultiSzEx")
    }
    
    static ObjToOpaque(param*)
    {
        dllcall("twapi\ObjToOpaque")
    }
    
    static ObjToOpaqueMulti(param*)
    {
        dllcall("twapi\ObjToOpaqueMulti")
    }
    
    static ObjToPACL(param*)
    {
        dllcall("twapi\ObjToPACL")
    }
    
    static ObjToPIDL(param*)
    {
        dllcall("twapi\ObjToPIDL")
    }
    
    static ObjToPOINT(param*)
    {
        dllcall("twapi\ObjToPOINT")
    }
    
    static ObjToPSECURITY_ATTRIBUTES(param*)
    {
        dllcall("twapi\ObjToPSECURITY_ATTRIBUTES")
    }
    
    static ObjToPSECURITY_DESCRIPTOR(param*)
    {
        dllcall("twapi\ObjToPSECURITY_DESCRIPTOR")
    }
    
    static ObjToPSID(param*)
    {
        dllcall("twapi\ObjToPSID")
    }
    
    static ObjToPSIDNonNull(param*)
    {
        dllcall("twapi\ObjToPSIDNonNull")
    }
    
    static ObjToRECT(param*)
    {
        dllcall("twapi\ObjToRECT")
    }
    
    static ObjToRECT_NULL(param*)
    {
        dllcall("twapi\ObjToRECT_NULL")
    }
    
    static ObjToRangedInt(param*)
    {
        dllcall("twapi\ObjToRangedInt")
    }
    
    static ObjToSHORT(param*)
    {
        dllcall("twapi\ObjToSHORT")
    }
    
    static ObjToSYSTEMTIME(param*)
    {
        dllcall("twapi\ObjToSYSTEMTIME")
    }
    
    static ObjToString(param*)
    {
        dllcall("twapi\ObjToString")
    }
    
    static ObjToStringN(param*)
    {
        dllcall("twapi\ObjToStringN")
    }
    
    static ObjToTIME_ZONE_INFORMATION(param*)
    {
        dllcall("twapi\ObjToTIME_ZONE_INFORMATION")
    }
    
    static ObjToUCHAR(param*)
    {
        dllcall("twapi\ObjToUCHAR")
    }
    
    static ObjToUSHORT(param*)
    {
        dllcall("twapi\ObjToUSHORT")
    }
    
    static ObjToUUID(param*)
    {
        dllcall("twapi\ObjToUUID")
    }
    
    static ObjToUUID_NULL(param*)
    {
        dllcall("twapi\ObjToUUID_NULL")
    }
    
    static ObjToUnicode(param*)
    {
        dllcall("twapi\ObjToUnicode")
    }
    
    static ObjToUnicodeN(param*)
    {
        dllcall("twapi\ObjToUnicodeN")
    }
    
    static ObjToVARIANT(param*)
    {
        dllcall("twapi\ObjToVARIANT")
    }
    
    static ObjToVT(param*)
    {
        dllcall("twapi\ObjToVT")
    }
    
    static ObjToVerifiedPointer(param*)
    {
        dllcall("twapi\ObjToVerifiedPointer")
    }
    
    static ObjToVerifiedPointerOrNull(param*)
    {
        dllcall("twapi\ObjToVerifiedPointerOrNull")
    }
    
    static ObjToVerifiedPointerOrNullTic(param*)
    {
        dllcall("twapi\ObjToVerifiedPointerOrNullTic")
    }
    
    static ObjToVerifiedPointerTic(param*)
    {
        dllcall("twapi\ObjToVerifiedPointerTic")
    }
    
    static ObjToWideInt(param*)
    {
        dllcall("twapi\ObjToWideInt")
    }
    
    static ObjTypeToVT(param*)
    {
        dllcall("twapi\ObjTypeToVT")
    }
    
    static ParsePSEC_WINNT_AUTH_IDENTITY(param*)
    {
        dllcall("twapi\ParsePSEC_WINNT_AUTH_IDENTITY")
    }
    
    static TwapiAlloc(param*)
    {
        dllcall("twapi\TwapiAlloc")
    }
    
    static TwapiAllocAString(param*)
    {
        dllcall("twapi\TwapiAllocAString")
    }
    
    static TwapiAllocAStringFromObj(param*)
    {
        dllcall("twapi\TwapiAllocAStringFromObj")
    }
    
    static TwapiAllocRegisteredPointer(param*)
    {
        dllcall("twapi\TwapiAllocRegisteredPointer")
    }
    
    static TwapiAllocSize(param*)
    {
        dllcall("twapi\TwapiAllocSize")
    }
    
    static TwapiAllocWString(param*)
    {
        dllcall("twapi\TwapiAllocWString")
    }
    
    static TwapiAllocWStringFromObj(param*)
    {
        dllcall("twapi\TwapiAllocWStringFromObj")
    }
    
    static TwapiAllocZero(param*)
    {
        dllcall("twapi\TwapiAllocZero")
    }
    
    static TwapiCStructParse(param*)
    {
        dllcall("twapi\TwapiCStructParse")
    }
    
    static TwapiCStructSize(param*)
    {
        dllcall("twapi\TwapiCStructSize")
    }
    
    static TwapiCallbackDelete(param*)
    {
        dllcall("twapi\TwapiCallbackDelete")
    }
    
    static TwapiCallbackNew(param*)
    {
        dllcall("twapi\TwapiCallbackNew")
    }
    
    static TwapiCallbackUnref(param*)
    {
        dllcall("twapi\TwapiCallbackUnref")
    }
    
    static TwapiClearResult(param*)
    {
        dllcall("twapi\TwapiClearResult")
    }
    
    static TwapiDebugOutput(param*)
    {
        dllcall("twapi\TwapiDebugOutput")
    }
    
    static TwapiDebugOutputObj(param*)
    {
        dllcall("twapi\TwapiDebugOutputObj")
    }
    
    static TwapiDefineAliasCmds(param*)
    {
        dllcall("twapi\TwapiDefineAliasCmds")
    }
    
    static TwapiDefineFncodeCmds(param*)
    {
        dllcall("twapi\TwapiDefineFncodeCmds")
    }
    
    static TwapiDefineTclCmds(param*)
    {
        dllcall("twapi\TwapiDefineTclCmds")
    }
    
    static TwapiDictLookupString(param*)
    {
        dllcall("twapi\TwapiDictLookupString")
    }
    
    static TwapiDoOneTimeInit(param*)
    {
        dllcall("twapi\TwapiDoOneTimeInit")
    }
    
    static TwapiEnqueueCallback(param*)
    {
        dllcall("twapi\TwapiEnqueueCallback")
    }
    
    static TwapiEnqueueTclEvent(param*)
    {
        dllcall("twapi\TwapiEnqueueTclEvent")
    }
    
    static TwapiEvalAndUpdateCallback(param*)
    {
        dllcall("twapi\TwapiEvalAndUpdateCallback")
    }
    
    static TwapiFree(param*)
    {
        dllcall("twapi\TwapiFree")
    }
    
    static TwapiFreeDecryptedPassword(param*)
    {
        dllcall("twapi\TwapiFreeDecryptedPassword")
    }
    
    static TwapiFreePIDL(param*)
    {
        dllcall("twapi\TwapiFreePIDL")
    }
    
    static TwapiFreeRegisteredPointer(param*)
    {
        dllcall("twapi\TwapiFreeRegisteredPointer")
    }
    
    static TwapiFreeSECURITY_ATTRIBUTES(param*)
    {
        dllcall("twapi\TwapiFreeSECURITY_ATTRIBUTES")
    }
    
    static TwapiFreeSECURITY_DESCRIPTOR(param*)
    {
        dllcall("twapi\TwapiFreeSECURITY_DESCRIPTOR")
    }
    
    static TwapiGetArgs(param*)
    {
        dllcall("twapi\TwapiGetArgs")
    }
    
    static TwapiGetArgsEx(param*)
    {
        dllcall("twapi\TwapiGetArgsEx")
    }
    
    static TwapiGetAtom(param*)
    {
        dllcall("twapi\TwapiGetAtom")
    }
    
    static TwapiGetDllVersion(param*)
    {
        dllcall("twapi\TwapiGetDllVersion")
    }
    
    static TwapiGetInstallDir(param*)
    {
        dllcall("twapi\TwapiGetInstallDir")
    }
    
    static TwapiGetSidFromStringRep(param*)
    {
        dllcall("twapi\TwapiGetSidFromStringRep")
    }
    
    static TwapiGetTclType(param*)
    {
        dllcall("twapi\TwapiGetTclType")
    }
    
    static TwapiInterpContextUnref(param*)
    {
        dllcall("twapi\TwapiInterpContextUnref")
    }
    
    static TwapiLowerCaseObj(param*)
    {
        dllcall("twapi\TwapiLowerCaseObj")
    }
    
    static TwapiLzmaFreeBuffer(param*)
    {
        dllcall("twapi\TwapiLzmaFreeBuffer")
    }
    
    static TwapiLzmaUncompressBuffer(param*)
    {
        dllcall("twapi\TwapiLzmaUncompressBuffer")
    }
    
    static TwapiMinOSVersion(param*)
    {
        dllcall("twapi\TwapiMinOSVersion")
    }
    
    static TwapiNTSTATUSToError(param*)
    {
        dllcall("twapi\TwapiNTSTATUSToError")
    }
    
    static TwapiPurgeAtoms(param*)
    {
        dllcall("twapi\TwapiPurgeAtoms")
    }
    
    static TwapiReallocTry(param*)
    {
        dllcall("twapi\TwapiReallocTry")
    }
    
    static TwapiRegisterCountedPointer(param*)
    {
        dllcall("twapi\TwapiRegisterCountedPointer")
    }
    
    static TwapiRegisterCountedPointerTic(param*)
    {
        dllcall("twapi\TwapiRegisterCountedPointerTic")
    }
    
    static TwapiRegisterModule(param*)
    {
        dllcall("twapi\TwapiRegisterModule")
    }
    
    static TwapiRegisterPointer(param*)
    {
        dllcall("twapi\TwapiRegisterPointer")
    }
    
    static TwapiRegisterPointerTic(param*)
    {
        dllcall("twapi\TwapiRegisterPointerTic")
    }
    
    static TwapiReturnError(param*)
    {
        dllcall("twapi\TwapiReturnError")
    }
    
    static TwapiReturnErrorEx(param*)
    {
        dllcall("twapi\TwapiReturnErrorEx")
    }
    
    static TwapiReturnErrorMsg(param*)
    {
        dllcall("twapi\TwapiReturnErrorMsg")
    }
    
    static TwapiReturnNonnullHandle(param*)
    {
        dllcall("twapi\TwapiReturnNonnullHandle")
    }
    
    static TwapiReturnSystemError(param*)
    {
        dllcall("twapi\TwapiReturnSystemError")
    }
    
    static TwapiRtlGetVersion(param*)
    {
        dllcall("twapi\TwapiRtlGetVersion")
    }
    
    static TwapiSetResult(param*)
    {
        dllcall("twapi\TwapiSetResult")
    }
    
    static TwapiTwine(param*)
    {
        dllcall("twapi\TwapiTwine")
    }
    
    static TwapiTwineObjv(param*)
    {
        dllcall("twapi\TwapiTwineObjv")
    }
    
    static TwapiUnregisterPointer(param*)
    {
        dllcall("twapi\TwapiUnregisterPointer")
    }
    
    static TwapiUnregisterPointerTic(param*)
    {
        dllcall("twapi\TwapiUnregisterPointerTic")
    }
    
    static TwapiUtf8ObjFromUnicode(param*)
    {
        dllcall("twapi\TwapiUtf8ObjFromUnicode")
    }
    
    static TwapiValidateSID(param*)
    {
        dllcall("twapi\TwapiValidateSID")
    }
    
    static TwapiVerifyPointer(param*)
    {
        dllcall("twapi\TwapiVerifyPointer")
    }
    
    static TwapiVerifyPointerTic(param*)
    {
        dllcall("twapi\TwapiVerifyPointerTic")
    }
    
    static TwapiWriteEventLogError(param*)
    {
        dllcall("twapi\TwapiWriteEventLogError")
    }
    
    static Twapi_AppendCOMError(param*)
    {
        dllcall("twapi\Twapi_AppendCOMError")
    }
    
    static Twapi_AppendLog(param*)
    {
        dllcall("twapi\Twapi_AppendLog")
    }
    
    static Twapi_AppendObjLog(param*)
    {
        dllcall("twapi\Twapi_AppendObjLog")
    }
    
    static Twapi_AppendSystemError(param*)
    {
        dllcall("twapi\Twapi_AppendSystemError")
    }
    
    static Twapi_AppendSystemErrorEx(param*)
    {
        dllcall("twapi\Twapi_AppendSystemErrorEx")
    }
    
    static Twapi_AppendWNetError(param*)
    {
        dllcall("twapi\Twapi_AppendWNetError")
    }
    
    static Twapi_AssignTlsSubSlot(param*)
    {
        dllcall("twapi\Twapi_AssignTlsSubSlot")
    }
    
    static Twapi_CheckThreadedTcl(param*)
    {
        dllcall("twapi\Twapi_CheckThreadedTcl")
    }
    
    static Twapi_CreateHiddenWindow(param*)
    {
        dllcall("twapi\Twapi_CreateHiddenWindow")
    }
    
    static Twapi_EnumWindowsCallback(param*)
    {
        dllcall("twapi\Twapi_EnumWindowsCallback")
    }
    
    static Twapi_GenerateWin32Error(param*)
    {
        dllcall("twapi\Twapi_GenerateWin32Error")
    }
    
    static Twapi_GetNotificationWindow(param*)
    {
        dllcall("twapi\Twapi_GetNotificationWindow")
    }
    
    static Twapi_GetTls(param*)
    {
        dllcall("twapi\Twapi_GetTls")
    }
    
    static Twapi_Init(interp)
    {
        return dllcall("twapi\Twapi_Init", "ptr", interp)
    }
    
    static Twapi_MakeTwapiErrorCodeObj(param*)
    {
        dllcall("twapi\Twapi_MakeTwapiErrorCodeObj")
    }
    
    static Twapi_MakeWindowsErrorCodeObj(param*)
    {
        dllcall("twapi\Twapi_MakeWindowsErrorCodeObj")
    }
    
    static Twapi_MapWindowsErrorToString(param*)
    {
        dllcall("twapi\Twapi_MapWindowsErrorToString")
    }
    
    static Twapi_NewId(param*)
    {
        dllcall("twapi\Twapi_NewId")
    }
    
    static Twapi_SetWindowLongPtr(param*)
    {
        dllcall("twapi\Twapi_SetWindowLongPtr")
    }
    
    static Twapi_SourceResource(param*)
    {
        dllcall("twapi\Twapi_SourceResource")
    }
    
    static Twapi_WrongLevelError(param*)
    {
        dllcall("twapi\Twapi_WrongLevelError")
    }
    
    static Twapi_base_Init(interp)
    {
        return dllcall("twapi\Twapi_base_Init", "ptr", interp)
    }
}
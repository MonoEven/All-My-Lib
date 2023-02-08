#Include <tkinter\tcl_const>

flag := Tcl.dll_file("tkinter\lib\tcl86t.dll")
if flag
    dllcall("LoadLibrary", "str", flag)
else
    throw error("tcl86t.dll is not existed.")

class Tcl extends Tcl_Const
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
    
    static TclAddLiteralObj(param*)
    {
        dllcall("tcl86t\TclAddLiteralObj")
    }
    
    static TclAllocateFreeObjects(param*)
    {
        dllcall("tcl86t\TclAllocateFreeObjects")
    }
    
    static TclBNInitBignumFromLong(param*)
    {
        dllcall("tcl86t\TclBNInitBignumFromLong")
    }
    
    static TclBNInitBignumFromWideInt(param*)
    {
        dllcall("tcl86t\TclBNInitBignumFromWideInt")
    }
    
    static TclBNInitBignumFromWideUInt(param*)
    {
        dllcall("tcl86t\TclBNInitBignumFromWideUInt")
    }
    
    static TclBN_epoch(param*)
    {
        dllcall("tcl86t\TclBN_epoch")
    }
    
    static TclBN_fast_s_mp_mul_digs(param*)
    {
        dllcall("tcl86t\TclBN_fast_s_mp_mul_digs")
    }
    
    static TclBN_fast_s_mp_sqr(param*)
    {
        dllcall("tcl86t\TclBN_fast_s_mp_sqr")
    }
    
    static TclBN_mp_add(param*)
    {
        dllcall("tcl86t\TclBN_mp_add")
    }
    
    static TclBN_mp_add_d(param*)
    {
        dllcall("tcl86t\TclBN_mp_add_d")
    }
    
    static TclBN_mp_and(param*)
    {
        dllcall("tcl86t\TclBN_mp_and")
    }
    
    static TclBN_mp_clamp(param*)
    {
        dllcall("tcl86t\TclBN_mp_clamp")
    }
    
    static TclBN_mp_clear(param*)
    {
        dllcall("tcl86t\TclBN_mp_clear")
    }
    
    static TclBN_mp_clear_multi(param*)
    {
        dllcall("tcl86t\TclBN_mp_clear_multi")
    }
    
    static TclBN_mp_cmp(param*)
    {
        dllcall("tcl86t\TclBN_mp_cmp")
    }
    
    static TclBN_mp_cmp_d(param*)
    {
        dllcall("tcl86t\TclBN_mp_cmp_d")
    }
    
    static TclBN_mp_cmp_mag(param*)
    {
        dllcall("tcl86t\TclBN_mp_cmp_mag")
    }
    
    static TclBN_mp_cnt_lsb(param*)
    {
        dllcall("tcl86t\TclBN_mp_cnt_lsb")
    }
    
    static TclBN_mp_copy(param*)
    {
        dllcall("tcl86t\TclBN_mp_copy")
    }
    
    static TclBN_mp_count_bits(param*)
    {
        dllcall("tcl86t\TclBN_mp_count_bits")
    }
    
    static TclBN_mp_div(param*)
    {
        dllcall("tcl86t\TclBN_mp_div")
    }
    
    static TclBN_mp_div_2(param*)
    {
        dllcall("tcl86t\TclBN_mp_div_2")
    }
    
    static TclBN_mp_div_2d(param*)
    {
        dllcall("tcl86t\TclBN_mp_div_2d")
    }
    
    static TclBN_mp_div_3(param*)
    {
        dllcall("tcl86t\TclBN_mp_div_3")
    }
    
    static TclBN_mp_div_d(param*)
    {
        dllcall("tcl86t\TclBN_mp_div_d")
    }
    
    static TclBN_mp_exch(param*)
    {
        dllcall("tcl86t\TclBN_mp_exch")
    }
    
    static TclBN_mp_expt_d(param*)
    {
        dllcall("tcl86t\TclBN_mp_expt_d")
    }
    
    static TclBN_mp_expt_d_ex(param*)
    {
        dllcall("tcl86t\TclBN_mp_expt_d_ex")
    }
    
    static TclBN_mp_get_mag_ull(param*)
    {
        dllcall("tcl86t\TclBN_mp_get_mag_ull")
    }
    
    static TclBN_mp_grow(param*)
    {
        dllcall("tcl86t\TclBN_mp_grow")
    }
    
    static TclBN_mp_init(param*)
    {
        dllcall("tcl86t\TclBN_mp_init")
    }
    
    static TclBN_mp_init_copy(param*)
    {
        dllcall("tcl86t\TclBN_mp_init_copy")
    }
    
    static TclBN_mp_init_multi(param*)
    {
        dllcall("tcl86t\TclBN_mp_init_multi")
    }
    
    static TclBN_mp_init_set(param*)
    {
        dllcall("tcl86t\TclBN_mp_init_set")
    }
    
    static TclBN_mp_init_set_int(param*)
    {
        dllcall("tcl86t\TclBN_mp_init_set_int")
    }
    
    static TclBN_mp_init_size(param*)
    {
        dllcall("tcl86t\TclBN_mp_init_size")
    }
    
    static TclBN_mp_karatsuba_mul(param*)
    {
        dllcall("tcl86t\TclBN_mp_karatsuba_mul")
    }
    
    static TclBN_mp_karatsuba_sqr(param*)
    {
        dllcall("tcl86t\TclBN_mp_karatsuba_sqr")
    }
    
    static TclBN_mp_lshd(param*)
    {
        dllcall("tcl86t\TclBN_mp_lshd")
    }
    
    static TclBN_mp_mod(param*)
    {
        dllcall("tcl86t\TclBN_mp_mod")
    }
    
    static TclBN_mp_mod_2d(param*)
    {
        dllcall("tcl86t\TclBN_mp_mod_2d")
    }
    
    static TclBN_mp_mul(param*)
    {
        dllcall("tcl86t\TclBN_mp_mul")
    }
    
    static TclBN_mp_mul_2(param*)
    {
        dllcall("tcl86t\TclBN_mp_mul_2")
    }
    
    static TclBN_mp_mul_2d(param*)
    {
        dllcall("tcl86t\TclBN_mp_mul_2d")
    }
    
    static TclBN_mp_mul_d(param*)
    {
        dllcall("tcl86t\TclBN_mp_mul_d")
    }
    
    static TclBN_mp_neg(param*)
    {
        dllcall("tcl86t\TclBN_mp_neg")
    }
    
    static TclBN_mp_or(param*)
    {
        dllcall("tcl86t\TclBN_mp_or")
    }
    
    static TclBN_mp_radix_size(param*)
    {
        dllcall("tcl86t\TclBN_mp_radix_size")
    }
    
    static TclBN_mp_read_radix(param*)
    {
        dllcall("tcl86t\TclBN_mp_read_radix")
    }
    
    static TclBN_mp_rshd(param*)
    {
        dllcall("tcl86t\TclBN_mp_rshd")
    }
    
    static TclBN_mp_set(param*)
    {
        dllcall("tcl86t\TclBN_mp_set")
    }
    
    static TclBN_mp_set_int(param*)
    {
        dllcall("tcl86t\TclBN_mp_set_int")
    }
    
    static TclBN_mp_set_ll(param*)
    {
        dllcall("tcl86t\TclBN_mp_set_ll")
    }
    
    static TclBN_mp_set_ull(param*)
    {
        dllcall("tcl86t\TclBN_mp_set_ull")
    }
    
    static TclBN_mp_shrink(param*)
    {
        dllcall("tcl86t\TclBN_mp_shrink")
    }
    
    static TclBN_mp_signed_rsh(param*)
    {
        dllcall("tcl86t\TclBN_mp_signed_rsh")
    }
    
    static TclBN_mp_sqr(param*)
    {
        dllcall("tcl86t\TclBN_mp_sqr")
    }
    
    static TclBN_mp_sqrt(param*)
    {
        dllcall("tcl86t\TclBN_mp_sqrt")
    }
    
    static TclBN_mp_sub(param*)
    {
        dllcall("tcl86t\TclBN_mp_sub")
    }
    
    static TclBN_mp_sub_d(param*)
    {
        dllcall("tcl86t\TclBN_mp_sub_d")
    }
    
    static TclBN_mp_to_radix(param*)
    {
        dllcall("tcl86t\TclBN_mp_to_radix")
    }
    
    static TclBN_mp_to_ubin(param*)
    {
        dllcall("tcl86t\TclBN_mp_to_ubin")
    }
    
    static TclBN_mp_to_unsigned_bin(param*)
    {
        dllcall("tcl86t\TclBN_mp_to_unsigned_bin")
    }
    
    static TclBN_mp_to_unsigned_bin_n(param*)
    {
        dllcall("tcl86t\TclBN_mp_to_unsigned_bin_n")
    }
    
    static TclBN_mp_toom_mul(param*)
    {
        dllcall("tcl86t\TclBN_mp_toom_mul")
    }
    
    static TclBN_mp_toom_sqr(param*)
    {
        dllcall("tcl86t\TclBN_mp_toom_sqr")
    }
    
    static TclBN_mp_toradix_n(param*)
    {
        dllcall("tcl86t\TclBN_mp_toradix_n")
    }
    
    static TclBN_mp_unsigned_bin_size(param*)
    {
        dllcall("tcl86t\TclBN_mp_unsigned_bin_size")
    }
    
    static TclBN_mp_xor(param*)
    {
        dllcall("tcl86t\TclBN_mp_xor")
    }
    
    static TclBN_mp_zero(param*)
    {
        dllcall("tcl86t\TclBN_mp_zero")
    }
    
    static TclBN_reverse(param*)
    {
        dllcall("tcl86t\TclBN_reverse")
    }
    
    static TclBN_revision(param*)
    {
        dllcall("tcl86t\TclBN_revision")
    }
    
    static TclBN_s_mp_add(param*)
    {
        dllcall("tcl86t\TclBN_s_mp_add")
    }
    
    static TclBN_s_mp_mul_digs(param*)
    {
        dllcall("tcl86t\TclBN_s_mp_mul_digs")
    }
    
    static TclBN_s_mp_sqr(param*)
    {
        dllcall("tcl86t\TclBN_s_mp_sqr")
    }
    
    static TclBN_s_mp_sub(param*)
    {
        dllcall("tcl86t\TclBN_s_mp_sub")
    }
    
    static TclCallVarTraces(param*)
    {
        dllcall("tcl86t\TclCallVarTraces")
    }
    
    static TclChannelEventScriptInvoker(param*)
    {
        dllcall("tcl86t\TclChannelEventScriptInvoker")
    }
    
    static TclChannelTransform(param*)
    {
        dllcall("tcl86t\TclChannelTransform")
    }
    
    static TclCheckExecutionTraces(param*)
    {
        dllcall("tcl86t\TclCheckExecutionTraces")
    }
    
    static TclCheckInterpTraces(param*)
    {
        dllcall("tcl86t\TclCheckInterpTraces")
    }
    
    static TclCleanupChildren(param*)
    {
        dllcall("tcl86t\TclCleanupChildren")
    }
    
    static TclCleanupCommand(param*)
    {
        dllcall("tcl86t\TclCleanupCommand")
    }
    
    static TclCleanupVar(param*)
    {
        dllcall("tcl86t\TclCleanupVar")
    }
    
    static TclCopyAndCollapse(param*)
    {
        dllcall("tcl86t\TclCopyAndCollapse")
    }
    
    static TclCopyChannel(param*)
    {
        dllcall("tcl86t\TclCopyChannel")
    }
    
    static TclCopyChannelOld(param*)
    {
        dllcall("tcl86t\TclCopyChannelOld")
    }
    
    static TclCreatePipeline(param*)
    {
        dllcall("tcl86t\TclCreatePipeline")
    }
    
    static TclCreateProc(param*)
    {
        dllcall("tcl86t\TclCreateProc")
    }
    
    static TclDbDumpActiveObjects(param*)
    {
        dllcall("tcl86t\TclDbDumpActiveObjects")
    }
    
    static TclDeleteCompiledLocalVars(param*)
    {
        dllcall("tcl86t\TclDeleteCompiledLocalVars")
    }
    
    static TclDeleteVars(param*)
    {
        dllcall("tcl86t\TclDeleteVars")
    }
    
    static TclDoubleDigits(param*)
    {
        dllcall("tcl86t\TclDoubleDigits")
    }
    
    static TclDumpMemoryInfo(param*)
    {
        dllcall("tcl86t\TclDumpMemoryInfo")
    }
    
    static TclEvalObjEx(param*)
    {
        dllcall("tcl86t\TclEvalObjEx")
    }
    
    static TclExpandCodeArray(param*)
    {
        dllcall("tcl86t\TclExpandCodeArray")
    }
    
    static TclExprFloatError(param*)
    {
        dllcall("tcl86t\TclExprFloatError")
    }
    
    static TclFindElement(param*)
    {
        dllcall("tcl86t\TclFindElement")
    }
    
    static TclFindProc(param*)
    {
        dllcall("tcl86t\TclFindProc")
    }
    
    static TclFormatInt(param*)
    {
        dllcall("tcl86t\TclFormatInt")
    }
    
    static TclFreeObj(param*)
    {
        dllcall("tcl86t\TclFreeObj")
    }
    
    static TclFreePackageInfo(param*)
    {
        dllcall("tcl86t\TclFreePackageInfo")
    }
    
    static TclGetAndDetachPids(param*)
    {
        dllcall("tcl86t\TclGetAndDetachPids")
    }
    
    static TclGetAuxDataType(param*)
    {
        dllcall("tcl86t\TclGetAuxDataType")
    }
    
    static TclGetEnv(param*)
    {
        dllcall("tcl86t\TclGetEnv")
    }
    
    static TclGetExtension(param*)
    {
        dllcall("tcl86t\TclGetExtension")
    }
    
    static TclGetFrame(param*)
    {
        dllcall("tcl86t\TclGetFrame")
    }
    
    static TclGetInstructionTable(param*)
    {
        dllcall("tcl86t\TclGetInstructionTable")
    }
    
    static TclGetIntForIndex(param*)
    {
        dllcall("tcl86t\TclGetIntForIndex")
    }
    
    static TclGetLibraryPath(param*)
    {
        dllcall("tcl86t\TclGetLibraryPath")
    }
    
    static TclGetLoadedPackages(param*)
    {
        dllcall("tcl86t\TclGetLoadedPackages")
    }
    
    static TclGetNamespaceChildTable(param*)
    {
        dllcall("tcl86t\TclGetNamespaceChildTable")
    }
    
    static TclGetNamespaceCommandTable(param*)
    {
        dllcall("tcl86t\TclGetNamespaceCommandTable")
    }
    
    static TclGetNamespaceForQualName(param*)
    {
        dllcall("tcl86t\TclGetNamespaceForQualName")
    }
    
    static TclGetNamespaceFromObj(param*)
    {
        dllcall("tcl86t\TclGetNamespaceFromObj")
    }
    
    static TclGetObjInterpProc(param*)
    {
        dllcall("tcl86t\TclGetObjInterpProc")
    }
    
    static TclGetObjNameOfExecutable(param*)
    {
        dllcall("tcl86t\TclGetObjNameOfExecutable")
    }
    
    static TclGetOpenMode(param*)
    {
        dllcall("tcl86t\TclGetOpenMode")
    }
    
    static TclGetOriginalCommand(param*)
    {
        dllcall("tcl86t\TclGetOriginalCommand")
    }
    
    static TclGetPlatform(param*)
    {
        dllcall("tcl86t\TclGetPlatform")
    }
    
    static TclGetSrcInfoForPc(param*)
    {
        dllcall("tcl86t\TclGetSrcInfoForPc")
    }
    
    static TclGuessPackageName(param*)
    {
        dllcall("tcl86t\TclGuessPackageName")
    }
    
    static TclHandleCreate(param*)
    {
        dllcall("tcl86t\TclHandleCreate")
    }
    
    static TclHandleFree(param*)
    {
        dllcall("tcl86t\TclHandleFree")
    }
    
    static TclHandlePreserve(param*)
    {
        dllcall("tcl86t\TclHandlePreserve")
    }
    
    static TclHandleRelease(param*)
    {
        dllcall("tcl86t\TclHandleRelease")
    }
    
    static TclHideLiteral(param*)
    {
        dllcall("tcl86t\TclHideLiteral")
    }
    
    static TclHideUnsafeCommands(param*)
    {
        dllcall("tcl86t\TclHideUnsafeCommands")
    }
    
    static TclInExit(param*)
    {
        dllcall("tcl86t\TclInExit")
    }
    
    static TclInThreadExit(param*)
    {
        dllcall("tcl86t\TclInThreadExit")
    }
    
    static TclInitCompiledLocals(param*)
    {
        dllcall("tcl86t\TclInitCompiledLocals")
    }
    
    static TclInitRewriteEnsemble(param*)
    {
        dllcall("tcl86t\TclInitRewriteEnsemble")
    }
    
    static TclInitVarHashTable(param*)
    {
        dllcall("tcl86t\TclInitVarHashTable")
    }
    
    static TclInterpInit(param*)
    {
        dllcall("tcl86t\TclInterpInit")
    }
    
    static TclInvokeObjectCommand(param*)
    {
        dllcall("tcl86t\TclInvokeObjectCommand")
    }
    
    static TclInvokeStringCommand(param*)
    {
        dllcall("tcl86t\TclInvokeStringCommand")
    }
    
    static TclIsProc(param*)
    {
        dllcall("tcl86t\TclIsProc")
    }
    
    static TclListObjSetElement(param*)
    {
        dllcall("tcl86t\TclListObjSetElement")
    }
    
    static TclLookupVar(param*)
    {
        dllcall("tcl86t\TclLookupVar")
    }
    
    static TclNREvalObjEx(param*)
    {
        dllcall("tcl86t\TclNREvalObjEx")
    }
    
    static TclNREvalObjv(param*)
    {
        dllcall("tcl86t\TclNREvalObjv")
    }
    
    static TclNRInterpProc(param*)
    {
        dllcall("tcl86t\TclNRInterpProc")
    }
    
    static TclNRInterpProcCore(param*)
    {
        dllcall("tcl86t\TclNRInterpProcCore")
    }
    
    static TclNRRunCallbacks(param*)
    {
        dllcall("tcl86t\TclNRRunCallbacks")
    }
    
    static TclNeedSpace(param*)
    {
        dllcall("tcl86t\TclNeedSpace")
    }
    
    static TclNewProcBodyObj(param*)
    {
        dllcall("tcl86t\TclNewProcBodyObj")
    }
    
    static TclObjBeingDeleted(param*)
    {
        dllcall("tcl86t\TclObjBeingDeleted")
    }
    
    static TclObjCommandComplete(param*)
    {
        dllcall("tcl86t\TclObjCommandComplete")
    }
    
    static TclObjGetFrame(param*)
    {
        dllcall("tcl86t\TclObjGetFrame")
    }
    
    static TclObjInterpProc(param*)
    {
        dllcall("tcl86t\TclObjInterpProc")
    }
    
    static TclObjInvoke(param*)
    {
        dllcall("tcl86t\TclObjInvoke")
    }
    
    static TclObjLookupVar(param*)
    {
        dllcall("tcl86t\TclObjLookupVar")
    }
    
    static TclPopStackFrame(param*)
    {
        dllcall("tcl86t\TclPopStackFrame")
    }
    
    static TclPrecTraceProc(param*)
    {
        dllcall("tcl86t\TclPrecTraceProc")
    }
    
    static TclPreventAliasLoop(param*)
    {
        dllcall("tcl86t\TclPreventAliasLoop")
    }
    
    static TclProcCleanupProc(param*)
    {
        dllcall("tcl86t\TclProcCleanupProc")
    }
    
    static TclProcCompileProc(param*)
    {
        dllcall("tcl86t\TclProcCompileProc")
    }
    
    static TclProcDeleteProc(param*)
    {
        dllcall("tcl86t\TclProcDeleteProc")
    }
    
    static TclPtrGetVar(param*)
    {
        dllcall("tcl86t\TclPtrGetVar")
    }
    
    static TclPtrIncrObjVar(param*)
    {
        dllcall("tcl86t\TclPtrIncrObjVar")
    }
    
    static TclPtrMakeUpvar(param*)
    {
        dllcall("tcl86t\TclPtrMakeUpvar")
    }
    
    static TclPtrObjMakeUpvar(param*)
    {
        dllcall("tcl86t\TclPtrObjMakeUpvar")
    }
    
    static TclPtrSetVar(param*)
    {
        dllcall("tcl86t\TclPtrSetVar")
    }
    
    static TclPtrUnsetVar(param*)
    {
        dllcall("tcl86t\TclPtrUnsetVar")
    }
    
    static TclPushStackFrame(param*)
    {
        dllcall("tcl86t\TclPushStackFrame")
    }
    
    static TclRegAbout(param*)
    {
        dllcall("tcl86t\TclRegAbout")
    }
    
    static TclRegError(param*)
    {
        dllcall("tcl86t\TclRegError")
    }
    
    static TclRegExpRangeUniChar(param*)
    {
        dllcall("tcl86t\TclRegExpRangeUniChar")
    }
    
    static TclRegisterLiteral(param*)
    {
        dllcall("tcl86t\TclRegisterLiteral")
    }
    
    static TclRenameCommand(param*)
    {
        dllcall("tcl86t\TclRenameCommand")
    }
    
    static TclResetCancellation(param*)
    {
        dllcall("tcl86t\TclResetCancellation")
    }
    
    static TclResetRewriteEnsemble(param*)
    {
        dllcall("tcl86t\TclResetRewriteEnsemble")
    }
    
    static TclResetShadowedCmdRefs(param*)
    {
        dllcall("tcl86t\TclResetShadowedCmdRefs")
    }
    
    static TclServiceIdle(param*)
    {
        dllcall("tcl86t\TclServiceIdle")
    }
    
    static TclSetByteCodeFromAny(param*)
    {
        dllcall("tcl86t\TclSetByteCodeFromAny")
    }
    
    static TclSetLibraryPath(param*)
    {
        dllcall("tcl86t\TclSetLibraryPath")
    }
    
    static TclSetNsPath(param*)
    {
        dllcall("tcl86t\TclSetNsPath")
    }
    
    static TclSetObjNameOfExecutable(param*)
    {
        dllcall("tcl86t\TclSetObjNameOfExecutable")
    }
    
    static TclSetPreInitScript(param*)
    {
        dllcall("tcl86t\TclSetPreInitScript")
    }
    
    static TclSetSlaveCancelFlags(param*)
    {
        dllcall("tcl86t\TclSetSlaveCancelFlags")
    }
    
    static TclSetupEnv(param*)
    {
        dllcall("tcl86t\TclSetupEnv")
    }
    
    static TclSockGetPort(param*)
    {
        dllcall("tcl86t\TclSockGetPort")
    }
    
    static TclSockMinimumBuffers(param*)
    {
        dllcall("tcl86t\TclSockMinimumBuffers")
    }
    
    static TclStackAlloc(param*)
    {
        dllcall("tcl86t\TclStackAlloc")
    }
    
    static TclStackFree(param*)
    {
        dllcall("tcl86t\TclStackFree")
    }
    
    static TclTeardownNamespace(param*)
    {
        dllcall("tcl86t\TclTeardownNamespace")
    }
    
    static TclTraceDictPath(param*)
    {
        dllcall("tcl86t\TclTraceDictPath")
    }
    
    static TclUniCharMatch(param*)
    {
        dllcall("tcl86t\TclUniCharMatch")
    }
    
    static TclUpdateReturnInfo(param*)
    {
        dllcall("tcl86t\TclUpdateReturnInfo")
    }
    
    static TclVarErrMsg(param*)
    {
        dllcall("tcl86t\TclVarErrMsg")
    }
    
    static TclVarHashCreateVar(param*)
    {
        dllcall("tcl86t\TclVarHashCreateVar")
    }
    
    static TclVarTraceExists(param*)
    {
        dllcall("tcl86t\TclVarTraceExists")
    }
    
    static TclWinAddProcess(param*)
    {
        dllcall("tcl86t\TclWinAddProcess")
    }
    
    static TclWinCPUID(param*)
    {
        dllcall("tcl86t\TclWinCPUID")
    }
    
    static TclWinConvertError(param*)
    {
        dllcall("tcl86t\TclWinConvertError")
    }
    
    static TclWinFlushDirtyChannels(param*)
    {
        dllcall("tcl86t\TclWinFlushDirtyChannels")
    }
    
    static TclWinGetPlatformId(param*)
    {
        dllcall("tcl86t\TclWinGetPlatformId")
    }
    
    static TclWinGetServByName(param*)
    {
        dllcall("tcl86t\TclWinGetServByName")
    }
    
    static TclWinGetSockOpt(param*)
    {
        dllcall("tcl86t\TclWinGetSockOpt")
    }
    
    static TclWinGetTclInstance(param*)
    {
        dllcall("tcl86t\TclWinGetTclInstance")
    }
    
    static TclWinNoBackslash(param*)
    {
        dllcall("tcl86t\TclWinNoBackslash")
    }
    
    static TclWinResetInterfaces(param*)
    {
        dllcall("tcl86t\TclWinResetInterfaces")
    }
    
    static TclWinSetInterfaces(param*)
    {
        dllcall("tcl86t\TclWinSetInterfaces")
    }
    
    static TclWinSetSockOpt(param*)
    {
        dllcall("tcl86t\TclWinSetSockOpt")
    }
    
    static Tcl_Access(param*)
    {
        dllcall("tcl86t\Tcl_Access")
    }
    
    static Tcl_AddErrorInfo(param*)
    {
        dllcall("tcl86t\Tcl_AddErrorInfo")
    }
    
    static Tcl_AddInterpResolvers(param*)
    {
        dllcall("tcl86t\Tcl_AddInterpResolvers")
    }
    
    static Tcl_AddObjErrorInfo(param*)
    {
        dllcall("tcl86t\Tcl_AddObjErrorInfo")
    }
    
    static Tcl_AlertNotifier(clientData)
    {
        dllcall("tcl86t\Tcl_AlertNotifier", "ptr", clientData)
    }
    
    static Tcl_Alloc(param*)
    {
        dllcall("tcl86t\Tcl_Alloc")
    }
    
    static Tcl_AllocStatBuf(param*)
    {
        dllcall("tcl86t\Tcl_AllocStatBuf")
    }
    
    static Tcl_AllowExceptions(param*)
    {
        dllcall("tcl86t\Tcl_AllowExceptions")
    }
    
    static Tcl_AppendAllObjTypes(interp, objPtr) ; => int
    {
        return dllcall("tcl86t\Tcl_AppendAllObjTypes", "ptr", interp, "ptr", objPtr)
    }
    
    static Tcl_AppendElement(interp, string)
    {
        dllcall("tcl86t\Tcl_AppendElement", "ptr", interp, "ptr", this.strBuffer(string))
    }
    
    static Tcl_AppendExportList(param*)
    {
        dllcall("tcl86t\Tcl_AppendExportList")
    }
    
    static Tcl_AppendFormatToObj(param*)
    {
        dllcall("tcl86t\Tcl_AppendFormatToObj")
    }
    
    static Tcl_AppendLimitedToObj(param*)
    {
        dllcall("tcl86t\Tcl_AppendLimitedToObj")
    }
    
    static Tcl_AppendObjToErrorInfo(param*)
    {
        dllcall("tcl86t\Tcl_AppendObjToErrorInfo")
    }
    
    static Tcl_AppendObjToObj(param*)
    {
        dllcall("tcl86t\Tcl_AppendObjToObj")
    }
    
    static Tcl_AppendPrintfToObj(param*)
    {
        dllcall("tcl86t\Tcl_AppendPrintfToObj")
    }
    
    static Tcl_AppendResult(interp, string*)
    {
        fn := dllcall("tcl86t\Tcl_AppendResult", "ptr", interp)
        for i in string
            fn := fn.bind("ptr", this.strBuffer(i))
        fn()
    }
    
    static Tcl_AppendResultVA(interp, argList)
    {
        dllcall("tcl86t\Tcl_AppendResultVA", "ptr", interp, "ptr", argList)
    }
    
    static Tcl_AppendStringsToObj(param*)
    {
        dllcall("tcl86t\Tcl_AppendStringsToObj")
    }
    
    static Tcl_AppendStringsToObjVA(param*)
    {
        dllcall("tcl86t\Tcl_AppendStringsToObjVA")
    }
    
    static Tcl_AppendToObj(param*)
    {
        dllcall("tcl86t\Tcl_AppendToObj")
    }
    
    static Tcl_AppendUnicodeToObj(param*)
    {
        dllcall("tcl86t\Tcl_AppendUnicodeToObj")
    }
    
    static Tcl_AsyncCreate(param*)
    {
        dllcall("tcl86t\Tcl_AsyncCreate")
    }
    
    static Tcl_AsyncDelete(param*)
    {
        dllcall("tcl86t\Tcl_AsyncDelete")
    }
    
    static Tcl_AsyncInvoke(param*)
    {
        dllcall("tcl86t\Tcl_AsyncInvoke")
    }
    
    static Tcl_AsyncMark(param*)
    {
        dllcall("tcl86t\Tcl_AsyncMark")
    }
    
    static Tcl_AsyncReady(param*)
    {
        dllcall("tcl86t\Tcl_AsyncReady")
    }
    
    static Tcl_AttemptAlloc(param*)
    {
        dllcall("tcl86t\Tcl_AttemptAlloc")
    }
    
    static Tcl_AttemptDbCkalloc(param*)
    {
        dllcall("tcl86t\Tcl_AttemptDbCkalloc")
    }
    
    static Tcl_AttemptDbCkrealloc(param*)
    {
        dllcall("tcl86t\Tcl_AttemptDbCkrealloc")
    }
    
    static Tcl_AttemptRealloc(param*)
    {
        dllcall("tcl86t\Tcl_AttemptRealloc")
    }
    
    static Tcl_AttemptSetObjLength(param*)
    {
        dllcall("tcl86t\Tcl_AttemptSetObjLength")
    }
    
    static Tcl_BackgroundError(param*)
    {
        dllcall("tcl86t\Tcl_BackgroundError")
    }
    
    static Tcl_BackgroundException(param*)
    {
        dllcall("tcl86t\Tcl_BackgroundException")
    }
    
    static Tcl_Backslash(param*)
    {
        dllcall("tcl86t\Tcl_Backslash")
    }
    
    static Tcl_BadChannelOption(param*)
    {
        dllcall("tcl86t\Tcl_BadChannelOption")
    }
    
    static Tcl_CallWhenDeleted(param*)
    {
        dllcall("tcl86t\Tcl_CallWhenDeleted")
    }
    
    static Tcl_CancelEval(param*)
    {
        dllcall("tcl86t\Tcl_CancelEval")
    }
    
    static Tcl_CancelIdleCall(param*)
    {
        dllcall("tcl86t\Tcl_CancelIdleCall")
    }
    
    static Tcl_Canceled(param*)
    {
        dllcall("tcl86t\Tcl_Canceled")
    }
    
    static Tcl_ChannelBlockModeProc(param*)
    {
        dllcall("tcl86t\Tcl_ChannelBlockModeProc")
    }
    
    static Tcl_ChannelBuffered(param*)
    {
        dllcall("tcl86t\Tcl_ChannelBuffered")
    }
    
    static Tcl_ChannelClose2Proc(param*)
    {
        dllcall("tcl86t\Tcl_ChannelClose2Proc")
    }
    
    static Tcl_ChannelCloseProc(param*)
    {
        dllcall("tcl86t\Tcl_ChannelCloseProc")
    }
    
    static Tcl_ChannelFlushProc(param*)
    {
        dllcall("tcl86t\Tcl_ChannelFlushProc")
    }
    
    static Tcl_ChannelGetHandleProc(param*)
    {
        dllcall("tcl86t\Tcl_ChannelGetHandleProc")
    }
    
    static Tcl_ChannelGetOptionProc(param*)
    {
        dllcall("tcl86t\Tcl_ChannelGetOptionProc")
    }
    
    static Tcl_ChannelHandlerProc(param*)
    {
        dllcall("tcl86t\Tcl_ChannelHandlerProc")
    }
    
    static Tcl_ChannelInputProc(param*)
    {
        dllcall("tcl86t\Tcl_ChannelInputProc")
    }
    
    static Tcl_ChannelName(param*)
    {
        dllcall("tcl86t\Tcl_ChannelName")
    }
    
    static Tcl_ChannelOutputProc(param*)
    {
        dllcall("tcl86t\Tcl_ChannelOutputProc")
    }
    
    static Tcl_ChannelSeekProc(param*)
    {
        dllcall("tcl86t\Tcl_ChannelSeekProc")
    }
    
    static Tcl_ChannelSetOptionProc(param*)
    {
        dllcall("tcl86t\Tcl_ChannelSetOptionProc")
    }
    
    static Tcl_ChannelThreadActionProc(param*)
    {
        dllcall("tcl86t\Tcl_ChannelThreadActionProc")
    }
    
    static Tcl_ChannelTruncateProc(param*)
    {
        dllcall("tcl86t\Tcl_ChannelTruncateProc")
    }
    
    static Tcl_ChannelVersion(param*)
    {
        dllcall("tcl86t\Tcl_ChannelVersion")
    }
    
    static Tcl_ChannelWatchProc(param*)
    {
        dllcall("tcl86t\Tcl_ChannelWatchProc")
    }
    
    static Tcl_ChannelWideSeekProc(param*)
    {
        dllcall("tcl86t\Tcl_ChannelWideSeekProc")
    }
    
    static Tcl_Chdir(param*)
    {
        dllcall("tcl86t\Tcl_Chdir")
    }
    
    static Tcl_ClearChannelHandlers(param*)
    {
        dllcall("tcl86t\Tcl_ClearChannelHandlers")
    }
    
    static Tcl_Close(param*)
    {
        dllcall("tcl86t\Tcl_Close")
    }
    
    static Tcl_CloseEx(param*)
    {
        dllcall("tcl86t\Tcl_CloseEx")
    }
    
    static Tcl_CommandComplete(param*)
    {
        dllcall("tcl86t\Tcl_CommandComplete")
    }
    
    static Tcl_CommandTraceInfo(param*)
    {
        dllcall("tcl86t\Tcl_CommandTraceInfo")
    }
    
    static Tcl_Concat(param*)
    {
        dllcall("tcl86t\Tcl_Concat")
    }
    
    static Tcl_ConcatObj(param*)
    {
        dllcall("tcl86t\Tcl_ConcatObj")
    }
    
    static Tcl_ConditionFinalize(condPtr)
    {
        dllcall("tcl86t\Tcl_ConditionFinalize", "ptr", condPtr)
    }
    
    static Tcl_ConditionNotify(condPtr)
    {
        dllcall("tcl86t\Tcl_ConditionNotify", "ptr", condPtr)
    }
    
    static Tcl_ConditionWait(condPtr, mutexPtr, timePtr)
    {
        dllcall("tcl86t\Tcl_ConditionWait", "ptr", condPtr, "ptr", mutexPtr, "ptr", timePtr)
    }
    
    static Tcl_ConvertCountedElement(param*)
    {
        dllcall("tcl86t\Tcl_ConvertCountedElement")
    }
    
    static Tcl_ConvertElement(param*)
    {
        dllcall("tcl86t\Tcl_ConvertElement")
    }
    
    static Tcl_ConvertToType(interp, objPtr, typePtr) ; => int
    {
        return dllcall("tcl86t\Tcl_ConvertToType", "ptr", interp, "ptr", objPtr, "ptr", typePtr)
    }
    
    static Tcl_CreateAlias(slaveInterp, srcCmd, targetInterp, targetCmd, argc, argv) ; => int
    {
        return dllcall("tcl86t\Tcl_CreateAlias", "ptr", slaveInterp, "ptr", this.strBuffer(srcCmd), "ptr", targetInterp, "ptr", this.strBuffer(targetCmd), "int", argc, "ptr", argv)
    }
    
    static Tcl_CreateAliasObj(slaveInterp, srcCmd, targetInterp, targetCmd, objc, objv) ; => int
    {
        return dllcall("tcl86t\Tcl_CreateAliasObj", "ptr", slaveInterp, "ptr", this.strBuffer(srcCmd), "ptr", targetInterp, "ptr", this.strBuffer(targetCmd), "int", objc, "ptr", objv)
    }
    
    static Tcl_CreateChannel(param*)
    {
        dllcall("tcl86t\Tcl_CreateChannel")
    }
    
    static Tcl_CreateChannelHandler(param*)
    {
        dllcall("tcl86t\Tcl_CreateChannelHandler")
    }
    
    static Tcl_CreateCloseHandler(param*)
    {
        dllcall("tcl86t\Tcl_CreateCloseHandler")
    }
    
    static Tcl_CreateCommand(interp, cmdName, proc, clientData, deleteProc)
    {
        return dllcall("tcl86t\Tcl_CreateCommand", "ptr", interp, "ptr", this.strBuffer(cmdName), "ptr", proc, "ptr", clientData, "ptr", deleteProc)
    }
    
    static Tcl_CreateEncoding(param*)
    {
        dllcall("tcl86t\Tcl_CreateEncoding")
    }
    
    static Tcl_CreateEnsemble(param*)
    {
        dllcall("tcl86t\Tcl_CreateEnsemble")
    }
    
    static Tcl_CreateEventSource(setupProc, checkProc, clientData)
    {
        dllcall("tcl86t\Tcl_CreateEventSource", "ptr", setupProc, "ptr", checkProc, "ptr", clientData)
    }
    
    static Tcl_CreateExitHandler(param*)
    {
        dllcall("tcl86t\Tcl_CreateExitHandler")
    }
    
    static Tcl_CreateHashEntry(param*)
    {
        dllcall("tcl86t\Tcl_CreateHashEntry")
    }
    
    static Tcl_CreateInterp() ; => Tcl_Interp*
    {
        return dllcall("tcl86t\Tcl_CreateInterp")
    }
    
    static Tcl_CreateMathFunc(param*)
    {
        dllcall("tcl86t\Tcl_CreateMathFunc")
    }
    
    static Tcl_CreateNamespace(param*)
    {
        dllcall("tcl86t\Tcl_CreateNamespace")
    }
    
    static Tcl_CreateObjCommand(interp, cmdName, proc, clientData, deleteProc) ; => Tcl_Command
    {
        return dllcall("tcl86t\Tcl_CreateObjCommand", "ptr", interp, "ptr", this.strBuffer(cmdName), "ptr", proc, "ptr", clientData, "ptr", deleteProc)
    }
    
    static Tcl_CreateObjTrace(param*)
    {
        dllcall("tcl86t\Tcl_CreateObjTrace")
    }
    
    static Tcl_CreatePipe(param*)
    {
        dllcall("tcl86t\Tcl_CreatePipe")
    }
    
    static Tcl_CreateSlave(interp, slaveName, isSafe) ; => Tcl_Interp*
    {
        return dllcall("tcl86t\Tcl_CreateSlave", "ptr", interp, "ptr", this.strBuffer(slaveName), "int", isSafe)
    }
    
    static Tcl_CreateThread(&idPtr, threadProc, clientData, stackSize, flags) ; => int
    {
        return dllcall("tcl86t\Tcl_CreateThread", "ptr*", &idptr, "ptr", threadProc, "ptr", clientData, "int", stackSize, "int", flags)
    }
    
    static Tcl_CreateThreadExitHandler(param*)
    {
        dllcall("tcl86t\Tcl_CreateThreadExitHandler")
    }
    
    static Tcl_CreateTimerHandler(param*)
    {
        dllcall("tcl86t\Tcl_CreateTimerHandler")
    }
    
    static Tcl_CreateTrace(param*)
    {
        dllcall("tcl86t\Tcl_CreateTrace")
    }
    
    static Tcl_CutChannel(param*)
    {
        dllcall("tcl86t\Tcl_CutChannel")
    }
    
    static Tcl_DStringAppend(param*)
    {
        dllcall("tcl86t\Tcl_DStringAppend")
    }
    
    static Tcl_DStringAppendElement(param*)
    {
        dllcall("tcl86t\Tcl_DStringAppendElement")
    }
    
    static Tcl_DStringEndSublist(param*)
    {
        dllcall("tcl86t\Tcl_DStringEndSublist")
    }
    
    static Tcl_DStringFree(param*)
    {
        dllcall("tcl86t\Tcl_DStringFree")
    }
    
    static Tcl_DStringGetResult(param*)
    {
        dllcall("tcl86t\Tcl_DStringGetResult")
    }
    
    static Tcl_DStringInit(param*)
    {
        dllcall("tcl86t\Tcl_DStringInit")
    }
    
    static Tcl_DStringResult(param*)
    {
        dllcall("tcl86t\Tcl_DStringResult")
    }
    
    static Tcl_DStringSetLength(param*)
    {
        dllcall("tcl86t\Tcl_DStringSetLength")
    }
    
    static Tcl_DStringStartSublist(param*)
    {
        dllcall("tcl86t\Tcl_DStringStartSublist")
    }
    
    static Tcl_DStringTrunc(param*)
    {
        dllcall("tcl86t\Tcl_DStringSetLength")
    }
    
    static Tcl_DbCkalloc(param*)
    {
        dllcall("tcl86t\Tcl_DbCkalloc")
    }
    
    static Tcl_DbCkfree(param*)
    {
        dllcall("tcl86t\Tcl_DbCkfree")
    }
    
    static Tcl_DbCkrealloc(param*)
    {
        dllcall("tcl86t\Tcl_DbCkrealloc")
    }
    
    static Tcl_DbDecrRefCount(objPtr)
    {
        dllcall("tcl86t\Tcl_DbDecrRefCount", "ptr", objPtr)
    }
    
    static Tcl_DbIncrRefCount(objPtr)
    {
        dllcall("tcl86t\Tcl_DbIncrRefCount", "ptr", objPtr)
    }
    
    static Tcl_DbIsShared(objPtr) ; => int
    {
        return dllcall("tcl86t\Tcl_DbIsShared", "ptr", objPtr)
    }
    
    static Tcl_DbNewBignumObj(param*)
    {
        dllcall("tcl86t\Tcl_DbNewBignumObj")
    }
    
    static Tcl_DbNewBooleanObj(param*)
    {
        dllcall("tcl86t\Tcl_DbNewBooleanObj")
    }
    
    static Tcl_DbNewByteArrayObj(param*)
    {
        dllcall("tcl86t\Tcl_DbNewByteArrayObj")
    }
    
    static Tcl_DbNewDictObj(param*)
    {
        dllcall("tcl86t\Tcl_DbNewDictObj")
    }
    
    static Tcl_DbNewDoubleObj(param*)
    {
        dllcall("tcl86t\Tcl_DbNewDoubleObj")
    }
    
    static Tcl_DbNewListObj(param*)
    {
        dllcall("tcl86t\Tcl_DbNewListObj")
    }
    
    static Tcl_DbNewLongObj(param*)
    {
        dllcall("tcl86t\Tcl_DbNewLongObj")
    }
    
    static Tcl_DbNewObj() ; => Tcl_Obj*
    {
        return dllcall("tcl86t\Tcl_DbNewObj")
    }
    
    static Tcl_DbNewStringObj(param*)
    {
        dllcall("tcl86t\Tcl_DbNewStringObj")
    }
    
    static Tcl_DbNewWideIntObj(param*)
    {
        dllcall("tcl86t\Tcl_DbNewWideIntObj")
    }
    
    static Tcl_DecrRefCount(objPtr)
    {
        dllcall("tcl86t\Tcl_DbDecrRefCount", "ptr", objPtr)
    }
    
    static Tcl_DeleteAssocData(param*)
    {
        dllcall("tcl86t\Tcl_DeleteAssocData")
    }
    
    static Tcl_DeleteChannelHandler(param*)
    {
        dllcall("tcl86t\Tcl_DeleteChannelHandler")
    }
    
    static Tcl_DeleteCloseHandler(param*)
    {
        dllcall("tcl86t\Tcl_DeleteCloseHandler")
    }
    
    static Tcl_DeleteCommand(interp, cmdName) ; => int
    {
        return dllcall("tcl86t\Tcl_DeleteCommand", "ptr", interp, "ptr", this.strBuffer(cmdName))
    }
    
    static Tcl_DeleteCommandFromToken(param*)
    {
        dllcall("tcl86t\Tcl_DeleteCommandFromToken")
    }
    
    static Tcl_DeleteEventSource(setupProc, checkProc, clientData)
    {
        dllcall("tcl86t\Tcl_DeleteEventSource", "ptr", setupProc, "ptr", checkProc, "ptr", clientData)
    }
    
    static Tcl_DeleteEvents(deleteProc, clientData)
    {
        dllcall("tcl86t\Tcl_DeleteEvents", "ptr", deleteProc, "ptr", clientData)
    }
    
    static Tcl_DeleteExitHandler(param*)
    {
        dllcall("tcl86t\Tcl_DeleteExitHandler")
    }
    
    static Tcl_DeleteHashEntry(param*)
    {
        dllcall("tcl86t\Tcl_DeleteHashEntry")
    }
    
    static Tcl_DeleteHashTable(param*)
    {
        dllcall("tcl86t\Tcl_DeleteHashTable")
    }
    
    static Tcl_DeleteInterp(interp)
    {
        dllcall("tcl86t\Tcl_DeleteInterp", "ptr", interp)
    }
    
    static Tcl_DeleteNamespace(param*)
    {
        dllcall("tcl86t\Tcl_DeleteNamespace")
    }
    
    static Tcl_DeleteThreadExitHandler(param*)
    {
        dllcall("tcl86t\Tcl_DeleteThreadExitHandler")
    }
    
    static Tcl_DeleteTimerHandler(param*)
    {
        dllcall("tcl86t\Tcl_DeleteTimerHandler")
    }
    
    static Tcl_DeleteTrace(param*)
    {
        dllcall("tcl86t\Tcl_DeleteTrace")
    }
    
    static Tcl_DetachChannel(param*)
    {
        dllcall("tcl86t\Tcl_DetachChannel")
    }
    
    static Tcl_DetachPids(param*)
    {
        dllcall("tcl86t\Tcl_DetachPids")
    }
    
    static Tcl_DictObjDone(param*)
    {
        dllcall("tcl86t\Tcl_DictObjDone")
    }
    
    static Tcl_DictObjFirst(param*)
    {
        dllcall("tcl86t\Tcl_DictObjFirst")
    }
    
    static Tcl_DictObjGet(param*)
    {
        dllcall("tcl86t\Tcl_DictObjGet")
    }
    
    static Tcl_DictObjNext(param*)
    {
        dllcall("tcl86t\Tcl_DictObjNext")
    }
    
    static Tcl_DictObjPut(param*)
    {
        dllcall("tcl86t\Tcl_DictObjPut")
    }
    
    static Tcl_DictObjPutKeyList(param*)
    {
        dllcall("tcl86t\Tcl_DictObjPutKeyList")
    }
    
    static Tcl_DictObjRemove(param*)
    {
        dllcall("tcl86t\Tcl_DictObjRemove")
    }
    
    static Tcl_DictObjRemoveKeyList(param*)
    {
        dllcall("tcl86t\Tcl_DictObjRemoveKeyList")
    }
    
    static Tcl_DictObjSize(param*)
    {
        dllcall("tcl86t\Tcl_DictObjSize")
    }
    
    static Tcl_DiscardInterpState(param*)
    {
        dllcall("tcl86t\Tcl_DiscardInterpState")
    }
    
    static Tcl_DiscardResult(param*)
    {
        dllcall("tcl86t\Tcl_DiscardResult")
    }
    
    static Tcl_DoOneEvent(param*)
    {
        dllcall("tcl86t\Tcl_DoOneEvent")
    }
    
    static Tcl_DoWhenIdle(param*)
    {
        dllcall("tcl86t\Tcl_DoWhenIdle")
    }
    
    static Tcl_DontCallWhenDeleted(param*)
    {
        dllcall("tcl86t\Tcl_DontCallWhenDeleted")
    }
    
    static Tcl_DumpActiveMemory(param*)
    {
        dllcall("tcl86t\Tcl_DumpActiveMemory")
    }
    
    static Tcl_DuplicateObj(objPtr) ; => Tcl_Obj*
    {
        return dllcall("tcl86t\Tcl_DuplicateObj", "ptr", objPtr)
    }
    
    static Tcl_Eof(param*)
    {
        dllcall("tcl86t\Tcl_Eof")
    }
    
    static Tcl_ErrnoId(param*)
    {
        dllcall("tcl86t\Tcl_ErrnoId")
    }
    
    static Tcl_ErrnoMsg(param*)
    {
        dllcall("tcl86t\Tcl_ErrnoMsg")
    }
    
    static Tcl_Eval(interp, script) ; => int
    {
        return dllcall("tcl86t\Tcl_Eval", "ptr", interp, "ptr", this.strBuffer(script))
    }
    
    static Tcl_EvalEx(interp, script, numBytes, flags) ; => int
    {
        return dllcall("tcl86t\Tcl_EvalEx", "ptr", interp, "ptr", this.strBuffer(script), "int", numBytes, "int", flags)
    }
    
    static Tcl_EvalFile(interp, fileName) ; => int
    {
        return dllcall("tcl86t\Tcl_EvalFile", "ptr", interp, "ptr", this.strBuffer(fileName))
    }
    
    static Tcl_EvalObj(param*)
    {
        dllcall("tcl86t\Tcl_EvalObj")
    }
    
    static Tcl_EvalObjEx(interp, objPtr, flags) ; => int
    {
        return dllcall("tcl86t\Tcl_EvalObjEx", "ptr", interp, "ptr", objPtr, "int", flags)
    }
    
    static Tcl_EvalObjv(interp, objc, objv, flags) ; => int
    {
        return dllcall("tcl86t\Tcl_EvalObjv", "ptr", interp, "int", objc, "ptr", objv, "int", flags)
    }
    
    static Tcl_EvalTokens(param*)
    {
        dllcall("tcl86t\Tcl_EvalTokens")
    }
    
    static Tcl_EvalTokensStandard(param*)
    {
        dllcall("tcl86t\Tcl_EvalTokensStandard")
    }
    
    static Tcl_EventuallyFree(param*)
    {
        dllcall("tcl86t\Tcl_EventuallyFree")
    }
    
    static Tcl_Exit(param*)
    {
        dllcall("tcl86t\Tcl_Exit")
    }
    
    static Tcl_ExitThread(param*)
    {
        dllcall("tcl86t\Tcl_ExitThread")
    }
    
    static Tcl_Export(param*)
    {
        dllcall("tcl86t\Tcl_Export")
    }
    
    static Tcl_ExposeCommand(interp, hiddenCmdName, cmdName) ; => int
    {
        return dllcall("tcl86t\Tcl_ExposeCommand", "ptr", interp, "ptr", this.strBuffer(hiddenCmdName), "ptr", this.strBuffer(cmdName))
    }
    
    static Tcl_ExprBoolean(param*)
    {
        dllcall("tcl86t\Tcl_ExprBoolean")
    }
    
    static Tcl_ExprBooleanObj(param*)
    {
        dllcall("tcl86t\Tcl_ExprBooleanObj")
    }
    
    static Tcl_ExprDouble(param*)
    {
        dllcall("tcl86t\Tcl_ExprDouble")
    }
    
    static Tcl_ExprDoubleObj(param*)
    {
        dllcall("tcl86t\Tcl_ExprDoubleObj")
    }
    
    static Tcl_ExprLong(param*)
    {
        dllcall("tcl86t\Tcl_ExprLong")
    }
    
    static Tcl_ExprLongObj(param*)
    {
        dllcall("tcl86t\Tcl_ExprLongObj")
    }
    
    static Tcl_ExprObj(param*)
    {
        dllcall("tcl86t\Tcl_ExprObj")
    }
    
    static Tcl_ExprString(param*)
    {
        dllcall("tcl86t\Tcl_ExprString")
    }
    
    static Tcl_ExternalToUtf(param*)
    {
        dllcall("tcl86t\Tcl_ExternalToUtf")
    }
    
    static Tcl_ExternalToUtfDString(param*)
    {
        dllcall("tcl86t\Tcl_ExternalToUtfDString")
    }
    
    static Tcl_FSAccess(param*)
    {
        dllcall("tcl86t\Tcl_FSAccess")
    }
    
    static Tcl_FSChdir(param*)
    {
        dllcall("tcl86t\Tcl_FSChdir")
    }
    
    static Tcl_FSConvertToPathType(param*)
    {
        dllcall("tcl86t\Tcl_FSConvertToPathType")
    }
    
    static Tcl_FSCopyDirectory(param*)
    {
        dllcall("tcl86t\Tcl_FSCopyDirectory")
    }
    
    static Tcl_FSCopyFile(param*)
    {
        dllcall("tcl86t\Tcl_FSCopyFile")
    }
    
    static Tcl_FSCreateDirectory(param*)
    {
        dllcall("tcl86t\Tcl_FSCreateDirectory")
    }
    
    static Tcl_FSData(param*)
    {
        dllcall("tcl86t\Tcl_FSData")
    }
    
    static Tcl_FSDeleteFile(param*)
    {
        dllcall("tcl86t\Tcl_FSDeleteFile")
    }
    
    static Tcl_FSEqualPaths(param*)
    {
        dllcall("tcl86t\Tcl_FSEqualPaths")
    }
    
    static Tcl_FSEvalFile(param*)
    {
        dllcall("tcl86t\Tcl_FSEvalFile")
    }
    
    static Tcl_FSEvalFileEx(param*)
    {
        dllcall("tcl86t\Tcl_FSEvalFileEx")
    }
    
    static Tcl_FSFileAttrStrings(param*)
    {
        dllcall("tcl86t\Tcl_FSFileAttrStrings")
    }
    
    static Tcl_FSFileAttrsGet(param*)
    {
        dllcall("tcl86t\Tcl_FSFileAttrsGet")
    }
    
    static Tcl_FSFileAttrsSet(param*)
    {
        dllcall("tcl86t\Tcl_FSFileAttrsSet")
    }
    
    static Tcl_FSFileSystemInfo(param*)
    {
        dllcall("tcl86t\Tcl_FSFileSystemInfo")
    }
    
    static Tcl_FSGetCwd(param*)
    {
        dllcall("tcl86t\Tcl_FSGetCwd")
    }
    
    static Tcl_FSGetFileSystemForPath(param*)
    {
        dllcall("tcl86t\Tcl_FSGetFileSystemForPath")
    }
    
    static Tcl_FSGetInternalRep(param*)
    {
        dllcall("tcl86t\Tcl_FSGetInternalRep")
    }
    
    static Tcl_FSGetNativePath(param*)
    {
        dllcall("tcl86t\Tcl_FSGetNativePath")
    }
    
    static Tcl_FSGetNormalizedPath(param*)
    {
        dllcall("tcl86t\Tcl_FSGetNormalizedPath")
    }
    
    static Tcl_FSGetPathType(param*)
    {
        dllcall("tcl86t\Tcl_FSGetPathType")
    }
    
    static Tcl_FSGetTranslatedPath(param*)
    {
        dllcall("tcl86t\Tcl_FSGetTranslatedPath")
    }
    
    static Tcl_FSGetTranslatedStringPath(param*)
    {
        dllcall("tcl86t\Tcl_FSGetTranslatedStringPath")
    }
    
    static Tcl_FSJoinPath(param*)
    {
        dllcall("tcl86t\Tcl_FSJoinPath")
    }
    
    static Tcl_FSJoinToPath(param*)
    {
        dllcall("tcl86t\Tcl_FSJoinToPath")
    }
    
    static Tcl_FSLink(param*)
    {
        dllcall("tcl86t\Tcl_FSLink")
    }
    
    static Tcl_FSListVolumes(param*)
    {
        dllcall("tcl86t\Tcl_FSListVolumes")
    }
    
    static Tcl_FSLoadFile(param*)
    {
        dllcall("tcl86t\Tcl_FSLoadFile")
    }
    
    static Tcl_FSLstat(param*)
    {
        dllcall("tcl86t\Tcl_FSLstat")
    }
    
    static Tcl_FSMatchInDirectory(param*)
    {
        dllcall("tcl86t\Tcl_FSMatchInDirectory")
    }
    
    static Tcl_FSMountsChanged(param*)
    {
        dllcall("tcl86t\Tcl_FSMountsChanged")
    }
    
    static Tcl_FSNewNativePath(param*)
    {
        dllcall("tcl86t\Tcl_FSNewNativePath")
    }
    
    static Tcl_FSOpenFileChannel(param*)
    {
        dllcall("tcl86t\Tcl_FSOpenFileChannel")
    }
    
    static Tcl_FSPathSeparator(param*)
    {
        dllcall("tcl86t\Tcl_FSPathSeparator")
    }
    
    static Tcl_FSRegister(param*)
    {
        dllcall("tcl86t\Tcl_FSRegister")
    }
    
    static Tcl_FSRemoveDirectory(param*)
    {
        dllcall("tcl86t\Tcl_FSRemoveDirectory")
    }
    
    static Tcl_FSRenameFile(param*)
    {
        dllcall("tcl86t\Tcl_FSRenameFile")
    }
    
    static Tcl_FSSplitPath(param*)
    {
        dllcall("tcl86t\Tcl_FSSplitPath")
    }
    
    static Tcl_FSStat(param*)
    {
        dllcall("tcl86t\Tcl_FSStat")
    }
    
    static Tcl_FSUnloadFile(param*)
    {
        dllcall("tcl86t\Tcl_FSUnloadFile")
    }
    
    static Tcl_FSUnregister(param*)
    {
        dllcall("tcl86t\Tcl_FSUnregister")
    }
    
    static Tcl_FSUtime(param*)
    {
        dllcall("tcl86t\Tcl_FSUtime")
    }
    
    static Tcl_Finalize(param*)
    {
        dllcall("tcl86t\Tcl_Finalize")
    }
    
    static Tcl_FinalizeNotifier(clientData)
    {
        dllcall("tcl86t\Tcl_FinalizeNotifier", "ptr", clientData)
    }
    
    static Tcl_FinalizeThread(param*)
    {
        dllcall("tcl86t\Tcl_FinalizeThread")
    }
    
    static Tcl_FindCommand(param*)
    {
        dllcall("tcl86t\Tcl_FindCommand")
    }
    
    static Tcl_FindEnsemble(param*)
    {
        dllcall("tcl86t\Tcl_FindEnsemble")
    }
    
    static Tcl_FindExecutable(param*)
    {
        dllcall("tcl86t\Tcl_FindExecutable")
    }
    
    static Tcl_FindHashEntry(param*)
    {
        dllcall("tcl86t\Tcl_FindHashEntry")
    }
    
    static Tcl_FindNamespace(param*)
    {
        dllcall("tcl86t\Tcl_FindNamespace")
    }
    
    static Tcl_FindNamespaceVar(param*)
    {
        dllcall("tcl86t\Tcl_FindNamespaceVar")
    }
    
    static Tcl_FindSymbol(param*)
    {
        dllcall("tcl86t\Tcl_FindSymbol")
    }
    
    static Tcl_FirstHashEntry(param*)
    {
        dllcall("tcl86t\Tcl_FirstHashEntry")
    }
    
    static Tcl_Flush(param*)
    {
        dllcall("tcl86t\Tcl_Flush")
    }
    
    static Tcl_ForgetImport(param*)
    {
        dllcall("tcl86t\Tcl_ForgetImport")
    }
    
    static Tcl_Format(param*)
    {
        dllcall("tcl86t\Tcl_Format")
    }
    
    static Tcl_Free(param*)
    {
        dllcall("tcl86t\Tcl_Free")
    }
    
    static Tcl_FreeEncoding(param*)
    {
        dllcall("tcl86t\Tcl_FreeEncoding")
    }
    
    static Tcl_FreeParse(param*)
    {
        dllcall("tcl86t\Tcl_FreeParse")
    }
    
    static Tcl_FreeResult(interp)
    {
        dllcall("tcl86t\Tcl_FreeResult", "ptr", interp)
    }
    
    static Tcl_GetAccessTimeFromStat(param*)
    {
        dllcall("tcl86t\Tcl_GetAccessTimeFromStat")
    }
    
    static Tcl_GetAlias(interp, srcCmd, targetInterpPtr, &targetCmdPtr, &argcPtr, &argvPtr) ; => int
    {
        return dllcall("tcl86t\Tcl_GetAlias", "ptr", interp, "ptr", this.strBuffer(srcCmd), "ptr", targetInterpPtr, "ptr*", &targetCmdPtr, "int*", &argcPtr, "ptr*", &argvPtr)
    }
    
    static Tcl_GetAliasObj(interp, srcCmd, targetInterpPtr, &targetCmdPtr, &objcPtr, &objvPtr) ; => int
    {
        dllcall("tcl86t\Tcl_GetAliasObj", "ptr", interp, "ptr", this.strBuffer(srcCmd), "ptr", targetInterpPtr, "ptr*", &targetCmdPtr, "int*", &objcPtr, "ptr*", &objvPtr)
    }
    
    static Tcl_GetAllocMutex(param*)
    {
        dllcall("tcl86t\Tcl_GetAllocMutex")
    }
    
    static Tcl_GetAssocData(param*)
    {
        dllcall("tcl86t\Tcl_GetAssocData")
    }
    
    static Tcl_GetBignumFromObj(param*)
    {
        dllcall("tcl86t\Tcl_GetBignumFromObj")
    }
    
    static Tcl_GetBlockSizeFromStat(param*)
    {
        dllcall("tcl86t\Tcl_GetBlockSizeFromStat")
    }
    
    static Tcl_GetBlocksFromStat(param*)
    {
        dllcall("tcl86t\Tcl_GetBlocksFromStat")
    }
    
    static Tcl_GetBoolean(param*)
    {
        dllcall("tcl86t\Tcl_GetBoolean")
    }
    
    static Tcl_GetBooleanFromObj(param*)
    {
        dllcall("tcl86t\Tcl_GetBooleanFromObj")
    }
    
    static Tcl_GetByteArrayFromObj(param*)
    {
        dllcall("tcl86t\Tcl_GetByteArrayFromObj")
    }
    
    static Tcl_GetChangeTimeFromStat(param*)
    {
        dllcall("tcl86t\Tcl_GetChangeTimeFromStat")
    }
    
    static Tcl_GetChannel(param*)
    {
        dllcall("tcl86t\Tcl_GetChannel")
    }
    
    static Tcl_GetChannelBufferSize(param*)
    {
        dllcall("tcl86t\Tcl_GetChannelBufferSize")
    }
    
    static Tcl_GetChannelError(param*)
    {
        dllcall("tcl86t\Tcl_GetChannelError")
    }
    
    static Tcl_GetChannelErrorInterp(param*)
    {
        dllcall("tcl86t\Tcl_GetChannelErrorInterp")
    }
    
    static Tcl_GetChannelHandle(param*)
    {
        dllcall("tcl86t\Tcl_GetChannelHandle")
    }
    
    static Tcl_GetChannelInstanceData(param*)
    {
        dllcall("tcl86t\Tcl_GetChannelInstanceData")
    }
    
    static Tcl_GetChannelMode(param*)
    {
        dllcall("tcl86t\Tcl_GetChannelMode")
    }
    
    static Tcl_GetChannelName(param*)
    {
        dllcall("tcl86t\Tcl_GetChannelName")
    }
    
    static Tcl_GetChannelNames(param*)
    {
        dllcall("tcl86t\Tcl_GetChannelNames")
    }
    
    static Tcl_GetChannelNamesEx(param*)
    {
        dllcall("tcl86t\Tcl_GetChannelNamesEx")
    }
    
    static Tcl_GetChannelOption(param*)
    {
        dllcall("tcl86t\Tcl_GetChannelOption")
    }
    
    static Tcl_GetChannelThread(param*)
    {
        dllcall("tcl86t\Tcl_GetChannelThread")
    }
    
    static Tcl_GetChannelType(param*)
    {
        dllcall("tcl86t\Tcl_GetChannelType")
    }
    
    static Tcl_GetCharLength(param*)
    {
        dllcall("tcl86t\Tcl_GetCharLength")
    }
    
    static Tcl_GetCommandFromObj(param*)
    {
        dllcall("tcl86t\Tcl_GetCommandFromObj")
    }
    
    static Tcl_GetCommandFullName(param*)
    {
        dllcall("tcl86t\Tcl_GetCommandFullName")
    }
    
    static Tcl_GetCommandInfo(interp, cmdName, infoPtr) ; => int
    {
        return dllcall("tcl86t\Tcl_GetCommandInfo", "ptr", interp, "ptr", this.strBuffer(cmdName), "ptr", infoPtr)
    }
    
    static Tcl_GetCommandInfoFromToken(param*)
    {
        dllcall("tcl86t\Tcl_GetCommandInfoFromToken")
    }
    
    static Tcl_GetCommandName(interp, token) ; => char*
    {
        return strget(dllcall("tcl86t\Tcl_GetCommandName", "ptr", interp, "ptr", token), , "utf-8")
    }
    
    static Tcl_GetCurrentNamespace(param*)
    {
        dllcall("tcl86t\Tcl_GetCurrentNamespace")
    }
    
    static Tcl_GetCurrentThread() ; => Tcl_ThreadId
    {
        return dllcall("tcl86t\Tcl_GetCurrentThread")
    }
    
    static Tcl_GetCwd(param*)
    {
        dllcall("tcl86t\Tcl_GetCwd")
    }
    
    static Tcl_GetDefaultEncodingDir(param*)
    {
        dllcall("tcl86t\Tcl_GetDefaultEncodingDir")
    }
    
    static Tcl_GetDeviceTypeFromStat(param*)
    {
        dllcall("tcl86t\Tcl_GetDeviceTypeFromStat")
    }
    
    static Tcl_GetDouble(param*)
    {
        dllcall("tcl86t\Tcl_GetDouble")
    }
    
    static Tcl_GetDoubleFromObj(param*)
    {
        dllcall("tcl86t\Tcl_GetDoubleFromObj")
    }
    
    static Tcl_GetEncoding(param*)
    {
        dllcall("tcl86t\Tcl_GetEncoding")
    }
    
    static Tcl_GetEncodingFromObj(param*)
    {
        dllcall("tcl86t\Tcl_GetEncodingFromObj")
    }
    
    static Tcl_GetEncodingName(param*)
    {
        dllcall("tcl86t\Tcl_GetEncodingName")
    }
    
    static Tcl_GetEncodingNameFromEnvironment(param*)
    {
        dllcall("tcl86t\Tcl_GetEncodingNameFromEnvironment")
    }
    
    static Tcl_GetEncodingNames(param*)
    {
        dllcall("tcl86t\Tcl_GetEncodingNames")
    }
    
    static Tcl_GetEncodingSearchPath(param*)
    {
        dllcall("tcl86t\Tcl_GetEncodingSearchPath")
    }
    
    static Tcl_GetEnsembleFlags(param*)
    {
        dllcall("tcl86t\Tcl_GetEnsembleFlags")
    }
    
    static Tcl_GetEnsembleMappingDict(param*)
    {
        dllcall("tcl86t\Tcl_GetEnsembleMappingDict")
    }
    
    static Tcl_GetEnsembleNamespace(param*)
    {
        dllcall("tcl86t\Tcl_GetEnsembleNamespace")
    }
    
    static Tcl_GetEnsembleParameterList(param*)
    {
        dllcall("tcl86t\Tcl_GetEnsembleParameterList")
    }
    
    static Tcl_GetEnsembleSubcommandList(param*)
    {
        dllcall("tcl86t\Tcl_GetEnsembleSubcommandList")
    }
    
    static Tcl_GetEnsembleUnknownHandler(param*)
    {
        dllcall("tcl86t\Tcl_GetEnsembleUnknownHandler")
    }
    
    static Tcl_GetErrno(param*)
    {
        dllcall("tcl86t\Tcl_GetErrno")
    }
    
    static Tcl_GetErrorLine(param*)
    {
        dllcall("tcl86t\Tcl_GetErrorLine")
    }
    
    static Tcl_GetFSDeviceFromStat(param*)
    {
        dllcall("tcl86t\Tcl_GetFSDeviceFromStat")
    }
    
    static Tcl_GetFSInodeFromStat(param*)
    {
        dllcall("tcl86t\Tcl_GetFSInodeFromStat")
    }
    
    static Tcl_GetGlobalNamespace(param*)
    {
        dllcall("tcl86t\Tcl_GetGlobalNamespace")
    }
    
    static Tcl_GetGroupIdFromStat(param*)
    {
        dllcall("tcl86t\Tcl_GetGroupIdFromStat")
    }
    
    static Tcl_GetHostName(param*)
    {
        dllcall("tcl86t\Tcl_GetHostName")
    }
    
    static Tcl_GetIndexFromObj(param*)
    {
        dllcall("tcl86t\Tcl_GetIndexFromObj")
    }
    
    static Tcl_GetIndexFromObjStruct(param*)
    {
        dllcall("tcl86t\Tcl_GetIndexFromObjStruct")
    }
    
    static Tcl_GetInt(param*)
    {
        dllcall("tcl86t\Tcl_GetInt")
    }
    
    static Tcl_GetIntFromObj(param*)
    {
        dllcall("tcl86t\Tcl_GetIntFromObj")
    }
    
    static Tcl_GetInterpPath(askingInterp, slaveInterp) ; => int
    {
        return dllcall("tcl86t\Tcl_GetInterpPath", "ptr", askingInterp, "ptr", slaveInterp)
    }
    
    static Tcl_GetInterpResolvers(param*)
    {
        dllcall("tcl86t\Tcl_GetInterpResolvers")
    }
    
    static Tcl_GetLinkCountFromStat(param*)
    {
        dllcall("tcl86t\Tcl_GetLinkCountFromStat")
    }
    
    static Tcl_GetLongFromObj(param*)
    {
        dllcall("tcl86t\Tcl_GetLongFromObj")
    }
    
    static Tcl_GetMaster(interp) ; => Tcl_Interp*
    {
        return dllcall("tcl86t\Tcl_GetMaster", "ptr", interp)
    }
    
    static Tcl_GetMathFuncInfo(param*)
    {
        dllcall("tcl86t\Tcl_GetMathFuncInfo")
    }
    
    static Tcl_GetMemoryInfo(param*)
    {
        dllcall("tcl86t\Tcl_GetMemoryInfo")
    }
    
    static Tcl_GetModeFromStat(param*)
    {
        dllcall("tcl86t\Tcl_GetModeFromStat")
    }
    
    static Tcl_GetModificationTimeFromStat(param*)
    {
        dllcall("tcl86t\Tcl_GetModificationTimeFromStat")
    }
    
    static Tcl_GetNameOfExecutable(param*)
    {
        dllcall("tcl86t\Tcl_GetNameOfExecutable")
    }
    
    static Tcl_GetNamespaceResolvers(param*)
    {
        dllcall("tcl86t\Tcl_GetNamespaceResolvers")
    }
    
    static Tcl_GetNamespaceUnknownHandler(param*)
    {
        dllcall("tcl86t\Tcl_GetNamespaceUnknownHandler")
    }
    
    static Tcl_GetObjResult(interp) ; => Tcl_Obj*
    {
        return dllcall("tcl86t\Tcl_GetObjResult", "ptr", interp)
    }
    
    static Tcl_GetObjType(typeName) ; => Tcl_ObjType*
    {
        return dllcall("tcl86t\Tcl_GetObjType", "ptr", this.strBuffer(typeName))
    }
    
    static Tcl_GetPathType(param*)
    {
        dllcall("tcl86t\Tcl_GetPathType")
    }
    
    static Tcl_GetRange(param*)
    {
        dllcall("tcl86t\Tcl_GetRange")
    }
    
    static Tcl_GetRegExpFromObj(param*)
    {
        dllcall("tcl86t\Tcl_GetRegExpFromObj")
    }
    
    static Tcl_GetReturnOptions(param*)
    {
        dllcall("tcl86t\Tcl_GetReturnOptions")
    }
    
    static Tcl_GetServiceMode() ; => int
    {
        return dllcall("tcl86t\Tcl_GetServiceMode")
    }
    
    static Tcl_GetSizeFromStat(param*)
    {
        dllcall("tcl86t\Tcl_GetSizeFromStat")
    }
    
    static Tcl_GetSlave(interp, slaveName) ; => Tcl_Interp*
    {
        return dllcall("tcl86t\Tcl_GetSlave", "ptr", interp, "ptr", this.strBuffer(slaveName))
    }
    
    static Tcl_GetStackedChannel(param*)
    {
        dllcall("tcl86t\Tcl_GetStackedChannel")
    }
    
    static Tcl_GetStartupScript(param*)
    {
        dllcall("tcl86t\Tcl_GetStartupScript")
    }
    
    static Tcl_GetStdChannel(param*)
    {
        dllcall("tcl86t\Tcl_GetStdChannel")
    }
    
    static Tcl_GetString(param*)
    {
        dllcall("tcl86t\Tcl_GetString")
    }
    
    static Tcl_GetStringFromObj(param*)
    {
        dllcall("tcl86t\Tcl_GetStringFromObj")
    }
    
    static Tcl_GetStringResult(interp) ; => char*
    {
        return strget(dllcall("tcl86t\Tcl_GetStringResult", "ptr", interp), , "utf-8")
    }
    
    static Tcl_GetThreadData(keyPtr, size)
    {
        dllcall("tcl86t\Tcl_GetThreadData", "ptr", keyPtr, "ptr", size)
    }
    
    static Tcl_GetTime(param*)
    {
        dllcall("tcl86t\Tcl_GetTime")
    }
    
    static Tcl_GetTopChannel(param*)
    {
        dllcall("tcl86t\Tcl_GetTopChannel")
    }
    
    static Tcl_GetUniChar(param*)
    {
        dllcall("tcl86t\Tcl_GetUniChar")
    }
    
    static Tcl_GetUnicode(param*)
    {
        dllcall("tcl86t\Tcl_GetUnicode")
    }
    
    static Tcl_GetUnicodeFromObj(param*)
    {
        dllcall("tcl86t\Tcl_GetUnicodeFromObj")
    }
    
    static Tcl_GetUserIdFromStat(param*)
    {
        dllcall("tcl86t\Tcl_GetUserIdFromStat")
    }
    
    static Tcl_GetVar(interp, varName, flags) ; => char*
    {
        return strget(dllcall("tcl86t\Tcl_GetVar", "ptr", interp, "ptr", this.strBuffer(varName), "int", flags), , "utf-8")
    }
    
    static Tcl_GetVar2(interp, name1, name2, flags) ; => char*
    {
        return strget(dllcall("tcl86t\Tcl_GetVar2", "ptr", interp, "ptr", this.strBuffer(name1), "ptr", this.strBuffer(name2), "int", flags), , "utf-8")
    }
    
    static Tcl_GetVar2Ex(interp, name1, name2, flags) ; => Tcl_Obj*
    {
        return dllcall("tcl86t\Tcl_GetVar2Ex", "ptr", interp, "ptr", this.strBuffer(name1), "ptr", this.strBuffer(name2), "int", flags)
    }
    
    static Tcl_GetVariableFullName(param*)
    {
        dllcall("tcl86t\Tcl_GetVariableFullName")
    }
    
    static Tcl_GetVersion(param*)
    {
        dllcall("tcl86t\Tcl_GetVersion")
    }
    
    static Tcl_GetWideIntFromObj(param*)
    {
        dllcall("tcl86t\Tcl_GetWideIntFromObj")
    }
    
    static Tcl_Gets(param*)
    {
        dllcall("tcl86t\Tcl_Gets")
    }
    
    static Tcl_GetsObj(param*)
    {
        dllcall("tcl86t\Tcl_GetsObj")
    }
    
    static Tcl_GlobalEval(interp, script) ; => int
    {
        return dllcall("tcl86t\Tcl_GlobalEval", "ptr", interp, "ptr", this.strBuffer(script))
    }
    
    static Tcl_GlobalEvalObj(interp, objPtr, flags) ; => int
    {
        return dllcall("tcl86t\Tcl_GlobalEvalObj", "ptr", interp, "ptr", objPtr, "int", flags)
    }
    
    static Tcl_HashStats(param*)
    {
        dllcall("tcl86t\Tcl_HashStats")
    }
    
    static Tcl_HideCommand(interp, cmdName, hiddenCmdName)
    {
        return dllcall("tcl86t\Tcl_HideCommand", "ptr", interp, "ptr", this.strBuffer(hiddenCmdName), "ptr", this.strBuffer(cmdName))
    }
    
    static Tcl_Import(param*)
    {
        dllcall("tcl86t\Tcl_Import")
    }
    
    static Tcl_IncrRefCount(objPtr)
    {
        dllcall("tcl86t\Tcl_DbIncrRefCount", "ptr", objPtr)
    }
    
    static Tcl_Init(interp) ; => int
    {
        return dllcall("tcl86t\Tcl_Init", "ptr", interp)
    }
    
    static Tcl_InitBignumFromDouble(param*)
    {
        dllcall("tcl86t\Tcl_InitBignumFromDouble")
    }
    
    static Tcl_InitCustomHashTable(param*)
    {
        dllcall("tcl86t\Tcl_InitCustomHashTable")
    }
    
    static Tcl_InitHashTable(param*)
    {
        dllcall("tcl86t\Tcl_InitHashTable")
    }
    
    static Tcl_InitMemory(param*)
    {
        dllcall("tcl86t\Tcl_InitMemory")
    }
    
    static Tcl_InitNotifier() ; => ClientData
    {
        return dllcall("tcl86t\Tcl_InitNotifier")
    }
    
    static Tcl_InitObjHashTable(param*)
    {
        dllcall("tcl86t\Tcl_InitObjHashTable")
    }
    
    static Tcl_InitStubs(interp, version, exact)
    {
        return strget(dllcall("tcl86t\Tcl_PkgInitStubsCheck", "ptr", interp, "ptr", this.strBuffer(version), "int", exact), , "utf-8")
    }
    
    static Tcl_InputBlocked(param*)
    {
        dllcall("tcl86t\Tcl_InputBlocked")
    }
    
    static Tcl_InputBuffered(param*)
    {
        dllcall("tcl86t\Tcl_InputBuffered")
    }
    
    static Tcl_InterpActive(param*)
    {
        dllcall("tcl86t\Tcl_InterpActive")
    }
    
    static Tcl_InterpDeleted(interp) ; => int
    {
        return dllcall("tcl86t\Tcl_InterpDeleted", "ptr", interp)
    }
    
    static Tcl_InvalidateStringRep(objPtr)
    {
        dllcall("tcl86t\Tcl_InvalidateStringRep", "ptr", objPtr)
    }
    
    static Tcl_IsChannelExisting(param*)
    {
        dllcall("tcl86t\Tcl_IsChannelExisting")
    }
    
    static Tcl_IsChannelRegistered(param*)
    {
        dllcall("tcl86t\Tcl_IsChannelRegistered")
    }
    
    static Tcl_IsChannelShared(param*)
    {
        dllcall("tcl86t\Tcl_IsChannelShared")
    }
    
    static Tcl_IsEnsemble(param*)
    {
        dllcall("tcl86t\Tcl_IsEnsemble")
    }
    
    static Tcl_IsSafe(interp) ; => int
    {
        return dllcall("tcl86t\Tcl_IsSafe", "ptr", interp)
    }
    
    static Tcl_IsShared(objPtr) ; => int
    {
        return dllcall("tcl86t\Tcl_IsShared", "ptr", objPtr)
    }
    
    static Tcl_IsStandardChannel(param*)
    {
        dllcall("tcl86t\Tcl_IsStandardChannel")
    }
    
    static Tcl_JoinPath(param*)
    {
        dllcall("tcl86t\Tcl_JoinPath")
    }
    
    static Tcl_JoinThread(param*)
    {
        dllcall("tcl86t\Tcl_JoinThread")
    }
    
    static Tcl_LimitAddHandler(param*)
    {
        dllcall("tcl86t\Tcl_LimitAddHandler")
    }
    
    static Tcl_LimitCheck(param*)
    {
        dllcall("tcl86t\Tcl_LimitCheck")
    }
    
    static Tcl_LimitExceeded(param*)
    {
        dllcall("tcl86t\Tcl_LimitExceeded")
    }
    
    static Tcl_LimitGetCommands(param*)
    {
        dllcall("tcl86t\Tcl_LimitGetCommands")
    }
    
    static Tcl_LimitGetGranularity(param*)
    {
        dllcall("tcl86t\Tcl_LimitGetGranularity")
    }
    
    static Tcl_LimitGetTime(param*)
    {
        dllcall("tcl86t\Tcl_LimitGetTime")
    }
    
    static Tcl_LimitReady(param*)
    {
        dllcall("tcl86t\Tcl_LimitReady")
    }
    
    static Tcl_LimitRemoveHandler(param*)
    {
        dllcall("tcl86t\Tcl_LimitRemoveHandler")
    }
    
    static Tcl_LimitSetCommands(param*)
    {
        dllcall("tcl86t\Tcl_LimitSetCommands")
    }
    
    static Tcl_LimitSetGranularity(param*)
    {
        dllcall("tcl86t\Tcl_LimitSetGranularity")
    }
    
    static Tcl_LimitSetTime(param*)
    {
        dllcall("tcl86t\Tcl_LimitSetTime")
    }
    
    static Tcl_LimitTypeEnabled(param*)
    {
        dllcall("tcl86t\Tcl_LimitTypeEnabled")
    }
    
    static Tcl_LimitTypeExceeded(param*)
    {
        dllcall("tcl86t\Tcl_LimitTypeExceeded")
    }
    
    static Tcl_LimitTypeReset(param*)
    {
        dllcall("tcl86t\Tcl_LimitTypeReset")
    }
    
    static Tcl_LimitTypeSet(param*)
    {
        dllcall("tcl86t\Tcl_LimitTypeSet")
    }
    
    static Tcl_LinkVar(param*)
    {
        dllcall("tcl86t\Tcl_LinkVar")
    }
    
    static Tcl_ListMathFuncs(param*)
    {
        dllcall("tcl86t\Tcl_ListMathFuncs")
    }
    
    static Tcl_ListObjAppendElement(param*)
    {
        dllcall("tcl86t\Tcl_ListObjAppendElement")
    }
    
    static Tcl_ListObjAppendList(param*)
    {
        dllcall("tcl86t\Tcl_ListObjAppendList")
    }
    
    static Tcl_ListObjGetElements(param*)
    {
        dllcall("tcl86t\Tcl_ListObjGetElements")
    }
    
    static Tcl_ListObjIndex(param*)
    {
        dllcall("tcl86t\Tcl_ListObjIndex")
    }
    
    static Tcl_ListObjLength(param*)
    {
        dllcall("tcl86t\Tcl_ListObjLength")
    }
    
    static Tcl_ListObjReplace(param*)
    {
        dllcall("tcl86t\Tcl_ListObjReplace")
    }
    
    static Tcl_LoadFile(param*)
    {
        dllcall("tcl86t\Tcl_LoadFile")
    }
    
    static Tcl_LogCommandInfo(param*)
    {
        dllcall("tcl86t\Tcl_LogCommandInfo")
    }
    
    static Tcl_Main(param*)
    {
        dllcall("tcl86t\Tcl_Main")
    }
    
    static Tcl_MainEx(param*)
    {
        dllcall("tcl86t\Tcl_MainEx")
    }
    
    static Tcl_MainExW(param*)
    {
        dllcall("tcl86t\Tcl_MainExW")
    }
    
    static Tcl_MakeFileChannel(param*)
    {
        dllcall("tcl86t\Tcl_MakeFileChannel")
    }
    
    static Tcl_MakeSafe(interp) ; => int
    {
        return dllcall("tcl86t\Tcl_MakeSafe", "ptr", interp)
    }
    
    static Tcl_MakeTcpClientChannel(param*)
    {
        dllcall("tcl86t\Tcl_MakeTcpClientChannel")
    }
    
    static Tcl_Merge(param*)
    {
        dllcall("tcl86t\Tcl_Merge")
    }
    
    static Tcl_MutexFinalize(mutexPtr)
    {
        dllcall("tcl86t\Tcl_MutexFinalize", "ptr", mutexPtr)
    }
    
    static Tcl_MutexLock(mutexPtr)
    {
        dllcall("tcl86t\Tcl_MutexLock", "ptr", mutexPtr)
    }
    
    static Tcl_MutexUnlock(mutexPtr)
    {
        dllcall("tcl86t\Tcl_MutexUnlock", "ptr", mutexPtr)
    }
    
    static Tcl_NRAddCallback(param*)
    {
        dllcall("tcl86t\Tcl_NRAddCallback")
    }
    
    static Tcl_NRCallObjProc(param*)
    {
        dllcall("tcl86t\Tcl_NRCallObjProc")
    }
    
    static Tcl_NRCmdSwap(param*)
    {
        dllcall("tcl86t\Tcl_NRCmdSwap")
    }
    
    static Tcl_NRCreateCommand(param*)
    {
        dllcall("tcl86t\Tcl_NRCreateCommand")
    }
    
    static Tcl_NREvalObj(param*)
    {
        dllcall("tcl86t\Tcl_NREvalObj")
    }
    
    static Tcl_NREvalObjv(param*)
    {
        dllcall("tcl86t\Tcl_NREvalObjv")
    }
    
    static Tcl_NRExprObj(param*)
    {
        dllcall("tcl86t\Tcl_NRExprObj")
    }
    
    static Tcl_NRSubstObj(param*)
    {
        dllcall("tcl86t\Tcl_NRSubstObj")
    }
    
    static Tcl_NewBignumObj(param*)
    {
        dllcall("tcl86t\Tcl_NewBignumObj")
    }
    
    static Tcl_NewBooleanObj(param*)
    {
        dllcall("tcl86t\Tcl_NewBooleanObj")
    }
    
    static Tcl_NewByteArrayObj(param*)
    {
        dllcall("tcl86t\Tcl_NewByteArrayObj")
    }
    
    static Tcl_NewDictObj(param*)
    {
        dllcall("tcl86t\Tcl_NewDictObj")
    }
    
    static Tcl_NewDoubleObj(param*)
    {
        dllcall("tcl86t\Tcl_NewDoubleObj")
    }
    
    static Tcl_NewIntObj(param*)
    {
        dllcall("tcl86t\Tcl_NewIntObj")
    }
    
    static Tcl_NewListObj(param*)
    {
        dllcall("tcl86t\Tcl_NewListObj")
    }
    
    static Tcl_NewLongObj(param*)
    {
        dllcall("tcl86t\Tcl_NewLongObj")
    }
    
    static Tcl_NewObj() ; => Tcl_Obj*
    {
        return dllcall("tcl86t\Tcl_NewObj")
    }
    
    static Tcl_NewStringObj(param*)
    {
        dllcall("tcl86t\Tcl_NewStringObj")
    }
    
    static Tcl_NewUnicodeObj(param*)
    {
        dllcall("tcl86t\Tcl_NewUnicodeObj")
    }
    
    static Tcl_NewWideIntObj(param*)
    {
        dllcall("tcl86t\Tcl_NewWideIntObj")
    }
    
    static Tcl_NextHashEntry(param*)
    {
        dllcall("tcl86t\Tcl_NextHashEntry")
    }
    
    static Tcl_NotifyChannel(param*)
    {
        dllcall("tcl86t\Tcl_NotifyChannel")
    }
    
    static Tcl_NumUtfChars(param*)
    {
        dllcall("tcl86t\Tcl_NumUtfChars")
    }
    
    static Tcl_ObjGetVar2(interp, part1Ptr, part2Ptr, flags) ; => Tcl_Obj*
    {
        return dllcall("tcl86t\Tcl_ObjGetVar2", "ptr", interp, "ptr", part1Ptr, "ptr", part2Ptr, "int", flags)
    }
    
    static Tcl_ObjPrintf(param*)
    {
        dllcall("tcl86t\Tcl_ObjPrintf")
    }
    
    static Tcl_ObjSetVar2(interp, part1Ptr, part2Ptr, newValuePtr, flags) ; => Tcl_Obj*
    {
        return dllcall("tcl86t\Tcl_ObjSetVar2", "ptr", interp, "ptr", part1Ptr, "ptr", part2Ptr, "ptr", newValuePtr, "int", flags)
    }
    
    static Tcl_OpenCommandChannel(param*)
    {
        dllcall("tcl86t\Tcl_OpenCommandChannel")
    }
    
    static Tcl_OpenFileChannel(param*)
    {
        dllcall("tcl86t\Tcl_OpenFileChannel")
    }
    
    static Tcl_OpenTcpClient(param*)
    {
        dllcall("tcl86t\Tcl_OpenTcpClient")
    }
    
    static Tcl_OpenTcpServer(param*)
    {
        dllcall("tcl86t\Tcl_OpenTcpServer")
    }
    
    static Tcl_OutputBuffered(param*)
    {
        dllcall("tcl86t\Tcl_OutputBuffered")
    }
    
    static Tcl_Panic(param*)
    {
        dllcall("tcl86t\Tcl_Panic")
    }
    
    static Tcl_PanicVA(param*)
    {
        dllcall("tcl86t\Tcl_PanicVA")
    }
    
    static Tcl_ParseArgsObjv(param*)
    {
        dllcall("tcl86t\Tcl_ParseArgsObjv")
    }
    
    static Tcl_ParseBraces(param*)
    {
        dllcall("tcl86t\Tcl_ParseBraces")
    }
    
    static Tcl_ParseCommand(param*)
    {
        dllcall("tcl86t\Tcl_ParseCommand")
    }
    
    static Tcl_ParseExpr(param*)
    {
        dllcall("tcl86t\Tcl_ParseExpr")
    }
    
    static Tcl_ParseQuotedString(param*)
    {
        dllcall("tcl86t\Tcl_ParseQuotedString")
    }
    
    static Tcl_ParseVar(param*)
    {
        dllcall("tcl86t\Tcl_ParseVar")
    }
    
    static Tcl_ParseVarName(param*)
    {
        dllcall("tcl86t\Tcl_ParseVarName")
    }
    
    static Tcl_PkgInitStubsCheck(param*)
    {
        dllcall("tcl86t\Tcl_PkgInitStubsCheck")
    }
    
    static Tcl_PkgPresent(param*)
    {
        dllcall("tcl86t\Tcl_PkgPresent")
    }
    
    static Tcl_PkgPresentEx(param*)
    {
        dllcall("tcl86t\Tcl_PkgPresentEx")
    }
    
    static Tcl_PkgProvide(param*)
    {
        dllcall("tcl86t\Tcl_PkgProvide")
    }
    
    static Tcl_PkgProvideEx(param*)
    {
        dllcall("tcl86t\Tcl_PkgProvideEx")
    }
    
    static Tcl_PkgRequire(param*)
    {
        dllcall("tcl86t\Tcl_PkgRequire")
    }
    
    static Tcl_PkgRequireEx(param*)
    {
        dllcall("tcl86t\Tcl_PkgRequireEx")
    }
    
    static Tcl_PkgRequireProc(param*)
    {
        dllcall("tcl86t\Tcl_PkgRequireProc")
    }
    
    static Tcl_PopCallFrame(param*)
    {
        dllcall("tcl86t\Tcl_PopCallFrame")
    }
    
    static Tcl_PosixError(param*)
    {
        dllcall("tcl86t\Tcl_PosixError")
    }
    
    static Tcl_Preserve(param*)
    {
        dllcall("tcl86t\Tcl_Preserve")
    }
    
    static Tcl_PrintDouble(param*)
    {
        dllcall("tcl86t\Tcl_PrintDouble")
    }
    
    static Tcl_ProcObjCmd(param*)
    {
        dllcall("tcl86t\Tcl_ProcObjCmd")
    }
    
    static Tcl_PushCallFrame(param*)
    {
        dllcall("tcl86t\Tcl_PushCallFrame")
    }
    
    static Tcl_PutEnv(param*)
    {
        dllcall("tcl86t\Tcl_PutEnv")
    }
    
    static Tcl_QueryTimeProc(param*)
    {
        dllcall("tcl86t\Tcl_QueryTimeProc")
    }
    
    static Tcl_QueueEvent(evPtr, position)
    {
        dllcall("tcl86t\Tcl_QueueEvent", "ptr", evPtr, "ptr", position)
    }
    
    static Tcl_Read(param*)
    {
        dllcall("tcl86t\Tcl_Read")
    }
    
    static Tcl_ReadChars(param*)
    {
        dllcall("tcl86t\Tcl_ReadChars")
    }
    
    static Tcl_ReadRaw(param*)
    {
        dllcall("tcl86t\Tcl_ReadRaw")
    }
    
    static Tcl_Realloc(param*)
    {
        dllcall("tcl86t\Tcl_Realloc")
    }
    
    static Tcl_ReapDetachedProcs(param*)
    {
        dllcall("tcl86t\Tcl_ReapDetachedProcs")
    }
    
    static Tcl_RecordAndEval(param*)
    {
        dllcall("tcl86t\Tcl_RecordAndEval")
    }
    
    static Tcl_RecordAndEvalObj(param*)
    {
        dllcall("tcl86t\Tcl_RecordAndEvalObj")
    }
    
    static Tcl_RegExpCompile(param*)
    {
        dllcall("tcl86t\Tcl_RegExpCompile")
    }
    
    static Tcl_RegExpExec(param*)
    {
        dllcall("tcl86t\Tcl_RegExpExec")
    }
    
    static Tcl_RegExpExecObj(param*)
    {
        dllcall("tcl86t\Tcl_RegExpExecObj")
    }
    
    static Tcl_RegExpGetInfo(param*)
    {
        dllcall("tcl86t\Tcl_RegExpGetInfo")
    }
    
    static Tcl_RegExpMatch(param*)
    {
        dllcall("tcl86t\Tcl_RegExpMatch")
    }
    
    static Tcl_RegExpMatchObj(param*)
    {
        dllcall("tcl86t\Tcl_RegExpMatchObj")
    }
    
    static Tcl_RegExpRange(param*)
    {
        dllcall("tcl86t\Tcl_RegExpRange")
    }
    
    static Tcl_RegisterChannel(param*)
    {
        dllcall("tcl86t\Tcl_RegisterChannel")
    }
    
    static Tcl_RegisterConfig(param*)
    {
        dllcall("tcl86t\Tcl_RegisterConfig")
    }
    
    static Tcl_RegisterObjType(typePtr)
    {
        dllcall("tcl86t\Tcl_RegisterObjType", "ptr", typePtr)
    }
    
    static Tcl_Release(param*)
    {
        dllcall("tcl86t\Tcl_Release")
    }
    
    static Tcl_RemoveInterpResolvers(param*)
    {
        dllcall("tcl86t\Tcl_RemoveInterpResolvers")
    }
    
    static Tcl_ResetResult(interp)
    {
        dllcall("tcl86t\Tcl_ResetResult", "ptr", interp)
    }
    
    static Tcl_RestoreInterpState(param*)
    {
        dllcall("tcl86t\Tcl_RestoreInterpState")
    }
    
    static Tcl_RestoreResult(param*)
    {
        dllcall("tcl86t\Tcl_RestoreResult")
    }
    
    static Tcl_SaveInterpState(param*)
    {
        dllcall("tcl86t\Tcl_SaveInterpState")
    }
    
    static Tcl_SaveResult(param*)
    {
        dllcall("tcl86t\Tcl_SaveResult")
    }
    
    static Tcl_ScanCountedElement(param*)
    {
        dllcall("tcl86t\Tcl_ScanCountedElement")
    }
    
    static Tcl_ScanElement(param*)
    {
        dllcall("tcl86t\Tcl_ScanElement")
    }
    
    static Tcl_Seek(param*)
    {
        dllcall("tcl86t\Tcl_Seek")
    }
    
    static Tcl_SeekOld(param*)
    {
        dllcall("tcl86t\Tcl_SeekOld")
    }
    
    static Tcl_ServiceAll() ; => int
    {
        return dllcall("tcl86t\Tcl_ServiceAll")
    }
    
    static Tcl_ServiceEvent(flags) ; => int
    {
        return dllcall("tcl86t\Tcl_ServiceEvent", "int", flags)
    }
    
    static Tcl_ServiceModeHook(param*)
    {
        dllcall("tcl86t\Tcl_ServiceModeHook")
    }
    
    static Tcl_SetAssocData(param*)
    {
        dllcall("tcl86t\Tcl_SetAssocData")
    }
    
    static Tcl_SetBignumObj(param*)
    {
        dllcall("tcl86t\Tcl_SetBignumObj")
    }
    
    static Tcl_SetBooleanObj(param*)
    {
        dllcall("tcl86t\Tcl_SetBooleanObj")
    }
    
    static Tcl_SetByteArrayLength(param*)
    {
        dllcall("tcl86t\Tcl_SetByteArrayLength")
    }
    
    static Tcl_SetByteArrayObj(param*)
    {
        dllcall("tcl86t\Tcl_SetByteArrayObj")
    }
    
    static Tcl_SetChannelBufferSize(param*)
    {
        dllcall("tcl86t\Tcl_SetChannelBufferSize")
    }
    
    static Tcl_SetChannelError(param*)
    {
        dllcall("tcl86t\Tcl_SetChannelError")
    }
    
    static Tcl_SetChannelErrorInterp(param*)
    {
        dllcall("tcl86t\Tcl_SetChannelErrorInterp")
    }
    
    static Tcl_SetChannelOption(param*)
    {
        dllcall("tcl86t\Tcl_SetChannelOption")
    }
    
    static Tcl_SetCommandInfo(interp, cmdName, infoPtr) ; => int
    {
        return dllcall("tcl86t\Tcl_SetCommandInfo", "ptr", interp, "ptr", this.strBuffer(cmdName), "ptr", infoPtr)
    }
    
    static Tcl_SetCommandInfoFromToken(param*)
    {
        dllcall("tcl86t\Tcl_SetCommandInfoFromToken")
    }
    
    static Tcl_SetDefaultEncodingDir(param*)
    {
        dllcall("tcl86t\Tcl_SetDefaultEncodingDir")
    }
    
    static Tcl_SetDoubleObj(param*)
    {
        dllcall("tcl86t\Tcl_SetDoubleObj")
    }
    
    static Tcl_SetEncodingSearchPath(param*)
    {
        dllcall("tcl86t\Tcl_SetEncodingSearchPath")
    }
    
    static Tcl_SetEnsembleFlags(param*)
    {
        dllcall("tcl86t\Tcl_SetEnsembleFlags")
    }
    
    static Tcl_SetEnsembleMappingDict(param*)
    {
        dllcall("tcl86t\Tcl_SetEnsembleMappingDict")
    }
    
    static Tcl_SetEnsembleParameterList(param*)
    {
        dllcall("tcl86t\Tcl_SetEnsembleParameterList")
    }
    
    static Tcl_SetEnsembleSubcommandList(param*)
    {
        dllcall("tcl86t\Tcl_SetEnsembleSubcommandList")
    }
    
    static Tcl_SetEnsembleUnknownHandler(param*)
    {
        dllcall("tcl86t\Tcl_SetEnsembleUnknownHandler")
    }
    
    static Tcl_SetErrno(param*)
    {
        dllcall("tcl86t\Tcl_SetErrno")
    }
    
    static Tcl_SetErrorCode(param*)
    {
        dllcall("tcl86t\Tcl_SetErrorCode")
    }
    
    static Tcl_SetErrorCodeVA(param*)
    {
        dllcall("tcl86t\Tcl_SetErrorCodeVA")
    }
    
    static Tcl_SetErrorLine(param*)
    {
        dllcall("tcl86t\Tcl_SetErrorLine")
    }
    
    static Tcl_SetExitProc(param*)
    {
        dllcall("tcl86t\Tcl_SetExitProc")
    }
    
    static Tcl_SetIntObj(param*)
    {
        dllcall("tcl86t\Tcl_SetIntObj")
    }
    
    static Tcl_SetListObj(param*)
    {
        dllcall("tcl86t\Tcl_SetListObj")
    }
    
    static Tcl_SetLongObj(param*)
    {
        dllcall("tcl86t\Tcl_SetLongObj")
    }
    
    static Tcl_SetMainLoop(param*)
    {
        dllcall("tcl86t\Tcl_SetMainLoop")
    }
    
    static Tcl_SetMaxBlockTime(timePtr)
    {
        dllcall("tcl86t\Tcl_SetMaxBlockTime", "ptr", timePtr)
    }
    
    static Tcl_SetNamespaceResolvers(param*)
    {
        dllcall("tcl86t\Tcl_SetNamespaceResolvers")
    }
    
    static Tcl_SetNamespaceUnknownHandler(param*)
    {
        dllcall("tcl86t\Tcl_SetNamespaceUnknownHandler")
    }
    
    static Tcl_SetNotifier(param*)
    {
        dllcall("tcl86t\Tcl_SetNotifier")
    }
    
    static Tcl_SetObjErrorCode(param*)
    {
        dllcall("tcl86t\Tcl_SetObjErrorCode")
    }
    
    static Tcl_SetObjLength(param*)
    {
        dllcall("tcl86t\Tcl_SetObjLength")
    }
    
    static Tcl_SetObjResult(interp, objPtr)
    {
        return dllcall("tcl86t\Tcl_SetObjResult", "ptr", interp, "ptr", objPtr)
    }
    
    static Tcl_SetPanicProc(param*)
    {
        dllcall("tcl86t\Tcl_SetPanicProc")
    }
    
    static Tcl_SetRecursionLimit(param*)
    {
        dllcall("tcl86t\Tcl_SetRecursionLimit")
    }
    
    static Tcl_SetResult(interp, string, freeProc)
    {
        dllcall("tcl86t\Tcl_SetResult", "ptr", interp, "ptr", this.strBuffer(string), "ptr", freeProc)
    }
    
    static Tcl_SetReturnOptions(param*)
    {
        dllcall("tcl86t\Tcl_SetReturnOptions")
    }
    
    static Tcl_SetServiceMode(mode) ; => int
    {
        return dllcall("tcl86t\Tcl_SetServiceMode", "int", mode)
    }
    
    static Tcl_SetStartupScript(param*)
    {
        dllcall("tcl86t\Tcl_SetStartupScript")
    }
    
    static Tcl_SetStdChannel(param*)
    {
        dllcall("tcl86t\Tcl_SetStdChannel")
    }
    
    static Tcl_SetStringObj(param*)
    {
        dllcall("tcl86t\Tcl_SetStringObj")
    }
    
    static Tcl_SetSystemEncoding(param*)
    {
        dllcall("tcl86t\Tcl_SetSystemEncoding")
    }
    
    static Tcl_SetTimeProc(param*)
    {
        dllcall("tcl86t\Tcl_SetTimeProc")
    }
    
    static Tcl_SetTimer(timePtr)
    {
        dllcall("tcl86t\Tcl_SetTimer", "ptr", timePtr)
    }
    
    static Tcl_SetUnicodeObj(param*)
    {
        dllcall("tcl86t\Tcl_SetUnicodeObj")
    }
    
    static Tcl_SetVar(interp, varName, newValue, flags) ; => char*
    {
        return strget(dllcall("tcl86t\Tcl_SetVar", "ptr", interp, "ptr", this.strBuffer(varName), "ptr", this.strBuffer(newValue), "int", flags), , "utf-8")
    }
    
    static Tcl_SetVar2(interp, name1, name2, newValue, flags) ; => char*
    {
        return strget(dllcall("tcl86t\Tcl_SetVar2", "ptr", interp, "ptr", this.strBuffer(name1), "ptr", this.strBuffer(name2), "ptr", this.strBuffer(newValue), "int", flags), , "utf-8")
    }
    
    static Tcl_SetVar2Ex(interp, name1, name2, newValuePtr, flags) ; => Tcl_Obj*
    {
        return dllcall("tcl86t\Tcl_SetVar2Ex", "ptr", interp, "ptr", this.strBuffer(name1), "ptr", this.strBuffer(name2), "ptr", newValuePtr, "int", flags)
    }
    
    static Tcl_SetWideIntObj(param*)
    {
        dllcall("tcl86t\Tcl_SetWideIntObj")
    }
    
    static Tcl_SignalId(param*)
    {
        dllcall("tcl86t\Tcl_SignalId")
    }
    
    static Tcl_SignalMsg(param*)
    {
        dllcall("tcl86t\Tcl_SignalMsg")
    }
    
    static Tcl_Sleep(param*)
    {
        dllcall("tcl86t\Tcl_Sleep")
    }
    
    static Tcl_SourceRCFile(param*)
    {
        dllcall("tcl86t\Tcl_SourceRCFile")
    }
    
    static Tcl_SpliceChannel(param*)
    {
        dllcall("tcl86t\Tcl_SpliceChannel")
    }
    
    static Tcl_SplitList(param*)
    {
        dllcall("tcl86t\Tcl_SplitList")
    }
    
    static Tcl_SplitPath(param*)
    {
        dllcall("tcl86t\Tcl_SplitPath")
    }
    
    static Tcl_StackChannel(param*)
    {
        dllcall("tcl86t\Tcl_StackChannel")
    }
    
    static Tcl_Stat(param*)
    {
        dllcall("tcl86t\Tcl_Stat")
    }
    
    static Tcl_StaticPackage(param*)
    {
        dllcall("tcl86t\Tcl_StaticPackage")
    }
    
    static Tcl_StringCaseMatch(param*)
    {
        dllcall("tcl86t\Tcl_StringCaseMatch")
    }
    
    static Tcl_StringMatch(param*)
    {
        dllcall("tcl86t\Tcl_StringMatch")
    }
    
    static Tcl_SubstObj(param*)
    {
        dllcall("tcl86t\Tcl_SubstObj")
    }
    
    static Tcl_TakeBignumFromObj(param*)
    {
        dllcall("tcl86t\Tcl_TakeBignumFromObj")
    }
    
    static Tcl_Tell(param*)
    {
        dllcall("tcl86t\Tcl_Tell")
    }
    
    static Tcl_TellOld(param*)
    {
        dllcall("tcl86t\Tcl_TellOld")
    }
    
    static Tcl_ThreadAlert(threadId, clientData)
    {
        dllcall("tcl86t\Tcl_ThreadAlert", "ptr", threadId, "ptr", clientData)
    }
    
    static Tcl_ThreadQueueEvent(threadId, evPtr, position)
    {
        dllcall("tcl86t\Tcl_ThreadQueueEvent", "ptr", threadId, "ptr", evPtr, "ptr", position)
    }
    
    static Tcl_TraceCommand(param*)
    {
        dllcall("tcl86t\Tcl_TraceCommand")
    }
    
    static Tcl_TraceVar(param*)
    {
        dllcall("tcl86t\Tcl_TraceVar")
    }
    
    static Tcl_TraceVar2(param*)
    {
        dllcall("tcl86t\Tcl_TraceVar2")
    }
    
    static Tcl_TransferResult(param*)
    {
        dllcall("tcl86t\Tcl_TransferResult")
    }
    
    static Tcl_TranslateFileName(param*)
    {
        dllcall("tcl86t\Tcl_TranslateFileName")
    }
    
    static Tcl_TruncateChannel(param*)
    {
        dllcall("tcl86t\Tcl_TruncateChannel")
    }
    
    static Tcl_Ungets(param*)
    {
        dllcall("tcl86t\Tcl_Ungets")
    }
    
    static Tcl_UniCharAtIndex(param*)
    {
        dllcall("tcl86t\Tcl_UniCharAtIndex")
    }
    
    static Tcl_UniCharCaseMatch(param*)
    {
        dllcall("tcl86t\Tcl_UniCharCaseMatch")
    }
    
    static Tcl_UniCharIsAlnum(param*)
    {
        dllcall("tcl86t\Tcl_UniCharIsAlnum")
    }
    
    static Tcl_UniCharIsAlpha(param*)
    {
        dllcall("tcl86t\Tcl_UniCharIsAlpha")
    }
    
    static Tcl_UniCharIsControl(param*)
    {
        dllcall("tcl86t\Tcl_UniCharIsControl")
    }
    
    static Tcl_UniCharIsDigit(param*)
    {
        dllcall("tcl86t\Tcl_UniCharIsDigit")
    }
    
    static Tcl_UniCharIsGraph(param*)
    {
        dllcall("tcl86t\Tcl_UniCharIsGraph")
    }
    
    static Tcl_UniCharIsLower(param*)
    {
        dllcall("tcl86t\Tcl_UniCharIsLower")
    }
    
    static Tcl_UniCharIsPrint(param*)
    {
        dllcall("tcl86t\Tcl_UniCharIsPrint")
    }
    
    static Tcl_UniCharIsPunct(param*)
    {
        dllcall("tcl86t\Tcl_UniCharIsPunct")
    }
    
    static Tcl_UniCharIsSpace(param*)
    {
        dllcall("tcl86t\Tcl_UniCharIsSpace")
    }
    
    static Tcl_UniCharIsUpper(param*)
    {
        dllcall("tcl86t\Tcl_UniCharIsUpper")
    }
    
    static Tcl_UniCharIsWordChar(param*)
    {
        dllcall("tcl86t\Tcl_UniCharIsWordChar")
    }
    
    static Tcl_UniCharLen(param*)
    {
        dllcall("tcl86t\Tcl_UniCharLen")
    }
    
    static Tcl_UniCharNcasecmp(param*)
    {
        dllcall("tcl86t\Tcl_UniCharNcasecmp")
    }
    
    static Tcl_UniCharNcmp(param*)
    {
        dllcall("tcl86t\Tcl_UniCharNcmp")
    }
    
    static Tcl_UniCharToLower(param*)
    {
        dllcall("tcl86t\Tcl_UniCharToLower")
    }
    
    static Tcl_UniCharToTitle(param*)
    {
        dllcall("tcl86t\Tcl_UniCharToTitle")
    }
    
    static Tcl_UniCharToUpper(param*)
    {
        dllcall("tcl86t\Tcl_UniCharToUpper")
    }
    
    static Tcl_UniCharToUtf(param*)
    {
        dllcall("tcl86t\Tcl_UniCharToUtf")
    }
    
    static Tcl_UniCharToUtfDString(param*)
    {
        dllcall("tcl86t\Tcl_UniCharToUtfDString")
    }
    
    static Tcl_UnlinkVar(param*)
    {
        dllcall("tcl86t\Tcl_UnlinkVar")
    }
    
    static Tcl_UnregisterChannel(param*)
    {
        dllcall("tcl86t\Tcl_UnregisterChannel")
    }
    
    static Tcl_UnsetVar(interp, varName, flags) ; => int
    {
        return dllcall("tcl86t\Tcl_UnsetVar", "ptr", interp, "ptr", this.strBuffer(varName), "int", flags)
    }
    
    static Tcl_UnsetVar2(interp, name1, name2, flags) ; => int
    {
        return dllcall("tcl86t\Tcl_UnsetVar2", "ptr", interp, "ptr", this.strBuffer(name1), "ptr", this.strBuffer(name2), "int", flags)
    }
    
    static Tcl_UnstackChannel(param*)
    {
        dllcall("tcl86t\Tcl_UnstackChannel")
    }
    
    static Tcl_UntraceCommand(param*)
    {
        dllcall("tcl86t\Tcl_UntraceCommand")
    }
    
    static Tcl_UntraceVar(param*)
    {
        dllcall("tcl86t\Tcl_UntraceVar")
    }
    
    static Tcl_UntraceVar2(param*)
    {
        dllcall("tcl86t\Tcl_UntraceVar2")
    }
    
    static Tcl_UpVar(param*)
    {
        dllcall("tcl86t\Tcl_UpVar")
    }
    
    static Tcl_UpVar2(param*)
    {
        dllcall("tcl86t\Tcl_UpVar2")
    }
    
    static Tcl_UpdateLinkedVar(param*)
    {
        dllcall("tcl86t\Tcl_UpdateLinkedVar")
    }
    
    static Tcl_UtfAtIndex(param*)
    {
        dllcall("tcl86t\Tcl_UtfAtIndex")
    }
    
    static Tcl_UtfBackslash(param*)
    {
        dllcall("tcl86t\Tcl_UtfBackslash")
    }
    
    static Tcl_UtfCharComplete(param*)
    {
        dllcall("tcl86t\Tcl_UtfCharComplete")
    }
    
    static Tcl_UtfFindFirst(param*)
    {
        dllcall("tcl86t\Tcl_UtfFindFirst")
    }
    
    static Tcl_UtfFindLast(param*)
    {
        dllcall("tcl86t\Tcl_UtfFindLast")
    }
    
    static Tcl_UtfNcasecmp(param*)
    {
        dllcall("tcl86t\Tcl_UtfNcasecmp")
    }
    
    static Tcl_UtfNcmp(param*)
    {
        dllcall("tcl86t\Tcl_UtfNcmp")
    }
    
    static Tcl_UtfNext(param*)
    {
        dllcall("tcl86t\Tcl_UtfNext")
    }
    
    static Tcl_UtfPrev(param*)
    {
        dllcall("tcl86t\Tcl_UtfPrev")
    }
    
    static Tcl_UtfToExternal(param*)
    {
        dllcall("tcl86t\Tcl_UtfToExternal")
    }
    
    static Tcl_UtfToExternalDString(param*)
    {
        dllcall("tcl86t\Tcl_UtfToExternalDString")
    }
    
    static Tcl_UtfToLower(param*)
    {
        dllcall("tcl86t\Tcl_UtfToLower")
    }
    
    static Tcl_UtfToTitle(param*)
    {
        dllcall("tcl86t\Tcl_UtfToTitle")
    }
    
    static Tcl_UtfToUniChar(param*)
    {
        dllcall("tcl86t\Tcl_UtfToUniChar")
    }
    
    static Tcl_UtfToUniCharDString(param*)
    {
        dllcall("tcl86t\Tcl_UtfToUniCharDString")
    }
    
    static Tcl_UtfToUpper(param*)
    {
        dllcall("tcl86t\Tcl_UtfToUpper")
    }
    
    static Tcl_ValidateAllMemory(param*)
    {
        dllcall("tcl86t\Tcl_ValidateAllMemory")
    }
    
    static Tcl_VarEval(interp, string*) ; => int
    {
        fn := dllcall.bind("tcl86t\Tcl_VarEval", "ptr", interp)
        for i in string
            fn := fn.bind("ptr", this.strBuffer(i))
        return fn()
    }
    
    static Tcl_VarEvalVA(interp, argList) ; => int
    {
        return dllcall("tcl86t\Tcl_VarEvalVA", "ptr", interp, "ptr", argList)
    }
    
    static Tcl_VarTraceInfo(param*)
    {
        dllcall("tcl86t\Tcl_VarTraceInfo")
    }
    
    static Tcl_VarTraceInfo2(param*)
    {
        dllcall("tcl86t\Tcl_VarTraceInfo2")
    }
    
    static Tcl_WaitForEvent(timePtr) ; => int
    {
        return dllcall("tcl86t\Tcl_WaitForEvent", "ptr", timePtr)
    }
    
    static Tcl_WaitPid(param*)
    {
        dllcall("tcl86t\Tcl_WaitPid")
    }
    
    static Tcl_WinTCharToUtf(param*)
    {
        dllcall("tcl86t\Tcl_WinTCharToUtf")
    }
    
    static Tcl_WinUtfToTChar(param*)
    {
        dllcall("tcl86t\Tcl_WinUtfToTChar")
    }
    
    static Tcl_Write(param*)
    {
        dllcall("tcl86t\Tcl_Write")
    }
    
    static Tcl_WriteChars(param*)
    {
        dllcall("tcl86t\Tcl_WriteChars")
    }
    
    static Tcl_WriteObj(param*)
    {
        dllcall("tcl86t\Tcl_WriteObj")
    }
    
    static Tcl_WriteRaw(param*)
    {
        dllcall("tcl86t\Tcl_WriteRaw")
    }
    
    static Tcl_WrongNumArgs(param*)
    {
        dllcall("tcl86t\Tcl_WrongNumArgs")
    }
    
    static Tcl_ZlibAdler32(param*)
    {
        dllcall("tcl86t\Tcl_ZlibAdler32")
    }
    
    static Tcl_ZlibCRC32(param*)
    {
        dllcall("tcl86t\Tcl_ZlibCRC32")
    }
    
    static Tcl_ZlibDeflate(param*)
    {
        dllcall("tcl86t\Tcl_ZlibDeflate")
    }
    
    static Tcl_ZlibInflate(param*)
    {
        dllcall("tcl86t\Tcl_ZlibInflate")
    }
    
    static Tcl_ZlibStreamChecksum(param*)
    {
        dllcall("tcl86t\Tcl_ZlibStreamChecksum")
    }
    
    static Tcl_ZlibStreamClose(param*)
    {
        dllcall("tcl86t\Tcl_ZlibStreamClose")
    }
    
    static Tcl_ZlibStreamEof(param*)
    {
        dllcall("tcl86t\Tcl_ZlibStreamEof")
    }
    
    static Tcl_ZlibStreamGet(param*)
    {
        dllcall("tcl86t\Tcl_ZlibStreamGet")
    }
    
    static Tcl_ZlibStreamGetCommandName(param*)
    {
        dllcall("tcl86t\Tcl_ZlibStreamGetCommandName")
    }
    
    static Tcl_ZlibStreamInit(param*)
    {
        dllcall("tcl86t\Tcl_ZlibStreamInit")
    }
    
    static Tcl_ZlibStreamPut(param*)
    {
        dllcall("tcl86t\Tcl_ZlibStreamPut")
    }
    
    static Tcl_ZlibStreamReset(param*)
    {
        dllcall("tcl86t\Tcl_ZlibStreamReset")
    }
    
    static Tcl_ZlibStreamSetCompressionDictionary(param*)
    {
        dllcall("tcl86t\Tcl_ZlibStreamSetCompressionDictionary")
    }
    
    static TclpAlloc(param*)
    {
        dllcall("tcl86t\TclpAlloc")
    }
    
    static TclpCloseFile(param*)
    {
        dllcall("tcl86t\TclpCloseFile")
    }
    
    static TclpCreateCommandChannel(param*)
    {
        dllcall("tcl86t\TclpCreateCommandChannel")
    }
    
    static TclpCreatePipe(param*)
    {
        dllcall("tcl86t\TclpCreatePipe")
    }
    
    static TclpCreateProcess(param*)
    {
        dllcall("tcl86t\TclpCreateProcess")
    }
    
    static TclpCreateTempFile(param*)
    {
        dllcall("tcl86t\TclpCreateTempFile")
    }
    
    static TclpFindExecutable(param*)
    {
        dllcall("tcl86t\TclpFindExecutable")
    }
    
    static TclpFree(param*)
    {
        dllcall("tcl86t\TclpFree")
    }
    
    static TclpGetClicks(param*)
    {
        dllcall("tcl86t\TclpGetClicks")
    }
    
    static TclpGetCwd(param*)
    {
        dllcall("tcl86t\TclpGetCwd")
    }
    
    static TclpGetDate(param*)
    {
        dllcall("tcl86t\TclpGetDate")
    }
    
    static TclpGetDefaultStdChannel(param*)
    {
        dllcall("tcl86t\TclpGetDefaultStdChannel")
    }
    
    static TclpGetPid(param*)
    {
        dllcall("tcl86t\TclpGetPid")
    }
    
    static TclpGetSeconds(param*)
    {
        dllcall("tcl86t\TclpGetSeconds")
    }
    
    static TclpGetTime(param*)
    {
        dllcall("tcl86t\TclpGetTime")
    }
    
    static TclpGetUserHome(param*)
    {
        dllcall("tcl86t\TclpGetUserHome")
    }
    
    static TclpGmtime(param*)
    {
        dllcall("tcl86t\TclpGmtime")
    }
    
    static TclpHasSockets(param*)
    {
        dllcall("tcl86t\TclpHasSockets")
    }
    
    static TclpInetNtoa(param*)
    {
        dllcall("tcl86t\TclpInetNtoa")
    }
    
    static TclpLocaltime(param*)
    {
        dllcall("tcl86t\TclpLocaltime")
    }
    
    static TclpMakeFile(param*)
    {
        dllcall("tcl86t\TclpMakeFile")
    }
    
    static TclpObjAccess(param*)
    {
        dllcall("tcl86t\TclpObjAccess")
    }
    
    static TclpObjCopyDirectory(param*)
    {
        dllcall("tcl86t\TclpObjCopyDirectory")
    }
    
    static TclpObjCopyFile(param*)
    {
        dllcall("tcl86t\TclpObjCopyFile")
    }
    
    static TclpObjCreateDirectory(param*)
    {
        dllcall("tcl86t\TclpObjCreateDirectory")
    }
    
    static TclpObjDeleteFile(param*)
    {
        dllcall("tcl86t\TclpObjDeleteFile")
    }
    
    static TclpObjRemoveDirectory(param*)
    {
        dllcall("tcl86t\TclpObjRemoveDirectory")
    }
    
    static TclpObjRenameFile(param*)
    {
        dllcall("tcl86t\TclpObjRenameFile")
    }
    
    static TclpObjStat(param*)
    {
        dllcall("tcl86t\TclpObjStat")
    }
    
    static TclpOpenFile(param*)
    {
        dllcall("tcl86t\TclpOpenFile")
    }
    
    static TclpOpenFileChannel(param*)
    {
        dllcall("tcl86t\TclpOpenFileChannel")
    }
    
    static TclpRealloc(param*)
    {
        dllcall("tcl86t\TclpRealloc")
    }
    
    static TclpSetInitialEncodings(param*)
    {
        dllcall("tcl86t\TclpSetInitialEncodings")
    }
    
    static TclpUtfNcmp2(param*)
    {
        dllcall("tcl86t\TclpUtfNcmp2")
    }
}
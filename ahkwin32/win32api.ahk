Class win32api
{
    Static CloseHandle(handle)
    {
        if handle
            Return DllCall("CloseHandle", "Ptr", handle)
    }
    
    Static OpenProcess(reqdAccess, bInherit, pid)
    {
        Return DllCall("OpenProcess", "UInt", reqdAccess, "UInt", bInherit, "UInt", pid)
    }
    
    Static TerminateProcess(handle, exitCode)
    {
        if handle
            Return DllCall("TerminateProcess", "Ptr", handle, "UInt", exitCode)
    }
    
    Static NameCanonical := 7
    Static NameCanonicalEx := 9
    Static NameDisplay := 3
    Static NameFullyQualifiedDN := 1
    Static NameSamCompatible := 2
    Static NameServicePrincipal := 10
    Static NameUniqueId := 6
    Static NameUnknown := 0
    Static NameUserPrincipal := 8

    Static REG_NOTIFY_CHANGE_ATTRIBUTES := 2

    Static REG_NOTIFY_CHANGE_LAST_SET := 4

    Static REG_NOTIFY_CHANGE_NAME := 1
    Static REG_NOTIFY_CHANGE_SECURITY := 8

    Static STD_ERROR_HANDLE := -12

    Static STD_INPUT_HANDLE := -10

    STD_OUTPUT_HANDLE := -11

    Static VFT_APP := 1
    Static VFT_DLL := 2
    Static VFT_DRV := 3
    Static VFT_FONT := 4

    Static VFT_STATIC_LIB := 7

    Static VFT_UNKNOWN := 0
    Static VFT_VXD := 5

    Static VOS_DOS := 65536

    Static VOS_DOS_WINDOWS16 := 65537
    Static VOS_DOS_WINDOWS32 := 65540

    Static VOS_NT := 262144

    Static VOS_NT_WINDOWS32 := 262148

    Static VOS_OS216 := 131072

    Static VOS_OS216_PM16 := 131074

    Static VOS_OS232 := 196608

    Static VOS_OS232_PM32 := 196611

    Static VOS_UNKNOWN := 0

    Static VOS__PM16 := 2
    Static VOS__PM32 := 3
    Static VOS__WINDOWS16 := 1
    Static VOS__WINDOWS32 := 4

    Static VS_FF_DEBUG := 1
    Static VS_FF_INFOINFERRED := 16
    Static VS_FF_PATCHED := 4
    Static VS_FF_PRERELEASE := 2
    Static VS_FF_PRIVATEBUILD := 8
    Static VS_FF_SPECIALBUILD := 32
}
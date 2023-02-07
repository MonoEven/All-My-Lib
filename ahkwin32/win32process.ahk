Class win32process
{
    Static GetWindowThreadProcessId(hwnd)
    {
        Ret := DllCall("GetWindowThreadProcessId", "Ptr", hwnd, "Ptr*", &lpdwProcessId := 0)
        
        Return [Ret, lpdwProcessId]
    }
    
    Static ABOVE_NORMAL_PRIORITY_CLASS := 32768

    Static BELOW_NORMAL_PRIORITY_CLASS := 16384

    Static CREATE_BREAKAWAY_FROM_JOB := 16777216

    Static CREATE_DEFAULT_ERROR_MODE := 67108864

    Static CREATE_NEW_CONSOLE := 16

    Static CREATE_NEW_PROCESS_GROUP := 512

    Static CREATE_NO_WINDOW := 134217728

    Static CREATE_PRESERVE_CODE_AUTHZ_LEVEL := 33554432

    Static CREATE_SEPARATE_WOW_VDM := 2048

    Static CREATE_SHARED_WOW_VDM := 4096

    Static CREATE_SUSPENDED := 4

    Static CREATE_UNICODE_ENVIRONMENT := 1024

    Static DEBUG_ONLY_THIS_PROCESS := 2

    Static DEBUG_PROCESS := 1

    Static DETACHED_PROCESS := 8

    Static HIGH_PRIORITY_CLASS := 128

    Static IDLE_PRIORITY_CLASS := 64

    Static LIST_MODULES_32BIT := 1
    Static LIST_MODULES_64BIT := 2
    Static LIST_MODULES_ALL := 3
    Static LIST_MODULES_DEFAULT := 0

    Static MAXIMUM_PROCESSORS := 64

    Static NORMAL_PRIORITY_CLASS := 32

    Static REALTIME_PRIORITY_CLASS := 256

    Static STARTF_FORCEOFFFEEDBACK := 128
    Static STARTF_FORCEONFEEDBACK := 64
    Static STARTF_RUNFULLSCREEN := 32
    Static STARTF_USECOUNTCHARS := 8
    Static STARTF_USEFILLATTRIBUTE := 16
    Static STARTF_USEPOSITION := 4
    Static STARTF_USESHOWWINDOW := 1
    Static STARTF_USESIZE := 2
    Static STARTF_USESTDHANDLES := 256

    Static THREAD_MODE_BACKGROUND_BEGIN := 65536
    Static THREAD_MODE_BACKGROUND_END := 131072

    Static THREAD_PRIORITY_ABOVE_NORMAL := 1

    Static THREAD_PRIORITY_BELOW_NORMAL := -1

    Static THREAD_PRIORITY_HIGHEST := 2
    Static THREAD_PRIORITY_IDLE := -15
    Static THREAD_PRIORITY_LOWEST := -2
    Static THREAD_PRIORITY_NORMAL := 0

    Static THREAD_PRIORITY_TIME_CRITICAL := 15

    Static UNICODE := 1
}
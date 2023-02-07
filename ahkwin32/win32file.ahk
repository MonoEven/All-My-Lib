Class win32file
{
    Class handle
    {
        Ptr := 0
        
        Close()
        {
            if this.Ptr
                DllCall("CloseHandle", "Ptr", this.Ptr)
        }
    }
    
    Static CloseHandle(handle)
    {
        if handle
            DllCall("CloseHandle", "Ptr", handle)
    }
    
    Static CreateFile(fileName, desiredAccess, shareMode, attributes, CreationDisposition, flagsAndAttributes, hTemplateFile)
    {
        Ret := win32file.handle()
        Ret.Ptr := DllCall("CreateFileA", "AStr", fileName, "UInt", desiredAccess, "UInt", shareMode, "UInt", attributes, "UInt", CreationDisposition, "UInt", flagsAndAttributes, "UInt", hTemplateFile)
        
        Return Ret
    }
    
    Static ReadFile(hFile, bufSize, overlapped := 0)
    {
        Buf := Buffer(bufSize)
        DllCall("ReadFile", "Ptr", hFile, "Ptr", Buf, "UInt", Buf.Size, "UInt*", &BytesActuallyRead := 0, "Ptr", overlapped)
        
        Return [BytesActuallyRead, StrGet(Buf)]
    }
    
    Static WriteFile(hFile, data, ol := 0)
    {
        if !ol
            ol := StrLen(data) * 2
        
        DllCall("WriteFile", "Ptr", hFile, "Str", data, "UInt", ol, "UInt*", &lpNumberOfBytesWritten := 0, "Ptr", 0)
        
        Return lpNumberOfBytesWritten
    }

    Static CALLBACK_CHUNK_FINISHED := 0

    Static CALLBACK_STREAM_SWITCH := 1

    Static CBR_110 := 110
    Static CBR_115200 := 115200
    Static CBR_1200 := 1200
    Static CBR_128000 := 128000
    Static CBR_14400 := 14400
    Static CBR_19200 := 19200
    Static CBR_2400 := 2400
    Static CBR_256000 := 256000
    Static CBR_300 := 300
    Static CBR_38400 := 38400
    Static CBR_4800 := 4800
    Static CBR_56000 := 56000
    Static CBR_57600 := 57600
    Static CBR_600 := 600
    Static CBR_9600 := 9600

    Static CLRBREAK := 9
    Static CLRDTR := 6
    Static CLRRTS := 4

    Static COPY_FILE_ALLOW_DECRYPTED_DESTINATION := 8

    Static COPY_FILE_FAIL_IF_EXISTS := 1

    Static COPY_FILE_OPEN_SOURCE_FOR_WRITE := 4

    Static COPY_FILE_RESTARTABLE := 2

    Static CREATE_ALWAYS := 2

    Static CREATE_FOR_DIR := 2
    Static CREATE_FOR_IMPORT := 1

    Static CREATE_NEW := 1

    Static DRIVE_CDROM := 5
    Static DRIVE_FIXED := 3

    Static DRIVE_NO_ROOT_DIR := 1

    Static DRIVE_RAMDISK := 6
    Static DRIVE_REMOTE := 4
    Static DRIVE_REMOVABLE := 2
    Static DRIVE_UNKNOWN := 0

    Static DTR_CONTROL_DISABLE := 0
    Static DTR_CONTROL_ENABLE := 1
    Static DTR_CONTROL_HANDSHAKE := 2

    Static EVENPARITY := 2
    Static EV_BREAK := 64
    Static EV_CTS := 8
    Static EV_DSR := 16
    Static EV_ERR := 128
    Static EV_RING := 256
    Static EV_RLSD := 32
    Static EV_RXCHAR := 1
    Static EV_RXFLAG := 2
    Static EV_TXEMPTY := 4

    Static FD_ACCEPT := 8

    Static FD_ADDRESS_LIST_CHANGE := 512

    Static FD_CLOSE := 32
    Static FD_CONNECT := 16

    Static FD_GROUP_QOS := 128

    Static FD_OOB := 4
    Static FD_QOS := 64
    Static FD_READ := 1

    Static FD_ROUTING_INTERFACE_CHANGE := 256

    Static FD_WRITE := 2

    Static FileAllocationInfo := 5
    Static FileAttributeTagInfo := 9
    Static FileBasicInfo := 0
    Static FileCompressionInfo := 8
    Static FileDispositionInfo := 4
    Static FileEndOfFileInfo := 6
    Static FileIdBothDirectoryInfo := 10
    Static FileIdBothDirectoryRestartInfo := 11
    Static FileIdType := 0
    Static FileIoPriorityHintInfo := 12
    Static FileNameInfo := 2
    Static FileRenameInfo := 3
    Static FileStandardInfo := 1
    Static FileStreamInfo := 7

    Static FILE_ALL_ACCESS := 2032127

    Static FILE_ATTRIBUTE_ARCHIVE := 32
    Static FILE_ATTRIBUTE_COMPRESSED := 2048
    Static FILE_ATTRIBUTE_DIRECTORY := 16
    Static FILE_ATTRIBUTE_HIDDEN := 2
    Static FILE_ATTRIBUTE_NORMAL := 128
    Static FILE_ATTRIBUTE_OFFLINE := 4096
    Static FILE_ATTRIBUTE_READONLY := 1
    Static FILE_ATTRIBUTE_SYSTEM := 4
    Static FILE_ATTRIBUTE_TEMPORARY := 256

    Static FILE_BEGIN := 0
    Static FILE_CURRENT := 1
    Static FILE_ENCRYPTABLE := 0
    Static FILE_END := 2

    Static FILE_FLAG_BACKUP_SEMANTICS := 33554432

    Static FILE_FLAG_DELETE_ON_CLOSE := 67108864

    Static FILE_FLAG_NO_BUFFERING := 536870912

    Static FILE_FLAG_OPEN_REPARSE_POINT := 2097152

    Static FILE_FLAG_OVERLAPPED := 1073741824

    Static FILE_FLAG_POSIX_SEMANTICS := 16777216

    Static FILE_FLAG_RANDOM_ACCESS := 268435456

    Static FILE_FLAG_SEQUENTIAL_SCAN := 134217728

    Static FILE_FLAG_WRITE_THROUGH := -2147483648

    Static FILE_GENERIC_READ := 1179785
    Static FILE_GENERIC_WRITE := 1179926

    Static FILE_IS_ENCRYPTED := 1

    Static FILE_READ_ONLY := 8

    Static FILE_ROOT_DIR := 3

    Static FILE_SHARE_DELETE := 4
    Static FILE_SHARE_READ := 1
    Static FILE_SHARE_WRITE := 2

    Static FILE_SYSTEM_ATTR := 2
    Static FILE_SYSTEM_DIR := 4

    Static FILE_SYSTEM_NOT_SUPPORT := 6

    Static FILE_TYPE_CHAR := 2
    Static FILE_TYPE_DISK := 1
    Static FILE_TYPE_PIPE := 3
    Static FILE_TYPE_UNKNOWN := 0

    Static FILE_UNKNOWN := 5

    Static FILE_USER_DISALLOWED := 7

    Static GENERIC_EXECUTE := 536870912
    Static GENERIC_READ := -2147483648
    Static GENERIC_WRITE := 1073741824

    Static GetFileExInfoStandard := 1

    Static INVALID_HANDLE_VALUE := -1

    Static IoPriorityHintLow := 1
    Static IoPriorityHintNormal := 2
    Static IoPriorityHintVeryLow := 0

    Static MARKPARITY := 3

    Static MOVEFILE_COPY_ALLOWED := 2

    Static MOVEFILE_CREATE_HARDLINK := 16

    Static MOVEFILE_DELAY_UNTIL_REBOOT := 4

    Static MOVEFILE_FAIL_IF_NOT_TRACKABLE := 32

    Static MOVEFILE_REPLACE_EXISTING := 1

    Static MOVEFILE_WRITE_THROUGH := 8

    Static NOPARITY := 0

    Static ObjectIdType := 1

    Static ODDPARITY := 1

    Static ONE5STOPBITS := 1
    Static ONESTOPBIT := 0

    Static OPEN_ALWAYS := 4
    Static OPEN_EXISTING := 3

    Static OVERWRITE_HIDDEN := 4

    Static PROGRESS_CANCEL := 1
    Static PROGRESS_CONTINUE := 0
    Static PROGRESS_QUIET := 3
    Static PROGRESS_STOP := 2

    Static PURGE_RXABORT := 2
    Static PURGE_RXCLEAR := 8
    Static PURGE_TXABORT := 1
    Static PURGE_TXCLEAR := 4

    Static REPLACEFILE_IGNORE_MERGE_ERRORS := 2

    Static REPLACEFILE_WRITE_THROUGH := 1

    Static RTS_CONTROL_DISABLE := 0
    Static RTS_CONTROL_ENABLE := 1
    Static RTS_CONTROL_HANDSHAKE := 2
    Static RTS_CONTROL_TOGGLE := 3

    Static SCS_32BIT_BINARY := 0

    Static SCS_DOS_BINARY := 1

    Static SCS_OS216_BINARY := 5

    Static SCS_PIF_BINARY := 3

    Static SCS_POSIX_BINARY := 4

    Static SCS_WOW_BINARY := 2

    Static SECURITY_ANONYMOUS := 0

    Static SECURITY_CONTEXT_TRACKING := 262144

    Static SECURITY_DELEGATION := 196608

    Static SECURITY_EFFECTIVE_ONLY := 524288

    Static SECURITY_IDENTIFICATION := 65536
    Static SECURITY_IMPERSONATION := 131072

    Static SETBREAK := 8
    Static SETDTR := 5
    Static SETRTS := 3
    Static SETXOFF := 1
    Static SETXON := 2

    Static SO_CONNECT_TIME := 28684

    Static SO_UPDATE_ACCEPT_CONTEXT := 28683

    Static SO_UPDATE_CONNECT_CONTEXT := 28688

    Static SPACEPARITY := 4

    Static SYMBOLIC_LINK_FLAG_ALLOW_UNPRIVILEGED_CREATE := 2

    Static SYMBOLIC_LINK_FLAG_DIRECTORY := 1

    Static TF_DISCONNECT := 1

    Static TF_REUSE_SOCKET := 2

    Static TF_USE_DEFAULT_WORKER := 0

    Static TF_USE_KERNEL_APC := 32

    Static TF_USE_SYSTEM_THREAD := 16

    Static TF_WRITE_BEHIND := 4

    Static TRUNCATE_EXISTING := 5

    Static TWOSTOPBITS := 2

    Static UNICODE := 1

    Static WSAECONNABORTED := 10053
    Static WSAECONNRESET := 10054
    Static WSAEDISCON := 10101
    Static WSAEFAULT := 10014
    Static WSAEINPROGRESS := 10036
    Static WSAEINTR := 10004
    Static WSAEINVAL := 10022
    Static WSAEMSGSIZE := 10040
    Static WSAENETDOWN := 10050
    Static WSAENETRESET := 10052
    Static WSAENOBUFS := 10055
    Static WSAENOTCONN := 10057
    Static WSAENOTSOCK := 10038
    Static WSAEOPNOTSUPP := 10045
    Static WSAESHUTDOWN := 10058
    Static WSAEWOULDBLOCK := 10035

    Static WSA_IO_PENDING := 997

    Static WSA_OPERATION_ABORTED := 995
}
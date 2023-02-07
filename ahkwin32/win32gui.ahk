#Include <ahkwin32\CGdip>
_Token := CGdip.Startup()

Class win32gui
{
    Class DC
    {
        __New(hwnd)
        {
            this.hwnd := hwnd
        }
        
        GetDC()
        {
            Return GetDC(this.hwnd)
        }
    }
    
    Static EnumWindows(callback, extra)
    {
        fnptr := CallbackCreate(callback, "CDecl")
        
        Return DllCall("EnumWindows", "Ptr", fnptr, "UInt", extra)
    }
    
    Static FindWindow(ClassName, WindowName)
    {
        if !ClassName
            Return DllCall("FindWindow", "Ptr", 0, "Str", WindowName)
        
        Return DllCall("FindWindow", "Str", ClassName, "Str", WindowName)
    }
    
    Static GetWindowDC(hWnd)
    {
        Return win32gui.DC(hWnd)
    }
    
    Static GetWindowRect(hWnd)
    {
        if !hWnd
            Return []
        
        Rect := []
        
        DllCall("GetWindowRect", "Ptr", hWnd, "Ptr", lpRect := Buffer(16))
        
        Loop 4
            Rect.Push(NumGet(lpRect, (A_Index - 1) * 4, "Int"))
        
        Return Rect
    }
    
    Static GetWindowText(hWnd, encoding := "UTF-8")
    {
        Buf := Buffer(1024)
        DllCall("GetWindowTextA", "Ptr", hWnd, "Ptr", Buf, "UInt", Buf.Size)
        
        Return StrGet(Buf, encoding)
    }
    
    Static IsWindow(hWnd)
    {
        Return DllCall("IsWindow", "Ptr", hWnd)
    }
    
    Static IsWindowEnabled(hWnd)
    {
        Return DllCall("IsWindowEnabled", "Ptr", hWnd)
    }
    
    Static IsWindowVisible(hWnd)
    {
        Return DllCall("IsWindowVisible", "Ptr", hWnd)
    }
    
    Static MessageBox(parent, text, caption, flags)
    {
        Return DllCall("MessageBox", "Ptr", parent, "Str", text, "Str", caption, "UInt", flags)
    }
    
    Static PostMessage(hwnd, message, wparam, lparam)
    {
        Return DllCall("PostMessageA", "Ptr", hwnd, "UInt", message, "UInt", wparam, "UInt", lparam)
    }
    
    Static SetForegroundWindow(hWnd)
    {
        Return DllCall("SetForegroundWindow", "Ptr", hWnd)
    }
    
    Static CLR_NONE := -1

    Static dllhandle := 140728025874432

    Static ILC_COLOR := 0
    Static ILC_COLOR16 := 16
    Static ILC_COLOR24 := 24
    Static ILC_COLOR32 := 32
    Static ILC_COLOR4 := 4
    Static ILC_COLOR8 := 8
    Static ILC_COLORDDB := 254
    Static ILC_MASK := 1

    Static ILD_BLEND := 4
    Static ILD_BLEND25 := 2
    Static ILD_BLEND50 := 4
    Static ILD_FOCUS := 2
    Static ILD_MASK := 16
    Static ILD_NORMAL := 0
    Static ILD_SELECTED := 4
    Static ILD_TRANSPARENT := 1

    Static IMAGE_BITMAP := 0
    Static IMAGE_CURSOR := 2
    Static IMAGE_ICON := 1

    Static LR_CREATEDIBSECTION := 8192
    Static LR_DEFAULTCOLOR := 0
    Static LR_DEFAULTSIZE := 64
    Static LR_LOADFROMFILE := 16
    Static LR_LOADMAP3DCOLORS := 4096
    Static LR_LOADTRANSPARENT := 32
    Static LR_MONOCHROME := 1
    Static LR_SHARED := 32768
    Static LR_VGACOLOR := 128

    Static NIF_ICON := 2
    Static NIF_INFO := 16
    Static NIF_MESSAGE := 1
    Static NIF_STATE := 8
    Static NIF_TIP := 4

    Static NIIF_ERROR := 3

    Static NIIF_ICON_MASK := 15

    Static NIIF_INFO := 1
    Static NIIF_NONE := 0
    Static NIIF_NOSOUND := 16
    Static NIIF_WARNING := 2

    Static NIM_ADD := 0
    Static NIM_DELETE := 2
    Static NIM_MODIFY := 1
    Static NIM_SETVERSION := 4

    Static Token := _Token
    Static TPM_BOTTOMALIGN := 32
    Static TPM_CENTERALIGN := 4
    Static TPM_LEFTALIGN := 0
    Static TPM_LEFTBUTTON := 0
    Static TPM_NONOTIFY := 128
    Static TPM_RETURNCMD := 256
    Static TPM_RIGHTALIGN := 8
    Static TPM_RIGHTBUTTON := 2
    Static TPM_TOPALIGN := 0
    Static TPM_VCENTERALIGN := 16

    Static UNICODE := True
}
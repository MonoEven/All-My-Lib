#Include <ahkwin32\ahkwin32>

;messagebox
;win32gui.MessageBox(None,"Hello,pywin32!","pywin32",win32con.MB_OK)

;file
;handle := win32file.CreateFile("win32file_demo_test_file",
                                  ;win32file.GENERIC_WRITE,
                                  ;0,
                                  ;None,
                                  ;win32con.CREATE_NEW,
                                  ;0,
                                  ;None)
;test_data := "Hello there"
;win32file.WriteFile(handle, test_data)
;handle.Close()
;handle := win32file.CreateFile("win32file_demo_test_file", win32file.GENERIC_READ, 0, None, win32con.OPEN_EXISTING, 0, None)
;data := win32file.ReadFile(handle, 1024)[2]
;handle.Close()
;MsgBox data

;comobject
;w := win32com.client.Dispatch('Word.Application')
;xlApp := win32com.client.Dispatch('Excel.Application')
;w.Visible := 1
;w.DisplayAlerts := 0
;doc := w.Documents.Open(FileName := A_Desktop "\1.docx")
;myRange := doc.Range(0, 0)
;myRange.InsertBefore('Hello from Python!')
;wordSel := win32com.Select(myRange)
;; equal to-->
;; wordSel := myRange
;; wordSel.Select
;wordSel.Style := win32com.constants.wdStyleHeading1
;win32com.Close(w)
;; equal to-->
;; w.Documents.Close(SaveChanges := 0)
;; w.Quit()

; win32gui + Gdip
;get_windows(windowsname,filename)
;{
;    ; 获取窗口句柄
;    handle := win32gui.FindWindow(None,windowsname)
;    ; 将窗口放在前台，并激活该窗口（窗口不能最小化）
;    win32gui.SetForegroundWindow(handle)
;    ; 获取窗口DC
;    hdDC := win32gui.GetWindowDC(handle)
;    ; 根据句柄创建一个DC
;    newhdDC := win32ui.CreateDCFromHandle(hdDC)
;    ; 创建一个兼容设备内存的DC
;    saveDC := newhdDC.CreateCompatibleDC()
;    ; 创建bitmap保存图片
;    saveBitmap := win32ui.CreateBitmap()
;
;    ; 获取窗口的位置信息
;    arr_rect := win32gui.GetWindowRect(handle)
;    left := arr_rect[1], top := arr_rect[2], right := arr_rect[3], bottom := arr_rect[4]
;    ; 窗口长宽
;    width := right - left
;    height := bottom - top
;    ; bitmap初始化
;    saveBitmap.CreateCompatibleBitmap(newhdDC, width, height)
;    saveDC.SelectObject(saveBitmap)
;    saveDC.BitBlt([0, 0], [width, height], newhdDC, [0, 0], win32con.SRCCOPY)
;    saveBitmap.SaveBitmapFile(saveDC, filename)
;}
;get_windows("ahkwin32","截图.png")
;MsgBox win32gui.GetWindowText(win32gui.FindWindow(None, "ahkwin32"))

;ke := keyboardEmulation

;get_windows(windowsname,filename)
;{
;    ; 获取窗口句柄
;    hwnd := win32gui.FindWindow(None,windowsname)
;    ; 将窗口放在前台，并激活该窗口
;    win32gui.SetForegroundWindow(hwnd)
;
;    ; 输入helloworld
;
;    scancodes := [0x23, 0x12, 0x26, 0x26, 0x18, 0x11, 0x18, 0x13, 0x26, 0x20, 0x2a]
;
;    for code in scancodes
;        ke.key_press(code)
;    
;    ; 保存
;    ke.key_down(0x1d)
;    ke.key_down(0x1f)
;    ke.key_up(0x1d)
;    ke.key_up(0x1f)
;    sleep(1000)
;
;    ; 关闭窗口
;    win32gui.PostMessage(hwnd, win32con.WM_CLOSE, 0, 0)
;}

;get_windows("1.txt - Notepad","截图.png")
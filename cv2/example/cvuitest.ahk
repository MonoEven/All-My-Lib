#Include <cv2\cvui>

GUI_WINDOW1_NAME := 'Window 1'
GUI_WINDOW2_NAME := 'Windows 2'
ERROR_WINDOW_NAME := 'Error window'

; Check if an OpenCV window is open.
; From: https:#stackoverflow.com/a/48055987/29827
isWindowOpen(name)
{
	return cv2.getWindowProperty(name, cv2.WND_PROP_AUTOSIZE) != -1
}

; Open a new OpenCV window and watch it using cvui
openWindow(name)
{
	cv2.namedWindow(name)
	cvui.watch(name)
}

; Open an OpenCV window
closeWindow(name)
{
    cv2.destroyWindow(name)
	; Ensure OpenCV window event queue is processed, otherwise the window
	; will not be closed.
	cv2.waitKey(1)
}

; We have one mat for each window.
frametmp1 := cv2.mat(150, 600, CV2.CV_8UC3, [49, 52, 49])
frame1 := frametmp1.Clone()
frametmp2 := cv2.mat(150, 600, CV2.CV_8UC3, [49, 52, 49])
frame2 := frametmp2.Clone()
error_frame := cv2.mat(100, 300, CV2.CV_8UC3, [24, 66, 185])

; Flag to control if we should show an error window.
errored := False

; Create two OpenCV windows
cv2.namedWindow(GUI_WINDOW1_NAME)
cv2.namedWindow(GUI_WINDOW2_NAME)

; Init cvui and inform it to use the first window as the default one.
; cvui.init() will automatically watch the informed window.
cvui.init(GUI_WINDOW1_NAME)

; Tell cvui to keep track of mouse events in window2 as well.
cvui.watch(GUI_WINDOW2_NAME)

while (True)
{
    frame1.MAT := frametmp1.MAT.Clone()
    ; Inform cvui that all subsequent component calls and events are related to window 1.
    cvui.context(GUI_WINDOW1_NAME)

    cvui.beginColumn(frame1, 50, 20, -1, -1, 10)
    cvui.text('[Win1] Use the buttons below to control the errored window#None#')
        
    if cvui.button('Close')
        closeWindow(ERROR_WINDOW_NAME)

    ; If the button is clicked, we open the errored window.
    ; The content and rendering of such errored window will be performed
    ; after we handled all other windows.
    if cvui.button('Open')
    {
        errored := True
        openWindow(ERROR_WINDOW_NAME)
    }
    cvui.endColumn()

    ; Update all components of window1, e.g. mouse clicks, and show it.
    cvui.update(GUI_WINDOW1_NAME)
    cv2.imshow(GUI_WINDOW1_NAME, frame1)

    ; From this point on, we are going to render the second window. We need to inform cvui
    ; that all updates and components from now on are connected to window 2.
    ; We do that by calling cvui.context().
    frame2.MAT := frametmp2.MAT.Clone()
    cvui.context(GUI_WINDOW2_NAME)
    
    cvui.beginColumn(frame2, 50, 20, -1, -1, 10)
    cvui.text('[Win2] Use the buttons below to control the errored window#None#')

    if cvui.button('Close')
        closeWindow(ERROR_WINDOW_NAME)

    ; If the button is clicked, we open the errored window.
    ; The content and rendering of such errored window will be performed
    ; after we handled all other windows.
    if cvui.button('Open')
    {
        openWindow(ERROR_WINDOW_NAME)
        errored := True
    }
    cvui.endColumn()

    ; Update all components of window2, e.g. mouse clicks, and show it.
    cvui.update(GUI_WINDOW2_NAME)
    cv2.imshow(GUI_WINDOW2_NAME, frame2)

    ; Handle the content and rendering of the errored window,
    ; if we have un active errored and the window is actually open.
    if errored and isWindowOpen(ERROR_WINDOW_NAME)
    {
        ; Inform cvui that all subsequent component calls and events are
        ; related to the errored window from now on
        cvui.context(ERROR_WINDOW_NAME)

        cvui.text(error_frame, 70, 20, 'This is an errored message', 0.4, 0xff0000)

        if cvui.button(error_frame, 110, 40, 'Close')
            errored := False

        if errored
        {
            ; We still have an active errored.
            ; Update all components of the errored window, e.g. mouse clicks, and show it.
            cvui.update(ERROR_WINDOW_NAME)
            cv2.imshow(ERROR_WINDOW_NAME, error_frame)
        }
        else
            ; No more active errored. Let's close the errored window.
            closeWindow(ERROR_WINDOW_NAME)
    }

    ; Check if ESC key was pressed
    if cv2.waitKey(20) == 27
        break
}
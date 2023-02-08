#Include <tkinter\tk_const>

flag := Tk.dll_file("tkinter\lib\tk86t.dll")
if flag
    dllcall("LoadLibrary", "str", flag)
else
    throw error("tk86t.dll is not existed.")

class Tk extends Tk_Const
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
    
    static TkAllocWindow(param*)
    {
        dllcall("tk86t\TkAllocWindow")
    }
    
    static TkBTreeNumLines(param*)
    {
        dllcall("tk86t\TkBTreeNumLines")
    }
    
    static TkBezierPoints(param*)
    {
        dllcall("tk86t\TkBezierPoints")
    }
    
    static TkBezierScreenPoints(param*)
    {
        dllcall("tk86t\TkBezierScreenPoints")
    }
    
    static TkBindEventProc(param*)
    {
        dllcall("tk86t\TkBindEventProc")
    }
    
    static TkBindFree(param*)
    {
        dllcall("tk86t\TkBindFree")
    }
    
    static TkBindInit(param*)
    {
        dllcall("tk86t\TkBindInit")
    }
    
    static TkCanvasDashParseProc(param*)
    {
        dllcall("tk86t\TkCanvasDashParseProc")
    }
    
    static TkCanvasDashPrintProc(param*)
    {
        dllcall("tk86t\TkCanvasDashPrintProc")
    }
    
    static TkChangeEventWindow(param*)
    {
        dllcall("tk86t\TkChangeEventWindow")
    }
    
    static TkClipBox(param*)
    {
        dllcall("tk86t\TkClipBox")
    }
    
    static TkClipCleanup(param*)
    {
        dllcall("tk86t\TkClipCleanup")
    }
    
    static TkClipInit(param*)
    {
        dllcall("tk86t\TkClipInit")
    }
    
    static TkComputeAnchor(param*)
    {
        dllcall("tk86t\TkComputeAnchor")
    }
    
    static TkCreateCursorFromData(param*)
    {
        dllcall("tk86t\TkCreateCursorFromData")
    }
    
    static TkCreateFrame(param*)
    {
        dllcall("tk86t\TkCreateFrame")
    }
    
    static TkCreateMainWindow(param*)
    {
        dllcall("tk86t\TkCreateMainWindow")
    }
    
    static TkCreateRegion(param*)
    {
        dllcall("tk86t\TkCreateRegion")
    }
    
    static TkCreateThreadExitHandler(param*)
    {
        dllcall("tk86t\TkCreateThreadExitHandler")
    }
    
    static TkCreateXEventSource(param*)
    {
        dllcall("tk86t\TkCreateXEventSource")
    }
    
    static TkCurrentTime(param*)
    {
        dllcall("tk86t\TkCurrentTime")
    }
    
    static TkDebugBitmap(param*)
    {
        dllcall("tk86t\TkDebugBitmap")
    }
    
    static TkDebugBorder(param*)
    {
        dllcall("tk86t\TkDebugBorder")
    }
    
    static TkDebugColor(param*)
    {
        dllcall("tk86t\TkDebugColor")
    }
    
    static TkDebugConfig(param*)
    {
        dllcall("tk86t\TkDebugConfig")
    }
    
    static TkDebugCursor(param*)
    {
        dllcall("tk86t\TkDebugCursor")
    }
    
    static TkDebugFont(param*)
    {
        dllcall("tk86t\TkDebugFont")
    }
    
    static TkDeleteAllImages(param*)
    {
        dllcall("tk86t\TkDeleteAllImages")
    }
    
    static TkDeleteThreadExitHandler(param*)
    {
        dllcall("tk86t\TkDeleteThreadExitHandler")
    }
    
    static TkDestroyRegion(param*)
    {
        dllcall("tk86t\TkDestroyRegion")
    }
    
    static TkDoConfigureNotify(param*)
    {
        dllcall("tk86t\TkDoConfigureNotify")
    }
    
    static TkDrawAngledChars(param*)
    {
        dllcall("tk86t\TkDrawAngledChars")
    }
    
    static TkDrawAngledTextLayout(param*)
    {
        dllcall("tk86t\TkDrawAngledTextLayout")
    }
    
    static TkDrawInsetFocusHighlight(param*)
    {
        dllcall("tk86t\TkDrawInsetFocusHighlight")
    }
    
    static TkEventDeadWindow(param*)
    {
        dllcall("tk86t\TkEventDeadWindow")
    }
    
    static TkFillPolygon(param*)
    {
        dllcall("tk86t\TkFillPolygon")
    }
    
    static TkFindStateNum(param*)
    {
        dllcall("tk86t\TkFindStateNum")
    }
    
    static TkFindStateNumObj(param*)
    {
        dllcall("tk86t\TkFindStateNumObj")
    }
    
    static TkFindStateString(param*)
    {
        dllcall("tk86t\TkFindStateString")
    }
    
    static TkFocusDeadWindow(param*)
    {
        dllcall("tk86t\TkFocusDeadWindow")
    }
    
    static TkFocusFilterEvent(param*)
    {
        dllcall("tk86t\TkFocusFilterEvent")
    }
    
    static TkFocusFree(param*)
    {
        dllcall("tk86t\TkFocusFree")
    }
    
    static TkFocusKeyEvent(param*)
    {
        dllcall("tk86t\TkFocusKeyEvent")
    }
    
    static TkFontPkgFree(param*)
    {
        dllcall("tk86t\TkFontPkgFree")
    }
    
    static TkFontPkgInit(param*)
    {
        dllcall("tk86t\TkFontPkgInit")
    }
    
    static TkFreeBindingTags(param*)
    {
        dllcall("tk86t\TkFreeBindingTags")
    }
    
    static TkGCCleanup(param*)
    {
        dllcall("tk86t\TkGCCleanup")
    }
    
    static TkGetBitmapData(param*)
    {
        dllcall("tk86t\TkGetBitmapData")
    }
    
    static TkGetBitmapPredefTable(param*)
    {
        dllcall("tk86t\TkGetBitmapPredefTable")
    }
    
    static TkGetButtPoints(param*)
    {
        dllcall("tk86t\TkGetButtPoints")
    }
    
    static TkGetCursorByName(param*)
    {
        dllcall("tk86t\TkGetCursorByName")
    }
    
    static TkGetDefaultScreenName(param*)
    {
        dllcall("tk86t\TkGetDefaultScreenName")
    }
    
    static TkGetDisplay(param*)
    {
        dllcall("tk86t\TkGetDisplay")
    }
    
    static TkGetDisplayList(param*)
    {
        dllcall("tk86t\TkGetDisplayList")
    }
    
    static TkGetDisplayOf(param*)
    {
        dllcall("tk86t\TkGetDisplayOf")
    }
    
    static TkGetFocusWin(param*)
    {
        dllcall("tk86t\TkGetFocusWin")
    }
    
    static TkGetInterpNames(param*)
    {
        dllcall("tk86t\TkGetInterpNames")
    }
    
    static TkGetMainInfoList(param*)
    {
        dllcall("tk86t\TkGetMainInfoList")
    }
    
    static TkGetMiterPoints(param*)
    {
        dllcall("tk86t\TkGetMiterPoints")
    }
    
    static TkGetOptionSpec(param*)
    {
        dllcall("tk86t\TkGetOptionSpec")
    }
    
    static TkGetPointerCoords(param*)
    {
        dllcall("tk86t\TkGetPointerCoords")
    }
    
    static TkGetServerInfo(param*)
    {
        dllcall("tk86t\TkGetServerInfo")
    }
    
    static TkGetWindowFromObj(param*)
    {
        dllcall("tk86t\TkGetWindowFromObj")
    }
    
    static TkGrabDeadWindow(param*)
    {
        dllcall("tk86t\TkGrabDeadWindow")
    }
    
    static TkGrabState(param*)
    {
        dllcall("tk86t\TkGrabState")
    }
    
    static TkInOutEvents(param*)
    {
        dllcall("tk86t\TkInOutEvents")
    }
    
    static TkIncludePoint(param*)
    {
        dllcall("tk86t\TkIncludePoint")
    }
    
    static TkInstallFrameMenu(param*)
    {
        dllcall("tk86t\TkInstallFrameMenu")
    }
    
    static TkIntersectAngledTextLayout(param*)
    {
        dllcall("tk86t\TkIntersectAngledTextLayout")
    }
    
    static TkIntersectRegion(param*)
    {
        dllcall("tk86t\TkIntersectRegion")
    }
    
    static TkKeysymToString(param*)
    {
        dllcall("tk86t\TkKeysymToString")
    }
    
    static TkLineToArea(param*)
    {
        dllcall("tk86t\TkLineToArea")
    }
    
    static TkLineToPoint(param*)
    {
        dllcall("tk86t\TkLineToPoint")
    }
    
    static TkMakeBezierCurve(param*)
    {
        dllcall("tk86t\TkMakeBezierCurve")
    }
    
    static TkMakeBezierPostscript(param*)
    {
        dllcall("tk86t\TkMakeBezierPostscript")
    }
    
    static TkMakeRawCurve(param*)
    {
        dllcall("tk86t\TkMakeRawCurve")
    }
    
    static TkMakeRawCurvePostscript(param*)
    {
        dllcall("tk86t\TkMakeRawCurvePostscript")
    }
    
    static TkOffsetParseProc(param*)
    {
        dllcall("tk86t\TkOffsetParseProc")
    }
    
    static TkOffsetPrintProc(param*)
    {
        dllcall("tk86t\TkOffsetPrintProc")
    }
    
    static TkOptionClassChanged(param*)
    {
        dllcall("tk86t\TkOptionClassChanged")
    }
    
    static TkOptionDeadWindow(param*)
    {
        dllcall("tk86t\TkOptionDeadWindow")
    }
    
    static TkOrientParseProc(param*)
    {
        dllcall("tk86t\TkOrientParseProc")
    }
    
    static TkOrientPrintProc(param*)
    {
        dllcall("tk86t\TkOrientPrintProc")
    }
    
    static TkOvalToArea(param*)
    {
        dllcall("tk86t\TkOvalToArea")
    }
    
    static TkOvalToPoint(param*)
    {
        dllcall("tk86t\TkOvalToPoint")
    }
    
    static TkPhotoGetValidRegion(param*)
    {
        dllcall("tk86t\TkPhotoGetValidRegion")
    }
    
    static TkPixelParseProc(param*)
    {
        dllcall("tk86t\TkPixelParseProc")
    }
    
    static TkPixelPrintProc(param*)
    {
        dllcall("tk86t\TkPixelPrintProc")
    }
    
    static TkPointerDeadWindow(param*)
    {
        dllcall("tk86t\TkPointerDeadWindow")
    }
    
    static TkPointerEvent(param*)
    {
        dllcall("tk86t\TkPointerEvent")
    }
    
    static TkPolygonToArea(param*)
    {
        dllcall("tk86t\TkPolygonToArea")
    }
    
    static TkPolygonToPoint(param*)
    {
        dllcall("tk86t\TkPolygonToPoint")
    }
    
    static TkPositionInTree(param*)
    {
        dllcall("tk86t\TkPositionInTree")
    }
    
    static TkPutImage(param*)
    {
        dllcall("tk86t\TkPutImage")
    }
    
    static TkQueueEventForAllChildren(param*)
    {
        dllcall("tk86t\TkQueueEventForAllChildren")
    }
    
    static TkReadBitmapFile(param*)
    {
        dllcall("tk86t\TkReadBitmapFile")
    }
    
    static TkRectInRegion(param*)
    {
        dllcall("tk86t\TkRectInRegion")
    }
    
    static TkScrollWindow(param*)
    {
        dllcall("tk86t\TkScrollWindow")
    }
    
    static TkSelDeadWindow(param*)
    {
        dllcall("tk86t\TkSelDeadWindow")
    }
    
    static TkSelEventProc(param*)
    {
        dllcall("tk86t\TkSelEventProc")
    }
    
    static TkSelGetSelection(param*)
    {
        dllcall("tk86t\TkSelGetSelection")
    }
    
    static TkSelInit(param*)
    {
        dllcall("tk86t\TkSelInit")
    }
    
    static TkSelPropProc(param*)
    {
        dllcall("tk86t\TkSelPropProc")
    }
    
    static TkSetFocusWin(param*)
    {
        dllcall("tk86t\TkSetFocusWin")
    }
    
    static TkSetPixmapColormap(param*)
    {
        dllcall("tk86t\TkSetPixmapColormap")
    }
    
    static TkSetRegion(param*)
    {
        dllcall("tk86t\TkSetRegion")
    }
    
    static TkSetWindowMenuBar(param*)
    {
        dllcall("tk86t\TkSetWindowMenuBar")
    }
    
    static TkSmoothParseProc(param*)
    {
        dllcall("tk86t\TkSmoothParseProc")
    }
    
    static TkSmoothPrintProc(param*)
    {
        dllcall("tk86t\TkSmoothPrintProc")
    }
    
    static TkStateParseProc(param*)
    {
        dllcall("tk86t\TkStateParseProc")
    }
    
    static TkStatePrintProc(param*)
    {
        dllcall("tk86t\TkStatePrintProc")
    }
    
    static TkStringToKeysym(param*)
    {
        dllcall("tk86t\TkStringToKeysym")
    }
    
    static TkStylePkgFree(param*)
    {
        dllcall("tk86t\TkStylePkgFree")
    }
    
    static TkStylePkgInit(param*)
    {
        dllcall("tk86t\TkStylePkgInit")
    }
    
    static TkSubtractRegion(param*)
    {
        dllcall("tk86t\TkSubtractRegion")
    }
    
    static TkTextChanged(param*)
    {
        dllcall("tk86t\TkTextChanged")
    }
    
    static TkTextGetIndex(param*)
    {
        dllcall("tk86t\TkTextGetIndex")
    }
    
    static TkTextIndexBackBytes(param*)
    {
        dllcall("tk86t\TkTextIndexBackBytes")
    }
    
    static TkTextIndexForwBytes(param*)
    {
        dllcall("tk86t\TkTextIndexForwBytes")
    }
    
    static TkTextInsertDisplayProc(param*)
    {
        dllcall("tk86t\TkTextInsertDisplayProc")
    }
    
    static TkTextMakeByteIndex(param*)
    {
        dllcall("tk86t\TkTextMakeByteIndex")
    }
    
    static TkTextPrintIndex(param*)
    {
        dllcall("tk86t\TkTextPrintIndex")
    }
    
    static TkTextSetMark(param*)
    {
        dllcall("tk86t\TkTextSetMark")
    }
    
    static TkTextXviewCmd(param*)
    {
        dllcall("tk86t\TkTextXviewCmd")
    }
    
    static TkThickPolyLineToArea(param*)
    {
        dllcall("tk86t\TkThickPolyLineToArea")
    }
    
    static TkToplevelWindowForCommand(param*)
    {
        dllcall("tk86t\TkToplevelWindowForCommand")
    }
    
    static TkUnderlineAngledTextLayout(param*)
    {
        dllcall("tk86t\TkUnderlineAngledTextLayout")
    }
    
    static TkUnionRectWithRegion(param*)
    {
        dllcall("tk86t\TkUnionRectWithRegion")
    }
    
    static TkWinCancelMouseTimer(param*)
    {
        dllcall("tk86t\TkWinCancelMouseTimer")
    }
    
    static TkWinChildProc(param*)
    {
        dllcall("tk86t\TkWinChildProc")
    }
    
    static TkWinClipboardRender(param*)
    {
        dllcall("tk86t\TkWinClipboardRender")
    }
    
    static TkWinDialogDebug(param*)
    {
        dllcall("tk86t\TkWinDialogDebug")
    }
    
    static TkWinEmbeddedEventProc(param*)
    {
        dllcall("tk86t\TkWinEmbeddedEventProc")
    }
    
    static TkWinFillRect(param*)
    {
        dllcall("tk86t\TkWinFillRect")
    }
    
    static TkWinGetBorderPixels(param*)
    {
        dllcall("tk86t\TkWinGetBorderPixels")
    }
    
    static TkWinGetDrawableDC(param*)
    {
        dllcall("tk86t\TkWinGetDrawableDC")
    }
    
    static TkWinGetMenuSystemDefault(param*)
    {
        dllcall("tk86t\TkWinGetMenuSystemDefault")
    }
    
    static TkWinGetModifierState(param*)
    {
        dllcall("tk86t\TkWinGetModifierState")
    }
    
    static TkWinGetPlatformId(param*)
    {
        dllcall("tk86t\TkWinGetPlatformId")
    }
    
    static TkWinGetPlatformTheme(param*)
    {
        dllcall("tk86t\TkWinGetPlatformTheme")
    }
    
    static TkWinGetSystemPalette(param*)
    {
        dllcall("tk86t\TkWinGetSystemPalette")
    }
    
    static TkWinGetWrapperWindow(param*)
    {
        dllcall("tk86t\TkWinGetWrapperWindow")
    }
    
    static TkWinHandleMenuEvent(param*)
    {
        dllcall("tk86t\TkWinHandleMenuEvent")
    }
    
    static TkWinIndexOfColor(param*)
    {
        dllcall("tk86t\TkWinIndexOfColor")
    }
    
    static TkWinReleaseDrawableDC(param*)
    {
        dllcall("tk86t\TkWinReleaseDrawableDC")
    }
    
    static TkWinResendEvent(param*)
    {
        dllcall("tk86t\TkWinResendEvent")
    }
    
    static TkWinSelectPalette(param*)
    {
        dllcall("tk86t\TkWinSelectPalette")
    }
    
    static TkWinSetForegroundWindow(param*)
    {
        dllcall("tk86t\TkWinSetForegroundWindow")
    }
    
    static TkWinSetHINSTANCE(param*)
    {
        dllcall("tk86t\TkWinSetHINSTANCE")
    }
    
    static TkWinSetMenu(param*)
    {
        dllcall("tk86t\TkWinSetMenu")
    }
    
    static TkWinSetWindowPos(param*)
    {
        dllcall("tk86t\TkWinSetWindowPos")
    }
    
    static TkWinWmCleanup(param*)
    {
        dllcall("tk86t\TkWinWmCleanup")
    }
    
    static TkWinXCleanup(param*)
    {
        dllcall("tk86t\TkWinXCleanup")
    }
    
    static TkWinXInit(param*)
    {
        dllcall("tk86t\TkWinXInit")
    }
    
    static TkWmAddToColormapWindows(param*)
    {
        dllcall("tk86t\TkWmAddToColormapWindows")
    }
    
    static TkWmDeadWindow(param*)
    {
        dllcall("tk86t\TkWmDeadWindow")
    }
    
    static TkWmFocusToplevel(param*)
    {
        dllcall("tk86t\TkWmFocusToplevel")
    }
    
    static TkWmMapWindow(param*)
    {
        dllcall("tk86t\TkWmMapWindow")
    }
    
    static TkWmNewWindow(param*)
    {
        dllcall("tk86t\TkWmNewWindow")
    }
    
    static TkWmProtocolEventProc(param*)
    {
        dllcall("tk86t\TkWmProtocolEventProc")
    }
    
    static TkWmRemoveFromColormapWindows(param*)
    {
        dllcall("tk86t\TkWmRemoveFromColormapWindows")
    }
    
    static TkWmRestackToplevel(param*)
    {
        dllcall("tk86t\TkWmRestackToplevel")
    }
    
    static TkWmSetClass(param*)
    {
        dllcall("tk86t\TkWmSetClass")
    }
    
    static TkWmStackorderToplevel(param*)
    {
        dllcall("tk86t\TkWmStackorderToplevel")
    }
    
    static TkWmUnmapWindow(param*)
    {
        dllcall("tk86t\TkWmUnmapWindow")
    }
    
    static Tk_3DBorderColor(param*)
    {
        dllcall("tk86t\Tk_3DBorderColor")
    }
    
    static Tk_3DBorderGC(param*)
    {
        dllcall("tk86t\Tk_3DBorderGC")
    }
    
    static Tk_3DHorizontalBevel(param*)
    {
        dllcall("tk86t\Tk_3DHorizontalBevel")
    }
    
    static Tk_3DVerticalBevel(param*)
    {
        dllcall("tk86t\Tk_3DVerticalBevel")
    }
    
    static Tk_AddOption(param*)
    {
        dllcall("tk86t\Tk_AddOption")
    }
    
    static Tk_Alloc3DBorderFromObj(param*)
    {
        dllcall("tk86t\Tk_Alloc3DBorderFromObj")
    }
    
    static Tk_AllocBitmapFromObj(param*)
    {
        dllcall("tk86t\Tk_AllocBitmapFromObj")
    }
    
    static Tk_AllocColorFromObj(param*)
    {
        dllcall("tk86t\Tk_AllocColorFromObj")
    }
    
    static Tk_AllocCursorFromObj(param*)
    {
        dllcall("tk86t\Tk_AllocCursorFromObj")
    }
    
    static Tk_AllocFontFromObj(param*)
    {
        dllcall("tk86t\Tk_AllocFontFromObj")
    }
    
    static Tk_AllocStyleFromObj(param*)
    {
        dllcall("tk86t\Tk_AllocStyleFromObj")
    }
    
    static Tk_AttachHWND(param*)
    {
        dllcall("tk86t\Tk_AttachHWND")
    }
    
    static Tk_BindEvent(param*)
    {
        dllcall("tk86t\Tk_BindEvent")
    }
    
    static Tk_CanvasDrawableCoords(param*)
    {
        dllcall("tk86t\Tk_CanvasDrawableCoords")
    }
    
    static Tk_CanvasEventuallyRedraw(param*)
    {
        dllcall("tk86t\Tk_CanvasEventuallyRedraw")
    }
    
    static Tk_CanvasGetCoord(param*)
    {
        dllcall("tk86t\Tk_CanvasGetCoord")
    }
    
    static Tk_CanvasGetCoordFromObj(param*)
    {
        dllcall("tk86t\Tk_CanvasGetCoordFromObj")
    }
    
    static Tk_CanvasGetTextInfo(param*)
    {
        dllcall("tk86t\Tk_CanvasGetTextInfo")
    }
    
    static Tk_CanvasPsBitmap(param*)
    {
        dllcall("tk86t\Tk_CanvasPsBitmap")
    }
    
    static Tk_CanvasPsColor(param*)
    {
        dllcall("tk86t\Tk_CanvasPsColor")
    }
    
    static Tk_CanvasPsFont(param*)
    {
        dllcall("tk86t\Tk_CanvasPsFont")
    }
    
    static Tk_CanvasPsOutline(param*)
    {
        dllcall("tk86t\Tk_CanvasPsOutline")
    }
    
    static Tk_CanvasPsPath(param*)
    {
        dllcall("tk86t\Tk_CanvasPsPath")
    }
    
    static Tk_CanvasPsStipple(param*)
    {
        dllcall("tk86t\Tk_CanvasPsStipple")
    }
    
    static Tk_CanvasPsY(param*)
    {
        dllcall("tk86t\Tk_CanvasPsY")
    }
    
    static Tk_CanvasSetOffset(param*)
    {
        dllcall("tk86t\Tk_CanvasSetOffset")
    }
    
    static Tk_CanvasSetStippleOrigin(param*)
    {
        dllcall("tk86t\Tk_CanvasSetStippleOrigin")
    }
    
    static Tk_CanvasTagsParseProc(param*)
    {
        dllcall("tk86t\Tk_CanvasTagsParseProc")
    }
    
    static Tk_CanvasTagsPrintProc(param*)
    {
        dllcall("tk86t\Tk_CanvasTagsPrintProc")
    }
    
    static Tk_CanvasTkwin(param*)
    {
        dllcall("tk86t\Tk_CanvasTkwin")
    }
    
    static Tk_CanvasWindowCoords(param*)
    {
        dllcall("tk86t\Tk_CanvasWindowCoords")
    }
    
    static Tk_ChangeOutlineGC(param*)
    {
        dllcall("tk86t\Tk_ChangeOutlineGC")
    }
    
    static Tk_ChangeWindowAttributes(param*)
    {
        dllcall("tk86t\Tk_ChangeWindowAttributes")
    }
    
    static Tk_CharBbox(param*)
    {
        dllcall("tk86t\Tk_CharBbox")
    }
    
    static Tk_ClearSelection(param*)
    {
        dllcall("tk86t\Tk_ClearSelection")
    }
    
    static Tk_ClipboardAppend(param*)
    {
        dllcall("tk86t\Tk_ClipboardAppend")
    }
    
    static Tk_ClipboardClear(param*)
    {
        dllcall("tk86t\Tk_ClipboardClear")
    }
    
    static Tk_CollapseMotionEvents(param*)
    {
        dllcall("tk86t\Tk_CollapseMotionEvents")
    }
    
    static Tk_ComputeTextLayout(param*)
    {
        dllcall("tk86t\Tk_ComputeTextLayout")
    }
    
    static Tk_ConfigOutlineGC(param*)
    {
        dllcall("tk86t\Tk_ConfigOutlineGC")
    }
    
    static Tk_ConfigureInfo(param*)
    {
        dllcall("tk86t\Tk_ConfigureInfo")
    }
    
    static Tk_ConfigureValue(param*)
    {
        dllcall("tk86t\Tk_ConfigureValue")
    }
    
    static Tk_ConfigureWidget(param*)
    {
        dllcall("tk86t\Tk_ConfigureWidget")
    }
    
    static Tk_ConfigureWindow(param*)
    {
        dllcall("tk86t\Tk_ConfigureWindow")
    }
    
    static Tk_CoordsToWindow(param*)
    {
        dllcall("tk86t\Tk_CoordsToWindow")
    }
    
    static Tk_CreateAnonymousWindow(param*)
    {
        dllcall("tk86t\Tk_CreateAnonymousWindow")
    }
    
    static Tk_CreateBinding(param*)
    {
        dllcall("tk86t\Tk_CreateBinding")
    }
    
    static Tk_CreateBindingTable(param*)
    {
        dllcall("tk86t\Tk_CreateBindingTable")
    }
    
    static Tk_CreateClientMessageHandler(param*)
    {
        dllcall("tk86t\Tk_CreateClientMessageHandler")
    }
    
    static Tk_CreateConsoleWindow(param*)
    {
        dllcall("tk86t\Tk_CreateConsoleWindow")
    }
    
    static Tk_CreateErrorHandler(param*)
    {
        dllcall("tk86t\Tk_CreateErrorHandler")
    }
    
    static Tk_CreateEventHandler(param*)
    {
        dllcall("tk86t\Tk_CreateEventHandler")
    }
    
    static Tk_CreateGenericHandler(param*)
    {
        dllcall("tk86t\Tk_CreateGenericHandler")
    }
    
    static Tk_CreateImageType(param*)
    {
        dllcall("tk86t\Tk_CreateImageType")
    }
    
    static Tk_CreateItemType(param*)
    {
        dllcall("tk86t\Tk_CreateItemType")
    }
    
    static Tk_CreateOldImageType(param*)
    {
        dllcall("tk86t\Tk_CreateOldImageType")
    }
    
    static Tk_CreateOldPhotoImageFormat(param*)
    {
        dllcall("tk86t\Tk_CreateOldPhotoImageFormat")
    }
    
    static Tk_CreateOptionTable(param*)
    {
        dllcall("tk86t\Tk_CreateOptionTable")
    }
    
    static Tk_CreateOutline(param*)
    {
        dllcall("tk86t\Tk_CreateOutline")
    }
    
    static Tk_CreatePhotoImageFormat(param*)
    {
        dllcall("tk86t\Tk_CreatePhotoImageFormat")
    }
    
    static Tk_CreateSelHandler(param*)
    {
        dllcall("tk86t\Tk_CreateSelHandler")
    }
    
    static Tk_CreateSmoothMethod(param*)
    {
        dllcall("tk86t\Tk_CreateSmoothMethod")
    }
    
    static Tk_CreateStyle(param*)
    {
        dllcall("tk86t\Tk_CreateStyle")
    }
    
    static Tk_CreateWindow(interp, parent, name, topLevScreen := unset) ; => Tk_Window
    {
        if isset(topLevScreen)
            return dllcall("tk86t\Tk_CreateWindow", "ptr", interp, "ptr", parent, "ptr", this.strBuffer(name), "ptr", this.strBuffer(topLevScreen))
        return dllcall("tk86t\Tk_CreateWindow", "ptr", interp, "ptr", parent, "ptr", this.strBuffer(name))
    }
    
    static Tk_CreateWindowFromPath(interp, tkwin, pathName, topLevScreen) ; => Tk_Window
    {
        return dllcall("tk86t\Tk_CreateWindowFromPath", "ptr", interp, "ptr", tkwin, "ptr", this.strBuffer(pathName), "ptr", this.strBuffer(topLevScreen))
    }
    
    static Tk_DefineBitmap(param*)
    {
        dllcall("tk86t\Tk_DefineBitmap")
    }
    
    static Tk_DefineCursor(param*)
    {
        dllcall("tk86t\Tk_DefineCursor")
    }
    
    static Tk_DeleteAllBindings(param*)
    {
        dllcall("tk86t\Tk_DeleteAllBindings")
    }
    
    static Tk_DeleteBinding(param*)
    {
        dllcall("tk86t\Tk_DeleteBinding")
    }
    
    static Tk_DeleteBindingTable(param*)
    {
        dllcall("tk86t\Tk_DeleteBindingTable")
    }
    
    static Tk_DeleteClientMessageHandler(param*)
    {
        dllcall("tk86t\Tk_DeleteClientMessageHandler")
    }
    
    static Tk_DeleteErrorHandler(param*)
    {
        dllcall("tk86t\Tk_DeleteErrorHandler")
    }
    
    static Tk_DeleteEventHandler(param*)
    {
        dllcall("tk86t\Tk_DeleteEventHandler")
    }
    
    static Tk_DeleteGenericHandler(param*)
    {
        dllcall("tk86t\Tk_DeleteGenericHandler")
    }
    
    static Tk_DeleteImage(param*)
    {
        dllcall("tk86t\Tk_DeleteImage")
    }
    
    static Tk_DeleteOptionTable(param*)
    {
        dllcall("tk86t\Tk_DeleteOptionTable")
    }
    
    static Tk_DeleteOutline(param*)
    {
        dllcall("tk86t\Tk_DeleteOutline")
    }
    
    static Tk_DeleteSelHandler(param*)
    {
        dllcall("tk86t\Tk_DeleteSelHandler")
    }
    
    static Tk_DestroyWindow(tkwin)
    {
        dllcall("tk86t\Tk_DestroyWindow", "ptr", tkwin)
    }
    
    static Tk_DisplayName(param*)
    {
        dllcall("tk86t\Tk_DisplayName")
    }
    
    static Tk_DistanceToTextLayout(param*)
    {
        dllcall("tk86t\Tk_DistanceToTextLayout")
    }
    
    static Tk_DitherPhoto(param*)
    {
        dllcall("tk86t\Tk_DitherPhoto")
    }
    
    static Tk_Draw3DPolygon(param*)
    {
        dllcall("tk86t\Tk_Draw3DPolygon")
    }
    
    static Tk_Draw3DRectangle(param*)
    {
        dllcall("tk86t\Tk_Draw3DRectangle")
    }
    
    static Tk_DrawChars(param*)
    {
        dllcall("tk86t\Tk_DrawChars")
    }
    
    static Tk_DrawElement(param*)
    {
        dllcall("tk86t\Tk_DrawElement")
    }
    
    static Tk_DrawFocusHighlight(param*)
    {
        dllcall("tk86t\Tk_DrawFocusHighlight")
    }
    
    static Tk_DrawTextLayout(param*)
    {
        dllcall("tk86t\Tk_DrawTextLayout")
    }
    
    static Tk_Fill3DPolygon(param*)
    {
        dllcall("tk86t\Tk_Fill3DPolygon")
    }
    
    static Tk_Fill3DRectangle(param*)
    {
        dllcall("tk86t\Tk_Fill3DRectangle")
    }
    
    static Tk_FindPhoto(param*)
    {
        dllcall("tk86t\Tk_FindPhoto")
    }
    
    static Tk_FontId(param*)
    {
        dllcall("tk86t\Tk_FontId")
    }
    
    static Tk_Free3DBorder(param*)
    {
        dllcall("tk86t\Tk_Free3DBorder")
    }
    
    static Tk_Free3DBorderFromObj(param*)
    {
        dllcall("tk86t\Tk_Free3DBorderFromObj")
    }
    
    static Tk_FreeBitmap(param*)
    {
        dllcall("tk86t\Tk_FreeBitmap")
    }
    
    static Tk_FreeBitmapFromObj(param*)
    {
        dllcall("tk86t\Tk_FreeBitmapFromObj")
    }
    
    static Tk_FreeColor(param*)
    {
        dllcall("tk86t\Tk_FreeColor")
    }
    
    static Tk_FreeColorFromObj(param*)
    {
        dllcall("tk86t\Tk_FreeColorFromObj")
    }
    
    static Tk_FreeColormap(param*)
    {
        dllcall("tk86t\Tk_FreeColormap")
    }
    
    static Tk_FreeConfigOptions(param*)
    {
        dllcall("tk86t\Tk_FreeConfigOptions")
    }
    
    static Tk_FreeCursor(param*)
    {
        dllcall("tk86t\Tk_FreeCursor")
    }
    
    static Tk_FreeCursorFromObj(param*)
    {
        dllcall("tk86t\Tk_FreeCursorFromObj")
    }
    
    static Tk_FreeFont(param*)
    {
        dllcall("tk86t\Tk_FreeFont")
    }
    
    static Tk_FreeFontFromObj(param*)
    {
        dllcall("tk86t\Tk_FreeFontFromObj")
    }
    
    static Tk_FreeGC(param*)
    {
        dllcall("tk86t\Tk_FreeGC")
    }
    
    static Tk_FreeImage(param*)
    {
        dllcall("tk86t\Tk_FreeImage")
    }
    
    static Tk_FreeOptions(param*)
    {
        dllcall("tk86t\Tk_FreeOptions")
    }
    
    static Tk_FreePixmap(param*)
    {
        dllcall("tk86t\Tk_FreePixmap")
    }
    
    static Tk_FreeSavedOptions(param*)
    {
        dllcall("tk86t\Tk_FreeSavedOptions")
    }
    
    static Tk_FreeStyle(param*)
    {
        dllcall("tk86t\Tk_FreeStyle")
    }
    
    static Tk_FreeStyleFromObj(param*)
    {
        dllcall("tk86t\Tk_FreeStyleFromObj")
    }
    
    static Tk_FreeTextLayout(param*)
    {
        dllcall("tk86t\Tk_FreeTextLayout")
    }
    
    static Tk_FreeXId(param*)
    {
        dllcall("tk86t\Tk_FreeXId")
    }
    
    static Tk_GCForColor(param*)
    {
        dllcall("tk86t\Tk_GCForColor")
    }
    
    static Tk_GeometryRequest(param*)
    {
        dllcall("tk86t\Tk_GeometryRequest")
    }
    
    static Tk_Get3DBorder(param*)
    {
        dllcall("tk86t\Tk_Get3DBorder")
    }
    
    static Tk_Get3DBorderFromObj(param*)
    {
        dllcall("tk86t\Tk_Get3DBorderFromObj")
    }
    
    static Tk_GetAllBindings(param*)
    {
        dllcall("tk86t\Tk_GetAllBindings")
    }
    
    static Tk_GetAnchor(param*)
    {
        dllcall("tk86t\Tk_GetAnchor")
    }
    
    static Tk_GetAnchorFromObj(param*)
    {
        dllcall("tk86t\Tk_GetAnchorFromObj")
    }
    
    static Tk_GetAtomName(param*)
    {
        dllcall("tk86t\Tk_GetAtomName")
    }
    
    static Tk_GetBinding(param*)
    {
        dllcall("tk86t\Tk_GetBinding")
    }
    
    static Tk_GetBitmap(param*)
    {
        dllcall("tk86t\Tk_GetBitmap")
    }
    
    static Tk_GetBitmapFromData(param*)
    {
        dllcall("tk86t\Tk_GetBitmapFromData")
    }
    
    static Tk_GetBitmapFromObj(param*)
    {
        dllcall("tk86t\Tk_GetBitmapFromObj")
    }
    
    static Tk_GetCapStyle(param*)
    {
        dllcall("tk86t\Tk_GetCapStyle")
    }
    
    static Tk_GetColor(param*)
    {
        dllcall("tk86t\Tk_GetColor")
    }
    
    static Tk_GetColorByValue(param*)
    {
        dllcall("tk86t\Tk_GetColorByValue")
    }
    
    static Tk_GetColorFromObj(param*)
    {
        dllcall("tk86t\Tk_GetColorFromObj")
    }
    
    static Tk_GetColormap(param*)
    {
        dllcall("tk86t\Tk_GetColormap")
    }
    
    static Tk_GetCursor(param*)
    {
        dllcall("tk86t\Tk_GetCursor")
    }
    
    static Tk_GetCursorFromData(param*)
    {
        dllcall("tk86t\Tk_GetCursorFromData")
    }
    
    static Tk_GetCursorFromObj(param*)
    {
        dllcall("tk86t\Tk_GetCursorFromObj")
    }
    
    static Tk_GetDash(param*)
    {
        dllcall("tk86t\Tk_GetDash")
    }
    
    static Tk_GetElementBorderWidth(param*)
    {
        dllcall("tk86t\Tk_GetElementBorderWidth")
    }
    
    static Tk_GetElementBox(param*)
    {
        dllcall("tk86t\Tk_GetElementBox")
    }
    
    static Tk_GetElementId(param*)
    {
        dllcall("tk86t\Tk_GetElementId")
    }
    
    static Tk_GetElementSize(param*)
    {
        dllcall("tk86t\Tk_GetElementSize")
    }
    
    static Tk_GetFont(param*)
    {
        dllcall("tk86t\Tk_GetFont")
    }
    
    static Tk_GetFontFromObj(param*)
    {
        dllcall("tk86t\Tk_GetFontFromObj")
    }
    
    static Tk_GetFontMetrics(param*)
    {
        dllcall("tk86t\Tk_GetFontMetrics")
    }
    
    static Tk_GetGC(param*)
    {
        dllcall("tk86t\Tk_GetGC")
    }
    
    static Tk_GetHINSTANCE(param*)
    {
        dllcall("tk86t\Tk_GetHINSTANCE")
    }
    
    static Tk_GetHWND(param*)
    {
        dllcall("tk86t\Tk_GetHWND")
    }
    
    static Tk_GetImage(param*)
    {
        dllcall("tk86t\Tk_GetImage")
    }
    
    static Tk_GetImageMasterData(param*)
    {
        dllcall("tk86t\Tk_GetImageMasterData")
    }
    
    static Tk_GetItemTypes(param*)
    {
        dllcall("tk86t\Tk_GetItemTypes")
    }
    
    static Tk_GetJoinStyle(param*)
    {
        dllcall("tk86t\Tk_GetJoinStyle")
    }
    
    static Tk_GetJustify(param*)
    {
        dllcall("tk86t\Tk_GetJustify")
    }
    
    static Tk_GetJustifyFromObj(param*)
    {
        dllcall("tk86t\Tk_GetJustifyFromObj")
    }
    
    static Tk_GetMMFromObj(param*)
    {
        dllcall("tk86t\Tk_GetMMFromObj")
    }
    
    static Tk_GetNumMainWindows() ; => int
    {
        return dllcall("tk86t\Tk_GetNumMainWindows")
    }
    
    static Tk_GetOption(param*)
    {
        dllcall("tk86t\Tk_GetOption")
    }
    
    static Tk_GetOptionInfo(param*)
    {
        dllcall("tk86t\Tk_GetOptionInfo")
    }
    
    static Tk_GetOptionValue(param*)
    {
        dllcall("tk86t\Tk_GetOptionValue")
    }
    
    static Tk_GetPixels(param*)
    {
        dllcall("tk86t\Tk_GetPixels")
    }
    
    static Tk_GetPixelsFromObj(param*)
    {
        dllcall("tk86t\Tk_GetPixelsFromObj")
    }
    
    static Tk_GetPixmap(param*)
    {
        dllcall("tk86t\Tk_GetPixmap")
    }
    
    static Tk_GetRelief(param*)
    {
        dllcall("tk86t\Tk_GetRelief")
    }
    
    static Tk_GetReliefFromObj(param*)
    {
        dllcall("tk86t\Tk_GetReliefFromObj")
    }
    
    static Tk_GetRootCoords(param*)
    {
        dllcall("tk86t\Tk_GetRootCoords")
    }
    
    static Tk_GetScreenMM(param*)
    {
        dllcall("tk86t\Tk_GetScreenMM")
    }
    
    static Tk_GetScrollInfo(param*)
    {
        dllcall("tk86t\Tk_GetScrollInfo")
    }
    
    static Tk_GetScrollInfoObj(param*)
    {
        dllcall("tk86t\Tk_GetScrollInfoObj")
    }
    
    static Tk_GetSelection(param*)
    {
        dllcall("tk86t\Tk_GetSelection")
    }
    
    static Tk_GetStyle(param*)
    {
        dllcall("tk86t\Tk_GetStyle")
    }
    
    static Tk_GetStyleEngine(param*)
    {
        dllcall("tk86t\Tk_GetStyleEngine")
    }
    
    static Tk_GetStyleFromObj(param*)
    {
        dllcall("tk86t\Tk_GetStyleFromObj")
    }
    
    static Tk_GetStyledElement(param*)
    {
        dllcall("tk86t\Tk_GetStyledElement")
    }
    
    static Tk_GetUid(param*)
    {
        dllcall("tk86t\Tk_GetUid")
    }
    
    static Tk_GetUserInactiveTime(param*)
    {
        dllcall("tk86t\Tk_GetUserInactiveTime")
    }
    
    static Tk_GetVRootGeometry(param*)
    {
        dllcall("tk86t\Tk_GetVRootGeometry")
    }
    
    static Tk_GetVisual(param*)
    {
        dllcall("tk86t\Tk_GetVisual")
    }
    
    static Tk_Grab(param*)
    {
        dllcall("tk86t\Tk_Grab")
    }
    
    static Tk_HWNDToWindow(hwnd) ; => Tk_Window
    {
        return dllcall("tk86t\Tk_HWNDToWindow", "ptr", hwnd)
    }
    
    static Tk_HandleEvent(param*)
    {
        dllcall("tk86t\Tk_HandleEvent")
    }
    
    static Tk_IdToWindow(param*)
    {
        dllcall("tk86t\Tk_IdToWindow")
    }
    
    static Tk_ImageChanged(param*)
    {
        dllcall("tk86t\Tk_ImageChanged")
    }
    
    static Tk_Init(interp) ; => int
    {
        return dllcall("tk86t\Tk_Init", "ptr", interp)
    }
    
    static Tk_InitConsoleChannels(param*)
    {
        dllcall("tk86t\Tk_InitConsoleChannels")
    }
    
    static Tk_InitOptions(param*)
    {
        dllcall("tk86t\Tk_InitOptions")
    }
    
    static Tk_InternAtom(param*)
    {
        dllcall("tk86t\Tk_InternAtom")
    }
    
    static Tk_Interp(param*)
    {
        dllcall("tk86t\Tk_Interp")
    }
    
    static Tk_IntersectTextLayout(param*)
    {
        dllcall("tk86t\Tk_IntersectTextLayout")
    }
    
    static Tk_MainEx(param*)
    {
        dllcall("tk86t\Tk_MainEx")
    }
    
    static Tk_MainExW(param*)
    {
        dllcall("tk86t\Tk_MainExW")
    }
    
    static Tk_MainLoop()
    {
        dllcall("tk86t\Tk_MainLoop")
    }
    
    static Tk_MainWindow(interp) ; => Tk_Window
    {
        return dllcall("tk86t\Tk_MainWindow", "ptr", interp)
    }
    
    static Tk_MaintainGeometry(param*)
    {
        dllcall("tk86t\Tk_MaintainGeometry")
    }
    
    static Tk_MakeWindowExist(tkwin)
    {
        dllcall("tk86t\Tk_MakeWindowExist", "ptr", tkwin)
    }
    
    static Tk_ManageGeometry(param*)
    {
        dllcall("tk86t\Tk_ManageGeometry")
    }
    
    static Tk_MapWindow(param*)
    {
        dllcall("tk86t\Tk_MapWindow")
    }
    
    static Tk_MeasureChars(param*)
    {
        dllcall("tk86t\Tk_MeasureChars")
    }
    
    static Tk_MoveResizeWindow(param*)
    {
        dllcall("tk86t\Tk_MoveResizeWindow")
    }
    
    static Tk_MoveToplevelWindow(param*)
    {
        dllcall("tk86t\Tk_MoveToplevelWindow")
    }
    
    static Tk_MoveWindow(param*)
    {
        dllcall("tk86t\Tk_MoveWindow")
    }
    
    static Tk_NameOf3DBorder(param*)
    {
        dllcall("tk86t\Tk_NameOf3DBorder")
    }
    
    static Tk_NameOfAnchor(param*)
    {
        dllcall("tk86t\Tk_NameOfAnchor")
    }
    
    static Tk_NameOfBitmap(param*)
    {
        dllcall("tk86t\Tk_NameOfBitmap")
    }
    
    static Tk_NameOfCapStyle(param*)
    {
        dllcall("tk86t\Tk_NameOfCapStyle")
    }
    
    static Tk_NameOfColor(param*)
    {
        dllcall("tk86t\Tk_NameOfColor")
    }
    
    static Tk_NameOfCursor(param*)
    {
        dllcall("tk86t\Tk_NameOfCursor")
    }
    
    static Tk_NameOfFont(param*)
    {
        dllcall("tk86t\Tk_NameOfFont")
    }
    
    static Tk_NameOfImage(param*)
    {
        dllcall("tk86t\Tk_NameOfImage")
    }
    
    static Tk_NameOfJoinStyle(param*)
    {
        dllcall("tk86t\Tk_NameOfJoinStyle")
    }
    
    static Tk_NameOfJustify(param*)
    {
        dllcall("tk86t\Tk_NameOfJustify")
    }
    
    static Tk_NameOfRelief(param*)
    {
        dllcall("tk86t\Tk_NameOfRelief")
    }
    
    static Tk_NameOfStyle(param*)
    {
        dllcall("tk86t\Tk_NameOfStyle")
    }
    
    static Tk_NameToWindow(param*)
    {
        dllcall("tk86t\Tk_NameToWindow")
    }
    
    static Tk_OwnSelection(param*)
    {
        dllcall("tk86t\Tk_OwnSelection")
    }
    
    static Tk_ParseArgv(param*)
    {
        dllcall("tk86t\Tk_ParseArgv")
    }
    
    static Tk_PhotoBlank(param*)
    {
        dllcall("tk86t\Tk_PhotoBlank")
    }
    
    static Tk_PhotoExpand(param*)
    {
        dllcall("tk86t\Tk_PhotoExpand")
    }
    
    static Tk_PhotoExpand_Panic(param*)
    {
        dllcall("tk86t\Tk_PhotoExpand_Panic")
    }
    
    static Tk_PhotoGetImage(param*)
    {
        dllcall("tk86t\Tk_PhotoGetImage")
    }
    
    static Tk_PhotoGetSize(param*)
    {
        dllcall("tk86t\Tk_PhotoGetSize")
    }
    
    static Tk_PhotoPutBlock(param*)
    {
        dllcall("tk86t\Tk_PhotoPutBlock")
    }
    
    static Tk_PhotoPutBlock_NoComposite(param*)
    {
        dllcall("tk86t\Tk_PhotoPutBlock_NoComposite")
    }
    
    static Tk_PhotoPutBlock_Panic(param*)
    {
        dllcall("tk86t\Tk_PhotoPutBlock_Panic")
    }
    
    static Tk_PhotoPutZoomedBlock(param*)
    {
        dllcall("tk86t\Tk_PhotoPutZoomedBlock")
    }
    
    static Tk_PhotoPutZoomedBlock_NoComposite(param*)
    {
        dllcall("tk86t\Tk_PhotoPutZoomedBlock_NoComposite")
    }
    
    static Tk_PhotoPutZoomedBlock_Panic(param*)
    {
        dllcall("tk86t\Tk_PhotoPutZoomedBlock_Panic")
    }
    
    static Tk_PhotoSetSize(param*)
    {
        dllcall("tk86t\Tk_PhotoSetSize")
    }
    
    static Tk_PhotoSetSize_Panic(param*)
    {
        dllcall("tk86t\Tk_PhotoSetSize_Panic")
    }
    
    static Tk_PkgInitStubsCheck(param*)
    {
        dllcall("tk86t\Tk_PkgInitStubsCheck")
    }
    
    static Tk_PointToChar(param*)
    {
        dllcall("tk86t\Tk_PointToChar")
    }
    
    static Tk_PointerEvent(param*)
    {
        dllcall("tk86t\Tk_PointerEvent")
    }
    
    static Tk_PostscriptBitmap(param*)
    {
        dllcall("tk86t\Tk_PostscriptBitmap")
    }
    
    static Tk_PostscriptColor(param*)
    {
        dllcall("tk86t\Tk_PostscriptColor")
    }
    
    static Tk_PostscriptFont(param*)
    {
        dllcall("tk86t\Tk_PostscriptFont")
    }
    
    static Tk_PostscriptFontName(param*)
    {
        dllcall("tk86t\Tk_PostscriptFontName")
    }
    
    static Tk_PostscriptImage(param*)
    {
        dllcall("tk86t\Tk_PostscriptImage")
    }
    
    static Tk_PostscriptPath(param*)
    {
        dllcall("tk86t\Tk_PostscriptPath")
    }
    
    static Tk_PostscriptPhoto(param*)
    {
        dllcall("tk86t\Tk_PostscriptPhoto")
    }
    
    static Tk_PostscriptStipple(param*)
    {
        dllcall("tk86t\Tk_PostscriptStipple")
    }
    
    static Tk_PostscriptY(param*)
    {
        dllcall("tk86t\Tk_PostscriptY")
    }
    
    static Tk_PreserveColormap(param*)
    {
        dllcall("tk86t\Tk_PreserveColormap")
    }
    
    static Tk_QueueWindowEvent(param*)
    {
        dllcall("tk86t\Tk_QueueWindowEvent")
    }
    
    static Tk_RedrawImage(param*)
    {
        dllcall("tk86t\Tk_RedrawImage")
    }
    
    static Tk_RegisterStyleEngine(param*)
    {
        dllcall("tk86t\Tk_RegisterStyleEngine")
    }
    
    static Tk_RegisterStyledElement(param*)
    {
        dllcall("tk86t\Tk_RegisterStyledElement")
    }
    
    static Tk_ResetOutlineGC(param*)
    {
        dllcall("tk86t\Tk_ResetOutlineGC")
    }
    
    static Tk_ResetUserInactiveTime(param*)
    {
        dllcall("tk86t\Tk_ResetUserInactiveTime")
    }
    
    static Tk_ResizeWindow(param*)
    {
        dllcall("tk86t\Tk_ResizeWindow")
    }
    
    static Tk_RestackWindow(param*)
    {
        dllcall("tk86t\Tk_RestackWindow")
    }
    
    static Tk_RestoreSavedOptions(param*)
    {
        dllcall("tk86t\Tk_RestoreSavedOptions")
    }
    
    static Tk_RestrictEvents(param*)
    {
        dllcall("tk86t\Tk_RestrictEvents")
    }
    
    static Tk_SafeInit(interp) ; => int
    {
        return dllcall("tk86t\Tk_SafeInit", "ptr", interp)
    }
    
    static Tk_SetAppName(tkwin, name) ; => char*
    {
        return strget(dllcall("tk86t\Tk_SetAppName", "ptr", tkwin, "ptr", this.strBuffer(name)), , "utf-8")
    }
    
    static Tk_SetBackgroundFromBorder(param*)
    {
        dllcall("tk86t\Tk_SetBackgroundFromBorder")
    }
    
    static Tk_SetCaretPos(param*)
    {
        dllcall("tk86t\Tk_SetCaretPos")
    }
    
    static Tk_SetClass(param*)
    {
        dllcall("tk86t\Tk_SetClass")
    }
    
    static Tk_SetClassProcs(param*)
    {
        dllcall("tk86t\Tk_SetClassProcs")
    }
    
    static Tk_SetGrid(param*)
    {
        dllcall("tk86t\Tk_SetGrid")
    }
    
    static Tk_SetInternalBorder(param*)
    {
        dllcall("tk86t\Tk_SetInternalBorder")
    }
    
    static Tk_SetInternalBorderEx(param*)
    {
        dllcall("tk86t\Tk_SetInternalBorderEx")
    }
    
    static Tk_SetMinimumRequestSize(param*)
    {
        dllcall("tk86t\Tk_SetMinimumRequestSize")
    }
    
    static Tk_SetOptions(param*)
    {
        dllcall("tk86t\Tk_SetOptions")
    }
    
    static Tk_SetTSOrigin(param*)
    {
        dllcall("tk86t\Tk_SetTSOrigin")
    }
    
    static Tk_SetWindowBackground(param*)
    {
        dllcall("tk86t\Tk_SetWindowBackground")
    }
    
    static Tk_SetWindowBackgroundPixmap(param*)
    {
        dllcall("tk86t\Tk_SetWindowBackgroundPixmap")
    }
    
    static Tk_SetWindowBorder(param*)
    {
        dllcall("tk86t\Tk_SetWindowBorder")
    }
    
    static Tk_SetWindowBorderPixmap(param*)
    {
        dllcall("tk86t\Tk_SetWindowBorderPixmap")
    }
    
    static Tk_SetWindowBorderWidth(param*)
    {
        dllcall("tk86t\Tk_SetWindowBorderWidth")
    }
    
    static Tk_SetWindowColormap(param*)
    {
        dllcall("tk86t\Tk_SetWindowColormap")
    }
    
    static Tk_SetWindowVisual(param*)
    {
        dllcall("tk86t\Tk_SetWindowVisual")
    }
    
    static Tk_SizeOfBitmap(param*)
    {
        dllcall("tk86t\Tk_SizeOfBitmap")
    }
    
    static Tk_SizeOfImage(param*)
    {
        dllcall("tk86t\Tk_SizeOfImage")
    }
    
    static Tk_StrictMotif(param*)
    {
        dllcall("tk86t\Tk_StrictMotif")
    }
    
    static Tk_TextLayoutToPostscript(param*)
    {
        dllcall("tk86t\Tk_TextLayoutToPostscript")
    }
    
    static Tk_TextWidth(param*)
    {
        dllcall("tk86t\Tk_TextWidth")
    }
    
    static Tk_TranslateWinEvent(param*)
    {
        dllcall("tk86t\Tk_TranslateWinEvent")
    }
    
    static Tk_UndefineCursor(param*)
    {
        dllcall("tk86t\Tk_UndefineCursor")
    }
    
    static Tk_UnderlineChars(param*)
    {
        dllcall("tk86t\Tk_UnderlineChars")
    }
    
    static Tk_UnderlineTextLayout(param*)
    {
        dllcall("tk86t\Tk_UnderlineTextLayout")
    }
    
    static Tk_Ungrab(param*)
    {
        dllcall("tk86t\Tk_Ungrab")
    }
    
    static Tk_UnmaintainGeometry(param*)
    {
        dllcall("tk86t\Tk_UnmaintainGeometry")
    }
    
    static Tk_UnmapWindow(param*)
    {
        dllcall("tk86t\Tk_UnmapWindow")
    }
    
    static Tk_UnsetGrid(param*)
    {
        dllcall("tk86t\Tk_UnsetGrid")
    }
    
    static Tk_UpdatePointer(param*)
    {
        dllcall("tk86t\Tk_UpdatePointer")
    }
    
    static TkpChangeFocus(param*)
    {
        dllcall("tk86t\TkpChangeFocus")
    }
    
    static TkpClaimFocus(param*)
    {
        dllcall("tk86t\TkpClaimFocus")
    }
    
    static TkpCloseDisplay(param*)
    {
        dllcall("tk86t\TkpCloseDisplay")
    }
    
    static TkpCmapStressed(param*)
    {
        dllcall("tk86t\TkpCmapStressed")
    }
    
    static TkpDisplayWarning(param*)
    {
        dllcall("tk86t\TkpDisplayWarning")
    }
    
    static TkpDrawFrame(param*)
    {
        dllcall("tk86t\TkpDrawFrame")
    }
    
    static TkpDrawHighlightBorder(param*)
    {
        dllcall("tk86t\TkpDrawHighlightBorder")
    }
    
    static TkpFreeCursor(param*)
    {
        dllcall("tk86t\TkpFreeCursor")
    }
    
    static TkpGetAppName(param*)
    {
        dllcall("tk86t\TkpGetAppName")
    }
    
    static TkpGetCapture(param*)
    {
        dllcall("tk86t\TkpGetCapture")
    }
    
    static TkpGetKeySym(param*)
    {
        dllcall("tk86t\TkpGetKeySym")
    }
    
    static TkpGetMS(param*)
    {
        dllcall("tk86t\TkpGetMS")
    }
    
    static TkpGetOtherWindow(param*)
    {
        dllcall("tk86t\TkpGetOtherWindow")
    }
    
    static TkpGetString(param*)
    {
        dllcall("tk86t\TkpGetString")
    }
    
    static TkpGetSubFonts(param*)
    {
        dllcall("tk86t\TkpGetSubFonts")
    }
    
    static TkpGetSystemDefault(param*)
    {
        dllcall("tk86t\TkpGetSystemDefault")
    }
    
    static TkpGetWrapperWindow(param*)
    {
        dllcall("tk86t\TkpGetWrapperWindow")
    }
    
    static TkpInit(param*)
    {
        dllcall("tk86t\TkpInit")
    }
    
    static TkpInitKeymapInfo(param*)
    {
        dllcall("tk86t\TkpInitKeymapInfo")
    }
    
    static TkpInitializeMenuBindings(param*)
    {
        dllcall("tk86t\TkpInitializeMenuBindings")
    }
    
    static TkpMakeContainer(param*)
    {
        dllcall("tk86t\TkpMakeContainer")
    }
    
    static TkpMakeMenuWindow(param*)
    {
        dllcall("tk86t\TkpMakeMenuWindow")
    }
    
    static TkpMakeWindow(param*)
    {
        dllcall("tk86t\TkpMakeWindow")
    }
    
    static TkpMenuNotifyToplevelCreate(param*)
    {
        dllcall("tk86t\TkpMenuNotifyToplevelCreate")
    }
    
    static TkpMenuThreadInit(param*)
    {
        dllcall("tk86t\TkpMenuThreadInit")
    }
    
    static TkpOpenDisplay(param*)
    {
        dllcall("tk86t\TkpOpenDisplay")
    }
    
    static TkpPrintWindowId(param*)
    {
        dllcall("tk86t\TkpPrintWindowId")
    }
    
    static TkpRedirectKeyEvent(param*)
    {
        dllcall("tk86t\TkpRedirectKeyEvent")
    }
    
    static TkpScanWindowId(param*)
    {
        dllcall("tk86t\TkpScanWindowId")
    }
    
    static TkpSetCapture(param*)
    {
        dllcall("tk86t\TkpSetCapture")
    }
    
    static TkpSetCursor(param*)
    {
        dllcall("tk86t\TkpSetCursor")
    }
    
    static TkpSetKeycodeAndState(param*)
    {
        dllcall("tk86t\TkpSetKeycodeAndState")
    }
    
    static TkpSetMainMenubar(param*)
    {
        dllcall("tk86t\TkpSetMainMenubar")
    }
    
    static TkpSync(param*)
    {
        dllcall("tk86t\TkpSync")
    }
    
    static TkpTestembedCmd(param*)
    {
        dllcall("tk86t\TkpTestembedCmd")
    }
    
    static TkpTesttextCmd(param*)
    {
        dllcall("tk86t\TkpTesttextCmd")
    }
    
    static TkpUseWindow(param*)
    {
        dllcall("tk86t\TkpUseWindow")
    }
    
    static TkpWmSetState(param*)
    {
        dllcall("tk86t\TkpWmSetState")
    }
    
    static XAllocColor(param*)
    {
        dllcall("tk86t\XAllocColor")
    }
    
    static XBell(param*)
    {
        dllcall("tk86t\XBell")
    }
    
    static XChangeGC(param*)
    {
        dllcall("tk86t\XChangeGC")
    }
    
    static XChangeProperty(param*)
    {
        dllcall("tk86t\XChangeProperty")
    }
    
    static XChangeWindowAttributes(param*)
    {
        dllcall("tk86t\XChangeWindowAttributes")
    }
    
    static XClearWindow(param*)
    {
        dllcall("tk86t\XClearWindow")
    }
    
    static XConfigureWindow(param*)
    {
        dllcall("tk86t\XConfigureWindow")
    }
    
    static XCopyArea(param*)
    {
        dllcall("tk86t\XCopyArea")
    }
    
    static XCopyPlane(param*)
    {
        dllcall("tk86t\XCopyPlane")
    }
    
    static XCreateBitmapFromData(param*)
    {
        dllcall("tk86t\XCreateBitmapFromData")
    }
    
    static XCreateColormap(param*)
    {
        dllcall("tk86t\XCreateColormap")
    }
    
    static XCreateGC(param*)
    {
        dllcall("tk86t\XCreateGC")
    }
    
    static XCreateGlyphCursor(param*)
    {
        dllcall("tk86t\XCreateGlyphCursor")
    }
    
    static XCreateIC(param*)
    {
        dllcall("tk86t\XCreateIC")
    }
    
    static XCreateImage(param*)
    {
        dllcall("tk86t\XCreateImage")
    }
    
    static XCreatePixmapCursor(param*)
    {
        dllcall("tk86t\XCreatePixmapCursor")
    }
    
    static XDefineCursor(param*)
    {
        dllcall("tk86t\XDefineCursor")
    }
    
    static XDeleteProperty(param*)
    {
        dllcall("tk86t\XDeleteProperty")
    }
    
    static XDestroyIC(param*)
    {
        dllcall("tk86t\XDestroyIC")
    }
    
    static XDestroyWindow(param*)
    {
        dllcall("tk86t\XDestroyWindow")
    }
    
    static XDrawArc(param*)
    {
        dllcall("tk86t\XDrawArc")
    }
    
    static XDrawArcs(param*)
    {
        dllcall("tk86t\XDrawArcs")
    }
    
    static XDrawLine(param*)
    {
        dllcall("tk86t\XDrawLine")
    }
    
    static XDrawLines(param*)
    {
        dllcall("tk86t\XDrawLines")
    }
    
    static XDrawPoint(param*)
    {
        dllcall("tk86t\XDrawPoint")
    }
    
    static XDrawPoints(param*)
    {
        dllcall("tk86t\XDrawPoints")
    }
    
    static XDrawRectangle(param*)
    {
        dllcall("tk86t\XDrawRectangle")
    }
    
    static XDrawRectangles(param*)
    {
        dllcall("tk86t\XDrawRectangles")
    }
    
    static XDrawSegments(param*)
    {
        dllcall("tk86t\XDrawSegments")
    }
    
    static XFillArc(param*)
    {
        dllcall("tk86t\XFillArc")
    }
    
    static XFillArcs(param*)
    {
        dllcall("tk86t\XFillArcs")
    }
    
    static XFillPolygon(param*)
    {
        dllcall("tk86t\XFillPolygon")
    }
    
    static XFillRectangle(param*)
    {
        dllcall("tk86t\XFillRectangle")
    }
    
    static XFillRectangles(param*)
    {
        dllcall("tk86t\XFillRectangles")
    }
    
    static XFilterEvent(param*)
    {
        dllcall("tk86t\XFilterEvent")
    }
    
    static XFlush(param*)
    {
        dllcall("tk86t\XFlush")
    }
    
    static XForceScreenSaver(param*)
    {
        dllcall("tk86t\XForceScreenSaver")
    }
    
    static XFree(param*)
    {
        dllcall("tk86t\XFree")
    }
    
    static XFreeColormap(param*)
    {
        dllcall("tk86t\XFreeColormap")
    }
    
    static XFreeColors(param*)
    {
        dllcall("tk86t\XFreeColors")
    }
    
    static XFreeCursor(param*)
    {
        dllcall("tk86t\XFreeCursor")
    }
    
    static XFreeGC(param*)
    {
        dllcall("tk86t\XFreeGC")
    }
    
    static XFreeModifiermap(param*)
    {
        dllcall("tk86t\XFreeModifiermap")
    }
    
    static XGContextFromGC(param*)
    {
        dllcall("tk86t\XGContextFromGC")
    }
    
    static XGetAtomName(param*)
    {
        dllcall("tk86t\XGetAtomName")
    }
    
    static XGetGeometry(param*)
    {
        dllcall("tk86t\XGetGeometry")
    }
    
    static XGetImage(param*)
    {
        dllcall("tk86t\XGetImage")
    }
    
    static XGetInputFocus(param*)
    {
        dllcall("tk86t\XGetInputFocus")
    }
    
    static XGetModifierMapping(param*)
    {
        dllcall("tk86t\XGetModifierMapping")
    }
    
    static XGetVisualInfo(param*)
    {
        dllcall("tk86t\XGetVisualInfo")
    }
    
    static XGetWMColormapWindows(param*)
    {
        dllcall("tk86t\XGetWMColormapWindows")
    }
    
    static XGetWindowAttributes(param*)
    {
        dllcall("tk86t\XGetWindowAttributes")
    }
    
    static XGetWindowProperty(param*)
    {
        dllcall("tk86t\XGetWindowProperty")
    }
    
    static XGrabKeyboard(param*)
    {
        dllcall("tk86t\XGrabKeyboard")
    }
    
    static XGrabPointer(param*)
    {
        dllcall("tk86t\XGrabPointer")
    }
    
    static XGrabServer(param*)
    {
        dllcall("tk86t\XGrabServer")
    }
    
    static XIconifyWindow(param*)
    {
        dllcall("tk86t\XIconifyWindow")
    }
    
    static XInternAtom(param*)
    {
        dllcall("tk86t\XInternAtom")
    }
    
    static XKeycodeToKeysym(param*)
    {
        dllcall("tk86t\XKeycodeToKeysym")
    }
    
    static XKeysymToKeycode(param*)
    {
        dllcall("tk86t\XKeysymToKeycode")
    }
    
    static XKeysymToString(param*)
    {
        dllcall("tk86t\XKeysymToString")
    }
    
    static XListHosts(param*)
    {
        dllcall("tk86t\XListHosts")
    }
    
    static XLookupColor(param*)
    {
        dllcall("tk86t\XLookupColor")
    }
    
    static XLowerWindow(param*)
    {
        dllcall("tk86t\XLowerWindow")
    }
    
    static XMapWindow(param*)
    {
        dllcall("tk86t\XMapWindow")
    }
    
    static XMoveResizeWindow(param*)
    {
        dllcall("tk86t\XMoveResizeWindow")
    }
    
    static XMoveWindow(param*)
    {
        dllcall("tk86t\XMoveWindow")
    }
    
    static XNextEvent(param*)
    {
        dllcall("tk86t\XNextEvent")
    }
    
    static XNoOp(param*)
    {
        dllcall("tk86t\XNoOp")
    }
    
    static XOffsetRegion(param*)
    {
        dllcall("tk86t\XOffsetRegion")
    }
    
    static XParseColor(param*)
    {
        dllcall("tk86t\XParseColor")
    }
    
    static XPutBackEvent(param*)
    {
        dllcall("tk86t\XPutBackEvent")
    }
    
    static XPutImage(param*)
    {
        dllcall("tk86t\XPutImage")
    }
    
    static XQueryColors(param*)
    {
        dllcall("tk86t\XQueryColors")
    }
    
    static XQueryPointer(param*)
    {
        dllcall("tk86t\XQueryPointer")
    }
    
    static XQueryTree(param*)
    {
        dllcall("tk86t\XQueryTree")
    }
    
    static XRaiseWindow(param*)
    {
        dllcall("tk86t\XRaiseWindow")
    }
    
    static XRefreshKeyboardMapping(param*)
    {
        dllcall("tk86t\XRefreshKeyboardMapping")
    }
    
    static XReparentWindow(param*)
    {
        dllcall("tk86t\XReparentWindow")
    }
    
    static XResizeWindow(param*)
    {
        dllcall("tk86t\XResizeWindow")
    }
    
    static XRootWindow(param*)
    {
        dllcall("tk86t\XRootWindow")
    }
    
    static XSelectInput(param*)
    {
        dllcall("tk86t\XSelectInput")
    }
    
    static XSendEvent(param*)
    {
        dllcall("tk86t\XSendEvent")
    }
    
    static XSetArcMode(param*)
    {
        dllcall("tk86t\XSetArcMode")
    }
    
    static XSetBackground(param*)
    {
        dllcall("tk86t\XSetBackground")
    }
    
    static XSetClipMask(param*)
    {
        dllcall("tk86t\XSetClipMask")
    }
    
    static XSetClipOrigin(param*)
    {
        dllcall("tk86t\XSetClipOrigin")
    }
    
    static XSetCommand(param*)
    {
        dllcall("tk86t\XSetCommand")
    }
    
    static XSetDashes(param*)
    {
        dllcall("tk86t\XSetDashes")
    }
    
    static XSetErrorHandler(param*)
    {
        dllcall("tk86t\XSetErrorHandler")
    }
    
    static XSetFillRule(param*)
    {
        dllcall("tk86t\XSetFillRule")
    }
    
    static XSetFillStyle(param*)
    {
        dllcall("tk86t\XSetFillStyle")
    }
    
    static XSetFont(param*)
    {
        dllcall("tk86t\XSetFont")
    }
    
    static XSetForeground(param*)
    {
        dllcall("tk86t\XSetForeground")
    }
    
    static XSetFunction(param*)
    {
        dllcall("tk86t\XSetFunction")
    }
    
    static XSetIconName(param*)
    {
        dllcall("tk86t\XSetIconName")
    }
    
    static XSetInputFocus(param*)
    {
        dllcall("tk86t\XSetInputFocus")
    }
    
    static XSetLineAttributes(param*)
    {
        dllcall("tk86t\XSetLineAttributes")
    }
    
    static XSetSelectionOwner(param*)
    {
        dllcall("tk86t\XSetSelectionOwner")
    }
    
    static XSetStipple(param*)
    {
        dllcall("tk86t\XSetStipple")
    }
    
    static XSetTSOrigin(param*)
    {
        dllcall("tk86t\XSetTSOrigin")
    }
    
    static XSetWMClientMachine(param*)
    {
        dllcall("tk86t\XSetWMClientMachine")
    }
    
    static XSetWindowBackground(param*)
    {
        dllcall("tk86t\XSetWindowBackground")
    }
    
    static XSetWindowBackgroundPixmap(param*)
    {
        dllcall("tk86t\XSetWindowBackgroundPixmap")
    }
    
    static XSetWindowBorder(param*)
    {
        dllcall("tk86t\XSetWindowBorder")
    }
    
    static XSetWindowBorderPixmap(param*)
    {
        dllcall("tk86t\XSetWindowBorderPixmap")
    }
    
    static XSetWindowBorderWidth(param*)
    {
        dllcall("tk86t\XSetWindowBorderWidth")
    }
    
    static XSetWindowColormap(param*)
    {
        dllcall("tk86t\XSetWindowColormap")
    }
    
    static XStringListToTextProperty(param*)
    {
        dllcall("tk86t\XStringListToTextProperty")
    }
    
    static XStringToKeysym(param*)
    {
        dllcall("tk86t\XStringToKeysym")
    }
    
    static XSync(param*)
    {
        dllcall("tk86t\XSync")
    }
    
    static XSynchronize(param*)
    {
        dllcall("tk86t\XSynchronize")
    }
    
    static XTranslateCoordinates(param*)
    {
        dllcall("tk86t\XTranslateCoordinates")
    }
    
    static XUngrabKeyboard(param*)
    {
        dllcall("tk86t\XUngrabKeyboard")
    }
    
    static XUngrabPointer(param*)
    {
        dllcall("tk86t\XUngrabPointer")
    }
    
    static XUngrabServer(param*)
    {
        dllcall("tk86t\XUngrabServer")
    }
    
    static XUnmapWindow(param*)
    {
        dllcall("tk86t\XUnmapWindow")
    }
    
    static XVisualIDFromVisual(param*)
    {
        dllcall("tk86t\XVisualIDFromVisual")
    }
    
    static XWarpPointer(param*)
    {
        dllcall("tk86t\XWarpPointer")
    }
    
    static XWindowEvent(param*)
    {
        dllcall("tk86t\XWindowEvent")
    }
    
    static XWithdrawWindow(param*)
    {
        dllcall("tk86t\XWithdrawWindow")
    }
    
    static XmbLookupString(param*)
    {
        dllcall("tk86t\XmbLookupString")
    }
    
    static _XInitImageFuncPtrs(param*)
    {
        dllcall("tk86t\_XInitImageFuncPtrs")
    }
}
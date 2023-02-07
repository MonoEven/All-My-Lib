flag := imgui.dll_file("imgui\lib\imgui.dll")
if flag
    dllcall("LoadLibrary", "str", flag)
else
    throw error("imgui.dll is not existed.")

class imgui
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
    
    static Cimguidll_QEAA_XZ(param*)
    {
        dllcall("imgui\??0Cimguidll@@QEAA@XZ")
    }
    
    static Cimguidll_QEAAAEAV0_QEAV0_Z(param*)
    {
        dllcall("imgui\??4Cimguidll@@QEAAAEAV0@$$QEAV0@@Z")
    }
    
    static Cimguidll_QEAAAEAV0_AEBV0_Z(param*)
    {
        dllcall("imgui\??4Cimguidll@@QEAAAEAV0@AEBV0@@Z")
    }
    
    static aliFont_YAPEAXXZ(param*)
    {
        dllcall("imgui\?aliFont@@YAPEAXXZ")
    }
    
    static fnimguidll_YAHXZ(param*)
    {
        dllcall("imgui\?fnimguidll@@YAHXZ")
    }
    
    static nimguidll_3HA(param*)
    {
        dllcall("imgui\?nimguidll@@3HA")
    }
    
    static simhei_font_YAPEAXXZ(param*)
    {
        dllcall("imgui\?simhei_font@@YAPEAXXZ")
    }
    
    static AddBezierCurve(param*)
    {
        dllcall("imgui\AddBezierCurve")
    }
    
    static AddCircle(param*)
    {
        dllcall("imgui\AddCircle")
    }
    
    static AddCircleFilled(param*)
    {
        dllcall("imgui\AddCircleFilled")
    }
    
    static AddConvexPolyFilled(param*)
    {
        dllcall("imgui\AddConvexPolyFilled")
    }
    
    static AddImage(param*)
    {
        dllcall("imgui\AddImage")
    }
    
    static AddImageFit(param*)
    {
        dllcall("imgui\AddImageFit")
    }
    
    static AddImageQuad(param*)
    {
        dllcall("imgui\AddImageQuad")
    }
    
    static AddImageRounded(param*)
    {
        dllcall("imgui\AddImageRounded")
    }
    
    static AddLine(param*)
    {
        dllcall("imgui\AddLine")
    }
    
    static AddNgon(param*)
    {
        dllcall("imgui\AddNgon")
    }
    
    static AddNgonFilled(param*)
    {
        dllcall("imgui\AddNgonFilled")
    }
    
    static AddPolyline(param*)
    {
        dllcall("imgui\AddPolyline")
    }
    
    static AddQuad(param*)
    {
        dllcall("imgui\AddQuad")
    }
    
    static AddQuadFilled(param*)
    {
        dllcall("imgui\AddQuadFilled")
    }
    
    static AddRect(param*)
    {
        dllcall("imgui\AddRect")
    }
    
    static AddRectFilled(param*)
    {
        dllcall("imgui\AddRectFilled")
    }
    
    static AddRectFilledMultiColor(param*)
    {
        dllcall("imgui\AddRectFilledMultiColor")
    }
    
    static AddText(param*)
    {
        dllcall("imgui\AddText")
    }
    
    static AddTriangle(param*)
    {
        dllcall("imgui\AddTriangle")
    }
    
    static AddTriangleFilled(param*)
    {
        dllcall("imgui\AddTriangleFilled")
    }
    
    static AlignTextToFramePadding(param*)
    {
        dllcall("imgui\AlignTextToFramePadding")
    }
    
    static ArrowButton(param*)
    {
        dllcall("imgui\ArrowButton")
    }
    
    static Begin(param*)
    {
        dllcall("imgui\Begin")
    }
    
    static BeginChild(param*)
    {
        dllcall("imgui\BeginChild")
    }
    
    static BeginChildFrame(param*)
    {
        dllcall("imgui\BeginChildFrame")
    }
    
    static BeginCombo(param*)
    {
        dllcall("imgui\BeginCombo")
    }
    
    static BeginDragDropSource(param*)
    {
        dllcall("imgui\BeginDragDropSource")
    }
    
    static BeginFrame(param*)
    {
        dllcall("imgui\BeginFrame")
    }
    
    static BeginGroup(param*)
    {
        dllcall("imgui\BeginGroup")
    }
    
    static BeginMainMenuBar(param*)
    {
        dllcall("imgui\BeginMainMenuBar")
    }
    
    static BeginMenu(param*)
    {
        dllcall("imgui\BeginMenu")
    }
    
    static BeginMenuBar(param*)
    {
        dllcall("imgui\BeginMenuBar")
    }
    
    static BeginPopup(param*)
    {
        dllcall("imgui\BeginPopup")
    }
    
    static BeginPopupContextItem(param*)
    {
        dllcall("imgui\BeginPopupContextItem")
    }
    
    static BeginPopupContextVoid(param*)
    {
        dllcall("imgui\BeginPopupContextVoid")
    }
    
    static BeginPopupContextWindow(param*)
    {
        dllcall("imgui\BeginPopupContextWindow")
    }
    
    static BeginPopupModal(param*)
    {
        dllcall("imgui\BeginPopupModal")
    }
    
    static BeginTabBar(param*)
    {
        dllcall("imgui\BeginTabBar")
    }
    
    static BeginTabItem(param*)
    {
        dllcall("imgui\BeginTabItem")
    }
    
    static BeginTooltip(param*)
    {
        dllcall("imgui\BeginTooltip")
    }
    
    static Bullet(param*)
    {
        dllcall("imgui\Bullet")
    }
    
    static BulletText(param*)
    {
        dllcall("imgui\BulletText")
    }
    
    static Button(param*)
    {
        dllcall("imgui\Button")
    }
    
    static CalcItemWidth(param*)
    {
        dllcall("imgui\CalcItemWidth")
    }
    
    static CalcTextSize(param*)
    {
        dllcall("imgui\CalcTextSize")
    }
    
    static CaptureKeyboardFromApp(param*)
    {
        dllcall("imgui\CaptureKeyboardFromApp")
    }
    
    static CaptureMouseFromApp(param*)
    {
        dllcall("imgui\CaptureMouseFromApp")
    }
    
    static Checkbox(param*)
    {
        dllcall("imgui\Checkbox")
    }
    
    static CheckboxFlags(param*)
    {
        dllcall("imgui\CheckboxFlags")
    }
    
    static CloseCurrentPopup(param*)
    {
        dllcall("imgui\CloseCurrentPopup")
    }
    
    static CollapsingHeader(param*)
    {
        dllcall("imgui\CollapsingHeader")
    }
    
    static CollapsingHeaderEx(param*)
    {
        dllcall("imgui\CollapsingHeaderEx")
    }
    
    static ColorEdit(param*)
    {
        dllcall("imgui\ColorEdit")
    }
    
    static ColorPicker(param*)
    {
        dllcall("imgui\ColorPicker")
    }
    
    static Columns(param*)
    {
        dllcall("imgui\Columns")
    }
    
    static DestroyPlatformWindows(param*)
    {
        dllcall("imgui\DestroyPlatformWindows")
    }
    
    static DockSpace(param*)
    {
        dllcall("imgui\DockSpace")
    }
    
    static DockSpaceOverViewport(param*)
    {
        dllcall("imgui\DockSpaceOverViewport")
    }
    
    static DragFloat(param*)
    {
        dllcall("imgui\DragFloat")
    }
    
    static DragFloatN(param*)
    {
        dllcall("imgui\DragFloatN")
    }
    
    static DragFloatRange2(param*)
    {
        dllcall("imgui\DragFloatRange2")
    }
    
    static DragInt(param*)
    {
        dllcall("imgui\DragInt")
    }
    
    static DragIntN(param*)
    {
        dllcall("imgui\DragIntN")
    }
    
    static DragIntRange2(param*)
    {
        dllcall("imgui\DragIntRange2")
    }
    
    static DrawTest(param*)
    {
        dllcall("imgui\DrawTest")
    }
    
    static Dummy(param*)
    {
        dllcall("imgui\Dummy")
    }
    
    static EnableViewports(param*)
    {
        dllcall("imgui\EnableViewports")
    }
    
    static End(param*)
    {
        dllcall("imgui\End")
    }
    
    static EndChild(param*)
    {
        dllcall("imgui\EndChild")
    }
    
    static EndChildFrame(param*)
    {
        dllcall("imgui\EndChildFrame")
    }
    
    static EndCombo(param*)
    {
        dllcall("imgui\EndCombo")
    }
    
    static EndFrame(param*)
    {
        dllcall("imgui\EndFrame")
    }
    
    static EndGroup(param*)
    {
        dllcall("imgui\EndGroup")
    }
    
    static EndMainMenuBar(param*)
    {
        dllcall("imgui\EndMainMenuBar")
    }
    
    static EndMenuBar(param*)
    {
        dllcall("imgui\EndMenuBar")
    }
    
    static EndMenu_(param*)
    {
        dllcall("imgui\EndMenu_")
    }
    
    static EndPopup(param*)
    {
        dllcall("imgui\EndPopup")
    }
    
    static EndTabBar(param*)
    {
        dllcall("imgui\EndTabBar")
    }
    
    static EndTabItem(param*)
    {
        dllcall("imgui\EndTabItem")
    }
    
    static EndTooltip(param*)
    {
        dllcall("imgui\EndTooltip")
    }
    
    static GUICreate(param*)
    {
        dllcall("imgui\GUICreate")
    }
    
    static GetBackgroundDrawList(param*)
    {
        dllcall("imgui\GetBackgroundDrawList")
    }
    
    static GetColorU32(param*)
    {
        dllcall("imgui\GetColorU32")
    }
    
    static GetColumnIndex(param*)
    {
        dllcall("imgui\GetColumnIndex")
    }
    
    static GetColumnOffset(param*)
    {
        dllcall("imgui\GetColumnOffset")
    }
    
    static GetColumnWidth(param*)
    {
        dllcall("imgui\GetColumnWidth")
    }
    
    static GetColumnsCount(param*)
    {
        dllcall("imgui\GetColumnsCount")
    }
    
    static GetContentRegionAvail(param*)
    {
        dllcall("imgui\GetContentRegionAvail")
    }
    
    static GetContentRegionMax(param*)
    {
        dllcall("imgui\GetContentRegionMax")
    }
    
    static GetCursorPosX(param*)
    {
        dllcall("imgui\GetCursorPosX")
    }
    
    static GetCursorPosY(param*)
    {
        dllcall("imgui\GetCursorPosY")
    }
    
    static GetCursorPosition(param*)
    {
        dllcall("imgui\GetCursorPosition")
    }
    
    static GetCursorScreenPos(param*)
    {
        dllcall("imgui\GetCursorScreenPos")
    }
    
    static GetCursorStartPos(param*)
    {
        dllcall("imgui\GetCursorStartPos")
    }
    
    static GetFont(param*)
    {
        dllcall("imgui\GetFont")
    }
    
    static GetFontSize(param*)
    {
        dllcall("imgui\GetFontSize")
    }
    
    static GetFontTexUvWhitePixel(param*)
    {
        dllcall("imgui\GetFontTexUvWhitePixel")
    }
    
    static GetForegroundDrawList(param*)
    {
        dllcall("imgui\GetForegroundDrawList")
    }
    
    static GetFrameCount(param*)
    {
        dllcall("imgui\GetFrameCount")
    }
    
    static GetFrameHeight(param*)
    {
        dllcall("imgui\GetFrameHeight")
    }
    
    static GetFrameHeightWithSpacing(param*)
    {
        dllcall("imgui\GetFrameHeightWithSpacing")
    }
    
    static GetID(param*)
    {
        dllcall("imgui\GetID")
    }
    
    static GetIO(param*)
    {
        dllcall("imgui\GetIO")
    }
    
    static GetItemRectMax(param*)
    {
        dllcall("imgui\GetItemRectMax")
    }
    
    static GetItemRectMin(param*)
    {
        dllcall("imgui\GetItemRectMin")
    }
    
    static GetItemRectSize(param*)
    {
        dllcall("imgui\GetItemRectSize")
    }
    
    static GetKeyIndex(param*)
    {
        dllcall("imgui\GetKeyIndex")
    }
    
    static GetKeyPressedAmount(param*)
    {
        dllcall("imgui\GetKeyPressedAmount")
    }
    
    static GetMainViewport(param*)
    {
        dllcall("imgui\GetMainViewport")
    }
    
    static GetMouseCursor(param*)
    {
        dllcall("imgui\GetMouseCursor")
    }
    
    static GetMouseDragDelta(param*)
    {
        dllcall("imgui\GetMouseDragDelta")
    }
    
    static GetMousePos(param*)
    {
        dllcall("imgui\GetMousePos")
    }
    
    static GetMousePosOnOpeningCurrentPopup(param*)
    {
        dllcall("imgui\GetMousePosOnOpeningCurrentPopup")
    }
    
    static GetOverlayDrawList(param*)
    {
        dllcall("imgui\GetOverlayDrawList")
    }
    
    static GetScrollMaxX(param*)
    {
        dllcall("imgui\GetScrollMaxX")
    }
    
    static GetScrollMaxY(param*)
    {
        dllcall("imgui\GetScrollMaxY")
    }
    
    static GetScrollX(param*)
    {
        dllcall("imgui\GetScrollX")
    }
    
    static GetScrollY(param*)
    {
        dllcall("imgui\GetScrollY")
    }
    
    static GetStyle(param*)
    {
        dllcall("imgui\GetStyle")
    }
    
    static GetTextLineHeight(param*)
    {
        dllcall("imgui\GetTextLineHeight")
    }
    
    static GetTextLineHeightWithSpacing(param*)
    {
        dllcall("imgui\GetTextLineHeightWithSpacing")
    }
    
    static GetTime(param*)
    {
        dllcall("imgui\GetTime")
    }
    
    static GetTreeNodeToLabelSpacing(param*)
    {
        dllcall("imgui\GetTreeNodeToLabelSpacing")
    }
    
    static GetWindowContentRegionMax(param*)
    {
        dllcall("imgui\GetWindowContentRegionMax")
    }
    
    static GetWindowContentRegionMin(param*)
    {
        dllcall("imgui\GetWindowContentRegionMin")
    }
    
    static GetWindowContentRegionWidth(param*)
    {
        dllcall("imgui\GetWindowContentRegionWidth")
    }
    
    static GetWindowDockID(param*)
    {
        dllcall("imgui\GetWindowDockID")
    }
    
    static GetWindowDpiScale(param*)
    {
        dllcall("imgui\GetWindowDpiScale")
    }
    
    static GetWindowDrawList(param*)
    {
        dllcall("imgui\GetWindowDrawList")
    }
    
    static GetWindowHeight(param*)
    {
        dllcall("imgui\GetWindowHeight")
    }
    
    static GetWindowPos(param*)
    {
        dllcall("imgui\GetWindowPos")
    }
    
    static GetWindowSize(param*)
    {
        dllcall("imgui\GetWindowSize")
    }
    
    static GetWindowViewport(param*)
    {
        dllcall("imgui\GetWindowViewport")
    }
    
    static GetWindowWidth(param*)
    {
        dllcall("imgui\GetWindowWidth")
    }
    
    static ImBitVector_Clear(param*)
    {
        dllcall("imgui\ImBitVector_Clear")
    }
    
    static ImBitVector_ClearBit(param*)
    {
        dllcall("imgui\ImBitVector_ClearBit")
    }
    
    static ImBitVector_Create(param*)
    {
        dllcall("imgui\ImBitVector_Create")
    }
    
    static ImBitVector_SetBit(param*)
    {
        dllcall("imgui\ImBitVector_SetBit")
    }
    
    static ImBitVector_TestBit(param*)
    {
        dllcall("imgui\ImBitVector_TestBit")
    }
    
    static ImColor_HSV(param*)
    {
        dllcall("imgui\ImColor_HSV")
    }
    
    static ImColor_ImColor_Float(param*)
    {
        dllcall("imgui\ImColor_ImColor_Float")
    }
    
    static ImColor_ImColor_Int(param*)
    {
        dllcall("imgui\ImColor_ImColor_Int")
    }
    
    static ImColor_ImColor_Nil(param*)
    {
        dllcall("imgui\ImColor_ImColor_Nil")
    }
    
    static ImColor_ImColor_U32(param*)
    {
        dllcall("imgui\ImColor_ImColor_U32")
    }
    
    static ImColor_ImColor_Vec4(param*)
    {
        dllcall("imgui\ImColor_ImColor_Vec4")
    }
    
    static ImColor_SetHSV(param*)
    {
        dllcall("imgui\ImColor_SetHSV")
    }
    
    static ImColor_destroy(param*)
    {
        dllcall("imgui\ImColor_destroy")
    }
    
    static ImDrawCmd_GetTexID(param*)
    {
        dllcall("imgui\ImDrawCmd_GetTexID")
    }
    
    static ImDrawCmd_ImDrawCmd(param*)
    {
        dllcall("imgui\ImDrawCmd_ImDrawCmd")
    }
    
    static ImDrawCmd_destroy(param*)
    {
        dllcall("imgui\ImDrawCmd_destroy")
    }
    
    static ImDrawDataBuilder_Clear(param*)
    {
        dllcall("imgui\ImDrawDataBuilder_Clear")
    }
    
    static ImDrawDataBuilder_ClearFreeMemory(param*)
    {
        dllcall("imgui\ImDrawDataBuilder_ClearFreeMemory")
    }
    
    static ImDrawDataBuilder_FlattenIntoSingleLayer(param*)
    {
        dllcall("imgui\ImDrawDataBuilder_FlattenIntoSingleLayer")
    }
    
    static ImDrawDataBuilder_GetDrawListCount(param*)
    {
        dllcall("imgui\ImDrawDataBuilder_GetDrawListCount")
    }
    
    static ImDrawData_Clear(param*)
    {
        dllcall("imgui\ImDrawData_Clear")
    }
    
    static ImDrawData_DeIndexAllBuffers(param*)
    {
        dllcall("imgui\ImDrawData_DeIndexAllBuffers")
    }
    
    static ImDrawData_ImDrawData(param*)
    {
        dllcall("imgui\ImDrawData_ImDrawData")
    }
    
    static ImDrawData_ScaleClipRects(param*)
    {
        dllcall("imgui\ImDrawData_ScaleClipRects")
    }
    
    static ImDrawData_destroy(param*)
    {
        dllcall("imgui\ImDrawData_destroy")
    }
    
    static ImDrawListSharedData_ImDrawListSharedData(param*)
    {
        dllcall("imgui\ImDrawListSharedData_ImDrawListSharedData")
    }
    
    static ImDrawListSharedData_SetCircleTessellationMaxError(param*)
    {
        dllcall("imgui\ImDrawListSharedData_SetCircleTessellationMaxError")
    }
    
    static ImDrawListSharedData_destroy(param*)
    {
        dllcall("imgui\ImDrawListSharedData_destroy")
    }
    
    static ImDrawListSplitter_Clear(param*)
    {
        dllcall("imgui\ImDrawListSplitter_Clear")
    }
    
    static ImDrawListSplitter_ClearFreeMemory(param*)
    {
        dllcall("imgui\ImDrawListSplitter_ClearFreeMemory")
    }
    
    static ImDrawListSplitter_ImDrawListSplitter(param*)
    {
        dllcall("imgui\ImDrawListSplitter_ImDrawListSplitter")
    }
    
    static ImDrawListSplitter_Merge(param*)
    {
        dllcall("imgui\ImDrawListSplitter_Merge")
    }
    
    static ImDrawListSplitter_SetCurrentChannel(param*)
    {
        dllcall("imgui\ImDrawListSplitter_SetCurrentChannel")
    }
    
    static ImDrawListSplitter_Split(param*)
    {
        dllcall("imgui\ImDrawListSplitter_Split")
    }
    
    static ImDrawListSplitter_destroy(param*)
    {
        dllcall("imgui\ImDrawListSplitter_destroy")
    }
    
    static ImDrawList_AddBezierCubic(param*)
    {
        dllcall("imgui\ImDrawList_AddBezierCubic")
    }
    
    static ImDrawList_AddBezierQuadratic(param*)
    {
        dllcall("imgui\ImDrawList_AddBezierQuadratic")
    }
    
    static ImDrawList_AddCallback(param*)
    {
        dllcall("imgui\ImDrawList_AddCallback")
    }
    
    static ImDrawList_AddCircle(param*)
    {
        dllcall("imgui\ImDrawList_AddCircle")
    }
    
    static ImDrawList_AddCircleFilled(param*)
    {
        dllcall("imgui\ImDrawList_AddCircleFilled")
    }
    
    static ImDrawList_AddConvexPolyFilled(param*)
    {
        dllcall("imgui\ImDrawList_AddConvexPolyFilled")
    }
    
    static ImDrawList_AddDrawCmd(param*)
    {
        dllcall("imgui\ImDrawList_AddDrawCmd")
    }
    
    static ImDrawList_AddImage(param*)
    {
        dllcall("imgui\ImDrawList_AddImage")
    }
    
    static ImDrawList_AddImageQuad(param*)
    {
        dllcall("imgui\ImDrawList_AddImageQuad")
    }
    
    static ImDrawList_AddImageRounded(param*)
    {
        dllcall("imgui\ImDrawList_AddImageRounded")
    }
    
    static ImDrawList_AddLine(param*)
    {
        dllcall("imgui\ImDrawList_AddLine")
    }
    
    static ImDrawList_AddNgon(param*)
    {
        dllcall("imgui\ImDrawList_AddNgon")
    }
    
    static ImDrawList_AddNgonFilled(param*)
    {
        dllcall("imgui\ImDrawList_AddNgonFilled")
    }
    
    static ImDrawList_AddPolyline(param*)
    {
        dllcall("imgui\ImDrawList_AddPolyline")
    }
    
    static ImDrawList_AddQuad(param*)
    {
        dllcall("imgui\ImDrawList_AddQuad")
    }
    
    static ImDrawList_AddQuadFilled(param*)
    {
        dllcall("imgui\ImDrawList_AddQuadFilled")
    }
    
    static ImDrawList_AddRect(param*)
    {
        dllcall("imgui\ImDrawList_AddRect")
    }
    
    static ImDrawList_AddRectFilled(param*)
    {
        dllcall("imgui\ImDrawList_AddRectFilled")
    }
    
    static ImDrawList_AddRectFilledMultiColor(param*)
    {
        dllcall("imgui\ImDrawList_AddRectFilledMultiColor")
    }
    
    static ImDrawList_AddText_FontPtr(param*)
    {
        dllcall("imgui\ImDrawList_AddText_FontPtr")
    }
    
    static ImDrawList_AddText_Vec2(param*)
    {
        dllcall("imgui\ImDrawList_AddText_Vec2")
    }
    
    static ImDrawList_AddTriangle(param*)
    {
        dllcall("imgui\ImDrawList_AddTriangle")
    }
    
    static ImDrawList_AddTriangleFilled(param*)
    {
        dllcall("imgui\ImDrawList_AddTriangleFilled")
    }
    
    static ImDrawList_ChannelsMerge(param*)
    {
        dllcall("imgui\ImDrawList_ChannelsMerge")
    }
    
    static ImDrawList_ChannelsSetCurrent(param*)
    {
        dllcall("imgui\ImDrawList_ChannelsSetCurrent")
    }
    
    static ImDrawList_ChannelsSplit(param*)
    {
        dllcall("imgui\ImDrawList_ChannelsSplit")
    }
    
    static ImDrawList_CloneOutput(param*)
    {
        dllcall("imgui\ImDrawList_CloneOutput")
    }
    
    static ImDrawList_GetClipRectMax(param*)
    {
        dllcall("imgui\ImDrawList_GetClipRectMax")
    }
    
    static ImDrawList_GetClipRectMin(param*)
    {
        dllcall("imgui\ImDrawList_GetClipRectMin")
    }
    
    static ImDrawList_ImDrawList(param*)
    {
        dllcall("imgui\ImDrawList_ImDrawList")
    }
    
    static ImDrawList_PathArcTo(param*)
    {
        dllcall("imgui\ImDrawList_PathArcTo")
    }
    
    static ImDrawList_PathArcToFast(param*)
    {
        dllcall("imgui\ImDrawList_PathArcToFast")
    }
    
    static ImDrawList_PathBezierCubicCurveTo(param*)
    {
        dllcall("imgui\ImDrawList_PathBezierCubicCurveTo")
    }
    
    static ImDrawList_PathBezierQuadraticCurveTo(param*)
    {
        dllcall("imgui\ImDrawList_PathBezierQuadraticCurveTo")
    }
    
    static ImDrawList_PathClear(param*)
    {
        dllcall("imgui\ImDrawList_PathClear")
    }
    
    static ImDrawList_PathFillConvex(param*)
    {
        dllcall("imgui\ImDrawList_PathFillConvex")
    }
    
    static ImDrawList_PathLineTo(param*)
    {
        dllcall("imgui\ImDrawList_PathLineTo")
    }
    
    static ImDrawList_PathLineToMergeDuplicate(param*)
    {
        dllcall("imgui\ImDrawList_PathLineToMergeDuplicate")
    }
    
    static ImDrawList_PathRect(param*)
    {
        dllcall("imgui\ImDrawList_PathRect")
    }
    
    static ImDrawList_PathStroke(param*)
    {
        dllcall("imgui\ImDrawList_PathStroke")
    }
    
    static ImDrawList_PopClipRect(param*)
    {
        dllcall("imgui\ImDrawList_PopClipRect")
    }
    
    static ImDrawList_PopTextureID(param*)
    {
        dllcall("imgui\ImDrawList_PopTextureID")
    }
    
    static ImDrawList_PrimQuadUV(param*)
    {
        dllcall("imgui\ImDrawList_PrimQuadUV")
    }
    
    static ImDrawList_PrimRect(param*)
    {
        dllcall("imgui\ImDrawList_PrimRect")
    }
    
    static ImDrawList_PrimRectUV(param*)
    {
        dllcall("imgui\ImDrawList_PrimRectUV")
    }
    
    static ImDrawList_PrimReserve(param*)
    {
        dllcall("imgui\ImDrawList_PrimReserve")
    }
    
    static ImDrawList_PrimUnreserve(param*)
    {
        dllcall("imgui\ImDrawList_PrimUnreserve")
    }
    
    static ImDrawList_PrimVtx(param*)
    {
        dllcall("imgui\ImDrawList_PrimVtx")
    }
    
    static ImDrawList_PrimWriteIdx(param*)
    {
        dllcall("imgui\ImDrawList_PrimWriteIdx")
    }
    
    static ImDrawList_PrimWriteVtx(param*)
    {
        dllcall("imgui\ImDrawList_PrimWriteVtx")
    }
    
    static ImDrawList_PushClipRect(param*)
    {
        dllcall("imgui\ImDrawList_PushClipRect")
    }
    
    static ImDrawList_PushClipRectFullScreen(param*)
    {
        dllcall("imgui\ImDrawList_PushClipRectFullScreen")
    }
    
    static ImDrawList_PushTextureID(param*)
    {
        dllcall("imgui\ImDrawList_PushTextureID")
    }
    
    static ImDrawList__CalcCircleAutoSegmentCount(param*)
    {
        dllcall("imgui\ImDrawList__CalcCircleAutoSegmentCount")
    }
    
    static ImDrawList__ClearFreeMemory(param*)
    {
        dllcall("imgui\ImDrawList__ClearFreeMemory")
    }
    
    static ImDrawList__OnChangedClipRect(param*)
    {
        dllcall("imgui\ImDrawList__OnChangedClipRect")
    }
    
    static ImDrawList__OnChangedTextureID(param*)
    {
        dllcall("imgui\ImDrawList__OnChangedTextureID")
    }
    
    static ImDrawList__OnChangedVtxOffset(param*)
    {
        dllcall("imgui\ImDrawList__OnChangedVtxOffset")
    }
    
    static ImDrawList__PathArcToFastEx(param*)
    {
        dllcall("imgui\ImDrawList__PathArcToFastEx")
    }
    
    static ImDrawList__PathArcToN(param*)
    {
        dllcall("imgui\ImDrawList__PathArcToN")
    }
    
    static ImDrawList__PopUnusedDrawCmd(param*)
    {
        dllcall("imgui\ImDrawList__PopUnusedDrawCmd")
    }
    
    static ImDrawList__ResetForNewFrame(param*)
    {
        dllcall("imgui\ImDrawList__ResetForNewFrame")
    }
    
    static ImDrawList__TryMergeDrawCmds(param*)
    {
        dllcall("imgui\ImDrawList__TryMergeDrawCmds")
    }
    
    static ImDrawList_destroy(param*)
    {
        dllcall("imgui\ImDrawList_destroy")
    }
    
    static ImFontAtlasCustomRect_ImFontAtlasCustomRect(param*)
    {
        dllcall("imgui\ImFontAtlasCustomRect_ImFontAtlasCustomRect")
    }
    
    static ImFontAtlasCustomRect_IsPacked(param*)
    {
        dllcall("imgui\ImFontAtlasCustomRect_IsPacked")
    }
    
    static ImFontAtlasCustomRect_destroy(param*)
    {
        dllcall("imgui\ImFontAtlasCustomRect_destroy")
    }
    
    static ImFontAtlas_AddCustomRectFontGlyph(param*)
    {
        dllcall("imgui\ImFontAtlas_AddCustomRectFontGlyph")
    }
    
    static ImFontAtlas_AddCustomRectRegular(param*)
    {
        dllcall("imgui\ImFontAtlas_AddCustomRectRegular")
    }
    
    static ImFontAtlas_AddFont(param*)
    {
        dllcall("imgui\ImFontAtlas_AddFont")
    }
    
    static ImFontAtlas_AddFontDefault(param*)
    {
        dllcall("imgui\ImFontAtlas_AddFontDefault")
    }
    
    static ImFontAtlas_AddFontFromFileTTF(param*)
    {
        dllcall("imgui\ImFontAtlas_AddFontFromFileTTF")
    }
    
    static ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(param*)
    {
        dllcall("imgui\ImFontAtlas_AddFontFromMemoryCompressedBase85TTF")
    }
    
    static ImFontAtlas_AddFontFromMemoryCompressedTTF(param*)
    {
        dllcall("imgui\ImFontAtlas_AddFontFromMemoryCompressedTTF")
    }
    
    static ImFontAtlas_AddFontFromMemoryTTF(param*)
    {
        dllcall("imgui\ImFontAtlas_AddFontFromMemoryTTF")
    }
    
    static ImFontAtlas_Build(param*)
    {
        dllcall("imgui\ImFontAtlas_Build")
    }
    
    static ImFontAtlas_CalcCustomRectUV(param*)
    {
        dllcall("imgui\ImFontAtlas_CalcCustomRectUV")
    }
    
    static ImFontAtlas_Clear(param*)
    {
        dllcall("imgui\ImFontAtlas_Clear")
    }
    
    static ImFontAtlas_ClearFonts(param*)
    {
        dllcall("imgui\ImFontAtlas_ClearFonts")
    }
    
    static ImFontAtlas_ClearInputData(param*)
    {
        dllcall("imgui\ImFontAtlas_ClearInputData")
    }
    
    static ImFontAtlas_ClearTexData(param*)
    {
        dllcall("imgui\ImFontAtlas_ClearTexData")
    }
    
    static ImFontAtlas_GetCustomRectByIndex(param*)
    {
        dllcall("imgui\ImFontAtlas_GetCustomRectByIndex")
    }
    
    static ImFontAtlas_GetGlyphRangesChineseFull(param*)
    {
        dllcall("imgui\ImFontAtlas_GetGlyphRangesChineseFull")
    }
    
    static ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(param*)
    {
        dllcall("imgui\ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon")
    }
    
    static ImFontAtlas_GetGlyphRangesCyrillic(param*)
    {
        dllcall("imgui\ImFontAtlas_GetGlyphRangesCyrillic")
    }
    
    static ImFontAtlas_GetGlyphRangesDefault(param*)
    {
        dllcall("imgui\ImFontAtlas_GetGlyphRangesDefault")
    }
    
    static ImFontAtlas_GetGlyphRangesJapanese(param*)
    {
        dllcall("imgui\ImFontAtlas_GetGlyphRangesJapanese")
    }
    
    static ImFontAtlas_GetGlyphRangesKorean(param*)
    {
        dllcall("imgui\ImFontAtlas_GetGlyphRangesKorean")
    }
    
    static ImFontAtlas_GetGlyphRangesThai(param*)
    {
        dllcall("imgui\ImFontAtlas_GetGlyphRangesThai")
    }
    
    static ImFontAtlas_GetGlyphRangesVietnamese(param*)
    {
        dllcall("imgui\ImFontAtlas_GetGlyphRangesVietnamese")
    }
    
    static ImFontAtlas_GetMouseCursorTexData(param*)
    {
        dllcall("imgui\ImFontAtlas_GetMouseCursorTexData")
    }
    
    static ImFontAtlas_GetTexDataAsAlpha8(param*)
    {
        dllcall("imgui\ImFontAtlas_GetTexDataAsAlpha8")
    }
    
    static ImFontAtlas_GetTexDataAsRGBA32(param*)
    {
        dllcall("imgui\ImFontAtlas_GetTexDataAsRGBA32")
    }
    
    static ImFontAtlas_ImFontAtlas(param*)
    {
        dllcall("imgui\ImFontAtlas_ImFontAtlas")
    }
    
    static ImFontAtlas_IsBuilt(param*)
    {
        dllcall("imgui\ImFontAtlas_IsBuilt")
    }
    
    static ImFontAtlas_SetTexID(param*)
    {
        dllcall("imgui\ImFontAtlas_SetTexID")
    }
    
    static ImFontAtlas_destroy(param*)
    {
        dllcall("imgui\ImFontAtlas_destroy")
    }
    
    static ImFontConfig_ImFontConfig(param*)
    {
        dllcall("imgui\ImFontConfig_ImFontConfig")
    }
    
    static ImFontConfig_destroy(param*)
    {
        dllcall("imgui\ImFontConfig_destroy")
    }
    
    static ImFontGlyphRangesBuilder_AddChar(param*)
    {
        dllcall("imgui\ImFontGlyphRangesBuilder_AddChar")
    }
    
    static ImFontGlyphRangesBuilder_AddRanges(param*)
    {
        dllcall("imgui\ImFontGlyphRangesBuilder_AddRanges")
    }
    
    static ImFontGlyphRangesBuilder_AddText(param*)
    {
        dllcall("imgui\ImFontGlyphRangesBuilder_AddText")
    }
    
    static ImFontGlyphRangesBuilder_BuildRanges(param*)
    {
        dllcall("imgui\ImFontGlyphRangesBuilder_BuildRanges")
    }
    
    static ImFontGlyphRangesBuilder_Clear(param*)
    {
        dllcall("imgui\ImFontGlyphRangesBuilder_Clear")
    }
    
    static ImFontGlyphRangesBuilder_GetBit(param*)
    {
        dllcall("imgui\ImFontGlyphRangesBuilder_GetBit")
    }
    
    static ImFontGlyphRangesBuilder_ImFontGlyphRangesBuilder(param*)
    {
        dllcall("imgui\ImFontGlyphRangesBuilder_ImFontGlyphRangesBuilder")
    }
    
    static ImFontGlyphRangesBuilder_SetBit(param*)
    {
        dllcall("imgui\ImFontGlyphRangesBuilder_SetBit")
    }
    
    static ImFontGlyphRangesBuilder_destroy(param*)
    {
        dllcall("imgui\ImFontGlyphRangesBuilder_destroy")
    }
    
    static ImFont_AddGlyph(param*)
    {
        dllcall("imgui\ImFont_AddGlyph")
    }
    
    static ImFont_AddRemapChar(param*)
    {
        dllcall("imgui\ImFont_AddRemapChar")
    }
    
    static ImFont_BuildLookupTable(param*)
    {
        dllcall("imgui\ImFont_BuildLookupTable")
    }
    
    static ImFont_CalcTextSizeA(param*)
    {
        dllcall("imgui\ImFont_CalcTextSizeA")
    }
    
    static ImFont_CalcWordWrapPositionA(param*)
    {
        dllcall("imgui\ImFont_CalcWordWrapPositionA")
    }
    
    static ImFont_ClearOutputData(param*)
    {
        dllcall("imgui\ImFont_ClearOutputData")
    }
    
    static ImFont_FindGlyph(param*)
    {
        dllcall("imgui\ImFont_FindGlyph")
    }
    
    static ImFont_FindGlyphNoFallback(param*)
    {
        dllcall("imgui\ImFont_FindGlyphNoFallback")
    }
    
    static ImFont_GetCharAdvance(param*)
    {
        dllcall("imgui\ImFont_GetCharAdvance")
    }
    
    static ImFont_GetDebugName(param*)
    {
        dllcall("imgui\ImFont_GetDebugName")
    }
    
    static ImFont_GrowIndex(param*)
    {
        dllcall("imgui\ImFont_GrowIndex")
    }
    
    static ImFont_ImFont(param*)
    {
        dllcall("imgui\ImFont_ImFont")
    }
    
    static ImFont_IsGlyphRangeUnused(param*)
    {
        dllcall("imgui\ImFont_IsGlyphRangeUnused")
    }
    
    static ImFont_IsLoaded(param*)
    {
        dllcall("imgui\ImFont_IsLoaded")
    }
    
    static ImFont_RenderChar(param*)
    {
        dllcall("imgui\ImFont_RenderChar")
    }
    
    static ImFont_RenderText(param*)
    {
        dllcall("imgui\ImFont_RenderText")
    }
    
    static ImFont_SetGlyphVisible(param*)
    {
        dllcall("imgui\ImFont_SetGlyphVisible")
    }
    
    static ImFont_destroy(param*)
    {
        dllcall("imgui\ImFont_destroy")
    }
    
    static ImGuiComboPreviewData_ImGuiComboPreviewData(param*)
    {
        dllcall("imgui\ImGuiComboPreviewData_ImGuiComboPreviewData")
    }
    
    static ImGuiComboPreviewData_destroy(param*)
    {
        dllcall("imgui\ImGuiComboPreviewData_destroy")
    }
    
    static ImGuiContextHook_ImGuiContextHook(param*)
    {
        dllcall("imgui\ImGuiContextHook_ImGuiContextHook")
    }
    
    static ImGuiContextHook_destroy(param*)
    {
        dllcall("imgui\ImGuiContextHook_destroy")
    }
    
    static ImGuiContext_ImGuiContext(param*)
    {
        dllcall("imgui\ImGuiContext_ImGuiContext")
    }
    
    static ImGuiContext_destroy(param*)
    {
        dllcall("imgui\ImGuiContext_destroy")
    }
    
    static ImGuiDockContext_ImGuiDockContext(param*)
    {
        dllcall("imgui\ImGuiDockContext_ImGuiDockContext")
    }
    
    static ImGuiDockContext_destroy(param*)
    {
        dllcall("imgui\ImGuiDockContext_destroy")
    }
    
    static ImGuiDockNode_ImGuiDockNode(param*)
    {
        dllcall("imgui\ImGuiDockNode_ImGuiDockNode")
    }
    
    static ImGuiDockNode_IsCentralNode(param*)
    {
        dllcall("imgui\ImGuiDockNode_IsCentralNode")
    }
    
    static ImGuiDockNode_IsDockSpace(param*)
    {
        dllcall("imgui\ImGuiDockNode_IsDockSpace")
    }
    
    static ImGuiDockNode_IsEmpty(param*)
    {
        dllcall("imgui\ImGuiDockNode_IsEmpty")
    }
    
    static ImGuiDockNode_IsFloatingNode(param*)
    {
        dllcall("imgui\ImGuiDockNode_IsFloatingNode")
    }
    
    static ImGuiDockNode_IsHiddenTabBar(param*)
    {
        dllcall("imgui\ImGuiDockNode_IsHiddenTabBar")
    }
    
    static ImGuiDockNode_IsLeafNode(param*)
    {
        dllcall("imgui\ImGuiDockNode_IsLeafNode")
    }
    
    static ImGuiDockNode_IsNoTabBar(param*)
    {
        dllcall("imgui\ImGuiDockNode_IsNoTabBar")
    }
    
    static ImGuiDockNode_IsRootNode(param*)
    {
        dllcall("imgui\ImGuiDockNode_IsRootNode")
    }
    
    static ImGuiDockNode_IsSplitNode(param*)
    {
        dllcall("imgui\ImGuiDockNode_IsSplitNode")
    }
    
    static ImGuiDockNode_Rect(param*)
    {
        dllcall("imgui\ImGuiDockNode_Rect")
    }
    
    static ImGuiDockNode_SetLocalFlags(param*)
    {
        dllcall("imgui\ImGuiDockNode_SetLocalFlags")
    }
    
    static ImGuiDockNode_UpdateMergedFlags(param*)
    {
        dllcall("imgui\ImGuiDockNode_UpdateMergedFlags")
    }
    
    static ImGuiDockNode_destroy(param*)
    {
        dllcall("imgui\ImGuiDockNode_destroy")
    }
    
    static ImGuiIO_AddFocusEvent(param*)
    {
        dllcall("imgui\ImGuiIO_AddFocusEvent")
    }
    
    static ImGuiIO_AddInputCharacter(param*)
    {
        dllcall("imgui\ImGuiIO_AddInputCharacter")
    }
    
    static ImGuiIO_AddInputCharacterUTF16(param*)
    {
        dllcall("imgui\ImGuiIO_AddInputCharacterUTF16")
    }
    
    static ImGuiIO_AddInputCharactersUTF8(param*)
    {
        dllcall("imgui\ImGuiIO_AddInputCharactersUTF8")
    }
    
    static ImGuiIO_AddKeyAnalogEvent(param*)
    {
        dllcall("imgui\ImGuiIO_AddKeyAnalogEvent")
    }
    
    static ImGuiIO_AddKeyEvent(param*)
    {
        dllcall("imgui\ImGuiIO_AddKeyEvent")
    }
    
    static ImGuiIO_AddMouseButtonEvent(param*)
    {
        dllcall("imgui\ImGuiIO_AddMouseButtonEvent")
    }
    
    static ImGuiIO_AddMousePosEvent(param*)
    {
        dllcall("imgui\ImGuiIO_AddMousePosEvent")
    }
    
    static ImGuiIO_AddMouseViewportEvent(param*)
    {
        dllcall("imgui\ImGuiIO_AddMouseViewportEvent")
    }
    
    static ImGuiIO_AddMouseWheelEvent(param*)
    {
        dllcall("imgui\ImGuiIO_AddMouseWheelEvent")
    }
    
    static ImGuiIO_ClearInputCharacters(param*)
    {
        dllcall("imgui\ImGuiIO_ClearInputCharacters")
    }
    
    static ImGuiIO_ClearInputKeys(param*)
    {
        dllcall("imgui\ImGuiIO_ClearInputKeys")
    }
    
    static ImGuiIO_ImGuiIO(param*)
    {
        dllcall("imgui\ImGuiIO_ImGuiIO")
    }
    
    static ImGuiIO_SetKeyEventNativeData(param*)
    {
        dllcall("imgui\ImGuiIO_SetKeyEventNativeData")
    }
    
    static ImGuiIO_destroy(param*)
    {
        dllcall("imgui\ImGuiIO_destroy")
    }
    
    static ImGuiInputEvent_ImGuiInputEvent(param*)
    {
        dllcall("imgui\ImGuiInputEvent_ImGuiInputEvent")
    }
    
    static ImGuiInputEvent_destroy(param*)
    {
        dllcall("imgui\ImGuiInputEvent_destroy")
    }
    
    static ImGuiInputTextCallbackData_ClearSelection(param*)
    {
        dllcall("imgui\ImGuiInputTextCallbackData_ClearSelection")
    }
    
    static ImGuiInputTextCallbackData_DeleteChars(param*)
    {
        dllcall("imgui\ImGuiInputTextCallbackData_DeleteChars")
    }
    
    static ImGuiInputTextCallbackData_HasSelection(param*)
    {
        dllcall("imgui\ImGuiInputTextCallbackData_HasSelection")
    }
    
    static ImGuiInputTextCallbackData_ImGuiInputTextCallbackData(param*)
    {
        dllcall("imgui\ImGuiInputTextCallbackData_ImGuiInputTextCallbackData")
    }
    
    static ImGuiInputTextCallbackData_InsertChars(param*)
    {
        dllcall("imgui\ImGuiInputTextCallbackData_InsertChars")
    }
    
    static ImGuiInputTextCallbackData_SelectAll(param*)
    {
        dllcall("imgui\ImGuiInputTextCallbackData_SelectAll")
    }
    
    static ImGuiInputTextCallbackData_destroy(param*)
    {
        dllcall("imgui\ImGuiInputTextCallbackData_destroy")
    }
    
    static ImGuiInputTextState_ClearFreeMemory(param*)
    {
        dllcall("imgui\ImGuiInputTextState_ClearFreeMemory")
    }
    
    static ImGuiInputTextState_ClearSelection(param*)
    {
        dllcall("imgui\ImGuiInputTextState_ClearSelection")
    }
    
    static ImGuiInputTextState_ClearText(param*)
    {
        dllcall("imgui\ImGuiInputTextState_ClearText")
    }
    
    static ImGuiInputTextState_CursorAnimReset(param*)
    {
        dllcall("imgui\ImGuiInputTextState_CursorAnimReset")
    }
    
    static ImGuiInputTextState_CursorClamp(param*)
    {
        dllcall("imgui\ImGuiInputTextState_CursorClamp")
    }
    
    static ImGuiInputTextState_GetCursorPos(param*)
    {
        dllcall("imgui\ImGuiInputTextState_GetCursorPos")
    }
    
    static ImGuiInputTextState_GetRedoAvailCount(param*)
    {
        dllcall("imgui\ImGuiInputTextState_GetRedoAvailCount")
    }
    
    static ImGuiInputTextState_GetSelectionEnd(param*)
    {
        dllcall("imgui\ImGuiInputTextState_GetSelectionEnd")
    }
    
    static ImGuiInputTextState_GetSelectionStart(param*)
    {
        dllcall("imgui\ImGuiInputTextState_GetSelectionStart")
    }
    
    static ImGuiInputTextState_GetUndoAvailCount(param*)
    {
        dllcall("imgui\ImGuiInputTextState_GetUndoAvailCount")
    }
    
    static ImGuiInputTextState_HasSelection(param*)
    {
        dllcall("imgui\ImGuiInputTextState_HasSelection")
    }
    
    static ImGuiInputTextState_ImGuiInputTextState(param*)
    {
        dllcall("imgui\ImGuiInputTextState_ImGuiInputTextState")
    }
    
    static ImGuiInputTextState_OnKeyPressed(param*)
    {
        dllcall("imgui\ImGuiInputTextState_OnKeyPressed")
    }
    
    static ImGuiInputTextState_SelectAll(param*)
    {
        dllcall("imgui\ImGuiInputTextState_SelectAll")
    }
    
    static ImGuiInputTextState_destroy(param*)
    {
        dllcall("imgui\ImGuiInputTextState_destroy")
    }
    
    static ImGuiLastItemData_ImGuiLastItemData(param*)
    {
        dllcall("imgui\ImGuiLastItemData_ImGuiLastItemData")
    }
    
    static ImGuiLastItemData_destroy(param*)
    {
        dllcall("imgui\ImGuiLastItemData_destroy")
    }
    
    static ImGuiListClipperData_ImGuiListClipperData(param*)
    {
        dllcall("imgui\ImGuiListClipperData_ImGuiListClipperData")
    }
    
    static ImGuiListClipperData_Reset(param*)
    {
        dllcall("imgui\ImGuiListClipperData_Reset")
    }
    
    static ImGuiListClipperData_destroy(param*)
    {
        dllcall("imgui\ImGuiListClipperData_destroy")
    }
    
    static ImGuiListClipperRange_FromIndices(param*)
    {
        dllcall("imgui\ImGuiListClipperRange_FromIndices")
    }
    
    static ImGuiListClipperRange_FromPositions(param*)
    {
        dllcall("imgui\ImGuiListClipperRange_FromPositions")
    }
    
    static ImGuiListClipper_Begin(param*)
    {
        dllcall("imgui\ImGuiListClipper_Begin")
    }
    
    static ImGuiListClipper_End(param*)
    {
        dllcall("imgui\ImGuiListClipper_End")
    }
    
    static ImGuiListClipper_ForceDisplayRangeByIndices(param*)
    {
        dllcall("imgui\ImGuiListClipper_ForceDisplayRangeByIndices")
    }
    
    static ImGuiListClipper_ImGuiListClipper(param*)
    {
        dllcall("imgui\ImGuiListClipper_ImGuiListClipper")
    }
    
    static ImGuiListClipper_Step(param*)
    {
        dllcall("imgui\ImGuiListClipper_Step")
    }
    
    static ImGuiListClipper_destroy(param*)
    {
        dllcall("imgui\ImGuiListClipper_destroy")
    }
    
    static ImGuiMenuColumns_CalcNextTotalWidth(param*)
    {
        dllcall("imgui\ImGuiMenuColumns_CalcNextTotalWidth")
    }
    
    static ImGuiMenuColumns_DeclColumns(param*)
    {
        dllcall("imgui\ImGuiMenuColumns_DeclColumns")
    }
    
    static ImGuiMenuColumns_ImGuiMenuColumns(param*)
    {
        dllcall("imgui\ImGuiMenuColumns_ImGuiMenuColumns")
    }
    
    static ImGuiMenuColumns_Update(param*)
    {
        dllcall("imgui\ImGuiMenuColumns_Update")
    }
    
    static ImGuiMenuColumns_destroy(param*)
    {
        dllcall("imgui\ImGuiMenuColumns_destroy")
    }
    
    static ImGuiMetricsConfig_ImGuiMetricsConfig(param*)
    {
        dllcall("imgui\ImGuiMetricsConfig_ImGuiMetricsConfig")
    }
    
    static ImGuiMetricsConfig_destroy(param*)
    {
        dllcall("imgui\ImGuiMetricsConfig_destroy")
    }
    
    static ImGuiNavItemData_Clear(param*)
    {
        dllcall("imgui\ImGuiNavItemData_Clear")
    }
    
    static ImGuiNavItemData_ImGuiNavItemData(param*)
    {
        dllcall("imgui\ImGuiNavItemData_ImGuiNavItemData")
    }
    
    static ImGuiNavItemData_destroy(param*)
    {
        dllcall("imgui\ImGuiNavItemData_destroy")
    }
    
    static ImGuiNextItemData_ClearFlags(param*)
    {
        dllcall("imgui\ImGuiNextItemData_ClearFlags")
    }
    
    static ImGuiNextItemData_ImGuiNextItemData(param*)
    {
        dllcall("imgui\ImGuiNextItemData_ImGuiNextItemData")
    }
    
    static ImGuiNextItemData_destroy(param*)
    {
        dllcall("imgui\ImGuiNextItemData_destroy")
    }
    
    static ImGuiNextWindowData_ClearFlags(param*)
    {
        dllcall("imgui\ImGuiNextWindowData_ClearFlags")
    }
    
    static ImGuiNextWindowData_ImGuiNextWindowData(param*)
    {
        dllcall("imgui\ImGuiNextWindowData_ImGuiNextWindowData")
    }
    
    static ImGuiNextWindowData_destroy(param*)
    {
        dllcall("imgui\ImGuiNextWindowData_destroy")
    }
    
    static ImGuiOldColumnData_ImGuiOldColumnData(param*)
    {
        dllcall("imgui\ImGuiOldColumnData_ImGuiOldColumnData")
    }
    
    static ImGuiOldColumnData_destroy(param*)
    {
        dllcall("imgui\ImGuiOldColumnData_destroy")
    }
    
    static ImGuiOldColumns_ImGuiOldColumns(param*)
    {
        dllcall("imgui\ImGuiOldColumns_ImGuiOldColumns")
    }
    
    static ImGuiOldColumns_destroy(param*)
    {
        dllcall("imgui\ImGuiOldColumns_destroy")
    }
    
    static ImGuiOnceUponAFrame_ImGuiOnceUponAFrame(param*)
    {
        dllcall("imgui\ImGuiOnceUponAFrame_ImGuiOnceUponAFrame")
    }
    
    static ImGuiOnceUponAFrame_destroy(param*)
    {
        dllcall("imgui\ImGuiOnceUponAFrame_destroy")
    }
    
    static ImGuiPayload_Clear(param*)
    {
        dllcall("imgui\ImGuiPayload_Clear")
    }
    
    static ImGuiPayload_ImGuiPayload(param*)
    {
        dllcall("imgui\ImGuiPayload_ImGuiPayload")
    }
    
    static ImGuiPayload_IsDataType(param*)
    {
        dllcall("imgui\ImGuiPayload_IsDataType")
    }
    
    static ImGuiPayload_IsDelivery(param*)
    {
        dllcall("imgui\ImGuiPayload_IsDelivery")
    }
    
    static ImGuiPayload_IsPreview(param*)
    {
        dllcall("imgui\ImGuiPayload_IsPreview")
    }
    
    static ImGuiPayload_destroy(param*)
    {
        dllcall("imgui\ImGuiPayload_destroy")
    }
    
    static ImGuiPlatformIO_ImGuiPlatformIO(param*)
    {
        dllcall("imgui\ImGuiPlatformIO_ImGuiPlatformIO")
    }
    
    static ImGuiPlatformIO_Set_Platform_GetWindowPos(param*)
    {
        dllcall("imgui\ImGuiPlatformIO_Set_Platform_GetWindowPos")
    }
    
    static ImGuiPlatformIO_Set_Platform_GetWindowSize(param*)
    {
        dllcall("imgui\ImGuiPlatformIO_Set_Platform_GetWindowSize")
    }
    
    static ImGuiPlatformIO_destroy(param*)
    {
        dllcall("imgui\ImGuiPlatformIO_destroy")
    }
    
    static ImGuiPlatformImeData_ImGuiPlatformImeData(param*)
    {
        dllcall("imgui\ImGuiPlatformImeData_ImGuiPlatformImeData")
    }
    
    static ImGuiPlatformImeData_destroy(param*)
    {
        dllcall("imgui\ImGuiPlatformImeData_destroy")
    }
    
    static ImGuiPlatformMonitor_ImGuiPlatformMonitor(param*)
    {
        dllcall("imgui\ImGuiPlatformMonitor_ImGuiPlatformMonitor")
    }
    
    static ImGuiPlatformMonitor_destroy(param*)
    {
        dllcall("imgui\ImGuiPlatformMonitor_destroy")
    }
    
    static ImGuiPopupData_ImGuiPopupData(param*)
    {
        dllcall("imgui\ImGuiPopupData_ImGuiPopupData")
    }
    
    static ImGuiPopupData_destroy(param*)
    {
        dllcall("imgui\ImGuiPopupData_destroy")
    }
    
    static ImGuiPtrOrIndex_ImGuiPtrOrIndex_Int(param*)
    {
        dllcall("imgui\ImGuiPtrOrIndex_ImGuiPtrOrIndex_Int")
    }
    
    static ImGuiPtrOrIndex_ImGuiPtrOrIndex_Ptr(param*)
    {
        dllcall("imgui\ImGuiPtrOrIndex_ImGuiPtrOrIndex_Ptr")
    }
    
    static ImGuiPtrOrIndex_destroy(param*)
    {
        dllcall("imgui\ImGuiPtrOrIndex_destroy")
    }
    
    static ImGuiSettingsHandler_ImGuiSettingsHandler(param*)
    {
        dllcall("imgui\ImGuiSettingsHandler_ImGuiSettingsHandler")
    }
    
    static ImGuiSettingsHandler_destroy(param*)
    {
        dllcall("imgui\ImGuiSettingsHandler_destroy")
    }
    
    static ImGuiStackLevelInfo_ImGuiStackLevelInfo(param*)
    {
        dllcall("imgui\ImGuiStackLevelInfo_ImGuiStackLevelInfo")
    }
    
    static ImGuiStackLevelInfo_destroy(param*)
    {
        dllcall("imgui\ImGuiStackLevelInfo_destroy")
    }
    
    static ImGuiStackSizes_CompareWithCurrentState(param*)
    {
        dllcall("imgui\ImGuiStackSizes_CompareWithCurrentState")
    }
    
    static ImGuiStackSizes_ImGuiStackSizes(param*)
    {
        dllcall("imgui\ImGuiStackSizes_ImGuiStackSizes")
    }
    
    static ImGuiStackSizes_SetToCurrentState(param*)
    {
        dllcall("imgui\ImGuiStackSizes_SetToCurrentState")
    }
    
    static ImGuiStackSizes_destroy(param*)
    {
        dllcall("imgui\ImGuiStackSizes_destroy")
    }
    
    static ImGuiStackTool_ImGuiStackTool(param*)
    {
        dllcall("imgui\ImGuiStackTool_ImGuiStackTool")
    }
    
    static ImGuiStackTool_destroy(param*)
    {
        dllcall("imgui\ImGuiStackTool_destroy")
    }
    
    static ImGuiStoragePair_ImGuiStoragePair_Float(param*)
    {
        dllcall("imgui\ImGuiStoragePair_ImGuiStoragePair_Float")
    }
    
    static ImGuiStoragePair_ImGuiStoragePair_Int(param*)
    {
        dllcall("imgui\ImGuiStoragePair_ImGuiStoragePair_Int")
    }
    
    static ImGuiStoragePair_ImGuiStoragePair_Ptr(param*)
    {
        dllcall("imgui\ImGuiStoragePair_ImGuiStoragePair_Ptr")
    }
    
    static ImGuiStoragePair_destroy(param*)
    {
        dllcall("imgui\ImGuiStoragePair_destroy")
    }
    
    static ImGuiStorage_BuildSortByKey(param*)
    {
        dllcall("imgui\ImGuiStorage_BuildSortByKey")
    }
    
    static ImGuiStorage_Clear(param*)
    {
        dllcall("imgui\ImGuiStorage_Clear")
    }
    
    static ImGuiStorage_GetBool(param*)
    {
        dllcall("imgui\ImGuiStorage_GetBool")
    }
    
    static ImGuiStorage_GetBoolRef(param*)
    {
        dllcall("imgui\ImGuiStorage_GetBoolRef")
    }
    
    static ImGuiStorage_GetFloat(param*)
    {
        dllcall("imgui\ImGuiStorage_GetFloat")
    }
    
    static ImGuiStorage_GetFloatRef(param*)
    {
        dllcall("imgui\ImGuiStorage_GetFloatRef")
    }
    
    static ImGuiStorage_GetInt(param*)
    {
        dllcall("imgui\ImGuiStorage_GetInt")
    }
    
    static ImGuiStorage_GetIntRef(param*)
    {
        dllcall("imgui\ImGuiStorage_GetIntRef")
    }
    
    static ImGuiStorage_GetVoidPtr(param*)
    {
        dllcall("imgui\ImGuiStorage_GetVoidPtr")
    }
    
    static ImGuiStorage_GetVoidPtrRef(param*)
    {
        dllcall("imgui\ImGuiStorage_GetVoidPtrRef")
    }
    
    static ImGuiStorage_SetAllInt(param*)
    {
        dllcall("imgui\ImGuiStorage_SetAllInt")
    }
    
    static ImGuiStorage_SetBool(param*)
    {
        dllcall("imgui\ImGuiStorage_SetBool")
    }
    
    static ImGuiStorage_SetFloat(param*)
    {
        dllcall("imgui\ImGuiStorage_SetFloat")
    }
    
    static ImGuiStorage_SetInt(param*)
    {
        dllcall("imgui\ImGuiStorage_SetInt")
    }
    
    static ImGuiStorage_SetVoidPtr(param*)
    {
        dllcall("imgui\ImGuiStorage_SetVoidPtr")
    }
    
    static ImGuiStyleMod_ImGuiStyleMod_Float(param*)
    {
        dllcall("imgui\ImGuiStyleMod_ImGuiStyleMod_Float")
    }
    
    static ImGuiStyleMod_ImGuiStyleMod_Int(param*)
    {
        dllcall("imgui\ImGuiStyleMod_ImGuiStyleMod_Int")
    }
    
    static ImGuiStyleMod_ImGuiStyleMod_Vec2(param*)
    {
        dllcall("imgui\ImGuiStyleMod_ImGuiStyleMod_Vec2")
    }
    
    static ImGuiStyleMod_destroy(param*)
    {
        dllcall("imgui\ImGuiStyleMod_destroy")
    }
    
    static ImGuiStyle_ImGuiStyle(param*)
    {
        dllcall("imgui\ImGuiStyle_ImGuiStyle")
    }
    
    static ImGuiStyle_ScaleAllSizes(param*)
    {
        dllcall("imgui\ImGuiStyle_ScaleAllSizes")
    }
    
    static ImGuiStyle_destroy(param*)
    {
        dllcall("imgui\ImGuiStyle_destroy")
    }
    
    static ImGuiTabBar_GetTabName(param*)
    {
        dllcall("imgui\ImGuiTabBar_GetTabName")
    }
    
    static ImGuiTabBar_GetTabOrder(param*)
    {
        dllcall("imgui\ImGuiTabBar_GetTabOrder")
    }
    
    static ImGuiTabBar_ImGuiTabBar(param*)
    {
        dllcall("imgui\ImGuiTabBar_ImGuiTabBar")
    }
    
    static ImGuiTabBar_destroy(param*)
    {
        dllcall("imgui\ImGuiTabBar_destroy")
    }
    
    static ImGuiTabItem_ImGuiTabItem(param*)
    {
        dllcall("imgui\ImGuiTabItem_ImGuiTabItem")
    }
    
    static ImGuiTabItem_destroy(param*)
    {
        dllcall("imgui\ImGuiTabItem_destroy")
    }
    
    static ImGuiTableColumnSettings_ImGuiTableColumnSettings(param*)
    {
        dllcall("imgui\ImGuiTableColumnSettings_ImGuiTableColumnSettings")
    }
    
    static ImGuiTableColumnSettings_destroy(param*)
    {
        dllcall("imgui\ImGuiTableColumnSettings_destroy")
    }
    
    static ImGuiTableColumnSortSpecs_ImGuiTableColumnSortSpecs(param*)
    {
        dllcall("imgui\ImGuiTableColumnSortSpecs_ImGuiTableColumnSortSpecs")
    }
    
    static ImGuiTableColumnSortSpecs_destroy(param*)
    {
        dllcall("imgui\ImGuiTableColumnSortSpecs_destroy")
    }
    
    static ImGuiTableColumn_ImGuiTableColumn(param*)
    {
        dllcall("imgui\ImGuiTableColumn_ImGuiTableColumn")
    }
    
    static ImGuiTableColumn_destroy(param*)
    {
        dllcall("imgui\ImGuiTableColumn_destroy")
    }
    
    static ImGuiTableSettings_GetColumnSettings(param*)
    {
        dllcall("imgui\ImGuiTableSettings_GetColumnSettings")
    }
    
    static ImGuiTableSettings_ImGuiTableSettings(param*)
    {
        dllcall("imgui\ImGuiTableSettings_ImGuiTableSettings")
    }
    
    static ImGuiTableSettings_destroy(param*)
    {
        dllcall("imgui\ImGuiTableSettings_destroy")
    }
    
    static ImGuiTableSortSpecs_ImGuiTableSortSpecs(param*)
    {
        dllcall("imgui\ImGuiTableSortSpecs_ImGuiTableSortSpecs")
    }
    
    static ImGuiTableSortSpecs_destroy(param*)
    {
        dllcall("imgui\ImGuiTableSortSpecs_destroy")
    }
    
    static ImGuiTableTempData_ImGuiTableTempData(param*)
    {
        dllcall("imgui\ImGuiTableTempData_ImGuiTableTempData")
    }
    
    static ImGuiTableTempData_destroy(param*)
    {
        dllcall("imgui\ImGuiTableTempData_destroy")
    }
    
    static ImGuiTable_ImGuiTable(param*)
    {
        dllcall("imgui\ImGuiTable_ImGuiTable")
    }
    
    static ImGuiTable_destroy(param*)
    {
        dllcall("imgui\ImGuiTable_destroy")
    }
    
    static ImGuiTextBuffer_ImGuiTextBuffer(param*)
    {
        dllcall("imgui\ImGuiTextBuffer_ImGuiTextBuffer")
    }
    
    static ImGuiTextBuffer_append(param*)
    {
        dllcall("imgui\ImGuiTextBuffer_append")
    }
    
    static ImGuiTextBuffer_appendf(param*)
    {
        dllcall("imgui\ImGuiTextBuffer_appendf")
    }
    
    static ImGuiTextBuffer_appendfv(param*)
    {
        dllcall("imgui\ImGuiTextBuffer_appendfv")
    }
    
    static ImGuiTextBuffer_begin(param*)
    {
        dllcall("imgui\ImGuiTextBuffer_begin")
    }
    
    static ImGuiTextBuffer_c_str(param*)
    {
        dllcall("imgui\ImGuiTextBuffer_c_str")
    }
    
    static ImGuiTextBuffer_clear(param*)
    {
        dllcall("imgui\ImGuiTextBuffer_clear")
    }
    
    static ImGuiTextBuffer_destroy(param*)
    {
        dllcall("imgui\ImGuiTextBuffer_destroy")
    }
    
    static ImGuiTextBuffer_empty(param*)
    {
        dllcall("imgui\ImGuiTextBuffer_empty")
    }
    
    static ImGuiTextBuffer_end(param*)
    {
        dllcall("imgui\ImGuiTextBuffer_end")
    }
    
    static ImGuiTextBuffer_reserve(param*)
    {
        dllcall("imgui\ImGuiTextBuffer_reserve")
    }
    
    static ImGuiTextBuffer_size(param*)
    {
        dllcall("imgui\ImGuiTextBuffer_size")
    }
    
    static ImGuiTextFilter_Build(param*)
    {
        dllcall("imgui\ImGuiTextFilter_Build")
    }
    
    static ImGuiTextFilter_Clear(param*)
    {
        dllcall("imgui\ImGuiTextFilter_Clear")
    }
    
    static ImGuiTextFilter_Draw(param*)
    {
        dllcall("imgui\ImGuiTextFilter_Draw")
    }
    
    static ImGuiTextFilter_ImGuiTextFilter(param*)
    {
        dllcall("imgui\ImGuiTextFilter_ImGuiTextFilter")
    }
    
    static ImGuiTextFilter_IsActive(param*)
    {
        dllcall("imgui\ImGuiTextFilter_IsActive")
    }
    
    static ImGuiTextFilter_PassFilter(param*)
    {
        dllcall("imgui\ImGuiTextFilter_PassFilter")
    }
    
    static ImGuiTextFilter_destroy(param*)
    {
        dllcall("imgui\ImGuiTextFilter_destroy")
    }
    
    static ImGuiTextRange_ImGuiTextRange_Nil(param*)
    {
        dllcall("imgui\ImGuiTextRange_ImGuiTextRange_Nil")
    }
    
    static ImGuiTextRange_ImGuiTextRange_Str(param*)
    {
        dllcall("imgui\ImGuiTextRange_ImGuiTextRange_Str")
    }
    
    static ImGuiTextRange_destroy(param*)
    {
        dllcall("imgui\ImGuiTextRange_destroy")
    }
    
    static ImGuiTextRange_empty(param*)
    {
        dllcall("imgui\ImGuiTextRange_empty")
    }
    
    static ImGuiTextRange_split(param*)
    {
        dllcall("imgui\ImGuiTextRange_split")
    }
    
    static ImGuiViewportP_CalcWorkRectPos(param*)
    {
        dllcall("imgui\ImGuiViewportP_CalcWorkRectPos")
    }
    
    static ImGuiViewportP_CalcWorkRectSize(param*)
    {
        dllcall("imgui\ImGuiViewportP_CalcWorkRectSize")
    }
    
    static ImGuiViewportP_ClearRequestFlags(param*)
    {
        dllcall("imgui\ImGuiViewportP_ClearRequestFlags")
    }
    
    static ImGuiViewportP_GetBuildWorkRect(param*)
    {
        dllcall("imgui\ImGuiViewportP_GetBuildWorkRect")
    }
    
    static ImGuiViewportP_GetMainRect(param*)
    {
        dllcall("imgui\ImGuiViewportP_GetMainRect")
    }
    
    static ImGuiViewportP_GetWorkRect(param*)
    {
        dllcall("imgui\ImGuiViewportP_GetWorkRect")
    }
    
    static ImGuiViewportP_ImGuiViewportP(param*)
    {
        dllcall("imgui\ImGuiViewportP_ImGuiViewportP")
    }
    
    static ImGuiViewportP_UpdateWorkRect(param*)
    {
        dllcall("imgui\ImGuiViewportP_UpdateWorkRect")
    }
    
    static ImGuiViewportP_destroy(param*)
    {
        dllcall("imgui\ImGuiViewportP_destroy")
    }
    
    static ImGuiViewport_GetCenter(param*)
    {
        dllcall("imgui\ImGuiViewport_GetCenter")
    }
    
    static ImGuiViewport_GetWorkCenter(param*)
    {
        dllcall("imgui\ImGuiViewport_GetWorkCenter")
    }
    
    static ImGuiViewport_ImGuiViewport(param*)
    {
        dllcall("imgui\ImGuiViewport_ImGuiViewport")
    }
    
    static ImGuiViewport_destroy(param*)
    {
        dllcall("imgui\ImGuiViewport_destroy")
    }
    
    static ImGuiWindowClass_ImGuiWindowClass(param*)
    {
        dllcall("imgui\ImGuiWindowClass_ImGuiWindowClass")
    }
    
    static ImGuiWindowClass_destroy(param*)
    {
        dllcall("imgui\ImGuiWindowClass_destroy")
    }
    
    static ImGuiWindowSettings_GetName(param*)
    {
        dllcall("imgui\ImGuiWindowSettings_GetName")
    }
    
    static ImGuiWindowSettings_ImGuiWindowSettings(param*)
    {
        dllcall("imgui\ImGuiWindowSettings_ImGuiWindowSettings")
    }
    
    static ImGuiWindowSettings_destroy(param*)
    {
        dllcall("imgui\ImGuiWindowSettings_destroy")
    }
    
    static ImGuiWindow_CalcFontSize(param*)
    {
        dllcall("imgui\ImGuiWindow_CalcFontSize")
    }
    
    static ImGuiWindow_GetIDFromRectangle(param*)
    {
        dllcall("imgui\ImGuiWindow_GetIDFromRectangle")
    }
    
    static ImGuiWindow_GetIDNoKeepAlive_Int(param*)
    {
        dllcall("imgui\ImGuiWindow_GetIDNoKeepAlive_Int")
    }
    
    static ImGuiWindow_GetIDNoKeepAlive_Ptr(param*)
    {
        dllcall("imgui\ImGuiWindow_GetIDNoKeepAlive_Ptr")
    }
    
    static ImGuiWindow_GetIDNoKeepAlive_Str(param*)
    {
        dllcall("imgui\ImGuiWindow_GetIDNoKeepAlive_Str")
    }
    
    static ImGuiWindow_GetID_Int(param*)
    {
        dllcall("imgui\ImGuiWindow_GetID_Int")
    }
    
    static ImGuiWindow_GetID_Ptr(param*)
    {
        dllcall("imgui\ImGuiWindow_GetID_Ptr")
    }
    
    static ImGuiWindow_GetID_Str(param*)
    {
        dllcall("imgui\ImGuiWindow_GetID_Str")
    }
    
    static ImGuiWindow_ImGuiWindow(param*)
    {
        dllcall("imgui\ImGuiWindow_ImGuiWindow")
    }
    
    static ImGuiWindow_MenuBarHeight(param*)
    {
        dllcall("imgui\ImGuiWindow_MenuBarHeight")
    }
    
    static ImGuiWindow_MenuBarRect(param*)
    {
        dllcall("imgui\ImGuiWindow_MenuBarRect")
    }
    
    static ImGuiWindow_Rect(param*)
    {
        dllcall("imgui\ImGuiWindow_Rect")
    }
    
    static ImGuiWindow_TitleBarHeight(param*)
    {
        dllcall("imgui\ImGuiWindow_TitleBarHeight")
    }
    
    static ImGuiWindow_TitleBarRect(param*)
    {
        dllcall("imgui\ImGuiWindow_TitleBarRect")
    }
    
    static ImGuiWindow_destroy(param*)
    {
        dllcall("imgui\ImGuiWindow_destroy")
    }
    
    static ImRect_Add_Rect(param*)
    {
        dllcall("imgui\ImRect_Add_Rect")
    }
    
    static ImRect_Add_Vec2(param*)
    {
        dllcall("imgui\ImRect_Add_Vec2")
    }
    
    static ImRect_ClipWith(param*)
    {
        dllcall("imgui\ImRect_ClipWith")
    }
    
    static ImRect_ClipWithFull(param*)
    {
        dllcall("imgui\ImRect_ClipWithFull")
    }
    
    static ImRect_Contains_Rect(param*)
    {
        dllcall("imgui\ImRect_Contains_Rect")
    }
    
    static ImRect_Contains_Vec2(param*)
    {
        dllcall("imgui\ImRect_Contains_Vec2")
    }
    
    static ImRect_Expand_Float(param*)
    {
        dllcall("imgui\ImRect_Expand_Float")
    }
    
    static ImRect_Expand_Vec2(param*)
    {
        dllcall("imgui\ImRect_Expand_Vec2")
    }
    
    static ImRect_Floor(param*)
    {
        dllcall("imgui\ImRect_Floor")
    }
    
    static ImRect_GetArea(param*)
    {
        dllcall("imgui\ImRect_GetArea")
    }
    
    static ImRect_GetBL(param*)
    {
        dllcall("imgui\ImRect_GetBL")
    }
    
    static ImRect_GetBR(param*)
    {
        dllcall("imgui\ImRect_GetBR")
    }
    
    static ImRect_GetCenter(param*)
    {
        dllcall("imgui\ImRect_GetCenter")
    }
    
    static ImRect_GetHeight(param*)
    {
        dllcall("imgui\ImRect_GetHeight")
    }
    
    static ImRect_GetSize(param*)
    {
        dllcall("imgui\ImRect_GetSize")
    }
    
    static ImRect_GetTL(param*)
    {
        dllcall("imgui\ImRect_GetTL")
    }
    
    static ImRect_GetTR(param*)
    {
        dllcall("imgui\ImRect_GetTR")
    }
    
    static ImRect_GetWidth(param*)
    {
        dllcall("imgui\ImRect_GetWidth")
    }
    
    static ImRect_ImRect_Float(param*)
    {
        dllcall("imgui\ImRect_ImRect_Float")
    }
    
    static ImRect_ImRect_Nil(param*)
    {
        dllcall("imgui\ImRect_ImRect_Nil")
    }
    
    static ImRect_ImRect_Vec2(param*)
    {
        dllcall("imgui\ImRect_ImRect_Vec2")
    }
    
    static ImRect_ImRect_Vec4(param*)
    {
        dllcall("imgui\ImRect_ImRect_Vec4")
    }
    
    static ImRect_IsInverted(param*)
    {
        dllcall("imgui\ImRect_IsInverted")
    }
    
    static ImRect_Overlaps(param*)
    {
        dllcall("imgui\ImRect_Overlaps")
    }
    
    static ImRect_ToVec4(param*)
    {
        dllcall("imgui\ImRect_ToVec4")
    }
    
    static ImRect_Translate(param*)
    {
        dllcall("imgui\ImRect_Translate")
    }
    
    static ImRect_TranslateX(param*)
    {
        dllcall("imgui\ImRect_TranslateX")
    }
    
    static ImRect_TranslateY(param*)
    {
        dllcall("imgui\ImRect_TranslateY")
    }
    
    static ImRect_destroy(param*)
    {
        dllcall("imgui\ImRect_destroy")
    }
    
    static ImVec1_ImVec1_Float(param*)
    {
        dllcall("imgui\ImVec1_ImVec1_Float")
    }
    
    static ImVec1_ImVec1_Nil(param*)
    {
        dllcall("imgui\ImVec1_ImVec1_Nil")
    }
    
    static ImVec1_destroy(param*)
    {
        dllcall("imgui\ImVec1_destroy")
    }
    
    static ImVec2_ImVec2_Float(param*)
    {
        dllcall("imgui\ImVec2_ImVec2_Float")
    }
    
    static ImVec2_ImVec2_Nil(param*)
    {
        dllcall("imgui\ImVec2_ImVec2_Nil")
    }
    
    static ImVec2_destroy(param*)
    {
        dllcall("imgui\ImVec2_destroy")
    }
    
    static ImVec2ih_ImVec2ih_Nil(param*)
    {
        dllcall("imgui\ImVec2ih_ImVec2ih_Nil")
    }
    
    static ImVec2ih_ImVec2ih_Vec2(param*)
    {
        dllcall("imgui\ImVec2ih_ImVec2ih_Vec2")
    }
    
    static ImVec2ih_ImVec2ih_short(param*)
    {
        dllcall("imgui\ImVec2ih_ImVec2ih_short")
    }
    
    static ImVec2ih_destroy(param*)
    {
        dllcall("imgui\ImVec2ih_destroy")
    }
    
    static ImVec4_ImVec4_Float(param*)
    {
        dllcall("imgui\ImVec4_ImVec4_Float")
    }
    
    static ImVec4_ImVec4_Nil(param*)
    {
        dllcall("imgui\ImVec4_ImVec4_Nil")
    }
    
    static ImVec4_destroy(param*)
    {
        dllcall("imgui\ImVec4_destroy")
    }
    
    static ImVector_ImWchar_Init(param*)
    {
        dllcall("imgui\ImVector_ImWchar_Init")
    }
    
    static ImVector_ImWchar_UnInit(param*)
    {
        dllcall("imgui\ImVector_ImWchar_UnInit")
    }
    
    static ImVector_ImWchar_create(param*)
    {
        dllcall("imgui\ImVector_ImWchar_create")
    }
    
    static ImVector_ImWchar_destroy(param*)
    {
        dllcall("imgui\ImVector_ImWchar_destroy")
    }
    
    static Image(param*)
    {
        dllcall("imgui\Image")
    }
    
    static ImageButton(param*)
    {
        dllcall("imgui\ImageButton")
    }
    
    static ImageFit(param*)
    {
        dllcall("imgui\ImageFit")
    }
    
    static ImageFromFile(param*)
    {
        dllcall("imgui\ImageFromFile")
    }
    
    static ImageFromURL(param*)
    {
        dllcall("imgui\ImageFromURL")
    }
    
    static ImageGetSize(param*)
    {
        dllcall("imgui\ImageGetSize")
    }
    
    static Indent(param*)
    {
        dllcall("imgui\Indent")
    }
    
    static InputDouble(param*)
    {
        dllcall("imgui\InputDouble")
    }
    
    static InputFloat(param*)
    {
        dllcall("imgui\InputFloat")
    }
    
    static InputFloatN(param*)
    {
        dllcall("imgui\InputFloatN")
    }
    
    static InputInt(param*)
    {
        dllcall("imgui\InputInt")
    }
    
    static InputIntN(param*)
    {
        dllcall("imgui\InputIntN")
    }
    
    static InputText(param*)
    {
        dllcall("imgui\InputText")
    }
    
    static InputTextMultiline(param*)
    {
        dllcall("imgui\InputTextMultiline")
    }
    
    static InputTextWithHint(param*)
    {
        dllcall("imgui\InputTextWithHint")
    }
    
    static InvisibleButton(param*)
    {
        dllcall("imgui\InvisibleButton")
    }
    
    static IsAnyItemActive(param*)
    {
        dllcall("imgui\IsAnyItemActive")
    }
    
    static IsAnyItemFocused(param*)
    {
        dllcall("imgui\IsAnyItemFocused")
    }
    
    static IsAnyItemHovered(param*)
    {
        dllcall("imgui\IsAnyItemHovered")
    }
    
    static IsAnyMouseDown(param*)
    {
        dllcall("imgui\IsAnyMouseDown")
    }
    
    static IsItemActivated(param*)
    {
        dllcall("imgui\IsItemActivated")
    }
    
    static IsItemActive(param*)
    {
        dllcall("imgui\IsItemActive")
    }
    
    static IsItemClicked(param*)
    {
        dllcall("imgui\IsItemClicked")
    }
    
    static IsItemDeactivated(param*)
    {
        dllcall("imgui\IsItemDeactivated")
    }
    
    static IsItemDeactivatedAfterEdit(param*)
    {
        dllcall("imgui\IsItemDeactivatedAfterEdit")
    }
    
    static IsItemEdited(param*)
    {
        dllcall("imgui\IsItemEdited")
    }
    
    static IsItemFocused(param*)
    {
        dllcall("imgui\IsItemFocused")
    }
    
    static IsItemHovered(param*)
    {
        dllcall("imgui\IsItemHovered")
    }
    
    static IsItemToggledOpen(param*)
    {
        dllcall("imgui\IsItemToggledOpen")
    }
    
    static IsItemVisible(param*)
    {
        dllcall("imgui\IsItemVisible")
    }
    
    static IsKeyDown(param*)
    {
        dllcall("imgui\IsKeyDown")
    }
    
    static IsKeyPressed(param*)
    {
        dllcall("imgui\IsKeyPressed")
    }
    
    static IsKeyReleased(param*)
    {
        dllcall("imgui\IsKeyReleased")
    }
    
    static IsMouseClicked(param*)
    {
        dllcall("imgui\IsMouseClicked")
    }
    
    static IsMouseDown(param*)
    {
        dllcall("imgui\IsMouseDown")
    }
    
    static IsMouseDragging(param*)
    {
        dllcall("imgui\IsMouseDragging")
    }
    
    static IsMouseHoveringRect(param*)
    {
        dllcall("imgui\IsMouseHoveringRect")
    }
    
    static IsMousePosValid(param*)
    {
        dllcall("imgui\IsMousePosValid")
    }
    
    static IsMouseReleased(param*)
    {
        dllcall("imgui\IsMouseReleased")
    }
    
    static IsPopupOpen(param*)
    {
        dllcall("imgui\IsPopupOpen")
    }
    
    static IsRectVisible(param*)
    {
        dllcall("imgui\IsRectVisible")
    }
    
    static IsRectVisibleEx(param*)
    {
        dllcall("imgui\IsRectVisibleEx")
    }
    
    static IsWindowAppearing(param*)
    {
        dllcall("imgui\IsWindowAppearing")
    }
    
    static IsWindowCollapsed(param*)
    {
        dllcall("imgui\IsWindowCollapsed")
    }
    
    static IsWindowDocked(param*)
    {
        dllcall("imgui\IsWindowDocked")
    }
    
    static IsWindowFocused(param*)
    {
        dllcall("imgui\IsWindowFocused")
    }
    
    static IsWindowHovered(param*)
    {
        dllcall("imgui\IsWindowHovered")
    }
    
    static LabelText(param*)
    {
        dllcall("imgui\LabelText")
    }
    
    static ListBox(param*)
    {
        dllcall("imgui\ListBox")
    }
    
    static ListBoxFooter(param*)
    {
        dllcall("imgui\ListBoxFooter")
    }
    
    static ListBoxHeader(param*)
    {
        dllcall("imgui\ListBoxHeader")
    }
    
    static ListBoxHeaderEx(param*)
    {
        dllcall("imgui\ListBoxHeaderEx")
    }
    
    static LoadFont(param*)
    {
        dllcall("imgui\LoadFont")
    }
    
    static LoadIniSettingsFromDisk(param*)
    {
        dllcall("imgui\LoadIniSettingsFromDisk")
    }
    
    static LoadTextureFromFile(param*)
    {
        dllcall("imgui\LoadTextureFromFile")
    }
    
    static LoadTextureFromMemory(param*)
    {
        dllcall("imgui\LoadTextureFromMemory")
    }
    
    static MenuItem(param*)
    {
        dllcall("imgui\MenuItem")
    }
    
    static MenuItemEx(param*)
    {
        dllcall("imgui\MenuItemEx")
    }
    
    static NewLine(param*)
    {
        dllcall("imgui\NewLine")
    }
    
    static NextColumn(param*)
    {
        dllcall("imgui\NextColumn")
    }
    
    static OpenPopup(param*)
    {
        dllcall("imgui\OpenPopup")
    }
    
    static OpenPopupContextItem(param*)
    {
        dllcall("imgui\OpenPopupContextItem")
    }
    
    static PathArcTo(param*)
    {
        dllcall("imgui\PathArcTo")
    }
    
    static PathArcToFast(param*)
    {
        dllcall("imgui\PathArcToFast")
    }
    
    static PathBezierCurveTo(param*)
    {
        dllcall("imgui\PathBezierCurveTo")
    }
    
    static PathClear(param*)
    {
        dllcall("imgui\PathClear")
    }
    
    static PathFillConvex(param*)
    {
        dllcall("imgui\PathFillConvex")
    }
    
    static PathLineTo(param*)
    {
        dllcall("imgui\PathLineTo")
    }
    
    static PathLineToMergeDuplicate(param*)
    {
        dllcall("imgui\PathLineToMergeDuplicate")
    }
    
    static PathRect(param*)
    {
        dllcall("imgui\PathRect")
    }
    
    static PathStroke(param*)
    {
        dllcall("imgui\PathStroke")
    }
    
    static PeekMsg(param*)
    {
        dllcall("imgui\PeekMsg")
    }
    
    static PlotHistogram(param*)
    {
        dllcall("imgui\PlotHistogram")
    }
    
    static PlotLines(param*)
    {
        dllcall("imgui\PlotLines")
    }
    
    static PopAllowKeyboardFocus(param*)
    {
        dllcall("imgui\PopAllowKeyboardFocus")
    }
    
    static PopButtonRepeat(param*)
    {
        dllcall("imgui\PopButtonRepeat")
    }
    
    static PopClipRect(param*)
    {
        dllcall("imgui\PopClipRect")
    }
    
    static PopFont(param*)
    {
        dllcall("imgui\PopFont")
    }
    
    static PopID(param*)
    {
        dllcall("imgui\PopID")
    }
    
    static PopItemWidth(param*)
    {
        dllcall("imgui\PopItemWidth")
    }
    
    static PopStyleColor(param*)
    {
        dllcall("imgui\PopStyleColor")
    }
    
    static PopStyleVar(param*)
    {
        dllcall("imgui\PopStyleVar")
    }
    
    static PopTextWrapPos(param*)
    {
        dllcall("imgui\PopTextWrapPos")
    }
    
    static ProgressBar(param*)
    {
        dllcall("imgui\ProgressBar")
    }
    
    static PushAllowKeyboardFocus(param*)
    {
        dllcall("imgui\PushAllowKeyboardFocus")
    }
    
    static PushButtonRepeat(param*)
    {
        dllcall("imgui\PushButtonRepeat")
    }
    
    static PushClipRect(param*)
    {
        dllcall("imgui\PushClipRect")
    }
    
    static PushFont(param*)
    {
        dllcall("imgui\PushFont")
    }
    
    static PushID(param*)
    {
        dllcall("imgui\PushID")
    }
    
    static PushItemWidth(param*)
    {
        dllcall("imgui\PushItemWidth")
    }
    
    static PushStyleColor(param*)
    {
        dllcall("imgui\PushStyleColor")
    }
    
    static PushStyleVar(param*)
    {
        dllcall("imgui\PushStyleVar")
    }
    
    static PushStyleVarPos(param*)
    {
        dllcall("imgui\PushStyleVarPos")
    }
    
    static PushTextWrapPos(param*)
    {
        dllcall("imgui\PushTextWrapPos")
    }
    
    static RadioButton(param*)
    {
        dllcall("imgui\RadioButton")
    }
    
    static RenderPlatformWindowsDefault(param*)
    {
        dllcall("imgui\RenderPlatformWindowsDefault")
    }
    
    static ResetMouseDragDelta(param*)
    {
        dllcall("imgui\ResetMouseDragDelta")
    }
    
    static SameLine(param*)
    {
        dllcall("imgui\SameLine")
    }
    
    static SaveIniSettingsToDisk(param*)
    {
        dllcall("imgui\SaveIniSettingsToDisk")
    }
    
    static Selectable(param*)
    {
        dllcall("imgui\Selectable")
    }
    
    static Separator(param*)
    {
        dllcall("imgui\Separator")
    }
    
    static SetColumnOffset(param*)
    {
        dllcall("imgui\SetColumnOffset")
    }
    
    static SetColumnWidth(param*)
    {
        dllcall("imgui\SetColumnWidth")
    }
    
    static SetCursorPosX(param*)
    {
        dllcall("imgui\SetCursorPosX")
    }
    
    static SetCursorPosY(param*)
    {
        dllcall("imgui\SetCursorPosY")
    }
    
    static SetCursorPosition(param*)
    {
        dllcall("imgui\SetCursorPosition")
    }
    
    static SetCursorScreenPos(param*)
    {
        dllcall("imgui\SetCursorScreenPos")
    }
    
    static SetItemAllowOverlap(param*)
    {
        dllcall("imgui\SetItemAllowOverlap")
    }
    
    static SetItemDefaultFocus(param*)
    {
        dllcall("imgui\SetItemDefaultFocus")
    }
    
    static SetKeyboardFocusHere(param*)
    {
        dllcall("imgui\SetKeyboardFocusHere")
    }
    
    static SetMouseCursor(param*)
    {
        dllcall("imgui\SetMouseCursor")
    }
    
    static SetNextItemOpen(param*)
    {
        dllcall("imgui\SetNextItemOpen")
    }
    
    static SetNextItemWidth(param*)
    {
        dllcall("imgui\SetNextItemWidth")
    }
    
    static SetNextWindowBgAlpha(param*)
    {
        dllcall("imgui\SetNextWindowBgAlpha")
    }
    
    static SetNextWindowClass(param*)
    {
        dllcall("imgui\SetNextWindowClass")
    }
    
    static SetNextWindowCollapsed(param*)
    {
        dllcall("imgui\SetNextWindowCollapsed")
    }
    
    static SetNextWindowContentSize(param*)
    {
        dllcall("imgui\SetNextWindowContentSize")
    }
    
    static SetNextWindowDockID(param*)
    {
        dllcall("imgui\SetNextWindowDockID")
    }
    
    static SetNextWindowFocus(param*)
    {
        dllcall("imgui\SetNextWindowFocus")
    }
    
    static SetNextWindowPos(param*)
    {
        dllcall("imgui\SetNextWindowPos")
    }
    
    static SetNextWindowSize(param*)
    {
        dllcall("imgui\SetNextWindowSize")
    }
    
    static SetNextWindowSizeConstraints(param*)
    {
        dllcall("imgui\SetNextWindowSizeConstraints")
    }
    
    static SetNextWindowViewport(param*)
    {
        dllcall("imgui\SetNextWindowViewport")
    }
    
    static SetScrollFromPosX(param*)
    {
        dllcall("imgui\SetScrollFromPosX")
    }
    
    static SetScrollFromPosY(param*)
    {
        dllcall("imgui\SetScrollFromPosY")
    }
    
    static SetScrollHereX(param*)
    {
        dllcall("imgui\SetScrollHereX")
    }
    
    static SetScrollHereY(param*)
    {
        dllcall("imgui\SetScrollHereY")
    }
    
    static SetScrollX(param*)
    {
        dllcall("imgui\SetScrollX")
    }
    
    static SetScrollY(param*)
    {
        dllcall("imgui\SetScrollY")
    }
    
    static SetStyleColor(param*)
    {
        dllcall("imgui\SetStyleColor")
    }
    
    static SetTabItemClosed(param*)
    {
        dllcall("imgui\SetTabItemClosed")
    }
    
    static SetTooltip(param*)
    {
        dllcall("imgui\SetTooltip")
    }
    
    static SetWindowCollapsed(param*)
    {
        dllcall("imgui\SetWindowCollapsed")
    }
    
    static SetWindowCollapsedByName(param*)
    {
        dllcall("imgui\SetWindowCollapsedByName")
    }
    
    static SetWindowFocus(param*)
    {
        dllcall("imgui\SetWindowFocus")
    }
    
    static SetWindowFocusByName(param*)
    {
        dllcall("imgui\SetWindowFocusByName")
    }
    
    static SetWindowFontScale(param*)
    {
        dllcall("imgui\SetWindowFontScale")
    }
    
    static SetWindowPosByName(param*)
    {
        dllcall("imgui\SetWindowPosByName")
    }
    
    static SetWindowPosition(param*)
    {
        dllcall("imgui\SetWindowPosition")
    }
    
    static SetWindowSize(param*)
    {
        dllcall("imgui\SetWindowSize")
    }
    
    static SetWindowSizeByName(param*)
    {
        dllcall("imgui\SetWindowSizeByName")
    }
    
    static ShowDemoWindow(param*)
    {
        dllcall("imgui\ShowDemoWindow")
    }
    
    static ShutDown(param*)
    {
        dllcall("imgui\ShutDown")
    }
    
    static SliderAngle(param*)
    {
        dllcall("imgui\SliderAngle")
    }
    
    static SliderFloat(param*)
    {
        dllcall("imgui\SliderFloat")
    }
    
    static SliderFloatN(param*)
    {
        dllcall("imgui\SliderFloatN")
    }
    
    static SliderInt(param*)
    {
        dllcall("imgui\SliderInt")
    }
    
    static SliderIntN(param*)
    {
        dllcall("imgui\SliderIntN")
    }
    
    static SmallButton(param*)
    {
        dllcall("imgui\SmallButton")
    }
    
    static Spacing(param*)
    {
        dllcall("imgui\Spacing")
    }
    
    static StyleColorsClassic(param*)
    {
        dllcall("imgui\StyleColorsClassic")
    }
    
    static StyleColorsDark(param*)
    {
        dllcall("imgui\StyleColorsDark")
    }
    
    static StyleColorsLight(param*)
    {
        dllcall("imgui\StyleColorsLight")
    }
    
    static Text(param*)
    {
        dllcall("imgui\Text")
    }
    
    static TextColored(param*)
    {
        dllcall("imgui\TextColored")
    }
    
    static TextDisabled(param*)
    {
        dllcall("imgui\TextDisabled")
    }
    
    static TextWrapped(param*)
    {
        dllcall("imgui\TextWrapped")
    }
    
    static TextureFree(param*)
    {
        dllcall("imgui\TextureFree")
    }
    
    static TreeNode(param*)
    {
        dllcall("imgui\TreeNode")
    }
    
    static TreeNodeEx(param*)
    {
        dllcall("imgui\TreeNodeEx")
    }
    
    static TreePop(param*)
    {
        dllcall("imgui\TreePop")
    }
    
    static TreePush(param*)
    {
        dllcall("imgui\TreePush")
    }
    
    static Unindent(param*)
    {
        dllcall("imgui\Unindent")
    }
    
    static UpdatePlatformWindows(param*)
    {
        dllcall("imgui\UpdatePlatformWindows")
    }
    
    static VSliderFloat(param*)
    {
        dllcall("imgui\VSliderFloat")
    }
    
    static VSliderInt(param*)
    {
        dllcall("imgui\VSliderInt")
    }
    
    static ValueBool(param*)
    {
        dllcall("imgui\ValueBool")
    }
    
    static ValueFloat(param*)
    {
        dllcall("imgui\ValueFloat")
    }
    
    static ValueInt(param*)
    {
        dllcall("imgui\ValueInt")
    }
    
    static igAcceptDragDropPayload(param*)
    {
        dllcall("imgui\igAcceptDragDropPayload")
    }
    
    static igActivateItem(param*)
    {
        dllcall("imgui\igActivateItem")
    }
    
    static igAddContextHook(param*)
    {
        dllcall("imgui\igAddContextHook")
    }
    
    static igAlignTextToFramePadding(param*)
    {
        dllcall("imgui\igAlignTextToFramePadding")
    }
    
    static igArrowButton(param*)
    {
        dllcall("imgui\igArrowButton")
    }
    
    static igArrowButtonEx(param*)
    {
        dllcall("imgui\igArrowButtonEx")
    }
    
    static igBegin(param*)
    {
        dllcall("imgui\igBegin")
    }
    
    static igBeginChildEx(param*)
    {
        dllcall("imgui\igBeginChildEx")
    }
    
    static igBeginChildFrame(param*)
    {
        dllcall("imgui\igBeginChildFrame")
    }
    
    static igBeginChild_ID(param*)
    {
        dllcall("imgui\igBeginChild_ID")
    }
    
    static igBeginChild_Str(param*)
    {
        dllcall("imgui\igBeginChild_Str")
    }
    
    static igBeginColumns(param*)
    {
        dllcall("imgui\igBeginColumns")
    }
    
    static igBeginCombo(param*)
    {
        dllcall("imgui\igBeginCombo")
    }
    
    static igBeginComboPopup(param*)
    {
        dllcall("imgui\igBeginComboPopup")
    }
    
    static igBeginComboPreview(param*)
    {
        dllcall("imgui\igBeginComboPreview")
    }
    
    static igBeginDisabled(param*)
    {
        dllcall("imgui\igBeginDisabled")
    }
    
    static igBeginDockableDragDropSource(param*)
    {
        dllcall("imgui\igBeginDockableDragDropSource")
    }
    
    static igBeginDockableDragDropTarget(param*)
    {
        dllcall("imgui\igBeginDockableDragDropTarget")
    }
    
    static igBeginDocked(param*)
    {
        dllcall("imgui\igBeginDocked")
    }
    
    static igBeginDragDropSource(param*)
    {
        dllcall("imgui\igBeginDragDropSource")
    }
    
    static igBeginDragDropTarget(param*)
    {
        dllcall("imgui\igBeginDragDropTarget")
    }
    
    static igBeginDragDropTargetCustom(param*)
    {
        dllcall("imgui\igBeginDragDropTargetCustom")
    }
    
    static igBeginGroup(param*)
    {
        dllcall("imgui\igBeginGroup")
    }
    
    static igBeginListBox(param*)
    {
        dllcall("imgui\igBeginListBox")
    }
    
    static igBeginMainMenuBar(param*)
    {
        dllcall("imgui\igBeginMainMenuBar")
    }
    
    static igBeginMenu(param*)
    {
        dllcall("imgui\igBeginMenu")
    }
    
    static igBeginMenuBar(param*)
    {
        dllcall("imgui\igBeginMenuBar")
    }
    
    static igBeginMenuEx(param*)
    {
        dllcall("imgui\igBeginMenuEx")
    }
    
    static igBeginPopup(param*)
    {
        dllcall("imgui\igBeginPopup")
    }
    
    static igBeginPopupContextItem(param*)
    {
        dllcall("imgui\igBeginPopupContextItem")
    }
    
    static igBeginPopupContextVoid(param*)
    {
        dllcall("imgui\igBeginPopupContextVoid")
    }
    
    static igBeginPopupContextWindow(param*)
    {
        dllcall("imgui\igBeginPopupContextWindow")
    }
    
    static igBeginPopupEx(param*)
    {
        dllcall("imgui\igBeginPopupEx")
    }
    
    static igBeginPopupModal(param*)
    {
        dllcall("imgui\igBeginPopupModal")
    }
    
    static igBeginTabBar(param*)
    {
        dllcall("imgui\igBeginTabBar")
    }
    
    static igBeginTabBarEx(param*)
    {
        dllcall("imgui\igBeginTabBarEx")
    }
    
    static igBeginTabItem(param*)
    {
        dllcall("imgui\igBeginTabItem")
    }
    
    static igBeginTable(param*)
    {
        dllcall("imgui\igBeginTable")
    }
    
    static igBeginTableEx(param*)
    {
        dllcall("imgui\igBeginTableEx")
    }
    
    static igBeginTooltip(param*)
    {
        dllcall("imgui\igBeginTooltip")
    }
    
    static igBeginTooltipEx(param*)
    {
        dllcall("imgui\igBeginTooltipEx")
    }
    
    static igBeginViewportSideBar(param*)
    {
        dllcall("imgui\igBeginViewportSideBar")
    }
    
    static igBringWindowToDisplayBack(param*)
    {
        dllcall("imgui\igBringWindowToDisplayBack")
    }
    
    static igBringWindowToDisplayBehind(param*)
    {
        dllcall("imgui\igBringWindowToDisplayBehind")
    }
    
    static igBringWindowToDisplayFront(param*)
    {
        dllcall("imgui\igBringWindowToDisplayFront")
    }
    
    static igBringWindowToFocusFront(param*)
    {
        dllcall("imgui\igBringWindowToFocusFront")
    }
    
    static igBullet(param*)
    {
        dllcall("imgui\igBullet")
    }
    
    static igBulletText(param*)
    {
        dllcall("imgui\igBulletText")
    }
    
    static igBulletTextV(param*)
    {
        dllcall("imgui\igBulletTextV")
    }
    
    static igButton(param*)
    {
        dllcall("imgui\igButton")
    }
    
    static igButtonBehavior(param*)
    {
        dllcall("imgui\igButtonBehavior")
    }
    
    static igButtonEx(param*)
    {
        dllcall("imgui\igButtonEx")
    }
    
    static igCalcItemSize(param*)
    {
        dllcall("imgui\igCalcItemSize")
    }
    
    static igCalcItemWidth(param*)
    {
        dllcall("imgui\igCalcItemWidth")
    }
    
    static igCalcRoundingFlagsForRectInRect(param*)
    {
        dllcall("imgui\igCalcRoundingFlagsForRectInRect")
    }
    
    static igCalcTextSize(param*)
    {
        dllcall("imgui\igCalcTextSize")
    }
    
    static igCalcTypematicRepeatAmount(param*)
    {
        dllcall("imgui\igCalcTypematicRepeatAmount")
    }
    
    static igCalcWindowNextAutoFitSize(param*)
    {
        dllcall("imgui\igCalcWindowNextAutoFitSize")
    }
    
    static igCalcWrapWidthForPos(param*)
    {
        dllcall("imgui\igCalcWrapWidthForPos")
    }
    
    static igCallContextHooks(param*)
    {
        dllcall("imgui\igCallContextHooks")
    }
    
    static igCaptureKeyboardFromApp(param*)
    {
        dllcall("imgui\igCaptureKeyboardFromApp")
    }
    
    static igCaptureMouseFromApp(param*)
    {
        dllcall("imgui\igCaptureMouseFromApp")
    }
    
    static igCheckbox(param*)
    {
        dllcall("imgui\igCheckbox")
    }
    
    static igCheckboxFlags_IntPtr(param*)
    {
        dllcall("imgui\igCheckboxFlags_IntPtr")
    }
    
    static igCheckboxFlags_S64Ptr(param*)
    {
        dllcall("imgui\igCheckboxFlags_S64Ptr")
    }
    
    static igCheckboxFlags_U64Ptr(param*)
    {
        dllcall("imgui\igCheckboxFlags_U64Ptr")
    }
    
    static igCheckboxFlags_UintPtr(param*)
    {
        dllcall("imgui\igCheckboxFlags_UintPtr")
    }
    
    static igClearActiveID(param*)
    {
        dllcall("imgui\igClearActiveID")
    }
    
    static igClearDragDrop(param*)
    {
        dllcall("imgui\igClearDragDrop")
    }
    
    static igClearIniSettings(param*)
    {
        dllcall("imgui\igClearIniSettings")
    }
    
    static igCloseButton(param*)
    {
        dllcall("imgui\igCloseButton")
    }
    
    static igCloseCurrentPopup(param*)
    {
        dllcall("imgui\igCloseCurrentPopup")
    }
    
    static igClosePopupToLevel(param*)
    {
        dllcall("imgui\igClosePopupToLevel")
    }
    
    static igClosePopupsExceptModals(param*)
    {
        dllcall("imgui\igClosePopupsExceptModals")
    }
    
    static igClosePopupsOverWindow(param*)
    {
        dllcall("imgui\igClosePopupsOverWindow")
    }
    
    static igCollapseButton(param*)
    {
        dllcall("imgui\igCollapseButton")
    }
    
    static igCollapsingHeader_BoolPtr(param*)
    {
        dllcall("imgui\igCollapsingHeader_BoolPtr")
    }
    
    static igCollapsingHeader_TreeNodeFlags(param*)
    {
        dllcall("imgui\igCollapsingHeader_TreeNodeFlags")
    }
    
    static igColorButton(param*)
    {
        dllcall("imgui\igColorButton")
    }
    
    static igColorConvertFloat4ToU32(param*)
    {
        dllcall("imgui\igColorConvertFloat4ToU32")
    }
    
    static igColorConvertHSVtoRGB(param*)
    {
        dllcall("imgui\igColorConvertHSVtoRGB")
    }
    
    static igColorConvertRGBtoHSV(param*)
    {
        dllcall("imgui\igColorConvertRGBtoHSV")
    }
    
    static igColorConvertU32ToFloat4(param*)
    {
        dllcall("imgui\igColorConvertU32ToFloat4")
    }
    
    static igColorEdit3(param*)
    {
        dllcall("imgui\igColorEdit3")
    }
    
    static igColorEdit4(param*)
    {
        dllcall("imgui\igColorEdit4")
    }
    
    static igColorEditOptionsPopup(param*)
    {
        dllcall("imgui\igColorEditOptionsPopup")
    }
    
    static igColorPicker3(param*)
    {
        dllcall("imgui\igColorPicker3")
    }
    
    static igColorPicker4(param*)
    {
        dllcall("imgui\igColorPicker4")
    }
    
    static igColorPickerOptionsPopup(param*)
    {
        dllcall("imgui\igColorPickerOptionsPopup")
    }
    
    static igColorTooltip(param*)
    {
        dllcall("imgui\igColorTooltip")
    }
    
    static igColumns(param*)
    {
        dllcall("imgui\igColumns")
    }
    
    static igCombo_FnBoolPtr(param*)
    {
        dllcall("imgui\igCombo_FnBoolPtr")
    }
    
    static igCombo_Str(param*)
    {
        dllcall("imgui\igCombo_Str")
    }
    
    static igCombo_Str_arr(param*)
    {
        dllcall("imgui\igCombo_Str_arr")
    }
    
    static igCreateContext(param*)
    {
        dllcall("imgui\igCreateContext")
    }
    
    static igCreateNewWindowSettings(param*)
    {
        dllcall("imgui\igCreateNewWindowSettings")
    }
    
    static igDataTypeApplyFromText(param*)
    {
        dllcall("imgui\igDataTypeApplyFromText")
    }
    
    static igDataTypeApplyOp(param*)
    {
        dllcall("imgui\igDataTypeApplyOp")
    }
    
    static igDataTypeClamp(param*)
    {
        dllcall("imgui\igDataTypeClamp")
    }
    
    static igDataTypeCompare(param*)
    {
        dllcall("imgui\igDataTypeCompare")
    }
    
    static igDataTypeFormatString(param*)
    {
        dllcall("imgui\igDataTypeFormatString")
    }
    
    static igDataTypeGetInfo(param*)
    {
        dllcall("imgui\igDataTypeGetInfo")
    }
    
    static igDebugCheckVersionAndDataLayout(param*)
    {
        dllcall("imgui\igDebugCheckVersionAndDataLayout")
    }
    
    static igDebugDrawItemRect(param*)
    {
        dllcall("imgui\igDebugDrawItemRect")
    }
    
    static igDebugHookIdInfo(param*)
    {
        dllcall("imgui\igDebugHookIdInfo")
    }
    
    static igDebugNodeColumns(param*)
    {
        dllcall("imgui\igDebugNodeColumns")
    }
    
    static igDebugNodeDockNode(param*)
    {
        dllcall("imgui\igDebugNodeDockNode")
    }
    
    static igDebugNodeDrawCmdShowMeshAndBoundingBox(param*)
    {
        dllcall("imgui\igDebugNodeDrawCmdShowMeshAndBoundingBox")
    }
    
    static igDebugNodeDrawList(param*)
    {
        dllcall("imgui\igDebugNodeDrawList")
    }
    
    static igDebugNodeFont(param*)
    {
        dllcall("imgui\igDebugNodeFont")
    }
    
    static igDebugNodeStorage(param*)
    {
        dllcall("imgui\igDebugNodeStorage")
    }
    
    static igDebugNodeTabBar(param*)
    {
        dllcall("imgui\igDebugNodeTabBar")
    }
    
    static igDebugNodeTable(param*)
    {
        dllcall("imgui\igDebugNodeTable")
    }
    
    static igDebugNodeTableSettings(param*)
    {
        dllcall("imgui\igDebugNodeTableSettings")
    }
    
    static igDebugNodeViewport(param*)
    {
        dllcall("imgui\igDebugNodeViewport")
    }
    
    static igDebugNodeWindow(param*)
    {
        dllcall("imgui\igDebugNodeWindow")
    }
    
    static igDebugNodeWindowSettings(param*)
    {
        dllcall("imgui\igDebugNodeWindowSettings")
    }
    
    static igDebugNodeWindowsList(param*)
    {
        dllcall("imgui\igDebugNodeWindowsList")
    }
    
    static igDebugNodeWindowsListByBeginStackParent(param*)
    {
        dllcall("imgui\igDebugNodeWindowsListByBeginStackParent")
    }
    
    static igDebugRenderViewportThumbnail(param*)
    {
        dllcall("imgui\igDebugRenderViewportThumbnail")
    }
    
    static igDebugStartItemPicker(param*)
    {
        dllcall("imgui\igDebugStartItemPicker")
    }
    
    static igDestroyContext(param*)
    {
        dllcall("imgui\igDestroyContext")
    }
    
    static igDestroyPlatformWindow(param*)
    {
        dllcall("imgui\igDestroyPlatformWindow")
    }
    
    static igDestroyPlatformWindows(param*)
    {
        dllcall("imgui\igDestroyPlatformWindows")
    }
    
    static igDockBuilderAddNode(param*)
    {
        dllcall("imgui\igDockBuilderAddNode")
    }
    
    static igDockBuilderCopyDockSpace(param*)
    {
        dllcall("imgui\igDockBuilderCopyDockSpace")
    }
    
    static igDockBuilderCopyNode(param*)
    {
        dllcall("imgui\igDockBuilderCopyNode")
    }
    
    static igDockBuilderCopyWindowSettings(param*)
    {
        dllcall("imgui\igDockBuilderCopyWindowSettings")
    }
    
    static igDockBuilderDockWindow(param*)
    {
        dllcall("imgui\igDockBuilderDockWindow")
    }
    
    static igDockBuilderFinish(param*)
    {
        dllcall("imgui\igDockBuilderFinish")
    }
    
    static igDockBuilderGetCentralNode(param*)
    {
        dllcall("imgui\igDockBuilderGetCentralNode")
    }
    
    static igDockBuilderGetNode(param*)
    {
        dllcall("imgui\igDockBuilderGetNode")
    }
    
    static igDockBuilderRemoveNode(param*)
    {
        dllcall("imgui\igDockBuilderRemoveNode")
    }
    
    static igDockBuilderRemoveNodeChildNodes(param*)
    {
        dllcall("imgui\igDockBuilderRemoveNodeChildNodes")
    }
    
    static igDockBuilderRemoveNodeDockedWindows(param*)
    {
        dllcall("imgui\igDockBuilderRemoveNodeDockedWindows")
    }
    
    static igDockBuilderSetNodePos(param*)
    {
        dllcall("imgui\igDockBuilderSetNodePos")
    }
    
    static igDockBuilderSetNodeSize(param*)
    {
        dllcall("imgui\igDockBuilderSetNodeSize")
    }
    
    static igDockBuilderSplitNode(param*)
    {
        dllcall("imgui\igDockBuilderSplitNode")
    }
    
    static igDockContextCalcDropPosForDocking(param*)
    {
        dllcall("imgui\igDockContextCalcDropPosForDocking")
    }
    
    static igDockContextClearNodes(param*)
    {
        dllcall("imgui\igDockContextClearNodes")
    }
    
    static igDockContextEndFrame(param*)
    {
        dllcall("imgui\igDockContextEndFrame")
    }
    
    static igDockContextGenNodeID(param*)
    {
        dllcall("imgui\igDockContextGenNodeID")
    }
    
    static igDockContextInitialize(param*)
    {
        dllcall("imgui\igDockContextInitialize")
    }
    
    static igDockContextNewFrameUpdateDocking(param*)
    {
        dllcall("imgui\igDockContextNewFrameUpdateDocking")
    }
    
    static igDockContextNewFrameUpdateUndocking(param*)
    {
        dllcall("imgui\igDockContextNewFrameUpdateUndocking")
    }
    
    static igDockContextQueueDock(param*)
    {
        dllcall("imgui\igDockContextQueueDock")
    }
    
    static igDockContextQueueUndockNode(param*)
    {
        dllcall("imgui\igDockContextQueueUndockNode")
    }
    
    static igDockContextQueueUndockWindow(param*)
    {
        dllcall("imgui\igDockContextQueueUndockWindow")
    }
    
    static igDockContextRebuildNodes(param*)
    {
        dllcall("imgui\igDockContextRebuildNodes")
    }
    
    static igDockContextShutdown(param*)
    {
        dllcall("imgui\igDockContextShutdown")
    }
    
    static igDockNodeBeginAmendTabBar(param*)
    {
        dllcall("imgui\igDockNodeBeginAmendTabBar")
    }
    
    static igDockNodeEndAmendTabBar(param*)
    {
        dllcall("imgui\igDockNodeEndAmendTabBar")
    }
    
    static igDockNodeGetDepth(param*)
    {
        dllcall("imgui\igDockNodeGetDepth")
    }
    
    static igDockNodeGetRootNode(param*)
    {
        dllcall("imgui\igDockNodeGetRootNode")
    }
    
    static igDockNodeGetWindowMenuButtonId(param*)
    {
        dllcall("imgui\igDockNodeGetWindowMenuButtonId")
    }
    
    static igDockNodeIsInHierarchyOf(param*)
    {
        dllcall("imgui\igDockNodeIsInHierarchyOf")
    }
    
    static igDockSpace(param*)
    {
        dllcall("imgui\igDockSpace")
    }
    
    static igDockSpaceOverViewport(param*)
    {
        dllcall("imgui\igDockSpaceOverViewport")
    }
    
    static igDragBehavior(param*)
    {
        dllcall("imgui\igDragBehavior")
    }
    
    static igDragFloat(param*)
    {
        dllcall("imgui\igDragFloat")
    }
    
    static igDragFloat2(param*)
    {
        dllcall("imgui\igDragFloat2")
    }
    
    static igDragFloat3(param*)
    {
        dllcall("imgui\igDragFloat3")
    }
    
    static igDragFloat4(param*)
    {
        dllcall("imgui\igDragFloat4")
    }
    
    static igDragFloatRange2(param*)
    {
        dllcall("imgui\igDragFloatRange2")
    }
    
    static igDragInt(param*)
    {
        dllcall("imgui\igDragInt")
    }
    
    static igDragInt2(param*)
    {
        dllcall("imgui\igDragInt2")
    }
    
    static igDragInt3(param*)
    {
        dllcall("imgui\igDragInt3")
    }
    
    static igDragInt4(param*)
    {
        dllcall("imgui\igDragInt4")
    }
    
    static igDragIntRange2(param*)
    {
        dllcall("imgui\igDragIntRange2")
    }
    
    static igDragScalar(param*)
    {
        dllcall("imgui\igDragScalar")
    }
    
    static igDragScalarN(param*)
    {
        dllcall("imgui\igDragScalarN")
    }
    
    static igDummy(param*)
    {
        dllcall("imgui\igDummy")
    }
    
    static igEnd(param*)
    {
        dllcall("imgui\igEnd")
    }
    
    static igEndChild(param*)
    {
        dllcall("imgui\igEndChild")
    }
    
    static igEndChildFrame(param*)
    {
        dllcall("imgui\igEndChildFrame")
    }
    
    static igEndColumns(param*)
    {
        dllcall("imgui\igEndColumns")
    }
    
    static igEndCombo(param*)
    {
        dllcall("imgui\igEndCombo")
    }
    
    static igEndComboPreview(param*)
    {
        dllcall("imgui\igEndComboPreview")
    }
    
    static igEndDisabled(param*)
    {
        dllcall("imgui\igEndDisabled")
    }
    
    static igEndDragDropSource(param*)
    {
        dllcall("imgui\igEndDragDropSource")
    }
    
    static igEndDragDropTarget(param*)
    {
        dllcall("imgui\igEndDragDropTarget")
    }
    
    static igEndFrame(param*)
    {
        dllcall("imgui\igEndFrame")
    }
    
    static igEndGroup(param*)
    {
        dllcall("imgui\igEndGroup")
    }
    
    static igEndListBox(param*)
    {
        dllcall("imgui\igEndListBox")
    }
    
    static igEndMainMenuBar(param*)
    {
        dllcall("imgui\igEndMainMenuBar")
    }
    
    static igEndMenu(param*)
    {
        dllcall("imgui\igEndMenu")
    }
    
    static igEndMenuBar(param*)
    {
        dllcall("imgui\igEndMenuBar")
    }
    
    static igEndPopup(param*)
    {
        dllcall("imgui\igEndPopup")
    }
    
    static igEndTabBar(param*)
    {
        dllcall("imgui\igEndTabBar")
    }
    
    static igEndTabItem(param*)
    {
        dllcall("imgui\igEndTabItem")
    }
    
    static igEndTable(param*)
    {
        dllcall("imgui\igEndTable")
    }
    
    static igEndTooltip(param*)
    {
        dllcall("imgui\igEndTooltip")
    }
    
    static igErrorCheckEndFrameRecover(param*)
    {
        dllcall("imgui\igErrorCheckEndFrameRecover")
    }
    
    static igErrorCheckEndWindowRecover(param*)
    {
        dllcall("imgui\igErrorCheckEndWindowRecover")
    }
    
    static igFindBestWindowPosForPopup(param*)
    {
        dllcall("imgui\igFindBestWindowPosForPopup")
    }
    
    static igFindBestWindowPosForPopupEx(param*)
    {
        dllcall("imgui\igFindBestWindowPosForPopupEx")
    }
    
    static igFindBottomMostVisibleWindowWithinBeginStack(param*)
    {
        dllcall("imgui\igFindBottomMostVisibleWindowWithinBeginStack")
    }
    
    static igFindHoveredViewportFromPlatformWindowStack(param*)
    {
        dllcall("imgui\igFindHoveredViewportFromPlatformWindowStack")
    }
    
    static igFindOrCreateColumns(param*)
    {
        dllcall("imgui\igFindOrCreateColumns")
    }
    
    static igFindOrCreateWindowSettings(param*)
    {
        dllcall("imgui\igFindOrCreateWindowSettings")
    }
    
    static igFindRenderedTextEnd(param*)
    {
        dllcall("imgui\igFindRenderedTextEnd")
    }
    
    static igFindSettingsHandler(param*)
    {
        dllcall("imgui\igFindSettingsHandler")
    }
    
    static igFindViewportByID(param*)
    {
        dllcall("imgui\igFindViewportByID")
    }
    
    static igFindViewportByPlatformHandle(param*)
    {
        dllcall("imgui\igFindViewportByPlatformHandle")
    }
    
    static igFindWindowByID(param*)
    {
        dllcall("imgui\igFindWindowByID")
    }
    
    static igFindWindowByName(param*)
    {
        dllcall("imgui\igFindWindowByName")
    }
    
    static igFindWindowDisplayIndex(param*)
    {
        dllcall("imgui\igFindWindowDisplayIndex")
    }
    
    static igFindWindowSettings(param*)
    {
        dllcall("imgui\igFindWindowSettings")
    }
    
    static igFocusTopMostWindowUnderOne(param*)
    {
        dllcall("imgui\igFocusTopMostWindowUnderOne")
    }
    
    static igFocusWindow(param*)
    {
        dllcall("imgui\igFocusWindow")
    }
    
    static igGET_FLT_MAX(param*)
    {
        dllcall("imgui\igGET_FLT_MAX")
    }
    
    static igGET_FLT_MIN(param*)
    {
        dllcall("imgui\igGET_FLT_MIN")
    }
    
    static igGcAwakeTransientWindowBuffers(param*)
    {
        dllcall("imgui\igGcAwakeTransientWindowBuffers")
    }
    
    static igGcCompactTransientMiscBuffers(param*)
    {
        dllcall("imgui\igGcCompactTransientMiscBuffers")
    }
    
    static igGcCompactTransientWindowBuffers(param*)
    {
        dllcall("imgui\igGcCompactTransientWindowBuffers")
    }
    
    static igGetActiveID(param*)
    {
        dllcall("imgui\igGetActiveID")
    }
    
    static igGetAllocatorFunctions(param*)
    {
        dllcall("imgui\igGetAllocatorFunctions")
    }
    
    static igGetBackgroundDrawList_Nil(param*)
    {
        dllcall("imgui\igGetBackgroundDrawList_Nil")
    }
    
    static igGetBackgroundDrawList_ViewportPtr(param*)
    {
        dllcall("imgui\igGetBackgroundDrawList_ViewportPtr")
    }
    
    static igGetClipboardText(param*)
    {
        dllcall("imgui\igGetClipboardText")
    }
    
    static igGetColorU32_Col(param*)
    {
        dllcall("imgui\igGetColorU32_Col")
    }
    
    static igGetColorU32_U32(param*)
    {
        dllcall("imgui\igGetColorU32_U32")
    }
    
    static igGetColorU32_Vec4(param*)
    {
        dllcall("imgui\igGetColorU32_Vec4")
    }
    
    static igGetColumnIndex(param*)
    {
        dllcall("imgui\igGetColumnIndex")
    }
    
    static igGetColumnNormFromOffset(param*)
    {
        dllcall("imgui\igGetColumnNormFromOffset")
    }
    
    static igGetColumnOffset(param*)
    {
        dllcall("imgui\igGetColumnOffset")
    }
    
    static igGetColumnOffsetFromNorm(param*)
    {
        dllcall("imgui\igGetColumnOffsetFromNorm")
    }
    
    static igGetColumnWidth(param*)
    {
        dllcall("imgui\igGetColumnWidth")
    }
    
    static igGetColumnsCount(param*)
    {
        dllcall("imgui\igGetColumnsCount")
    }
    
    static igGetColumnsID(param*)
    {
        dllcall("imgui\igGetColumnsID")
    }
    
    static igGetContentRegionAvail(param*)
    {
        dllcall("imgui\igGetContentRegionAvail")
    }
    
    static igGetContentRegionMax(param*)
    {
        dllcall("imgui\igGetContentRegionMax")
    }
    
    static igGetContentRegionMaxAbs(param*)
    {
        dllcall("imgui\igGetContentRegionMaxAbs")
    }
    
    static igGetCurrentContext(param*)
    {
        dllcall("imgui\igGetCurrentContext")
    }
    
    static igGetCurrentTable(param*)
    {
        dllcall("imgui\igGetCurrentTable")
    }
    
    static igGetCurrentWindow(param*)
    {
        dllcall("imgui\igGetCurrentWindow")
    }
    
    static igGetCurrentWindowRead(param*)
    {
        dllcall("imgui\igGetCurrentWindowRead")
    }
    
    static igGetCursorPos(param*)
    {
        dllcall("imgui\igGetCursorPos")
    }
    
    static igGetCursorPosX(param*)
    {
        dllcall("imgui\igGetCursorPosX")
    }
    
    static igGetCursorPosY(param*)
    {
        dllcall("imgui\igGetCursorPosY")
    }
    
    static igGetCursorScreenPos(param*)
    {
        dllcall("imgui\igGetCursorScreenPos")
    }
    
    static igGetCursorStartPos(param*)
    {
        dllcall("imgui\igGetCursorStartPos")
    }
    
    static igGetDefaultFont(param*)
    {
        dllcall("imgui\igGetDefaultFont")
    }
    
    static igGetDragDropPayload(param*)
    {
        dllcall("imgui\igGetDragDropPayload")
    }
    
    static igGetDrawData(param*)
    {
        dllcall("imgui\igGetDrawData")
    }
    
    static igGetDrawListSharedData(param*)
    {
        dllcall("imgui\igGetDrawListSharedData")
    }
    
    static igGetFocusID(param*)
    {
        dllcall("imgui\igGetFocusID")
    }
    
    static igGetFocusScope(param*)
    {
        dllcall("imgui\igGetFocusScope")
    }
    
    static igGetFocusedFocusScope(param*)
    {
        dllcall("imgui\igGetFocusedFocusScope")
    }
    
    static igGetFont(param*)
    {
        dllcall("imgui\igGetFont")
    }
    
    static igGetFontSize(param*)
    {
        dllcall("imgui\igGetFontSize")
    }
    
    static igGetFontTexUvWhitePixel(param*)
    {
        dllcall("imgui\igGetFontTexUvWhitePixel")
    }
    
    static igGetForegroundDrawList_Nil(param*)
    {
        dllcall("imgui\igGetForegroundDrawList_Nil")
    }
    
    static igGetForegroundDrawList_ViewportPtr(param*)
    {
        dllcall("imgui\igGetForegroundDrawList_ViewportPtr")
    }
    
    static igGetForegroundDrawList_WindowPtr(param*)
    {
        dllcall("imgui\igGetForegroundDrawList_WindowPtr")
    }
    
    static igGetFrameCount(param*)
    {
        dllcall("imgui\igGetFrameCount")
    }
    
    static igGetFrameHeight(param*)
    {
        dllcall("imgui\igGetFrameHeight")
    }
    
    static igGetFrameHeightWithSpacing(param*)
    {
        dllcall("imgui\igGetFrameHeightWithSpacing")
    }
    
    static igGetHoveredID(param*)
    {
        dllcall("imgui\igGetHoveredID")
    }
    
    static igGetIDWithSeed(param*)
    {
        dllcall("imgui\igGetIDWithSeed")
    }
    
    static igGetID_Ptr(param*)
    {
        dllcall("imgui\igGetID_Ptr")
    }
    
    static igGetID_Str(param*)
    {
        dllcall("imgui\igGetID_Str")
    }
    
    static igGetID_StrStr(param*)
    {
        dllcall("imgui\igGetID_StrStr")
    }
    
    static igGetIO(param*)
    {
        dllcall("imgui\igGetIO")
    }
    
    static igGetInputTextState(param*)
    {
        dllcall("imgui\igGetInputTextState")
    }
    
    static igGetItemFlags(param*)
    {
        dllcall("imgui\igGetItemFlags")
    }
    
    static igGetItemID(param*)
    {
        dllcall("imgui\igGetItemID")
    }
    
    static igGetItemRectMax(param*)
    {
        dllcall("imgui\igGetItemRectMax")
    }
    
    static igGetItemRectMin(param*)
    {
        dllcall("imgui\igGetItemRectMin")
    }
    
    static igGetItemRectSize(param*)
    {
        dllcall("imgui\igGetItemRectSize")
    }
    
    static igGetItemStatusFlags(param*)
    {
        dllcall("imgui\igGetItemStatusFlags")
    }
    
    static igGetKeyData(param*)
    {
        dllcall("imgui\igGetKeyData")
    }
    
    static igGetKeyIndex(param*)
    {
        dllcall("imgui\igGetKeyIndex")
    }
    
    static igGetKeyName(param*)
    {
        dllcall("imgui\igGetKeyName")
    }
    
    static igGetKeyPressedAmount(param*)
    {
        dllcall("imgui\igGetKeyPressedAmount")
    }
    
    static igGetMainViewport(param*)
    {
        dllcall("imgui\igGetMainViewport")
    }
    
    static igGetMergedKeyModFlags(param*)
    {
        dllcall("imgui\igGetMergedKeyModFlags")
    }
    
    static igGetMouseClickedCount(param*)
    {
        dllcall("imgui\igGetMouseClickedCount")
    }
    
    static igGetMouseCursor(param*)
    {
        dllcall("imgui\igGetMouseCursor")
    }
    
    static igGetMouseDragDelta(param*)
    {
        dllcall("imgui\igGetMouseDragDelta")
    }
    
    static igGetMousePos(param*)
    {
        dllcall("imgui\igGetMousePos")
    }
    
    static igGetMousePosOnOpeningCurrentPopup(param*)
    {
        dllcall("imgui\igGetMousePosOnOpeningCurrentPopup")
    }
    
    static igGetNavInputAmount(param*)
    {
        dllcall("imgui\igGetNavInputAmount")
    }
    
    static igGetNavInputAmount2d(param*)
    {
        dllcall("imgui\igGetNavInputAmount2d")
    }
    
    static igGetNavInputName(param*)
    {
        dllcall("imgui\igGetNavInputName")
    }
    
    static igGetPlatformIO(param*)
    {
        dllcall("imgui\igGetPlatformIO")
    }
    
    static igGetPopupAllowedExtentRect(param*)
    {
        dllcall("imgui\igGetPopupAllowedExtentRect")
    }
    
    static igGetScrollMaxX(param*)
    {
        dllcall("imgui\igGetScrollMaxX")
    }
    
    static igGetScrollMaxY(param*)
    {
        dllcall("imgui\igGetScrollMaxY")
    }
    
    static igGetScrollX(param*)
    {
        dllcall("imgui\igGetScrollX")
    }
    
    static igGetScrollY(param*)
    {
        dllcall("imgui\igGetScrollY")
    }
    
    static igGetStateStorage(param*)
    {
        dllcall("imgui\igGetStateStorage")
    }
    
    static igGetStyle(param*)
    {
        dllcall("imgui\igGetStyle")
    }
    
    static igGetStyleColorName(param*)
    {
        dllcall("imgui\igGetStyleColorName")
    }
    
    static igGetStyleColorVec4(param*)
    {
        dllcall("imgui\igGetStyleColorVec4")
    }
    
    static igGetTextLineHeight(param*)
    {
        dllcall("imgui\igGetTextLineHeight")
    }
    
    static igGetTextLineHeightWithSpacing(param*)
    {
        dllcall("imgui\igGetTextLineHeightWithSpacing")
    }
    
    static igGetTime(param*)
    {
        dllcall("imgui\igGetTime")
    }
    
    static igGetTopMostAndVisiblePopupModal(param*)
    {
        dllcall("imgui\igGetTopMostAndVisiblePopupModal")
    }
    
    static igGetTopMostPopupModal(param*)
    {
        dllcall("imgui\igGetTopMostPopupModal")
    }
    
    static igGetTreeNodeToLabelSpacing(param*)
    {
        dllcall("imgui\igGetTreeNodeToLabelSpacing")
    }
    
    static igGetVersion(param*)
    {
        dllcall("imgui\igGetVersion")
    }
    
    static igGetViewportPlatformMonitor(param*)
    {
        dllcall("imgui\igGetViewportPlatformMonitor")
    }
    
    static igGetWindowAlwaysWantOwnTabBar(param*)
    {
        dllcall("imgui\igGetWindowAlwaysWantOwnTabBar")
    }
    
    static igGetWindowContentRegionMax(param*)
    {
        dllcall("imgui\igGetWindowContentRegionMax")
    }
    
    static igGetWindowContentRegionMin(param*)
    {
        dllcall("imgui\igGetWindowContentRegionMin")
    }
    
    static igGetWindowDockID(param*)
    {
        dllcall("imgui\igGetWindowDockID")
    }
    
    static igGetWindowDockNode(param*)
    {
        dllcall("imgui\igGetWindowDockNode")
    }
    
    static igGetWindowDpiScale(param*)
    {
        dllcall("imgui\igGetWindowDpiScale")
    }
    
    static igGetWindowDrawList(param*)
    {
        dllcall("imgui\igGetWindowDrawList")
    }
    
    static igGetWindowHeight(param*)
    {
        dllcall("imgui\igGetWindowHeight")
    }
    
    static igGetWindowPos(param*)
    {
        dllcall("imgui\igGetWindowPos")
    }
    
    static igGetWindowResizeBorderID(param*)
    {
        dllcall("imgui\igGetWindowResizeBorderID")
    }
    
    static igGetWindowResizeCornerID(param*)
    {
        dllcall("imgui\igGetWindowResizeCornerID")
    }
    
    static igGetWindowScrollbarID(param*)
    {
        dllcall("imgui\igGetWindowScrollbarID")
    }
    
    static igGetWindowScrollbarRect(param*)
    {
        dllcall("imgui\igGetWindowScrollbarRect")
    }
    
    static igGetWindowSize(param*)
    {
        dllcall("imgui\igGetWindowSize")
    }
    
    static igGetWindowViewport(param*)
    {
        dllcall("imgui\igGetWindowViewport")
    }
    
    static igGetWindowWidth(param*)
    {
        dllcall("imgui\igGetWindowWidth")
    }
    
    static igImAbs_Float(param*)
    {
        dllcall("imgui\igImAbs_Float")
    }
    
    static igImAbs_Int(param*)
    {
        dllcall("imgui\igImAbs_Int")
    }
    
    static igImAbs_double(param*)
    {
        dllcall("imgui\igImAbs_double")
    }
    
    static igImAlphaBlendColors(param*)
    {
        dllcall("imgui\igImAlphaBlendColors")
    }
    
    static igImBezierCubicCalc(param*)
    {
        dllcall("imgui\igImBezierCubicCalc")
    }
    
    static igImBezierCubicClosestPoint(param*)
    {
        dllcall("imgui\igImBezierCubicClosestPoint")
    }
    
    static igImBezierCubicClosestPointCasteljau(param*)
    {
        dllcall("imgui\igImBezierCubicClosestPointCasteljau")
    }
    
    static igImBezierQuadraticCalc(param*)
    {
        dllcall("imgui\igImBezierQuadraticCalc")
    }
    
    static igImBitArrayClearBit(param*)
    {
        dllcall("imgui\igImBitArrayClearBit")
    }
    
    static igImBitArraySetBit(param*)
    {
        dllcall("imgui\igImBitArraySetBit")
    }
    
    static igImBitArraySetBitRange(param*)
    {
        dllcall("imgui\igImBitArraySetBitRange")
    }
    
    static igImBitArrayTestBit(param*)
    {
        dllcall("imgui\igImBitArrayTestBit")
    }
    
    static igImCharIsBlankA(param*)
    {
        dllcall("imgui\igImCharIsBlankA")
    }
    
    static igImCharIsBlankW(param*)
    {
        dllcall("imgui\igImCharIsBlankW")
    }
    
    static igImClamp(param*)
    {
        dllcall("imgui\igImClamp")
    }
    
    static igImDot(param*)
    {
        dllcall("imgui\igImDot")
    }
    
    static igImFileClose(param*)
    {
        dllcall("imgui\igImFileClose")
    }
    
    static igImFileGetSize(param*)
    {
        dllcall("imgui\igImFileGetSize")
    }
    
    static igImFileLoadToMemory(param*)
    {
        dllcall("imgui\igImFileLoadToMemory")
    }
    
    static igImFileOpen(param*)
    {
        dllcall("imgui\igImFileOpen")
    }
    
    static igImFileRead(param*)
    {
        dllcall("imgui\igImFileRead")
    }
    
    static igImFileWrite(param*)
    {
        dllcall("imgui\igImFileWrite")
    }
    
    static igImFloorSigned_Float(param*)
    {
        dllcall("imgui\igImFloorSigned_Float")
    }
    
    static igImFloorSigned_Vec2(param*)
    {
        dllcall("imgui\igImFloorSigned_Vec2")
    }
    
    static igImFloor_Float(param*)
    {
        dllcall("imgui\igImFloor_Float")
    }
    
    static igImFloor_Vec2(param*)
    {
        dllcall("imgui\igImFloor_Vec2")
    }
    
    static igImFontAtlasBuildFinish(param*)
    {
        dllcall("imgui\igImFontAtlasBuildFinish")
    }
    
    static igImFontAtlasBuildInit(param*)
    {
        dllcall("imgui\igImFontAtlasBuildInit")
    }
    
    static igImFontAtlasBuildMultiplyCalcLookupTable(param*)
    {
        dllcall("imgui\igImFontAtlasBuildMultiplyCalcLookupTable")
    }
    
    static igImFontAtlasBuildMultiplyRectAlpha8(param*)
    {
        dllcall("imgui\igImFontAtlasBuildMultiplyRectAlpha8")
    }
    
    static igImFontAtlasBuildPackCustomRects(param*)
    {
        dllcall("imgui\igImFontAtlasBuildPackCustomRects")
    }
    
    static igImFontAtlasBuildRender32bppRectFromString(param*)
    {
        dllcall("imgui\igImFontAtlasBuildRender32bppRectFromString")
    }
    
    static igImFontAtlasBuildRender8bppRectFromString(param*)
    {
        dllcall("imgui\igImFontAtlasBuildRender8bppRectFromString")
    }
    
    static igImFontAtlasBuildSetupFont(param*)
    {
        dllcall("imgui\igImFontAtlasBuildSetupFont")
    }
    
    static igImFontAtlasGetBuilderForStbTruetype(param*)
    {
        dllcall("imgui\igImFontAtlasGetBuilderForStbTruetype")
    }
    
    static igImFormatString(param*)
    {
        dllcall("imgui\igImFormatString")
    }
    
    static igImFormatStringV(param*)
    {
        dllcall("imgui\igImFormatStringV")
    }
    
    static igImGetDirQuadrantFromDelta(param*)
    {
        dllcall("imgui\igImGetDirQuadrantFromDelta")
    }
    
    static igImHashData(param*)
    {
        dllcall("imgui\igImHashData")
    }
    
    static igImHashStr(param*)
    {
        dllcall("imgui\igImHashStr")
    }
    
    static igImInvLength(param*)
    {
        dllcall("imgui\igImInvLength")
    }
    
    static igImIsFloatAboveGuaranteedIntegerPrecision(param*)
    {
        dllcall("imgui\igImIsFloatAboveGuaranteedIntegerPrecision")
    }
    
    static igImIsPowerOfTwo_Int(param*)
    {
        dllcall("imgui\igImIsPowerOfTwo_Int")
    }
    
    static igImIsPowerOfTwo_U64(param*)
    {
        dllcall("imgui\igImIsPowerOfTwo_U64")
    }
    
    static igImLengthSqr_Vec2(param*)
    {
        dllcall("imgui\igImLengthSqr_Vec2")
    }
    
    static igImLengthSqr_Vec4(param*)
    {
        dllcall("imgui\igImLengthSqr_Vec4")
    }
    
    static igImLerp_Vec2Float(param*)
    {
        dllcall("imgui\igImLerp_Vec2Float")
    }
    
    static igImLerp_Vec2Vec2(param*)
    {
        dllcall("imgui\igImLerp_Vec2Vec2")
    }
    
    static igImLerp_Vec4(param*)
    {
        dllcall("imgui\igImLerp_Vec4")
    }
    
    static igImLineClosestPoint(param*)
    {
        dllcall("imgui\igImLineClosestPoint")
    }
    
    static igImLinearSweep(param*)
    {
        dllcall("imgui\igImLinearSweep")
    }
    
    static igImLog_Float(param*)
    {
        dllcall("imgui\igImLog_Float")
    }
    
    static igImLog_double(param*)
    {
        dllcall("imgui\igImLog_double")
    }
    
    static igImMax(param*)
    {
        dllcall("imgui\igImMax")
    }
    
    static igImMin(param*)
    {
        dllcall("imgui\igImMin")
    }
    
    static igImModPositive(param*)
    {
        dllcall("imgui\igImModPositive")
    }
    
    static igImMul(param*)
    {
        dllcall("imgui\igImMul")
    }
    
    static igImParseFormatFindEnd(param*)
    {
        dllcall("imgui\igImParseFormatFindEnd")
    }
    
    static igImParseFormatFindStart(param*)
    {
        dllcall("imgui\igImParseFormatFindStart")
    }
    
    static igImParseFormatPrecision(param*)
    {
        dllcall("imgui\igImParseFormatPrecision")
    }
    
    static igImParseFormatTrimDecorations(param*)
    {
        dllcall("imgui\igImParseFormatTrimDecorations")
    }
    
    static igImPow_Float(param*)
    {
        dllcall("imgui\igImPow_Float")
    }
    
    static igImPow_double(param*)
    {
        dllcall("imgui\igImPow_double")
    }
    
    static igImQsort(param*)
    {
        dllcall("imgui\igImQsort")
    }
    
    static igImRotate(param*)
    {
        dllcall("imgui\igImRotate")
    }
    
    static igImRsqrt_Float(param*)
    {
        dllcall("imgui\igImRsqrt_Float")
    }
    
    static igImRsqrt_double(param*)
    {
        dllcall("imgui\igImRsqrt_double")
    }
    
    static igImSaturate(param*)
    {
        dllcall("imgui\igImSaturate")
    }
    
    static igImSign_Float(param*)
    {
        dllcall("imgui\igImSign_Float")
    }
    
    static igImSign_double(param*)
    {
        dllcall("imgui\igImSign_double")
    }
    
    static igImStrSkipBlank(param*)
    {
        dllcall("imgui\igImStrSkipBlank")
    }
    
    static igImStrTrimBlanks(param*)
    {
        dllcall("imgui\igImStrTrimBlanks")
    }
    
    static igImStrbolW(param*)
    {
        dllcall("imgui\igImStrbolW")
    }
    
    static igImStrchrRange(param*)
    {
        dllcall("imgui\igImStrchrRange")
    }
    
    static igImStrdup(param*)
    {
        dllcall("imgui\igImStrdup")
    }
    
    static igImStrdupcpy(param*)
    {
        dllcall("imgui\igImStrdupcpy")
    }
    
    static igImStreolRange(param*)
    {
        dllcall("imgui\igImStreolRange")
    }
    
    static igImStricmp(param*)
    {
        dllcall("imgui\igImStricmp")
    }
    
    static igImStristr(param*)
    {
        dllcall("imgui\igImStristr")
    }
    
    static igImStrlenW(param*)
    {
        dllcall("imgui\igImStrlenW")
    }
    
    static igImStrncpy(param*)
    {
        dllcall("imgui\igImStrncpy")
    }
    
    static igImStrnicmp(param*)
    {
        dllcall("imgui\igImStrnicmp")
    }
    
    static igImTextCharFromUtf8(param*)
    {
        dllcall("imgui\igImTextCharFromUtf8")
    }
    
    static igImTextCharToUtf8(param*)
    {
        dllcall("imgui\igImTextCharToUtf8")
    }
    
    static igImTextCountCharsFromUtf8(param*)
    {
        dllcall("imgui\igImTextCountCharsFromUtf8")
    }
    
    static igImTextCountUtf8BytesFromChar(param*)
    {
        dllcall("imgui\igImTextCountUtf8BytesFromChar")
    }
    
    static igImTextCountUtf8BytesFromStr(param*)
    {
        dllcall("imgui\igImTextCountUtf8BytesFromStr")
    }
    
    static igImTextStrFromUtf8(param*)
    {
        dllcall("imgui\igImTextStrFromUtf8")
    }
    
    static igImTextStrToUtf8(param*)
    {
        dllcall("imgui\igImTextStrToUtf8")
    }
    
    static igImTriangleArea(param*)
    {
        dllcall("imgui\igImTriangleArea")
    }
    
    static igImTriangleBarycentricCoords(param*)
    {
        dllcall("imgui\igImTriangleBarycentricCoords")
    }
    
    static igImTriangleClosestPoint(param*)
    {
        dllcall("imgui\igImTriangleClosestPoint")
    }
    
    static igImTriangleContainsPoint(param*)
    {
        dllcall("imgui\igImTriangleContainsPoint")
    }
    
    static igImUpperPowerOfTwo(param*)
    {
        dllcall("imgui\igImUpperPowerOfTwo")
    }
    
    static igImage(param*)
    {
        dllcall("imgui\igImage")
    }
    
    static igImageButton(param*)
    {
        dllcall("imgui\igImageButton")
    }
    
    static igImageButtonEx(param*)
    {
        dllcall("imgui\igImageButtonEx")
    }
    
    static igIndent(param*)
    {
        dllcall("imgui\igIndent")
    }
    
    static igInitialize(param*)
    {
        dllcall("imgui\igInitialize")
    }
    
    static igInputDouble(param*)
    {
        dllcall("imgui\igInputDouble")
    }
    
    static igInputFloat(param*)
    {
        dllcall("imgui\igInputFloat")
    }
    
    static igInputFloat2(param*)
    {
        dllcall("imgui\igInputFloat2")
    }
    
    static igInputFloat3(param*)
    {
        dllcall("imgui\igInputFloat3")
    }
    
    static igInputFloat4(param*)
    {
        dllcall("imgui\igInputFloat4")
    }
    
    static igInputInt(param*)
    {
        dllcall("imgui\igInputInt")
    }
    
    static igInputInt2(param*)
    {
        dllcall("imgui\igInputInt2")
    }
    
    static igInputInt3(param*)
    {
        dllcall("imgui\igInputInt3")
    }
    
    static igInputInt4(param*)
    {
        dllcall("imgui\igInputInt4")
    }
    
    static igInputScalar(param*)
    {
        dllcall("imgui\igInputScalar")
    }
    
    static igInputScalarN(param*)
    {
        dllcall("imgui\igInputScalarN")
    }
    
    static igInputText(param*)
    {
        dllcall("imgui\igInputText")
    }
    
    static igInputTextEx(param*)
    {
        dllcall("imgui\igInputTextEx")
    }
    
    static igInputTextMultiline(param*)
    {
        dllcall("imgui\igInputTextMultiline")
    }
    
    static igInputTextWithHint(param*)
    {
        dllcall("imgui\igInputTextWithHint")
    }
    
    static igInvisibleButton(param*)
    {
        dllcall("imgui\igInvisibleButton")
    }
    
    static igIsActiveIdUsingKey(param*)
    {
        dllcall("imgui\igIsActiveIdUsingKey")
    }
    
    static igIsActiveIdUsingNavDir(param*)
    {
        dllcall("imgui\igIsActiveIdUsingNavDir")
    }
    
    static igIsActiveIdUsingNavInput(param*)
    {
        dllcall("imgui\igIsActiveIdUsingNavInput")
    }
    
    static igIsAnyItemActive(param*)
    {
        dllcall("imgui\igIsAnyItemActive")
    }
    
    static igIsAnyItemFocused(param*)
    {
        dllcall("imgui\igIsAnyItemFocused")
    }
    
    static igIsAnyItemHovered(param*)
    {
        dllcall("imgui\igIsAnyItemHovered")
    }
    
    static igIsAnyMouseDown(param*)
    {
        dllcall("imgui\igIsAnyMouseDown")
    }
    
    static igIsClippedEx(param*)
    {
        dllcall("imgui\igIsClippedEx")
    }
    
    static igIsDragDropPayloadBeingAccepted(param*)
    {
        dllcall("imgui\igIsDragDropPayloadBeingAccepted")
    }
    
    static igIsGamepadKey(param*)
    {
        dllcall("imgui\igIsGamepadKey")
    }
    
    static igIsItemActivated(param*)
    {
        dllcall("imgui\igIsItemActivated")
    }
    
    static igIsItemActive(param*)
    {
        dllcall("imgui\igIsItemActive")
    }
    
    static igIsItemClicked(param*)
    {
        dllcall("imgui\igIsItemClicked")
    }
    
    static igIsItemDeactivated(param*)
    {
        dllcall("imgui\igIsItemDeactivated")
    }
    
    static igIsItemDeactivatedAfterEdit(param*)
    {
        dllcall("imgui\igIsItemDeactivatedAfterEdit")
    }
    
    static igIsItemEdited(param*)
    {
        dllcall("imgui\igIsItemEdited")
    }
    
    static igIsItemFocused(param*)
    {
        dllcall("imgui\igIsItemFocused")
    }
    
    static igIsItemHovered(param*)
    {
        dllcall("imgui\igIsItemHovered")
    }
    
    static igIsItemToggledOpen(param*)
    {
        dllcall("imgui\igIsItemToggledOpen")
    }
    
    static igIsItemToggledSelection(param*)
    {
        dllcall("imgui\igIsItemToggledSelection")
    }
    
    static igIsItemVisible(param*)
    {
        dllcall("imgui\igIsItemVisible")
    }
    
    static igIsKeyDown(param*)
    {
        dllcall("imgui\igIsKeyDown")
    }
    
    static igIsKeyPressed(param*)
    {
        dllcall("imgui\igIsKeyPressed")
    }
    
    static igIsKeyPressedMap(param*)
    {
        dllcall("imgui\igIsKeyPressedMap")
    }
    
    static igIsKeyReleased(param*)
    {
        dllcall("imgui\igIsKeyReleased")
    }
    
    static igIsLegacyKey(param*)
    {
        dllcall("imgui\igIsLegacyKey")
    }
    
    static igIsMouseClicked(param*)
    {
        dllcall("imgui\igIsMouseClicked")
    }
    
    static igIsMouseDoubleClicked(param*)
    {
        dllcall("imgui\igIsMouseDoubleClicked")
    }
    
    static igIsMouseDown(param*)
    {
        dllcall("imgui\igIsMouseDown")
    }
    
    static igIsMouseDragPastThreshold(param*)
    {
        dllcall("imgui\igIsMouseDragPastThreshold")
    }
    
    static igIsMouseDragging(param*)
    {
        dllcall("imgui\igIsMouseDragging")
    }
    
    static igIsMouseHoveringRect(param*)
    {
        dllcall("imgui\igIsMouseHoveringRect")
    }
    
    static igIsMousePosValid(param*)
    {
        dllcall("imgui\igIsMousePosValid")
    }
    
    static igIsMouseReleased(param*)
    {
        dllcall("imgui\igIsMouseReleased")
    }
    
    static igIsNamedKey(param*)
    {
        dllcall("imgui\igIsNamedKey")
    }
    
    static igIsNavInputDown(param*)
    {
        dllcall("imgui\igIsNavInputDown")
    }
    
    static igIsNavInputTest(param*)
    {
        dllcall("imgui\igIsNavInputTest")
    }
    
    static igIsPopupOpen_ID(param*)
    {
        dllcall("imgui\igIsPopupOpen_ID")
    }
    
    static igIsPopupOpen_Str(param*)
    {
        dllcall("imgui\igIsPopupOpen_Str")
    }
    
    static igIsRectVisible_Nil(param*)
    {
        dllcall("imgui\igIsRectVisible_Nil")
    }
    
    static igIsRectVisible_Vec2(param*)
    {
        dllcall("imgui\igIsRectVisible_Vec2")
    }
    
    static igIsWindowAbove(param*)
    {
        dllcall("imgui\igIsWindowAbove")
    }
    
    static igIsWindowAppearing(param*)
    {
        dllcall("imgui\igIsWindowAppearing")
    }
    
    static igIsWindowChildOf(param*)
    {
        dllcall("imgui\igIsWindowChildOf")
    }
    
    static igIsWindowCollapsed(param*)
    {
        dllcall("imgui\igIsWindowCollapsed")
    }
    
    static igIsWindowDocked(param*)
    {
        dllcall("imgui\igIsWindowDocked")
    }
    
    static igIsWindowFocused(param*)
    {
        dllcall("imgui\igIsWindowFocused")
    }
    
    static igIsWindowHovered(param*)
    {
        dllcall("imgui\igIsWindowHovered")
    }
    
    static igIsWindowNavFocusable(param*)
    {
        dllcall("imgui\igIsWindowNavFocusable")
    }
    
    static igIsWindowWithinBeginStackOf(param*)
    {
        dllcall("imgui\igIsWindowWithinBeginStackOf")
    }
    
    static igItemAdd(param*)
    {
        dllcall("imgui\igItemAdd")
    }
    
    static igItemHoverable(param*)
    {
        dllcall("imgui\igItemHoverable")
    }
    
    static igItemSize_Rect(param*)
    {
        dllcall("imgui\igItemSize_Rect")
    }
    
    static igItemSize_Vec2(param*)
    {
        dllcall("imgui\igItemSize_Vec2")
    }
    
    static igKeepAliveID(param*)
    {
        dllcall("imgui\igKeepAliveID")
    }
    
    static igLabelText(param*)
    {
        dllcall("imgui\igLabelText")
    }
    
    static igLabelTextV(param*)
    {
        dllcall("imgui\igLabelTextV")
    }
    
    static igListBox_FnBoolPtr(param*)
    {
        dllcall("imgui\igListBox_FnBoolPtr")
    }
    
    static igListBox_Str_arr(param*)
    {
        dllcall("imgui\igListBox_Str_arr")
    }
    
    static igLoadIniSettingsFromDisk(param*)
    {
        dllcall("imgui\igLoadIniSettingsFromDisk")
    }
    
    static igLoadIniSettingsFromMemory(param*)
    {
        dllcall("imgui\igLoadIniSettingsFromMemory")
    }
    
    static igLogBegin(param*)
    {
        dllcall("imgui\igLogBegin")
    }
    
    static igLogButtons(param*)
    {
        dllcall("imgui\igLogButtons")
    }
    
    static igLogFinish(param*)
    {
        dllcall("imgui\igLogFinish")
    }
    
    static igLogRenderedText(param*)
    {
        dllcall("imgui\igLogRenderedText")
    }
    
    static igLogSetNextTextDecoration(param*)
    {
        dllcall("imgui\igLogSetNextTextDecoration")
    }
    
    static igLogText(param*)
    {
        dllcall("imgui\igLogText")
    }
    
    static igLogTextV(param*)
    {
        dllcall("imgui\igLogTextV")
    }
    
    static igLogToBuffer(param*)
    {
        dllcall("imgui\igLogToBuffer")
    }
    
    static igLogToClipboard(param*)
    {
        dllcall("imgui\igLogToClipboard")
    }
    
    static igLogToFile(param*)
    {
        dllcall("imgui\igLogToFile")
    }
    
    static igLogToTTY(param*)
    {
        dllcall("imgui\igLogToTTY")
    }
    
    static igMarkIniSettingsDirty_Nil(param*)
    {
        dllcall("imgui\igMarkIniSettingsDirty_Nil")
    }
    
    static igMarkIniSettingsDirty_WindowPtr(param*)
    {
        dllcall("imgui\igMarkIniSettingsDirty_WindowPtr")
    }
    
    static igMarkItemEdited(param*)
    {
        dllcall("imgui\igMarkItemEdited")
    }
    
    static igMemAlloc(param*)
    {
        dllcall("imgui\igMemAlloc")
    }
    
    static igMemFree(param*)
    {
        dllcall("imgui\igMemFree")
    }
    
    static igMenuItemEx(param*)
    {
        dllcall("imgui\igMenuItemEx")
    }
    
    static igMenuItem_Bool(param*)
    {
        dllcall("imgui\igMenuItem_Bool")
    }
    
    static igMenuItem_BoolPtr(param*)
    {
        dllcall("imgui\igMenuItem_BoolPtr")
    }
    
    static igNavInitRequestApplyResult(param*)
    {
        dllcall("imgui\igNavInitRequestApplyResult")
    }
    
    static igNavInitWindow(param*)
    {
        dllcall("imgui\igNavInitWindow")
    }
    
    static igNavMoveRequestApplyResult(param*)
    {
        dllcall("imgui\igNavMoveRequestApplyResult")
    }
    
    static igNavMoveRequestButNoResultYet(param*)
    {
        dllcall("imgui\igNavMoveRequestButNoResultYet")
    }
    
    static igNavMoveRequestCancel(param*)
    {
        dllcall("imgui\igNavMoveRequestCancel")
    }
    
    static igNavMoveRequestForward(param*)
    {
        dllcall("imgui\igNavMoveRequestForward")
    }
    
    static igNavMoveRequestResolveWithLastItem(param*)
    {
        dllcall("imgui\igNavMoveRequestResolveWithLastItem")
    }
    
    static igNavMoveRequestSubmit(param*)
    {
        dllcall("imgui\igNavMoveRequestSubmit")
    }
    
    static igNavMoveRequestTryWrapping(param*)
    {
        dllcall("imgui\igNavMoveRequestTryWrapping")
    }
    
    static igNewFrame(param*)
    {
        dllcall("imgui\igNewFrame")
    }
    
    static igNewLine(param*)
    {
        dllcall("imgui\igNewLine")
    }
    
    static igNextColumn(param*)
    {
        dllcall("imgui\igNextColumn")
    }
    
    static igOpenPopupEx(param*)
    {
        dllcall("imgui\igOpenPopupEx")
    }
    
    static igOpenPopupOnItemClick(param*)
    {
        dllcall("imgui\igOpenPopupOnItemClick")
    }
    
    static igOpenPopup_ID(param*)
    {
        dllcall("imgui\igOpenPopup_ID")
    }
    
    static igOpenPopup_Str(param*)
    {
        dllcall("imgui\igOpenPopup_Str")
    }
    
    static igPlotEx(param*)
    {
        dllcall("imgui\igPlotEx")
    }
    
    static igPlotHistogram_FloatPtr(param*)
    {
        dllcall("imgui\igPlotHistogram_FloatPtr")
    }
    
    static igPlotHistogram_FnFloatPtr(param*)
    {
        dllcall("imgui\igPlotHistogram_FnFloatPtr")
    }
    
    static igPlotLines_FloatPtr(param*)
    {
        dllcall("imgui\igPlotLines_FloatPtr")
    }
    
    static igPlotLines_FnFloatPtr(param*)
    {
        dllcall("imgui\igPlotLines_FnFloatPtr")
    }
    
    static igPopAllowKeyboardFocus(param*)
    {
        dllcall("imgui\igPopAllowKeyboardFocus")
    }
    
    static igPopButtonRepeat(param*)
    {
        dllcall("imgui\igPopButtonRepeat")
    }
    
    static igPopClipRect(param*)
    {
        dllcall("imgui\igPopClipRect")
    }
    
    static igPopColumnsBackground(param*)
    {
        dllcall("imgui\igPopColumnsBackground")
    }
    
    static igPopFocusScope(param*)
    {
        dllcall("imgui\igPopFocusScope")
    }
    
    static igPopFont(param*)
    {
        dllcall("imgui\igPopFont")
    }
    
    static igPopID(param*)
    {
        dllcall("imgui\igPopID")
    }
    
    static igPopItemFlag(param*)
    {
        dllcall("imgui\igPopItemFlag")
    }
    
    static igPopItemWidth(param*)
    {
        dllcall("imgui\igPopItemWidth")
    }
    
    static igPopStyleColor(param*)
    {
        dllcall("imgui\igPopStyleColor")
    }
    
    static igPopStyleVar(param*)
    {
        dllcall("imgui\igPopStyleVar")
    }
    
    static igPopTextWrapPos(param*)
    {
        dllcall("imgui\igPopTextWrapPos")
    }
    
    static igProgressBar(param*)
    {
        dllcall("imgui\igProgressBar")
    }
    
    static igPushAllowKeyboardFocus(param*)
    {
        dllcall("imgui\igPushAllowKeyboardFocus")
    }
    
    static igPushButtonRepeat(param*)
    {
        dllcall("imgui\igPushButtonRepeat")
    }
    
    static igPushClipRect(param*)
    {
        dllcall("imgui\igPushClipRect")
    }
    
    static igPushColumnClipRect(param*)
    {
        dllcall("imgui\igPushColumnClipRect")
    }
    
    static igPushColumnsBackground(param*)
    {
        dllcall("imgui\igPushColumnsBackground")
    }
    
    static igPushFocusScope(param*)
    {
        dllcall("imgui\igPushFocusScope")
    }
    
    static igPushFont(param*)
    {
        dllcall("imgui\igPushFont")
    }
    
    static igPushID_Int(param*)
    {
        dllcall("imgui\igPushID_Int")
    }
    
    static igPushID_Ptr(param*)
    {
        dllcall("imgui\igPushID_Ptr")
    }
    
    static igPushID_Str(param*)
    {
        dllcall("imgui\igPushID_Str")
    }
    
    static igPushID_StrStr(param*)
    {
        dllcall("imgui\igPushID_StrStr")
    }
    
    static igPushItemFlag(param*)
    {
        dllcall("imgui\igPushItemFlag")
    }
    
    static igPushItemWidth(param*)
    {
        dllcall("imgui\igPushItemWidth")
    }
    
    static igPushMultiItemsWidths(param*)
    {
        dllcall("imgui\igPushMultiItemsWidths")
    }
    
    static igPushOverrideID(param*)
    {
        dllcall("imgui\igPushOverrideID")
    }
    
    static igPushStyleColor_U32(param*)
    {
        dllcall("imgui\igPushStyleColor_U32")
    }
    
    static igPushStyleColor_Vec4(param*)
    {
        dllcall("imgui\igPushStyleColor_Vec4")
    }
    
    static igPushStyleVar_Float(param*)
    {
        dllcall("imgui\igPushStyleVar_Float")
    }
    
    static igPushStyleVar_Vec2(param*)
    {
        dllcall("imgui\igPushStyleVar_Vec2")
    }
    
    static igPushTextWrapPos(param*)
    {
        dllcall("imgui\igPushTextWrapPos")
    }
    
    static igRadioButton_Bool(param*)
    {
        dllcall("imgui\igRadioButton_Bool")
    }
    
    static igRadioButton_IntPtr(param*)
    {
        dllcall("imgui\igRadioButton_IntPtr")
    }
    
    static igRemoveContextHook(param*)
    {
        dllcall("imgui\igRemoveContextHook")
    }
    
    static igRender(param*)
    {
        dllcall("imgui\igRender")
    }
    
    static igRenderArrow(param*)
    {
        dllcall("imgui\igRenderArrow")
    }
    
    static igRenderArrowDockMenu(param*)
    {
        dllcall("imgui\igRenderArrowDockMenu")
    }
    
    static igRenderArrowPointingAt(param*)
    {
        dllcall("imgui\igRenderArrowPointingAt")
    }
    
    static igRenderBullet(param*)
    {
        dllcall("imgui\igRenderBullet")
    }
    
    static igRenderCheckMark(param*)
    {
        dllcall("imgui\igRenderCheckMark")
    }
    
    static igRenderColorRectWithAlphaCheckerboard(param*)
    {
        dllcall("imgui\igRenderColorRectWithAlphaCheckerboard")
    }
    
    static igRenderFrame(param*)
    {
        dllcall("imgui\igRenderFrame")
    }
    
    static igRenderFrameBorder(param*)
    {
        dllcall("imgui\igRenderFrameBorder")
    }
    
    static igRenderMouseCursor(param*)
    {
        dllcall("imgui\igRenderMouseCursor")
    }
    
    static igRenderNavHighlight(param*)
    {
        dllcall("imgui\igRenderNavHighlight")
    }
    
    static igRenderPlatformWindowsDefault(param*)
    {
        dllcall("imgui\igRenderPlatformWindowsDefault")
    }
    
    static igRenderRectFilledRangeH(param*)
    {
        dllcall("imgui\igRenderRectFilledRangeH")
    }
    
    static igRenderRectFilledWithHole(param*)
    {
        dllcall("imgui\igRenderRectFilledWithHole")
    }
    
    static igRenderText(param*)
    {
        dllcall("imgui\igRenderText")
    }
    
    static igRenderTextClipped(param*)
    {
        dllcall("imgui\igRenderTextClipped")
    }
    
    static igRenderTextClippedEx(param*)
    {
        dllcall("imgui\igRenderTextClippedEx")
    }
    
    static igRenderTextEllipsis(param*)
    {
        dllcall("imgui\igRenderTextEllipsis")
    }
    
    static igRenderTextWrapped(param*)
    {
        dllcall("imgui\igRenderTextWrapped")
    }
    
    static igResetMouseDragDelta(param*)
    {
        dllcall("imgui\igResetMouseDragDelta")
    }
    
    static igSameLine(param*)
    {
        dllcall("imgui\igSameLine")
    }
    
    static igSaveIniSettingsToDisk(param*)
    {
        dllcall("imgui\igSaveIniSettingsToDisk")
    }
    
    static igSaveIniSettingsToMemory(param*)
    {
        dllcall("imgui\igSaveIniSettingsToMemory")
    }
    
    static igScaleWindowsInViewport(param*)
    {
        dllcall("imgui\igScaleWindowsInViewport")
    }
    
    static igScrollToBringRectIntoView(param*)
    {
        dllcall("imgui\igScrollToBringRectIntoView")
    }
    
    static igScrollToItem(param*)
    {
        dllcall("imgui\igScrollToItem")
    }
    
    static igScrollToRect(param*)
    {
        dllcall("imgui\igScrollToRect")
    }
    
    static igScrollToRectEx(param*)
    {
        dllcall("imgui\igScrollToRectEx")
    }
    
    static igScrollbar(param*)
    {
        dllcall("imgui\igScrollbar")
    }
    
    static igScrollbarEx(param*)
    {
        dllcall("imgui\igScrollbarEx")
    }
    
    static igSelectable_Bool(param*)
    {
        dllcall("imgui\igSelectable_Bool")
    }
    
    static igSelectable_BoolPtr(param*)
    {
        dllcall("imgui\igSelectable_BoolPtr")
    }
    
    static igSeparator(param*)
    {
        dllcall("imgui\igSeparator")
    }
    
    static igSeparatorEx(param*)
    {
        dllcall("imgui\igSeparatorEx")
    }
    
    static igSetActiveID(param*)
    {
        dllcall("imgui\igSetActiveID")
    }
    
    static igSetActiveIdUsingKey(param*)
    {
        dllcall("imgui\igSetActiveIdUsingKey")
    }
    
    static igSetActiveIdUsingNavAndKeys(param*)
    {
        dllcall("imgui\igSetActiveIdUsingNavAndKeys")
    }
    
    static igSetAllocatorFunctions(param*)
    {
        dllcall("imgui\igSetAllocatorFunctions")
    }
    
    static igSetClipboardText(param*)
    {
        dllcall("imgui\igSetClipboardText")
    }
    
    static igSetColorEditOptions(param*)
    {
        dllcall("imgui\igSetColorEditOptions")
    }
    
    static igSetColumnOffset(param*)
    {
        dllcall("imgui\igSetColumnOffset")
    }
    
    static igSetColumnWidth(param*)
    {
        dllcall("imgui\igSetColumnWidth")
    }
    
    static igSetCurrentContext(param*)
    {
        dllcall("imgui\igSetCurrentContext")
    }
    
    static igSetCurrentFont(param*)
    {
        dllcall("imgui\igSetCurrentFont")
    }
    
    static igSetCurrentViewport(param*)
    {
        dllcall("imgui\igSetCurrentViewport")
    }
    
    static igSetCursorPos(param*)
    {
        dllcall("imgui\igSetCursorPos")
    }
    
    static igSetCursorPosX(param*)
    {
        dllcall("imgui\igSetCursorPosX")
    }
    
    static igSetCursorPosY(param*)
    {
        dllcall("imgui\igSetCursorPosY")
    }
    
    static igSetCursorScreenPos(param*)
    {
        dllcall("imgui\igSetCursorScreenPos")
    }
    
    static igSetDragDropPayload(param*)
    {
        dllcall("imgui\igSetDragDropPayload")
    }
    
    static igSetFocusID(param*)
    {
        dllcall("imgui\igSetFocusID")
    }
    
    static igSetHoveredID(param*)
    {
        dllcall("imgui\igSetHoveredID")
    }
    
    static igSetItemAllowOverlap(param*)
    {
        dllcall("imgui\igSetItemAllowOverlap")
    }
    
    static igSetItemDefaultFocus(param*)
    {
        dllcall("imgui\igSetItemDefaultFocus")
    }
    
    static igSetItemUsingMouseWheel(param*)
    {
        dllcall("imgui\igSetItemUsingMouseWheel")
    }
    
    static igSetKeyboardFocusHere(param*)
    {
        dllcall("imgui\igSetKeyboardFocusHere")
    }
    
    static igSetLastItemData(param*)
    {
        dllcall("imgui\igSetLastItemData")
    }
    
    static igSetMouseCursor(param*)
    {
        dllcall("imgui\igSetMouseCursor")
    }
    
    static igSetNavID(param*)
    {
        dllcall("imgui\igSetNavID")
    }
    
    static igSetNextItemOpen(param*)
    {
        dllcall("imgui\igSetNextItemOpen")
    }
    
    static igSetNextItemWidth(param*)
    {
        dllcall("imgui\igSetNextItemWidth")
    }
    
    static igSetNextWindowBgAlpha(param*)
    {
        dllcall("imgui\igSetNextWindowBgAlpha")
    }
    
    static igSetNextWindowClass(param*)
    {
        dllcall("imgui\igSetNextWindowClass")
    }
    
    static igSetNextWindowCollapsed(param*)
    {
        dllcall("imgui\igSetNextWindowCollapsed")
    }
    
    static igSetNextWindowContentSize(param*)
    {
        dllcall("imgui\igSetNextWindowContentSize")
    }
    
    static igSetNextWindowDockID(param*)
    {
        dllcall("imgui\igSetNextWindowDockID")
    }
    
    static igSetNextWindowFocus(param*)
    {
        dllcall("imgui\igSetNextWindowFocus")
    }
    
    static igSetNextWindowPos(param*)
    {
        dllcall("imgui\igSetNextWindowPos")
    }
    
    static igSetNextWindowScroll(param*)
    {
        dllcall("imgui\igSetNextWindowScroll")
    }
    
    static igSetNextWindowSize(param*)
    {
        dllcall("imgui\igSetNextWindowSize")
    }
    
    static igSetNextWindowSizeConstraints(param*)
    {
        dllcall("imgui\igSetNextWindowSizeConstraints")
    }
    
    static igSetNextWindowViewport(param*)
    {
        dllcall("imgui\igSetNextWindowViewport")
    }
    
    static igSetScrollFromPosX_Float(param*)
    {
        dllcall("imgui\igSetScrollFromPosX_Float")
    }
    
    static igSetScrollFromPosX_WindowPtr(param*)
    {
        dllcall("imgui\igSetScrollFromPosX_WindowPtr")
    }
    
    static igSetScrollFromPosY_Float(param*)
    {
        dllcall("imgui\igSetScrollFromPosY_Float")
    }
    
    static igSetScrollFromPosY_WindowPtr(param*)
    {
        dllcall("imgui\igSetScrollFromPosY_WindowPtr")
    }
    
    static igSetScrollHereX(param*)
    {
        dllcall("imgui\igSetScrollHereX")
    }
    
    static igSetScrollHereY(param*)
    {
        dllcall("imgui\igSetScrollHereY")
    }
    
    static igSetScrollX_Float(param*)
    {
        dllcall("imgui\igSetScrollX_Float")
    }
    
    static igSetScrollX_WindowPtr(param*)
    {
        dllcall("imgui\igSetScrollX_WindowPtr")
    }
    
    static igSetScrollY_Float(param*)
    {
        dllcall("imgui\igSetScrollY_Float")
    }
    
    static igSetScrollY_WindowPtr(param*)
    {
        dllcall("imgui\igSetScrollY_WindowPtr")
    }
    
    static igSetStateStorage(param*)
    {
        dllcall("imgui\igSetStateStorage")
    }
    
    static igSetTabItemClosed(param*)
    {
        dllcall("imgui\igSetTabItemClosed")
    }
    
    static igSetTooltip(param*)
    {
        dllcall("imgui\igSetTooltip")
    }
    
    static igSetTooltipV(param*)
    {
        dllcall("imgui\igSetTooltipV")
    }
    
    static igSetWindowClipRectBeforeSetChannel(param*)
    {
        dllcall("imgui\igSetWindowClipRectBeforeSetChannel")
    }
    
    static igSetWindowCollapsed_Bool(param*)
    {
        dllcall("imgui\igSetWindowCollapsed_Bool")
    }
    
    static igSetWindowCollapsed_Str(param*)
    {
        dllcall("imgui\igSetWindowCollapsed_Str")
    }
    
    static igSetWindowCollapsed_WindowPtr(param*)
    {
        dllcall("imgui\igSetWindowCollapsed_WindowPtr")
    }
    
    static igSetWindowDock(param*)
    {
        dllcall("imgui\igSetWindowDock")
    }
    
    static igSetWindowFocus_Nil(param*)
    {
        dllcall("imgui\igSetWindowFocus_Nil")
    }
    
    static igSetWindowFocus_Str(param*)
    {
        dllcall("imgui\igSetWindowFocus_Str")
    }
    
    static igSetWindowFontScale(param*)
    {
        dllcall("imgui\igSetWindowFontScale")
    }
    
    static igSetWindowHitTestHole(param*)
    {
        dllcall("imgui\igSetWindowHitTestHole")
    }
    
    static igSetWindowPos_Str(param*)
    {
        dllcall("imgui\igSetWindowPos_Str")
    }
    
    static igSetWindowPos_Vec2(param*)
    {
        dllcall("imgui\igSetWindowPos_Vec2")
    }
    
    static igSetWindowPos_WindowPtr(param*)
    {
        dllcall("imgui\igSetWindowPos_WindowPtr")
    }
    
    static igSetWindowSize_Str(param*)
    {
        dllcall("imgui\igSetWindowSize_Str")
    }
    
    static igSetWindowSize_Vec2(param*)
    {
        dllcall("imgui\igSetWindowSize_Vec2")
    }
    
    static igSetWindowSize_WindowPtr(param*)
    {
        dllcall("imgui\igSetWindowSize_WindowPtr")
    }
    
    static igShadeVertsLinearColorGradientKeepAlpha(param*)
    {
        dllcall("imgui\igShadeVertsLinearColorGradientKeepAlpha")
    }
    
    static igShadeVertsLinearUV(param*)
    {
        dllcall("imgui\igShadeVertsLinearUV")
    }
    
    static igShowAboutWindow(param*)
    {
        dllcall("imgui\igShowAboutWindow")
    }
    
    static igShowDemoWindow(param*)
    {
        dllcall("imgui\igShowDemoWindow")
    }
    
    static igShowFontAtlas(param*)
    {
        dllcall("imgui\igShowFontAtlas")
    }
    
    static igShowFontSelector(param*)
    {
        dllcall("imgui\igShowFontSelector")
    }
    
    static igShowMetricsWindow(param*)
    {
        dllcall("imgui\igShowMetricsWindow")
    }
    
    static igShowStackToolWindow(param*)
    {
        dllcall("imgui\igShowStackToolWindow")
    }
    
    static igShowStyleEditor(param*)
    {
        dllcall("imgui\igShowStyleEditor")
    }
    
    static igShowStyleSelector(param*)
    {
        dllcall("imgui\igShowStyleSelector")
    }
    
    static igShowUserGuide(param*)
    {
        dllcall("imgui\igShowUserGuide")
    }
    
    static igShrinkWidths(param*)
    {
        dllcall("imgui\igShrinkWidths")
    }
    
    static igShutdown(param*)
    {
        dllcall("imgui\igShutdown")
    }
    
    static igSliderAngle(param*)
    {
        dllcall("imgui\igSliderAngle")
    }
    
    static igSliderBehavior(param*)
    {
        dllcall("imgui\igSliderBehavior")
    }
    
    static igSliderFloat(param*)
    {
        dllcall("imgui\igSliderFloat")
    }
    
    static igSliderFloat2(param*)
    {
        dllcall("imgui\igSliderFloat2")
    }
    
    static igSliderFloat3(param*)
    {
        dllcall("imgui\igSliderFloat3")
    }
    
    static igSliderFloat4(param*)
    {
        dllcall("imgui\igSliderFloat4")
    }
    
    static igSliderInt(param*)
    {
        dllcall("imgui\igSliderInt")
    }
    
    static igSliderInt2(param*)
    {
        dllcall("imgui\igSliderInt2")
    }
    
    static igSliderInt3(param*)
    {
        dllcall("imgui\igSliderInt3")
    }
    
    static igSliderInt4(param*)
    {
        dllcall("imgui\igSliderInt4")
    }
    
    static igSliderScalar(param*)
    {
        dllcall("imgui\igSliderScalar")
    }
    
    static igSliderScalarN(param*)
    {
        dllcall("imgui\igSliderScalarN")
    }
    
    static igSmallButton(param*)
    {
        dllcall("imgui\igSmallButton")
    }
    
    static igSpacing(param*)
    {
        dllcall("imgui\igSpacing")
    }
    
    static igSplitterBehavior(param*)
    {
        dllcall("imgui\igSplitterBehavior")
    }
    
    static igStartMouseMovingWindow(param*)
    {
        dllcall("imgui\igStartMouseMovingWindow")
    }
    
    static igStartMouseMovingWindowOrNode(param*)
    {
        dllcall("imgui\igStartMouseMovingWindowOrNode")
    }
    
    static igStyleColorsClassic(param*)
    {
        dllcall("imgui\igStyleColorsClassic")
    }
    
    static igStyleColorsDark(param*)
    {
        dllcall("imgui\igStyleColorsDark")
    }
    
    static igStyleColorsLight(param*)
    {
        dllcall("imgui\igStyleColorsLight")
    }
    
    static igTabBarAddTab(param*)
    {
        dllcall("imgui\igTabBarAddTab")
    }
    
    static igTabBarCloseTab(param*)
    {
        dllcall("imgui\igTabBarCloseTab")
    }
    
    static igTabBarFindMostRecentlySelectedTabForActiveWindow(param*)
    {
        dllcall("imgui\igTabBarFindMostRecentlySelectedTabForActiveWindow")
    }
    
    static igTabBarFindTabByID(param*)
    {
        dllcall("imgui\igTabBarFindTabByID")
    }
    
    static igTabBarProcessReorder(param*)
    {
        dllcall("imgui\igTabBarProcessReorder")
    }
    
    static igTabBarQueueReorder(param*)
    {
        dllcall("imgui\igTabBarQueueReorder")
    }
    
    static igTabBarQueueReorderFromMousePos(param*)
    {
        dllcall("imgui\igTabBarQueueReorderFromMousePos")
    }
    
    static igTabBarRemoveTab(param*)
    {
        dllcall("imgui\igTabBarRemoveTab")
    }
    
    static igTabItemBackground(param*)
    {
        dllcall("imgui\igTabItemBackground")
    }
    
    static igTabItemButton(param*)
    {
        dllcall("imgui\igTabItemButton")
    }
    
    static igTabItemCalcSize(param*)
    {
        dllcall("imgui\igTabItemCalcSize")
    }
    
    static igTabItemEx(param*)
    {
        dllcall("imgui\igTabItemEx")
    }
    
    static igTabItemLabelAndCloseButton(param*)
    {
        dllcall("imgui\igTabItemLabelAndCloseButton")
    }
    
    static igTableBeginApplyRequests(param*)
    {
        dllcall("imgui\igTableBeginApplyRequests")
    }
    
    static igTableBeginCell(param*)
    {
        dllcall("imgui\igTableBeginCell")
    }
    
    static igTableBeginInitMemory(param*)
    {
        dllcall("imgui\igTableBeginInitMemory")
    }
    
    static igTableBeginRow(param*)
    {
        dllcall("imgui\igTableBeginRow")
    }
    
    static igTableDrawBorders(param*)
    {
        dllcall("imgui\igTableDrawBorders")
    }
    
    static igTableDrawContextMenu(param*)
    {
        dllcall("imgui\igTableDrawContextMenu")
    }
    
    static igTableEndCell(param*)
    {
        dllcall("imgui\igTableEndCell")
    }
    
    static igTableEndRow(param*)
    {
        dllcall("imgui\igTableEndRow")
    }
    
    static igTableFindByID(param*)
    {
        dllcall("imgui\igTableFindByID")
    }
    
    static igTableFixColumnSortDirection(param*)
    {
        dllcall("imgui\igTableFixColumnSortDirection")
    }
    
    static igTableGcCompactSettings(param*)
    {
        dllcall("imgui\igTableGcCompactSettings")
    }
    
    static igTableGcCompactTransientBuffers_TablePtr(param*)
    {
        dllcall("imgui\igTableGcCompactTransientBuffers_TablePtr")
    }
    
    static igTableGcCompactTransientBuffers_TableTempDataPtr(param*)
    {
        dllcall("imgui\igTableGcCompactTransientBuffers_TableTempDataPtr")
    }
    
    static igTableGetBoundSettings(param*)
    {
        dllcall("imgui\igTableGetBoundSettings")
    }
    
    static igTableGetCellBgRect(param*)
    {
        dllcall("imgui\igTableGetCellBgRect")
    }
    
    static igTableGetColumnCount(param*)
    {
        dllcall("imgui\igTableGetColumnCount")
    }
    
    static igTableGetColumnFlags(param*)
    {
        dllcall("imgui\igTableGetColumnFlags")
    }
    
    static igTableGetColumnIndex(param*)
    {
        dllcall("imgui\igTableGetColumnIndex")
    }
    
    static igTableGetColumnName_Int(param*)
    {
        dllcall("imgui\igTableGetColumnName_Int")
    }
    
    static igTableGetColumnName_TablePtr(param*)
    {
        dllcall("imgui\igTableGetColumnName_TablePtr")
    }
    
    static igTableGetColumnNextSortDirection(param*)
    {
        dllcall("imgui\igTableGetColumnNextSortDirection")
    }
    
    static igTableGetColumnResizeID(param*)
    {
        dllcall("imgui\igTableGetColumnResizeID")
    }
    
    static igTableGetColumnWidthAuto(param*)
    {
        dllcall("imgui\igTableGetColumnWidthAuto")
    }
    
    static igTableGetHeaderRowHeight(param*)
    {
        dllcall("imgui\igTableGetHeaderRowHeight")
    }
    
    static igTableGetHoveredColumn(param*)
    {
        dllcall("imgui\igTableGetHoveredColumn")
    }
    
    static igTableGetMaxColumnWidth(param*)
    {
        dllcall("imgui\igTableGetMaxColumnWidth")
    }
    
    static igTableGetRowIndex(param*)
    {
        dllcall("imgui\igTableGetRowIndex")
    }
    
    static igTableGetSortSpecs(param*)
    {
        dllcall("imgui\igTableGetSortSpecs")
    }
    
    static igTableHeader(param*)
    {
        dllcall("imgui\igTableHeader")
    }
    
    static igTableHeadersRow(param*)
    {
        dllcall("imgui\igTableHeadersRow")
    }
    
    static igTableLoadSettings(param*)
    {
        dllcall("imgui\igTableLoadSettings")
    }
    
    static igTableMergeDrawChannels(param*)
    {
        dllcall("imgui\igTableMergeDrawChannels")
    }
    
    static igTableNextColumn(param*)
    {
        dllcall("imgui\igTableNextColumn")
    }
    
    static igTableNextRow(param*)
    {
        dllcall("imgui\igTableNextRow")
    }
    
    static igTableOpenContextMenu(param*)
    {
        dllcall("imgui\igTableOpenContextMenu")
    }
    
    static igTablePopBackgroundChannel(param*)
    {
        dllcall("imgui\igTablePopBackgroundChannel")
    }
    
    static igTablePushBackgroundChannel(param*)
    {
        dllcall("imgui\igTablePushBackgroundChannel")
    }
    
    static igTableRemove(param*)
    {
        dllcall("imgui\igTableRemove")
    }
    
    static igTableResetSettings(param*)
    {
        dllcall("imgui\igTableResetSettings")
    }
    
    static igTableSaveSettings(param*)
    {
        dllcall("imgui\igTableSaveSettings")
    }
    
    static igTableSetBgColor(param*)
    {
        dllcall("imgui\igTableSetBgColor")
    }
    
    static igTableSetColumnEnabled(param*)
    {
        dllcall("imgui\igTableSetColumnEnabled")
    }
    
    static igTableSetColumnIndex(param*)
    {
        dllcall("imgui\igTableSetColumnIndex")
    }
    
    static igTableSetColumnSortDirection(param*)
    {
        dllcall("imgui\igTableSetColumnSortDirection")
    }
    
    static igTableSetColumnWidth(param*)
    {
        dllcall("imgui\igTableSetColumnWidth")
    }
    
    static igTableSetColumnWidthAutoAll(param*)
    {
        dllcall("imgui\igTableSetColumnWidthAutoAll")
    }
    
    static igTableSetColumnWidthAutoSingle(param*)
    {
        dllcall("imgui\igTableSetColumnWidthAutoSingle")
    }
    
    static igTableSettingsCreate(param*)
    {
        dllcall("imgui\igTableSettingsCreate")
    }
    
    static igTableSettingsFindByID(param*)
    {
        dllcall("imgui\igTableSettingsFindByID")
    }
    
    static igTableSettingsInstallHandler(param*)
    {
        dllcall("imgui\igTableSettingsInstallHandler")
    }
    
    static igTableSetupColumn(param*)
    {
        dllcall("imgui\igTableSetupColumn")
    }
    
    static igTableSetupDrawChannels(param*)
    {
        dllcall("imgui\igTableSetupDrawChannels")
    }
    
    static igTableSetupScrollFreeze(param*)
    {
        dllcall("imgui\igTableSetupScrollFreeze")
    }
    
    static igTableSortSpecsBuild(param*)
    {
        dllcall("imgui\igTableSortSpecsBuild")
    }
    
    static igTableSortSpecsSanitize(param*)
    {
        dllcall("imgui\igTableSortSpecsSanitize")
    }
    
    static igTableUpdateBorders(param*)
    {
        dllcall("imgui\igTableUpdateBorders")
    }
    
    static igTableUpdateColumnsWeightFromWidth(param*)
    {
        dllcall("imgui\igTableUpdateColumnsWeightFromWidth")
    }
    
    static igTableUpdateLayout(param*)
    {
        dllcall("imgui\igTableUpdateLayout")
    }
    
    static igTempInputIsActive(param*)
    {
        dllcall("imgui\igTempInputIsActive")
    }
    
    static igTempInputScalar(param*)
    {
        dllcall("imgui\igTempInputScalar")
    }
    
    static igTempInputText(param*)
    {
        dllcall("imgui\igTempInputText")
    }
    
    static igText(param*)
    {
        dllcall("imgui\igText")
    }
    
    static igTextColored(param*)
    {
        dllcall("imgui\igTextColored")
    }
    
    static igTextColoredV(param*)
    {
        dllcall("imgui\igTextColoredV")
    }
    
    static igTextDisabled(param*)
    {
        dllcall("imgui\igTextDisabled")
    }
    
    static igTextDisabledV(param*)
    {
        dllcall("imgui\igTextDisabledV")
    }
    
    static igTextEx(param*)
    {
        dllcall("imgui\igTextEx")
    }
    
    static igTextUnformatted(param*)
    {
        dllcall("imgui\igTextUnformatted")
    }
    
    static igTextV(param*)
    {
        dllcall("imgui\igTextV")
    }
    
    static igTextWrapped(param*)
    {
        dllcall("imgui\igTextWrapped")
    }
    
    static igTextWrappedV(param*)
    {
        dllcall("imgui\igTextWrappedV")
    }
    
    static igTranslateWindowsInViewport(param*)
    {
        dllcall("imgui\igTranslateWindowsInViewport")
    }
    
    static igTreeNodeBehavior(param*)
    {
        dllcall("imgui\igTreeNodeBehavior")
    }
    
    static igTreeNodeBehaviorIsOpen(param*)
    {
        dllcall("imgui\igTreeNodeBehaviorIsOpen")
    }
    
    static igTreeNodeExV_Ptr(param*)
    {
        dllcall("imgui\igTreeNodeExV_Ptr")
    }
    
    static igTreeNodeExV_Str(param*)
    {
        dllcall("imgui\igTreeNodeExV_Str")
    }
    
    static igTreeNodeEx_Ptr(param*)
    {
        dllcall("imgui\igTreeNodeEx_Ptr")
    }
    
    static igTreeNodeEx_Str(param*)
    {
        dllcall("imgui\igTreeNodeEx_Str")
    }
    
    static igTreeNodeEx_StrStr(param*)
    {
        dllcall("imgui\igTreeNodeEx_StrStr")
    }
    
    static igTreeNodeV_Ptr(param*)
    {
        dllcall("imgui\igTreeNodeV_Ptr")
    }
    
    static igTreeNodeV_Str(param*)
    {
        dllcall("imgui\igTreeNodeV_Str")
    }
    
    static igTreeNode_Ptr(param*)
    {
        dllcall("imgui\igTreeNode_Ptr")
    }
    
    static igTreeNode_Str(param*)
    {
        dllcall("imgui\igTreeNode_Str")
    }
    
    static igTreeNode_StrStr(param*)
    {
        dllcall("imgui\igTreeNode_StrStr")
    }
    
    static igTreePop(param*)
    {
        dllcall("imgui\igTreePop")
    }
    
    static igTreePushOverrideID(param*)
    {
        dllcall("imgui\igTreePushOverrideID")
    }
    
    static igTreePush_Ptr(param*)
    {
        dllcall("imgui\igTreePush_Ptr")
    }
    
    static igTreePush_Str(param*)
    {
        dllcall("imgui\igTreePush_Str")
    }
    
    static igUnindent(param*)
    {
        dllcall("imgui\igUnindent")
    }
    
    static igUpdateHoveredWindowAndCaptureFlags(param*)
    {
        dllcall("imgui\igUpdateHoveredWindowAndCaptureFlags")
    }
    
    static igUpdateInputEvents(param*)
    {
        dllcall("imgui\igUpdateInputEvents")
    }
    
    static igUpdateMouseMovingWindowEndFrame(param*)
    {
        dllcall("imgui\igUpdateMouseMovingWindowEndFrame")
    }
    
    static igUpdateMouseMovingWindowNewFrame(param*)
    {
        dllcall("imgui\igUpdateMouseMovingWindowNewFrame")
    }
    
    static igUpdatePlatformWindows(param*)
    {
        dllcall("imgui\igUpdatePlatformWindows")
    }
    
    static igUpdateWindowParentAndRootLinks(param*)
    {
        dllcall("imgui\igUpdateWindowParentAndRootLinks")
    }
    
    static igVSliderFloat(param*)
    {
        dllcall("imgui\igVSliderFloat")
    }
    
    static igVSliderInt(param*)
    {
        dllcall("imgui\igVSliderInt")
    }
    
    static igVSliderScalar(param*)
    {
        dllcall("imgui\igVSliderScalar")
    }
    
    static igValue_Bool(param*)
    {
        dllcall("imgui\igValue_Bool")
    }
    
    static igValue_Float(param*)
    {
        dllcall("imgui\igValue_Float")
    }
    
    static igValue_Int(param*)
    {
        dllcall("imgui\igValue_Int")
    }
    
    static igValue_Uint(param*)
    {
        dllcall("imgui\igValue_Uint")
    }
    
    static igWindowRectAbsToRel(param*)
    {
        dllcall("imgui\igWindowRectAbsToRel")
    }
    
    static igWindowRectRelToAbs(param*)
    {
        dllcall("imgui\igWindowRectRelToAbs")
    }
    
    static imgui_dll_test(param*)
    {
        dllcall("imgui\imgui_dll_test")
    }
    
    static imgui_get_custom_font_range(param*)
    {
        dllcall("imgui\imgui_get_custom_font_range")
    }
    
    static imgui_get_custom_font_range_from_string(param*)
    {
        dllcall("imgui\imgui_get_custom_font_range_from_string")
    }
    
    static imgui_stbi__fopen(param*)
    {
        dllcall("imgui\imgui_stbi__fopen")
    }
    
    static imgui_stbi__gif_load_next(param*)
    {
        dllcall("imgui\imgui_stbi__gif_load_next")
    }
    
    static imgui_stbi__load_gif(param*)
    {
        dllcall("imgui\imgui_stbi__load_gif")
    }
    
    static imgui_stbi__start_file(param*)
    {
        dllcall("imgui\imgui_stbi__start_file")
    }
    
    static imgui_toggle_button(param*)
    {
        dllcall("imgui\imgui_toggle_button")
    }
}

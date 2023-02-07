#Include <ahkwin32\CGdip>
_Token := CGdip.Startup()

Class win32ui
{
    Class Bitmap
    {
        CreateCompatibleBitmap(hdc, width, height)
        {
            this.hwnd := hdc.hwnd
            this.hbm := CreateDIBSection(width, height)
        }
        
        SaveBitmapFile(hdc, filename)
        {
            DllCall("gdiplus\GdipCreateBitmapFromHBITMAP", "Ptr", this.hbm, "Ptr", 0, "Ptr*", &pBitmap := 0)
            DeleteDC(hdc.hdc)
            CGdip.Bitmap(pBitmap).Save(filename)
        }
    }
    
    Class HDC
    {
        __New(hwnd := 0, hdc := 0)
        {
            this.hwnd := hwnd
            this.hdc := hdc
        }
        
        BitBlt(arr_dxy, arr_dwh, sdc, arr_sxy, Raster := "")
        {
            Ret := DllCall("gdi32\BitBlt", "Ptr", this.hdc, "Int", arr_dxy[1], "Int", arr_dxy[2], "Int", arr_dwh[1], "Int", arr_dwh[2], "Ptr", sDC.hdc, "Int", arr_sxy[1], "Int", arr_sxy[2], "UInt", Raster ? Raster : 0x00CC0020)
            ReleaseDC(sDC.hdc)
            
            Return Ret
        }
        
        CreateCompatibleDC()
        {
            Return win32ui.HDC(, CreateCompatibleDC())
        }
        
        SelectObject(bitmap)
        {
            this.obm := SelectObject(this.hdc, bitmap.hbm)
			PrintWindow(bitmap.hwnd, this.hdc)
        }
    }
    
    Static CreateBitmap()
    {
        Return win32ui.Bitmap()
    }
    
    Static CreateDCFromHandle(dc)
    {
        Return win32ui.HDC(dc.hwnd)
    }
    
    Static AFX_IDW_PANE_FIRST := 59648
    Static AFX_IDW_PANE_LAST := 59903

    Static AFX_WS_DEFAULT_VIEW := 1350565888

    Static CDocTemplate_Confidence_maybeAttemptForeign := 1
    Static CDocTemplate_Confidence_maybeAttemptNative := 2
    Static CDocTemplate_Confidence_noAttempt := 0
    Static CDocTemplate_Confidence_yesAlreadyOpen := 5
    Static CDocTemplate_Confidence_yesAttemptForeign := 3
    Static CDocTemplate_Confidence_yesAttemptNative := 4

    Static CDocTemplate_docName := 1
    Static CDocTemplate_fileNewName := 2
    Static CDocTemplate_filterExt := 4
    Static CDocTemplate_filterName := 3
    Static CDocTemplate_regFileTypeId := 5
    Static CDocTemplate_regFileTypeName := 6
    Static CDocTemplate_windowTitle := 0

    Static copyright := 'Copyright 1994-2018 Mark Hammond'

    Static CRichEditView_WrapNone := 0
    Static CRichEditView_WrapToTargetDevice := 2
    Static CRichEditView_WrapToWindow := 1

    Static debug := 0

    Static dllhandle := 140727847813120

    Static FWS_ADDTOTITLE := 32768
    Static FWS_PREFIXTITLE := 16384
    Static FWS_SNAPTOBARS := 8192

    Static IDB_BROWSER_HIER := 11145

    Static IDB_DEBUGGER_HIER := 16018

    Static IDB_HIERFOLDERS := 11142

    Static IDC_ABOUT_VERSION := 15062

    Static IDC_AUTOCOMPLETE := 15071

    Static IDC_AUTO_RELOAD := 15059

    Static IDC_BUTTON1 := 15004
    Static IDC_BUTTON2 := 15005
    Static IDC_BUTTON3 := 15006
    Static IDC_BUTTON4 := 15068
    Static IDC_CALLTIPS := 15072
    Static IDC_CHECK1 := 15066
    Static IDC_CHECK2 := 15067
    Static IDC_CHECK3 := 11151
    Static IDC_COMBO1 := 15058
    Static IDC_COMBO2 := 15076

    Static IDC_DBG_ADD := 16004
    Static IDC_DBG_BREAKPOINTS := 36889
    Static IDC_DBG_CLEAR := 16006
    Static IDC_DBG_CLOSE := 16010
    Static IDC_DBG_GO := 15022
    Static IDC_DBG_STACK := 36888
    Static IDC_DBG_STEP := 16013
    Static IDC_DBG_STEPOUT := 15020
    Static IDC_DBG_STEPOVER := 15021
    Static IDC_DBG_WATCH := 40002

    Static IDC_EDIT1 := 15008
    Static IDC_EDIT2 := 15009
    Static IDC_EDIT3 := 15010
    Static IDC_EDIT4 := 15011

    Static IDC_EDITOR_COLOR := 15073

    Static IDC_EDIT_TABS := 15028

    Static IDC_FOLD_ENABLE := 15078

    Static IDC_FOLD_ON_OPEN := 15073

    Static IDC_FOLD_SHOW_LINES := 15070

    Static IDC_INDENT_SIZE := 15055

    Static IDC_KEYBOARD_CONFIG := 15074

    Static IDC_LIST1 := 15013

    Static IDC_MARGIN_FOLD := 15082
    Static IDC_MARGIN_LINENUMBER := 15081
    Static IDC_MARGIN_MARKER := 15080

    Static IDC_PROMPT1 := 15014
    Static IDC_PROMPT2 := 15015
    Static IDC_PROMPT3 := 15016
    Static IDC_PROMPT4 := 15017

    Static IDC_PROMPT_TABS := 15039

    Static IDC_RADIO1 := 15061
    Static IDC_RADIO2 := 15062

    Static IDC_RIGHTEDGE_COLUMN := 15083
    Static IDC_RIGHTEDGE_DEFINE := 15086
    Static IDC_RIGHTEDGE_ENABLE := 15084
    Static IDC_RIGHTEDGE_SAMPLE := 15085

    Static IDC_SPIN1 := 15056
    Static IDC_SPIN2 := 15057
    Static IDC_SPIN3 := 15060

    Static IDC_TABTIMMY_BG := 15078
    Static IDC_TABTIMMY_IND := 15079
    Static IDC_TABTIMMY_NONE := 15077

    Static IDC_TAB_SIZE := 15054

    Static IDC_USE_SMART_TABS := 15064

    Static IDC_USE_TABS := 15053

    Static IDC_VIEW_EOL := 15071
    Static IDC_VIEW_INDENTATIONGUIDES := 15072
    Static IDC_VIEW_WHITESPACE := 15070

    Static IDC_VSS_INTEGRATE := 15063

    Static IDD_ABOUTBOX := 11139
    Static IDD_DUMMYPROPPAGE := 11148

    Static IDD_GENERAL_STATUS := 11149

    Static IDD_LARGE_EDIT := 11147

    Static IDD_PP_DEBUGGER := 16012
    Static IDD_PP_EDITOR := 11153
    Static IDD_PP_FORMAT := 15046
    Static IDD_PP_IDE := 11155
    Static IDD_PP_TABS := 11160
    Static IDD_PP_TOOLMENU := 11156

    Static IDD_PROPDEMO1 := 15019
    Static IDD_PROPDEMO2 := 15018

    Static IDD_RUN_SCRIPT := 15045

    Static IDD_SET_TABSTOPS := 15041

    Static IDD_SIMPLE_INPUT := 15044

    Static IDD_TREE := 15043

    Static IDD_TREE_MB := 15042

    Static IDR_CNTR_INPLACE := 6

    Static IDR_DEBUGGER := 11133
    Static IDR_MAINFRAME := 11128
    Static IDR_PYTHONCONTYPE := 11132
    Static IDR_PYTHONTYPE := 11129

    Static IDR_PYTHONTYPE_CNTR_IP := 11131

    Static IDR_TEXTTYPE := 11130

    Static ID_APP_ABOUT := 57664
    Static ID_APP_EXIT := 57665

    Static ID_EDIT_CLEAR := 57632

    Static ID_EDIT_CLEAR_ALL := 57633

    Static ID_EDIT_COPY := 57634
    Static ID_EDIT_CUT := 57635
    Static ID_EDIT_FIND := 57636

    Static ID_EDIT_GOTO_LINE := 57638

    Static ID_EDIT_PASTE := 57637
    Static ID_EDIT_REDO := 57644
    Static ID_EDIT_REPEAT := 57640
    Static ID_EDIT_REPLACE := 57641

    Static ID_EDIT_SELECT_ALL := 57642
    Static ID_EDIT_SELECT_BLOCK := 36875

    Static ID_EDIT_UNDO := 57643

    Static ID_FILE_CHECK := 36881
    Static ID_FILE_CLOSE := 57602
    Static ID_FILE_IMPORT := 36867
    Static ID_FILE_LOCATE := 36868

    Static ID_FILE_MRU_FILE1 := 57616
    Static ID_FILE_MRU_FILE2 := 57617
    Static ID_FILE_MRU_FILE3 := 57618
    Static ID_FILE_MRU_FILE4 := 57619

    Static ID_FILE_NEW := 57600
    Static ID_FILE_OPEN := 57601

    Static ID_FILE_PAGE_SETUP := 57605

    Static ID_FILE_PRINT := 57607

    Static ID_FILE_PRINT_PREVIEW := 57609
    Static ID_FILE_PRINT_SETUP := 57606

    Static ID_FILE_RUN := 36864
    Static ID_FILE_SAVE := 57603

    Static ID_FILE_SAVE_ALL := 36882
    Static ID_FILE_SAVE_AS := 57604

    Static ID_HELP_GUI_REF := 36870

    Static ID_HELP_OTHER := 14950
    Static ID_HELP_PYTHON := 36872

    Static ID_INDICATOR_COLNUM := 15038
    Static ID_INDICATOR_LINENUM := 15040

    Static ID_NEXT_PANE := 57680

    Static ID_PREV_PANE := 57681

    Static ID_SEPARATOR := 0

    Static ID_VIEW_BROWSE := 36869
    Static ID_VIEW_EOL := 36894

    Static ID_VIEW_FIXED_FONT := 15031

    Static ID_VIEW_FOLD_COLLAPSE := 36898

    Static ID_VIEW_FOLD_COLLAPSE_ALL := 36897

    Static ID_VIEW_FOLD_EXPAND := 36895

    Static ID_VIEW_FOLD_EXPAND_ALL := 36896

    Static ID_VIEW_FOLD_TOPLEVEL := 36900

    Static ID_VIEW_INDENTATIONGUIDES := 36901
    Static ID_VIEW_INTERACTIVE := 36873
    Static ID_VIEW_OPTIONS := 36879

    Static ID_VIEW_RIGHT_EDGE := 36904

    Static ID_VIEW_STATUS_BAR := 59393

    Static ID_VIEW_TOOLBAR := 59392

    Static ID_VIEW_TOOLBAR_DBG := 59424

    Static ID_VIEW_WHITESPACE := 36874

    Static ID_WINDOW_ARRANGE := 57649
    Static ID_WINDOW_CASCADE := 57650
    Static ID_WINDOW_NEW := 57648
    Static ID_WINDOW_SPLIT := 57653

    Static ID_WINDOW_TILE_HORZ := 57651
    Static ID_WINDOW_TILE_VERT := 57652

    Static LM_COMMIT := 64
    Static LM_HORZ := 2
    Static LM_HORZDOCK := 8
    Static LM_LENGTHY := 32
    Static LM_MRUWIDTH := 4
    Static LM_STRETCH := 1
    Static LM_VERTDOCK := 16

    Static MFS_4THICKFRAME := 512
    Static MFS_BLOCKSYSMENU := 4096
    Static MFS_MOVEFRAME := 2048
    Static MFS_SYNCACTIVE := 256
    Static MFS_THICKFRAME := 1024

    Static PD_ALLPAGES := 0
    Static PD_COLLATE := 16
    Static PD_DISABLEPRINTTOFILE := 524288
    Static PD_ENABLEPRINTHOOK := 4096
    Static PD_ENABLEPRINTTEMPLATE := 16384
    Static PD_ENABLEPRINTTEMPLATEHANDLE := 65536
    Static PD_ENABLESETUPHOOK := 8192
    Static PD_ENABLESETUPTEMPLATE := 32768
    Static PD_ENABLESETUPTEMPLATEHANDLE := 131072
    Static PD_HIDEPRINTTOFILE := 1048576
    Static PD_NONETWORKBUTTON := 2097152
    Static PD_NOPAGENUMS := 8
    Static PD_NOSELECTION := 4
    Static PD_NOWARNING := 128
    Static PD_PAGENUMS := 2
    Static PD_PRINTSETUP := 64
    Static PD_PRINTTOFILE := 32
    Static PD_RETURNDC := 256
    Static PD_RETURNDEFAULT := 1024
    Static PD_RETURNIC := 512
    Static PD_SELECTION := 1
    Static PD_SHOWHELP := 2048
    Static PD_USEDEVMODECOPIES := 262144
    Static PD_USEDEVMODECOPIESANDCOLLATE := 262144

    Static PSWIZB_BACK := 1
    Static PSWIZB_DISABLEDFINISH := 8
    Static PSWIZB_FINISH := 4
    Static PSWIZB_NEXT := 2

    Static UNICODE := 1
}
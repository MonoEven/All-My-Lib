#Include <tkinter\tcl_const>
#Include <tkinter\tcl>

class Tk_Const extends Tcl_Const
{
    static TK_MAJOR_VERSION := 8
    static TK_MINOR_VERSION := 6
    static TK_RELEASE_LEVEL := this.TCL_FINAL_RELEASE
    static TK_RELEASE_SERIAL := 11
    static TK_VERSION := "8.6"
    static TK_PATCH_LEVEL := "8.6.11"
    static TK_OPTION_NULL_OK := 1<<0
    static TK_OPTION_DONT_SET_DEFAULT := 1<<3
    static TK_CONFIG_ARGV_ONLY := 1
    static TK_CONFIG_OBJS := 0x80
    static TK_CONFIG_NULL_OK := 1<<0
    static TK_CONFIG_COLOR_ONLY := 1<<1
    static TK_CONFIG_MONO_ONLY	 := 1<<2
    static TK_CONFIG_DONT_SET_DEFAULT := 1<<3
    static TK_CONFIG_OPTION_SPECIFIED := 1<<4
    static TK_CONFIG_USER_BIT := 0x100
    static TK_ARGV_CONSTANT := 15
    static TK_ARGV_INT := 16
    static TK_ARGV_STRING := 17
    static TK_ARGV_UID := 18
    static TK_ARGV_REST := 19
    static TK_ARGV_FLOAT := 20
    static TK_ARGV_FUNC := 21
    static TK_ARGV_GENFUNC := 22
    static TK_ARGV_HELP := 23
    static TK_ARGV_CONST_OPTION := 24
    static TK_ARGV_OPTION_VALUE := 25
    static TK_ARGV_OPTION_NAME_VALUE := 26
    static TK_ARGV_END := 27
    static TK_ARGV_NO_DEFAULTS := 0x1
    static TK_ARGV_NO_LEFTOVERS := 0x2
    static TK_ARGV_NO_ABBREV := 0x4
    static TK_ARGV_DONT_SKIP_FIRST_ARG := 0x8
    static TK_WIDGET_DEFAULT_PRIO := 20
    static TK_STARTUP_FILE_PRIO := 40
    static TK_USER_DEFAULT_PRIO := 60
    static TK_INTERACTIVE_PRIO := 80
    static TK_MAX_PRIO := 100
    static TK_RELIEF_NULL := -1
    static TK_RELIEF_FLAT := 0
    static TK_RELIEF_GROOVE := 1
    static TK_RELIEF_RAISED := 2
    static TK_RELIEF_RIDGE := 3
    static TK_RELIEF_SOLID := 4
    static TK_RELIEF_SUNKEN := 5
    static TK_3D_FLAT_GC := 1
    static TK_3D_LIGHT_GC := 2
    static TK_3D_DARK_GC := 3
    static TK_NOTIFY_SHARE := 20
    static TK_WHOLE_WORDS := 1
    static TK_AT_LEAST_ONE := 2
    static TK_PARTIAL_OK := 4
    static TK_IGNORE_TABS := 8
    static TK_IGNORE_NEWLINES := 16
    static TK_SCROLL_MOVETO := 1
    static TK_SCROLL_PAGES := 2
    static TK_SCROLL_UNITS := 3
    static TK_SCROLL_ERROR := 4
    static MouseWheelMask := 1<<28
    static ActivateMask := 1<<29
    static VirtualEventMask := 1<<30
    static TK_MAPPED := 1
    static TK_TOP_LEVEL := 2
    static TK_ALREADY_DEAD := 4
    static TK_NEED_CONFIG_NOTIFY := 8
    static TK_GRAB_FLAG := 0x10
    static TK_CHECKED_IC := 0x20
    static TK_DONT_DESTROY_WINDOW := 0x40
    static TK_WM_COLORMAP_WINDOW := 0x80
    static TK_EMBEDDED := 0x100
    static TK_CONTAINER := 0x200
    static TK_BOTH_HALVES := 0x400
    static TK_WRAPPER := 0x1000
    static TK_REPARENTED := 0x2000
    static TK_ANONYMOUS_WINDOW := 0x4000
    static TK_HAS_WRAPPER := 0x8000
    static TK_WIN_MANAGED := 0x10000
    static TK_TOP_HIERARCHY := 0x20000
    static TK_PROP_PROPCHANGE := 0x40000
    static TK_WM_MANAGEABLE := 0x80000
    static TK_CAN_INPUT_TEXT := 0x100000
    static TK_TAG_SPACE := 3
    static TK_ITEM_STATE_DEPENDANT := 1
    static TK_ITEM_DONT_REDRAW	 := 2
    static TK_MOVABLE_POINTS := 2
    static TK_OFFSET_INDEX := 1
    static TK_OFFSET_RELATIVE := 2
    static TK_OFFSET_LEFT := 4
    static TK_OFFSET_CENTER := 8
    static TK_OFFSET_RIGHT := 16
    static TK_OFFSET_TOP := 32
    static TK_OFFSET_MIDDLE := 64
    static TK_OFFSET_BOTTOM := 128
    static TK_PHOTO_COMPOSITE_OVERLAY := 0
    static TK_PHOTO_COMPOSITE_SET := 1
    static TK_STYLE_VERSION_1 := 0x1
    static TK_STYLE_VERSION := this.TK_STYLE_VERSION_1
    static TK_ELEMENT_STATE_ACTIVE := 1<<0
    static TK_ELEMENT_STATE_DISABLED := 1<<1
    static TK_ELEMENT_STATE_FOCUS := 1<<2
    static TK_ELEMENT_STATE_PRESSED := 1<<3
    static TK_READABLE := this.TCL_READABLE
    static TK_WRITABLE := this.TCL_WRITABLE
    static TK_EXCEPTION := this.TCL_EXCEPTION
    static TK_DONT_WAIT := this.TCL_DONT_WAIT
    static TK_X_EVENTS := this.TCL_WINDOW_EVENTS
    static TK_WINDOW_EVENTS := this.TCL_WINDOW_EVENTS
    static TK_FILE_EVENTS := this.TCL_FILE_EVENTS
    static TK_TIMER_EVENTS := this.TCL_TIMER_EVENTS
    static TK_IDLE_EVENTS := this.TCL_IDLE_EVENTS
    static TK_ALL_EVENTS := this.TCL_ALL_EVENTS
    ; static Tk_IdleProc := Tcl.Tcl_IdleProc
    ; static Tk_FileProc := Tcl.Tcl_FileProc
    ; static Tk_TimerProc := Tcl.Tcl_TimerProc
    ; static Tk_TimerToken := Tcl.Tcl_TimerToken
    static Tk_BackgroundError := Tcl.Tcl_BackgroundError
    static Tk_CancelIdleCall := Tcl.Tcl_CancelIdleCall
    ; static Tk_CreateFileHandler := Tcl.Tcl_CreateFileHandler
    static Tk_CreateTimerHandler := Tcl.Tcl_CreateTimerHandler
    ; static Tk_DeleteFileHandler := Tcl.Tcl_DeleteFileHandler
    static Tk_DeleteTimerHandler := Tcl.Tcl_DeleteTimerHandler
    static Tk_DoOneEvent := Tcl.Tcl_DoOneEvent
    static Tk_DoWhenIdle := Tcl.Tcl_DoWhenIdle
    static Tk_Sleep := Tcl.Tcl_Sleep
    static Tk_EventuallyFree := Tcl.Tcl_EventuallyFree
    ; static Tk_FreeProc := Tcl.Tcl_FreeProc
    static Tk_Preserve := Tcl.Tcl_Preserve
    static Tk_Release := Tcl.Tcl_Release
    static TK_OPTION_BOOLEAN := 0
    static TK_OPTION_INT := 1
    static TK_OPTION_DOUBLE := 2
    static TK_OPTION_STRING := 3
    static TK_OPTION_STRING_TABLE := 4
    static TK_OPTION_COLOR := 5
    static TK_OPTION_FONT := 6
    static TK_OPTION_BITMAP := 7
    static TK_OPTION_BORDER := 8
    static TK_OPTION_RELIEF := 9
    static TK_OPTION_CURSOR := 10
    static TK_OPTION_JUSTIFY := 11
    static TK_OPTION_ANCHOR := 12
    static TK_OPTION_SYNONYM := 13
    static TK_OPTION_PIXELS := 14
    static TK_OPTION_WINDOW := 15
    static TK_OPTION_END := 16
    static TK_OPTION_CUSTOM := 17
    static TK_OPTION_STYLE := 18
    static TK_CONFIG_BOOLEAN := 0
    static TK_CONFIG_INT := 1
    static TK_CONFIG_DOUBLE := 2
    static TK_CONFIG_STRING := 3
    static TK_CONFIG_UID := 4
    static TK_CONFIG_COLOR := 5
    static TK_CONFIG_FONT := 6
    static TK_CONFIG_BITMAP := 7
    static TK_CONFIG_BORDER := 8
    static TK_CONFIG_RELIEF := 9
    static TK_CONFIG_CURSOR := 10
    static TK_CONFIG_ACTIVE_CURSOR := 11
    static TK_CONFIG_JUSTIFY := 12
    static TK_CONFIG_ANCHOR := 13
    static TK_CONFIG_SYNONYM := 14
    static TK_CONFIG_CAP_STYLE := 15
    static TK_CONFIG_JOIN_STYLE := 16
    static TK_CONFIG_PIXELS := 17
    static TK_CONFIG_MM := 18
    static TK_CONFIG_WINDOW := 19
    static TK_CONFIG_CUSTOM := 20
    static TK_CONFIG_END := 21
    static TK_DEFER_EVENT := 0
    static TK_PROCESS_EVENT := 1
    static TK_DISCARD_EVENT := 2
    static TK_ANCHOR_N := 0
    static TK_ANCHOR_NE := 1
    static TK_ANCHOR_E := 2
    static TK_ANCHOR_SE := 3
    static TK_ANCHOR_S := 4
    static TK_ANCHOR_SW := 5
    static TK_ANCHOR_W := 6
    static TK_ANCHOR_NW := 7
    static TK_ANCHOR_CENTER := 8
    static TK_JUSTIFY_LEFT := 0
    static TK_JUSTIFY_RIGHT := 1
    static TK_JUSTIFY_CENTER := 2
    static TK_STATE_NULL := -1
    static TK_STATE_ACTIVE := 0
    static TK_STATE_DISABLED := 1
    static TK_STATE_NORMAL := 2
    static TK_STATE_HIDDEN := 3
}
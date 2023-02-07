; BaseVersion: 2.7
; Version: 1.220904
; Author: Mono
; Time: 2022.09.04
; Reference: https://github.com/1024210879/cvui

#Include <cv2\cv2>

; 最新版本支持多线程
; cv2.setNumThreads(1)

; Access points to internal global namespaces.
__internal := CVUI._Internal()
_render := CVUI.Render()
_render._internal := CVUI._Internal()
theContext := CVUI._Context()
aOverlay := noArray()

Class CVUI
{
    Static VERSION := '2.7'

    Static ROW := 0
    Static COLUMN := 1
    Static DOWN := 2
    Static CLICK := 3
    Static OVER := 4
    Static OUT := 5
    Static UP := 6
    Static IS_DOWN := 7

    ; Constants regarding mouse buttons
    Static LEFT_BUTTON := 0
    Static MIDDLE_BUTTON := 1
    Static RIGHT_BUTTON := 2

    ; Constants regarding components
    Static TRACKBAR_HIDE_SEGMENT_LABELS := 1
    Static TRACKBAR_HIDE_STEP_SCALE := 2
    Static TRACKBAR_DISCRETE := 4
    Static TRACKBAR_HIDE_MIN_MAX_LABELS := 8
    Static TRACKBAR_HIDE_VALUE_LABEL := 16
    Static TRACKBAR_HIDE_LABELS := 32

    ; Internal things
    Static CVUI_ANTIALISED := cv2.LINE_AA
    Static CVUI_FILLED := -1

    ; Represent a 2D point.
    Class _Point
    {
        __New(theX := 0, theY := 0)
        {
            this.x := theX
            this.y := theY
        }

        inside(theRect)
        {
            return theRect.contains(this)
        }
    }

    ; Represent a rectangle.
    Class _Rect
    {
        __New(theX := 0, theY := 0, theWidth := 0, theHeight := 0)
        {
            this.x := theX
            this.y := theY
            this.width := theWidth
            this.height := theHeight
        }

        contains(thePoint)
        {
            return thePoint.x >= this.x and thePoint.x <= (this.x + this.width) and thePoint.y >= this.y and thePoint.y <= (this.y + this.height)
        }

        area()
        {
            return this.width * this.height
        }
    }

    ; Represent the size of something, i.e. width and height.
    ; It is essentially a simplified version of _Rect where x and y are zero.
    Class _Size Extends CVUI._Rect
    {
        __New(theWidth := 0, theHeight := 0)
        {
            this.x := 0
            this.y := 0
            this.width := theWidth
            this.height := theHeight
        }
    }

    ; Describe a block structure used by cvui to handle `begin*()` and `end*()` calls.
    Class _Block
    {
        __New()
        {
            this.where := None              ; where the block should be rendered to.
            this.rect := CVUI._Rect()             ; the size and position of the block.
            this.fill := CVUI._Rect()             ; the filled area occuppied by the block as it gets modified by its inner components.
            this.anchor := CVUI._Point()          ; the point where the next component of the block should be rendered.
            this.padding := 0               ; padding among components within this block.
            this.type := CVUI.ROW       		   ; type of the block, e.g. ROW or COLUMN.

            this.reset()
        }

        reset()
        {
            this.rect.x := 0
            this.rect.y := 0
            this.rect.width := 0
            this.rect.height := 0

            this.fill := this.rect
            this.fill.width := 0
            this.fill.height := 0

            this.anchor.x := 0
            this.anchor.y := 0

            this.padding := 0
        }
    }

    ; Describe a component label, including info about a shortcut.
    ; If a label contains "Re&start", then:
    ; - hasShortcut will be true
    ; - shortcut will be 's'
    ; - textBeforeShortcut will be "Re"
    ; - textAfterShortcut will be "tart"
    Class _Label
    {
        __New()
        {
            this.hasShortcut := False
            this.shortcut := ''
            this.textBeforeShortcut := ''
            this.textAfterShortcut := ''
        }
    }

    ; Describe a mouse button
    Class _MouseButton
    {
        __New()
        {
            this.justReleased := False           ; if the mouse button was released, i.e. click event.
            this.justPressed := False            ; if the mouse button was just pressed, i.e. true for a frame when a button is down.
            this.pressed := False                ; if the mouse button is pressed or not.
        }

        reset()
        {
            this.justPressed := False
            this.justReleased := False
            this.pressed := False
        }
    }

    ; Describe the information of the mouse cursor
    Class _Mouse
    {
        __New()
        {
            this.buttons := Map(                   ; status of each button. Use cvui.{RIGHT,LEFT,MIDDLE}_BUTTON to access the buttons.
                CVUI.LEFT_BUTTON, CVUI._MouseButton(),
                CVUI.MIDDLE_BUTTON, CVUI._MouseButton(),
                CVUI.RIGHT_BUTTON, CVUI._MouseButton()
            )
            this.anyButton := CVUI._MouseButton()     ; represent the behavior of all mouse buttons combined
            this.position := CVUI._Point(0, 0)        ; x and y coordinates of the mouse at the moment.
        }
    }

    ; Describe a (window) context.
    Class _Context
    {
        __New()
        {
            this.windowName := ''               ; name of the window related to this context.
            this.mouse := CVUI._Mouse()               ; the mouse cursor related to this context.
        }
    }

    ; Describe the inner parts of the trackbar component.
    Class _TrackbarParams
    {
        __New(theMin := 0., theMax := 25., theStep := 1., theSegments := 0, theLabelFormat := '%.0Lf', theOptions := 0)
        {
            this.min := theMin
            this.max := theMax
            this.step := theStep
            this.segments := theSegments
            this.options := theOptions
            this.labelFormat := theLabelFormat
        }
    }

    ; This Class contains all stuff that cvui uses internally to render
    ; and control interaction with components.
    Class _Internal
    {
        __New()
        {
            this.defaultContext := ''
            this.currentContext := ''
            this.contexts := Map()             ; indexed by the window name.
            this.buffer := []
            this.lastKeyPressed := -1       ; TODO: collect it per window
            this.delayWaitKey := -1
            this.screen := CVUI._Block()
            
            tmp := []
            
            Loop 100
                tmp.Push(CVUI._Block())
            
            this.stack := tmp ; TODO: make it dynamic
            this.stackCount := -1
            this.trackbarMarginX := 14
        }

        isMouseButton(theButton, theQuery)
        {
            aRet := False

            if (theQuery == CVUI.CLICK) or (theQuery == CVUI.UP)
                aRet := theButton.justReleased
            else if (theQuery == CVUI.DOWN)
                aRet := theButton.justPressed
            else if (theQuery == CVUI.IS_DOWN)
                aRet := theButton.pressed

            return aRet
        }

        mouseW(theWindowName := '')
        {
            /*
            Return the last position of the mouse.

            \param theWindowName name of the window whose mouse cursor will be used. If nothing is informed (default), the function will return the position of the mouse cursor for the default window (the one informed in `cvui::init()`).
            \return a point containing the position of the mouse cursor in the speficied window.
            */
            return this.getContext(theWindowName).mouse.position
        }

        mouseQ(theQuery)
        {
            /*
            Query the mouse for events, e.g. "is any button down now?". Available queries are

            * `cvui::DOWN`: any mouse button was pressed. `cvui::mouse()` returns `true` for a single frame only.
            * `cvui::UP`: any mouse button was released.  `cvui::mouse()` returns `true` for a single frame only.
            * `cvui::CLICK`: any mouse button was clicked (went down then up, no matter the amount of frames in between). `cvui::mouse()` returns `true` for a single frame only.
            * `cvui::IS_DOWN`: any mouse button is currently pressed. `cvui::mouse()` returns `true` for as long as the button is down/pressed.

            It is easier to think of this function as the answer to a questions. For instance, asking if any mouse button went down

            ```
            if (cvui::mouse(cvui::DOWN)) {
              // Any mouse button just went down.
            }
            ```

            The window whose mouse will be queried depends on the context. If `cvui::mouse(query)` is being called after
            `cvui::context()`, the window informed in the context will be queried. If no context is available, the default
            window (informed in `cvui::init()`) will be used.

            Parameters
            ----------
            theQuery int
                Integer describing the intended mouse query. Available queries are `cvui::DOWN`, `cvui::UP`, `cvui::CLICK`, and `cvui::IS_DOWN`.

            \sa mouse(const cv::String&)
            \sa mouse(const cv::String&, int)
            \sa mouse(const cv::String&, int, int)
            \sa mouse(int, int)
            */
            return this.mouseWQ('', theQuery)
        }

        mouseWQ(theWindowName, theQuery)
        {
            /*
             Query the mouse for events in a particular window. This function behave exactly like `cvui::mouse(int theQuery)`
             with the difference that queries are targeted at a particular window.

             \param theWindowName name of the window that will be queried.
             \param theQuery an integer describing the intended mouse query. Available queries are `cvui::DOWN`, `cvui::UP`, `cvui::CLICK`, and `cvui::IS_DOWN`.

             \sa mouse(const cv::String&)
             \sa mouse(const cv::String&, int, int)
             \sa mouse(int, int)
             \sa mouse(int)
            */
            aButton := this.getContext(theWindowName).mouse.anyButton
            aRet := this.isMouseButton(aButton, theQuery)

            return aRet
        }

        mouseBQ(theButton, theQuery)
        {
            /*
             Query the mouse for events in a particular button. This function behave exactly like `cvui::mouse(int theQuery)`,
             with the difference that queries are targeted at a particular mouse button instead.

             \param theButton an integer describing the mouse button to be queried. Possible values are `cvui::LEFT_BUTTON`, `cvui::MIDDLE_BUTTON` and `cvui::LEFT_BUTTON`.
             \param theQuery an integer describing the intended mouse query. Available queries are `cvui::DOWN`, `cvui::UP`, `cvui::CLICK`, and `cvui::IS_DOWN`.

             \sa mouse(const cv::String&)
             \sa mouse(const cv::String&, int, int)
             \sa mouse(int)
            */
            return this.mouseWBQ('', theButton, theQuery)
        }

        mouseWBQ(theWindowName, theButton, theQuery)
        {
            /*
             Query the mouse for events in a particular button in a particular window. This function behave exactly
             like `cvui::mouse(int theButton, int theQuery)`, with the difference that queries are targeted at
             a particular mouse button in a particular window instead.

             \param theWindowName name of the window that will be queried.
             \param theButton an integer describing the mouse button to be queried. Possible values are `cvui::LEFT_BUTTON`, `cvui::MIDDLE_BUTTON` and `cvui::LEFT_BUTTON`.
             \param theQuery an integer describing the intended mouse query. Available queries are `cvui::DOWN`, `cvui::UP`, `cvui::CLICK`, and `cvui::IS_DOWN`.
            */
            if theButton != CVUI.RIGHT_BUTTON and theButton != CVUI.MIDDLE_BUTTON and theButton != CVUI.LEFT_BUTTON
                __internal.error(6, 'Invalid mouse button. Are you using one of the available cvui.{RIGHT,MIDDLE,LEFT}_BUTTON ?')

            aButton := this.getContext(theWindowName).mouse.buttons[theButton]
            aRet := this.isMouseButton(aButton, theQuery)

            return aRet
        }

        init(theWindowName, theDelayWaitKey)
        {
            this.defaultContext := theWindowName
            this.currentContext := theWindowName
            this.delayWaitKey := theDelayWaitKey
            this.lastKeyPressed := -1
        }

        bitsetHas(theBitset, theValue)
        {
            return (theBitset & theValue) != 0
        }

        error(theId, theMessage)
        {
            printc('[CVUI] Fatal error (code ', theId, '): ', theMessage)
            cv2.waitKey(100000)
            exit(-1)
        }

        getContext(theWindowName := '')
        {
            if len(theWindowName) != 0
                ; Get context in particular
                return this.contexts[theWindowName]

            else if len(this.currentContext) != 0
                ; No window provided, return currently active context.
                return this.contexts[this.currentContext]

            else if len(this.defaultContext) != 0
                ; We have no active context, so let's use the default one.
                return this.contexts[this.defaultContext]

            else
                ; Apparently we have no window at all! <o>
                ; This should not happen. Probably cvui::init() was never called.
                this.error(5, 'Unable to read context. Did you forget to call cvui.init()?')
        }

        updateLayoutFlow(theBlock, theSize)
        {
            if theBlock.type == CVUI.ROW
            {
                aValue := theSize.width + theBlock.padding

                theBlock.anchor.x += aValue
                theBlock.fill.width += aValue
                theBlock.fill.height := max(theSize.height, theBlock.fill.height)
            }

            else if theBlock.type == CVUI.COLUMN
            {
                aValue := theSize.height + theBlock.padding

                theBlock.anchor.y += aValue
                theBlock.fill.height += aValue
                theBlock.fill.width := max(theSize.width, theBlock.fill.width)
            }
        }

        blockStackEmpty()
        {
            return this.stackCount == -1
        }

        topBlock()
        {
            if this.stackCount < 0
                this.error(3, 'You are using a function that should be enclosed by begin*() and end*(), but you probably forgot to call begin*().')

            return this.stack[this.stackCount + 1]
        }

        pushBlock()
        {
            this.stackCount += 1
            return this.stack[this.stackCount + 1]
        }

        popBlock()
        {
            ; Check if there is anything to be popped out from the stack.
            if this.stackCount < 0
                this.error(1, 'Mismatch in the number of begin*()/end*() calls. You are calling one more than the other.')

            aIndex := this.stackCount
            this.stackCount -= 1

            return this.stack[aIndex + 1]
        }

        createLabel(theLabel)
        {
            theLabel := StrSplit(theLabel)
            i := 0
            aBefore := ''
            aAfter := ''

            aLabel := CVUI._Label()
            aLabel.hasShortcut := False
            aLabel.shortcut := 0
            aLabel.textBeforeShortcut := ''
            aLabel.textAfterShortcut := ''

            while i < len(theLabel)
            {
                c := theLabel[i + 1]
                if c == '&' and i < len(theLabel) - 1
                {
                    aLabel.hasShortcut := True
                    aLabel.shortcut := theLabel[i + 2]
                    i += 1
                }
                else if aLabel.hasShortcut == False
                    aBefore .= c
                else
                    aAfter .= c
                i += 1
            }

            aLabel.textBeforeShortcut := aBefore
            aLabel.textAfterShortcut := aAfter

            return aLabel
        }

        text(theBlock, theX, theY, theText, theFontScale, theColor, theUpdateLayout)
        {
            tmp := cv2.getTextSize(theText, cv2.FONT_HERSHEY_SIMPLEX, theFontScale, 1)
            aSizeInfo := tmp[1]
            aBaseline := tmp[2]

            aTextSize := CVUI._Size(aSizeInfo[0], aSizeInfo[1])
            aPos := CVUI._Point(theX, theY + aTextSize.height)

            _render.text(theBlock, theText, aPos, theFontScale, theColor)

            if theUpdateLayout
            {
                ; Add an extra pixel to the height to overcome OpenCV font size problems.
                aTextSize.height += 1
                this.updateLayoutFlow(theBlock, aTextSize)
            }
        }

        counter(theBlock, theX, theY, theValue, theStep, theFormat)
        {
            aContentArea := CVUI._Rect(theX + 22, theY, 48, 22)

            if this.buttonWH(theBlock, theX, theY, 22, 22, '-', False)
                theValue[1] -= theStep

            aText := sprintf(theFormat, theValue[1])
            _render.counter(theBlock, aContentArea, aText)

            if this.buttonWH(theBlock, aContentArea.x + aContentArea.width, theY, 22, 22, "+", False)
                theValue[1] += theStep

            ; Update the layout flow
            aSize := CVUI._Size(22 * 2 + aContentArea.width, aContentArea.height)
            this.updateLayoutFlow(theBlock, aSize)

            return theValue[1]
        }

        checkbox(theBlock, theX, theY, theLabel, theState, theColor)
        {
            aMouse := this.getContext().mouse
            aRect := CVUI._Rect(theX, theY, 15, 15)
            tmp := cv2.getTextSize(theLabel, cv2.FONT_HERSHEY_SIMPLEX, 0.4, 1)
            aSizeInfo := tmp[1]
            aBaseline := tmp[2]
            aTextSize := CVUI._Rect(0, 0, aSizeInfo[0], aSizeInfo[1])
            aHitArea := CVUI._Rect(theX, theY, aRect.width + aTextSize.width + 6, aRect.height)
            aMouseIsOver := aHitArea.contains(aMouse.position)

            if aMouseIsOver
            {
                _render.checkbox(theBlock, CVUI.OVER, aRect)

                if aMouse.anyButton.justReleased
                    theState[1] := not theState[1]
            }
            else
                _render.checkbox(theBlock, CVUI.OUT, aRect)

            _render.checkboxLabel(theBlock, aRect, theLabel, aTextSize, theColor)

            if theState[1]
                _render.checkboxCheck(theBlock, aRect)

            ; Update the layout flow
            aSize := CVUI._Size(aHitArea.width, aHitArea.height)
            this.updateLayoutFlow(theBlock, aSize)

            return theState[1]
        }

        clamp01(theValue)
        {
            theValue := (theValue > 1.) ? 1. : theValue
            theValue := (theValue < 0.) ? 0. : theValue
            return theValue
        }

        trackbarForceValuesAsMultiplesOfSmallStep(theParams, theValue)
        {
            if this.bitsetHas(theParams.options, CVUI.TRACKBAR_DISCRETE) and (theParams.step != 0.)
            {
                k := float(theValue[1] - theParams.min) / theParams.step
                k := round(k)
                theValue[1] := theParams.min + theParams.step * k
            }
        }

        trackbarXPixelToValue(theParams, theBounding, thePixelX)
        {
            aRatio := float(thePixelX - (theBounding.x + this.trackbarMarginX)) / (theBounding.width - 2 * this.trackbarMarginX)
            aRatio := this.clamp01(aRatio)
            aValue := theParams.min + aRatio * (theParams.max - theParams.min)
            return aValue
        }

        trackbarValueToXPixel(theParams, theBounding, theValue)
        {
            aRatio := float(theValue - theParams.min) / (theParams.max - theParams.min)
            aRatio := this.clamp01(aRatio)
            aPixelsX := theBounding.x + this.trackbarMarginX + aRatio * (theBounding.width - 2 * this.trackbarMarginX)
            return int(aPixelsX)
        }

        iarea(theX, theY, theWidth, theHeight)
        {
            aMouse := this.getContext().mouse

            ; By default, return that the mouse is out of the interaction area.
            aRet := CVUI.OUT

            ; Check if the mouse is over the interaction area.
            aMouseIsOver := CVUI._Rect(theX, theY, theWidth, theHeight).contains(aMouse.position)

            if aMouseIsOver
            {
                if aMouse.anyButton.pressed
                    aRet := CVUI.DOWN
                else
                    aRet := CVUI.OVER
            }

            ; Tell if the button was clicked or not
            if aMouseIsOver and aMouse.anyButton.justReleased
                aRet := CVUI.CLICK

            return aRet
        }

        buttonWH(theBlock, theX, theY, theWidth, theHeight, theLabel, theUpdateLayout)
        {
            ; Calculate the space that the label will fill
            tmp := cv2.getTextSize(theLabel, cv2.FONT_HERSHEY_SIMPLEX, 0.4, 1)
            aSizeInfo := tmp[1]
            aBaseline := tmp[2]
            aTextSize := CVUI._Rect(0, 0, aSizeInfo[0], aSizeInfo[1])

            ; Make the button big enough to house the label
            aRect := CVUI._Rect(theX, theY, theWidth, theHeight)

            ; CVUI.Render the button according to mouse interaction, e.g. OVER, DOWN, OUT.
            aStatus := this.iarea(theX, theY, aRect.width, aRect.height)
            _render.button(theBlock, aStatus, aRect, theLabel)
            _render.buttonLabel(theBlock, aStatus, aRect, theLabel, aTextSize)

            ; Update the layout flow according to button size
            ; if we were told to update.
            if theUpdateLayout
            {
                aSize := CVUI._Size(theWidth, theHeight)
                this.updateLayoutFlow(theBlock, aSize)
            }

            aWasShortcutPressed := False
            
            ; Handle keyboard shortcuts
            if this.lastKeyPressed != -1
            {
                aLabel := this.createLabel(theLabel)

                if aLabel.hasShortcut and StrLower(aLabel.shortcut) == StrLower(chr(this.lastKeyPressed))
                    aWasShortcutPressed := True
            }

            ; Return true if the button was clicked
            return (aStatus == CVUI.CLICK) or aWasShortcutPressed
        }

        button(theBlock, theX, theY, theLabel)
        {
            ; Calculate the space that the label will fill
            tmp := cv2.getTextSize(theLabel, cv2.FONT_HERSHEY_SIMPLEX, 0.4, 1)
            aSizeInfo := tmp[1]
            aBaseline := tmp[2]
            aTextSize := CVUI._Rect(0, 0, aSizeInfo[0], aSizeInfo[1])

            ; Create a button based on the size of the text
            return this.buttonWH(theBlock, theX, theY, aTextSize.width + 30, aTextSize.height + 18, theLabel, True)
        }

        buttonI(theBlock, theX, theY, theIdle, theOver, theDown, theUpdateLayout)
        {
            aIdleRows := theIdle.shape[1]
            aIdleCols := theIdle.shape[2]

            aRect := CVUI._Rect(theX, theY, aIdleCols, aIdleRows)
            aStatus := this.iarea(theX, theY, aRect.width, aRect.height)

            if aStatus == CVUI.OUT
                _render.image(theBlock, aRect, theIdle)
            else if aStatus == CVUI.OVER
                _render.image(theBlock, aRect, theOver)
            else if aStatus == CVUI.DOWN
                _render.image(theBlock, aRect, theDown)

            ; Update the layout flow according to button size
            ; if we were told to update.
            if theUpdateLayout
            {
                aSize := CVUI._Size(aRect.width, aRect.height)
                this.updateLayoutFlow(theBlock, aSize)
            }

            ; Return true if the button was clicked
            return aStatus == CVUI.CLICK
        }

        image(theBlock, theX, theY, theImage)
        {
            aImageRows := theImage.shape[1]
            aImageCols := theImage.shape[2]

            aRect := CVUI._Rect(theX, theY, aImageCols, aImageRows)
            
            ; TODO check for render outside the frame area
            _render.image(theBlock, aRect, theImage)
            
            ; Update the layout flow according to image size
            aSize := CVUI._Size(aImageCols, aImageRows)
            this.updateLayoutFlow(theBlock, aSize)
        }

        trackbar(theBlock, theX, theY, theWidth, theValue, theParams)
        {
            aMouse := this.getContext().mouse
            aContentArea := CVUI._Rect(theX, theY, theWidth, 45)
            aMouseIsOver := aContentArea.contains(aMouse.position)
            aValue := theValue[1]

            _render.trackbar(theBlock, aMouseIsOver ? CVUI.OVER : CVUI.OUT, aContentArea, theValue[1], theParams)

            if aMouse.anyButton.pressed and aMouseIsOver
            {
                theValue[1] := this.trackbarXPixelToValue(theParams, aContentArea, aMouse.position.x)

                if this.bitsetHas(theParams.options, CVUI.TRACKBAR_DISCRETE)
                    this.trackbarForceValuesAsMultiplesOfSmallStep(theParams, theValue)
            }

            ; Update the layout flow
            ; TODO use aSize := aContentArea.size()?
            this.updateLayoutFlow(theBlock, aContentArea)

            return theValue[1] != aValue
        }

        window(theBlock, theX, theY, theWidth, theHeight, theTitle)
        {
            aTitleBar := CVUI._Rect(theX, theY, theWidth, 20)
            aContent := CVUI._Rect(theX, theY + aTitleBar.height, theWidth, theHeight - aTitleBar.height)

            _render.window(theBlock, aTitleBar, aContent, theTitle)

            ; Update the layout flow
            aSize := CVUI._Size(theWidth, theHeight)
            this.updateLayoutFlow(theBlock, aSize)
        }

        rect(theBlock, theX, theY, theWidth, theHeight, theBorderColor, theFillingColor)
        {
            aAnchor := CVUI._Point(theX, theY)
            aRect := CVUI._Rect(theX, theY, theWidth, theHeight)

            aRect.x := (aRect.width < 0) ? (aAnchor.x + aRect.width) : aAnchor.x
            aRect.y := (aRect.height < 0) ? (aAnchor.y + aRect.height) : aAnchor.y
            aRect.width := abs(aRect.width)
            aRect.height := abs(aRect.height)

            _render.rect(theBlock, aRect, theBorderColor, theFillingColor)

            ; Update the layout flow
            aSize := CVUI._Size(aRect.width, aRect.height)
            this.updateLayoutFlow(theBlock, aSize)
        }

        sparkline(theBlock, theValues, theX, theY, theWidth, theHeight, theColor)
        {
            aRect := CVUI._Rect(theX, theY, theWidth, theHeight)
            aHowManyValues := len(theValues)

            if (aHowManyValues >= 2)
            {
                tmp := this.findMinMax(theValues)
                aMin := tmp[1]
                aMax := tmp[2]
                _render.sparkline(theBlock, theValues, aRect, aMin, aMax, theColor)
            }
            else
                this.text(theBlock, theX, theY, (aHowManyValues == 0) ? 'No data.' : 'Insufficient data points.', 0.4, 0xCECECE, False)

            ; Update the layout flow
            aSize := CVUI._Size(theWidth, theHeight)
            this.updateLayoutFlow(theBlock, aSize)
        }

        hexToScalar(theColor)
        {
            aAlpha := (theColor >> 24) & 0xff
            aRed   := (theColor >> 16) & 0xff
            aGreen := (theColor >> 8)  & 0xff
            aBlue  := theColor & 0xff

            return [aBlue, aGreen, aRed, aAlpha]
        }

        isString(theObj)
        {
            return isinstance(theObj, String)
        }

        begin(theType, theWhere, theX, theY, theWidth, theHeight, thePadding)
        {
            aBlock := this.pushBlock()

            aBlock.where := theWhere

            aBlock.rect.x := theX
            aBlock.rect.y := theY
            aBlock.rect.width := theWidth
            aBlock.rect.height := theHeight

            aBlock.fill := aBlock.rect
            aBlock.fill.width := 0
            aBlock.fill.height := 0

            aBlock.anchor.x := theX
            aBlock.anchor.y := theY

            aBlock.padding := thePadding
            aBlock.type := theType
        }

        end(theType)
        {
            aBlock := this.popBlock()

            if aBlock.type != theType
                this.error(4, 'Calling wrong type of end*(). E.g. endColumn() instead of endRow(). Check if your begin*() calls are matched with their appropriate end*() calls.')

            ; If we still have blocks in the stack, we must update
            ; the current top with the dimensions that were filled by
            ; the newly popped block.

            if this.blockStackEmpty() == False
            {
                aTop := this.topBlock()
                aSize := CVUI._Size()

                ; If the block has rect.width < 0 or rect.heigth < 0, it means the
                ; user don't want to calculate the block's width/height. It's up to
                ; us do to the math. In that case, we use the block's fill rect to find
                ; out the occupied space. If the block's width/height is greater than
                ; zero, then the user is very specific about the desired size. In that
                ; case, we use the provided width/height, no matter what the fill rect
                ; actually is.
                aSize.width := (aBlock.rect.width < 0) ? aBlock.fill.width : aBlock.rect.width
                aSize.height := (aBlock.rect.height < 0) ? aBlock.fill.height : aBlock.rect.height

                this.updateLayoutFlow(aTop, aSize)
            }
        }

        ; Find the min and max values of a vector
        findMinMax(theValues)
        {
            aMin := theValues[1]
            aMax := theValues[1]

            for aValue in theValues
            {
                if aValue < aMin
                    aMin := aValue

                if aValue > aMax
                    aMax := aValue
            }

            return [aMin, aMax]
        }
    }

    ; Class that contains all rendering methods.
    Class Render
    {
        Static _internal := None

        rectangle(theWhere, theShape, theColor, theThickness := 1, theLineType := CVUI.CVUI_ANTIALISED)
        {
            aStartPoint := [int(theShape.x), int(theShape.y)]
            aEndPoint := [int(theShape.x + theShape.width), int(theShape.y + theShape.height)]

            cv2.rectangle(theWhere, aStartPoint, aEndPoint, theColor, theThickness, theLineType)
        }

        text(theBlock, theText, thePos, theFontScale, theColor)
        {
            aPosition := [int(thePos.x), int(thePos.y)]
            cv2.putText(theBlock.where, theText, aPosition, cv2.FONT_HERSHEY_SIMPLEX, theFontScale, this._internal.hexToScalar(theColor), 1, cv2.LINE_AA)
        }

        counter(theBlock, theShape, theValue)
        {
            this.rectangle(theBlock.where, theShape, [0x29, 0x29, 0x29], CVUI.CVUI_FILLED) ; fill
            this.rectangle(theBlock.where, theShape, [0x45, 0x45, 0x45])              ; border

            tmp := cv2.getTextSize(theValue, cv2.FONT_HERSHEY_SIMPLEX, 0.4, 1)
            aSizeInfo := tmp[1]
            aBaseline := tmp[2]
            aTextSize := CVUI._Rect(0, 0, aSizeInfo[0], aSizeInfo[1])

            aPos := CVUI._Point(theShape.x + theShape.width / 2 - aTextSize.width / 2, theShape.y + aTextSize.height / 2 + theShape.height / 2)
            cv2.putText(theBlock.where, theValue, [int(aPos.x), int(aPos.y)], cv2.FONT_HERSHEY_SIMPLEX, 0.4, [0xCE, 0xCE, 0xCE], 1, CVUI.CVUI_ANTIALISED)
        }

        button(theBlock, theState, theShape, theLabel)
        {
            ; Outline
            this.rectangle(theBlock.where, theShape, [0x29, 0x29, 0x29])

            ; Border
            theShape.x += 1
            theShape.y +=1
            theShape.width -= 2
            theShape.height -= 2
            this.rectangle(theBlock.where, theShape, [0x4A, 0x4A, 0x4A])

            ; Inside
            theShape.x += 1
            theShape.y +=1
            theShape.width -= 2
            theShape.height -= 2
            this.rectangle(theBlock.where, theShape, (theState == CVUI.OUT) ? [0x42, 0x42, 0x42] : ((theState == CVUI.OVER) ? [0x52, 0x52, 0x52] : [0x32, 0x32, 0x32]), CVUI.CVUI_FILLED)
        }

        image(theBlock, theRect, theImage)
        {
            theBlock.where[theRect.x, theRect.y, theRect.width, theRect.height] := theImage
        }

        putText(theBlock, theState, theColor, theText, thePosition)
        {
            aFontScale := (theState == CVUI.DOWN) ? 0.39 : 0.4
            aTextSize := CVUI._Rect()

            if theText != ''
            {
                aPosition := [int(thePosition.x), int(thePosition.y)]
                cv2.putText(theBlock.where, theText, aPosition, cv2.FONT_HERSHEY_SIMPLEX, aFontScale, theColor, 1, CVUI.CVUI_ANTIALISED)

                tmp := cv2.getTextSize(theText, cv2.FONT_HERSHEY_SIMPLEX, aFontScale, 1)
                aSizeInfo := tmp[1]
                aBaseline := tmp[2]
                aTextSize := CVUI._Rect(0, 0, aSizeInfo[0], aSizeInfo[1])
            }

            return aTextSize.width
        }

        putTextCentered(theBlock, thePosition, theText)
        {
            aFontScale := 0.3

            tmp := cv2.getTextSize(theText, cv2.FONT_HERSHEY_SIMPLEX, aFontScale, 1)
            aSizeInfo := tmp[1]
            aBaseline := tmp[2]
            aTextSize := CVUI._Rect(0, 0, aSizeInfo[0], aSizeInfo[1])
            aPositionDecentered := CVUI._Point(thePosition.x - aTextSize.width / 2, thePosition.y)
            cv2.putText(theBlock.where, theText, [int(aPositionDecentered.x), int(aPositionDecentered.y)], cv2.FONT_HERSHEY_SIMPLEX, aFontScale, [0xCE, 0xCE, 0xCE], 1, CVUI.CVUI_ANTIALISED)

            return aTextSize.width
        }

        buttonLabel(theBlock, theState, theRect, theLabel, theTextSize)
        {
            aPos := CVUI._Point(theRect.x + theRect.width / 2 - theTextSize.width / 2, theRect.y + theRect.height / 2 + theTextSize.height / 2)
            aColor := [0xCE, 0xCE, 0xCE]

            aLabel := this._internal.createLabel(theLabel)

            if aLabel.hasShortcut == False
                this.putText(theBlock, theState, aColor, theLabel, aPos)

            else
            {
                aWidth := this.putText(theBlock, theState, aColor, aLabel.textBeforeShortcut, aPos)
                aStart := aPos.x + aWidth
                aPos.x += aWidth

                aShortcut := ''
                aShortcut .= aLabel.shortcut

                aWidth := this.putText(theBlock, theState, aColor, aShortcut, aPos)
                aEnd := aStart + aWidth
                aPos.x += aWidth

                this.putText(theBlock, theState, aColor, aLabel.textAfterShortcut, aPos)
                cv2.line(theBlock.where, [int(aStart), int(aPos.y + 3)], [int(aEnd), int(aPos.y + 3)], aColor, 1, CVUI.CVUI_ANTIALISED)
            }
        }

        trackbarHandle(theBlock, theState, theShape, theValue, theParams, theWorkingArea)
        {
            aBarTopLeft := CVUI._Point(theWorkingArea.x, theWorkingArea.y + theWorkingArea.height / 2)
            aBarHeight := 7

            ; Draw the rectangle representing the handle
            aPixelX := this._internal.trackbarValueToXPixel(theParams, theShape, theValue)
            aIndicatorWidth := 3
            aIndicatorHeight := 4
            aPoint1 := CVUI._Point(aPixelX - aIndicatorWidth, aBarTopLeft.y - aIndicatorHeight)
            aPoint2 := CVUI._Point(aPixelX + aIndicatorWidth, aBarTopLeft.y + aBarHeight + aIndicatorHeight)
            aRect := CVUI._Rect(aPoint1.x, aPoint1.y, aPoint2.x - aPoint1.x, aPoint2.y - aPoint1.y)

            aFillColor := (theState == CVUI.OVER) ? 0x525252 : 0x424242

            this.rect(theBlock, aRect, 0x212121, 0x212121)
            aRect.x += 1
            aRect.y += 1
            aRect.width -= 2
            aRect.height -= 2
            this.rect(theBlock, aRect, 0x515151, aFillColor)

            aShowLabel := this._internal.bitsetHas(theParams.options, CVUI.TRACKBAR_HIDE_VALUE_LABEL) == False

            ; Draw the handle label
            if aShowLabel
            {
                aTextPos := CVUI._Point(aPixelX, aPoint2.y + 11)
                aText := sprintf(theParams.labelFormat, theValue)
                this.putTextCentered(theBlock, aTextPos, aText)
            }
        }

        trackbarPath(theBlock, theState, theShape, theValue, theParams, theWorkingArea)
        {
            aBarHeight := 7
            aBarTopLeft := CVUI._Point(theWorkingArea.x, theWorkingArea.y + theWorkingArea.height / 2)
            aRect := CVUI._Rect(aBarTopLeft.x, aBarTopLeft.y, theWorkingArea.width, aBarHeight)

            aBorderColor := (theState == CVUI.OVER) ? 0x4e4e4e : 0x3e3e3e

            this.rect(theBlock, aRect, aBorderColor, 0x292929)
            cv2.line(theBlock.where, [int(aRect.x + 1), int(aRect.y + aBarHeight - 2)], [int(aRect.x + aRect.width - 2), int(aRect.y + aBarHeight - 2)], [0x0e, 0x0e, 0x0e])
        }

        trackbarSteps(theBlock, theState, theShape, theValue, theParams, theWorkingArea)
        {
            aBarTopLeft := CVUI._Point(theWorkingArea.x, theWorkingArea.y + theWorkingArea.height / 2)
            aColor := [0x51, 0x51, 0x51]

            aDiscrete := this._internal.bitsetHas(theParams.options, CVUI.TRACKBAR_DISCRETE)
            aFixedStep := aDiscrete ? theParams.step : ((theParams.max - theParams.min) / 20)

            ; TODO check min, max and step to prevent infinite loop.
            aValue := theParams.min
            while aValue <= theParams.max
            {
                aPixelX := int(this._internal.trackbarValueToXPixel(theParams, theShape, aValue))
                aPoint1 := [aPixelX, int(aBarTopLeft.y)]
                aPoint2 := [aPixelX, int(aBarTopLeft.y - 3)]
                cv2.line(theBlock.where, aPoint1, aPoint2, aColor)
                aValue += aFixedStep
            }
        }

        trackbarSegmentLabel(theBlock, theShape, theParams, theValue, theWorkingArea, theShowLabel)
        {
            aColor := [0x51, 0x51, 0x51]
            aBarTopLeft := CVUI._Point(theWorkingArea.x, theWorkingArea.y + theWorkingArea.height / 2)

            aPixelX := int(this._internal.trackbarValueToXPixel(theParams, theShape, theValue))

            aPoint1 := [aPixelX, int(aBarTopLeft.y)]
            aPoint2 := [aPixelX, int(aBarTopLeft.y - 8)]
            cv2.line(theBlock.where, aPoint1, aPoint2, aColor)

            if theShowLabel
            {
                aText := sprintf(theParams.labelFormat, theValue)
                aTextPos := CVUI._Point(aPixelX, aBarTopLeft.y - 11)
                this.putTextCentered(theBlock, aTextPos, aText)
            }
        }

        trackbarSegments(theBlock, theState, theShape, theValue, theParams, theWorkingArea)
        {
            aSegments := (theParams.segments < 1) ? 1 : theParams.segments
            aSegmentLength := float(theParams.max - theParams.min) / aSegments

            aHasMinMaxLabels := this._internal.bitsetHas(theParams.options, CVUI.TRACKBAR_HIDE_MIN_MAX_LABELS) == False

            ; CVUI.Render the min value label
            this.trackbarSegmentLabel(theBlock, theShape, theParams, theParams.min, theWorkingArea, aHasMinMaxLabels)

            ; Draw large steps and labels
            aHasSegmentLabels := this._internal.bitsetHas(theParams.options, CVUI.TRACKBAR_HIDE_SEGMENT_LABELS) == False
            ; TODO check min, max and step to prevent infinite loop.
            aValue := theParams.min
            while aValue <= theParams.max
            {
                this.trackbarSegmentLabel(theBlock, theShape, theParams, aValue, theWorkingArea, aHasSegmentLabels)
                aValue += aSegmentLength
            }

            ; CVUI.Render the max value label
            this.trackbarSegmentLabel(theBlock, theShape, theParams, theParams.max, theWorkingArea, aHasMinMaxLabels)
        }

        trackbar(theBlock, theState, theShape, theValue, theParams)
        {
            aWorkingArea := CVUI._Rect(theShape.x + this._internal.trackbarMarginX, theShape.y, theShape.width - 2 * this._internal.trackbarMarginX, theShape.height)

            this.trackbarPath(theBlock, theState, theShape, theValue, theParams, aWorkingArea)

            aHideAllLabels := this._internal.bitsetHas(theParams.options, CVUI.TRACKBAR_HIDE_LABELS)
            aShowSteps := this._internal.bitsetHas(theParams.options, CVUI.TRACKBAR_HIDE_STEP_SCALE) == False

            if aShowSteps and (aHideAllLabels == False)
                this.trackbarSteps(theBlock, theState, theShape, theValue, theParams, aWorkingArea)

            if aHideAllLabels == False
                this.trackbarSegments(theBlock, theState, theShape, theValue, theParams, aWorkingArea)

            this.trackbarHandle(theBlock, theState, theShape, theValue, theParams, aWorkingArea)
        }

        checkbox(theBlock, theState, theShape)
        {
            ; Outline
            this.rectangle(theBlock.where, theShape, (theState == CVUI.OUT) ? [0x63, 0x63, 0x63] : [0x80, 0x80, 0x80])

            ; Border
            theShape.x += 1
            theShape.y+=1
            theShape.width -= 2
            theShape.height -= 2
            this.rectangle(theBlock.where, theShape, [0x17, 0x17, 0x17])

            ; Inside
            theShape.x += 1
            theShape.y += 1
            theShape.width -= 2
            theShape.height -= 2
            this.rectangle(theBlock.where, theShape, [0x29, 0x29, 0x29], CVUI.CVUI_FILLED)
        }

        checkboxLabel(theBlock, theRect, theLabel, theTextSize, theColor)
        {
            aPos := CVUI._Point(theRect.x + theRect.width + 6, theRect.y + theTextSize.height + theRect.height / 2 - theTextSize.height / 2 - 1)
            this.text(theBlock, theLabel, aPos, 0.4, theColor)
        }

        checkboxCheck(theBlock, theShape)
        {
            theShape.x += 1
            theShape.y += 1
            theShape.width -= 2
            theShape.height -= 2
            this.rectangle(theBlock.where, theShape, [0xFF, 0xBF, 0x75], CVUI.CVUI_FILLED)
        }

        window(theBlock, theTitleBar, theContent, theTitle)
        {
            Global aOverlay
            
            aTransparecy := False
            aAlpha := 0.3
            
            aOverlay.MAT := theBlock.where.MAT.copy()
            tomat(aOverlay, aOverlay.MAT)

            ; CVUI.Render borders in the title bar
            this.rectangle(theBlock.where, theTitleBar, [0x4A, 0x4A, 0x4A])

            ; CVUI.Render the inside of the title bar
            theTitleBar.x += 1
            theTitleBar.y += 1
            theTitleBar.width -= 2
            theTitleBar.height -= 2
            this.rectangle(theBlock.where, theTitleBar, [0x21, 0x21, 0x21], CVUI.CVUI_FILLED)

            ; CVUI.Render title text.
            aPos := CVUI._Point(theTitleBar.x + 5, theTitleBar.y + 12)
            cv2.putText(theBlock.where, theTitle, [int(aPos.x), int(aPos.y)], cv2.FONT_HERSHEY_SIMPLEX, 0.4, [0xCE, 0xCE, 0xCE], 1, CVUI.CVUI_ANTIALISED)

            ; CVUI.Render borders of the body
            this.rectangle(theBlock.where, theContent, [0x4A, 0x4A, 0x4A])

            ; CVUI.Render the body filling.
            theContent.x += 1
            theContent.y += 1
            theContent.width -= 2
            theContent.height -= 2
            this.rectangle(aOverlay, theContent, [0x31, 0x31, 0x31], CVUI.CVUI_FILLED)

            if aTransparecy
            {
                theBlock.where.copyTo(aOverlay)
                this.rectangle(aOverlay, theContent, [0x31, 0x31, 0x31], CVUI.CVUI_FILLED)
                theBlock.where := cv2.addWeighted(aOverlay, aAlpha, theBlock.where, 1.0 - aAlpha, 0.0)
            }
            else
                this.rectangle(theBlock.where, theContent, [0x31, 0x31, 0x31], CVUI.CVUI_FILLED)
        }

        rect(theBlock, thePos, theBorderColor, theFillingColor)
        {
            aBorderColor := this._internal.hexToScalar(theBorderColor)
            aFillingColor := this._internal.hexToScalar(theFillingColor)

            aHasFilling := aFillingColor[4] != 0xff

            if aHasFilling
                this.rectangle(theBlock.where, thePos, aFillingColor, CVUI.CVUI_FILLED, CVUI.CVUI_ANTIALISED)

            ; CVUI.Render the border
            this.rectangle(theBlock.where, thePos, aBorderColor)
        }

        sparkline(theBlock, theValues, theRect, theMin, theMax, theColor)
        {
            aSize := len(theValues)
            i := 0
            aScale := theMax - theMin
            aGap := float(theRect.width) / aSize
            aPosX := theRect.x

            while i <= aSize - 2
            {
                x := aPosX
                y := (theValues[i + 1] - theMin) / aScale * -(theRect.height - 5) + theRect.y + theRect.height - 5
                aPoint1 := CVUI._Point(x, y)

                x := aPosX + aGap
                y := (theValues[i + 1] - theMin) / aScale * -(theRect.height - 5) + theRect.y + theRect.height - 5
                aPoint2 := CVUI._Point(x, y)

                cv2.line(theBlock.where, [int(aPoint1.x), int(aPoint1.y)], [int(aPoint2.x), int(aPoint2.y)], this._internal.hexToScalar(theColor))
                aPosX += aGap

                i += 1
            }
        }
    }

    initf1(theWindowName, theDelayWaitKey := -1, theCreateNamedWindow := True)
    {
        /*
        Initializes cvui. You must provide the name of the window where
        components will be added. It is also possible to tell cvui to handle
        OpenCV's event queue automatically (by informing a value greater than zero
        in the `theDelayWaitKey` parameter of the function). In that case, cvui will
        automatically call `cv2.waitKey()` within `cvui.update()`, so you don't
        have to worry about it. The value passed to `theDelayWaitKey` will be
        used as the delay for `cv2.waitKey()`.

        Parameters
        ----------
        theWindowName str
            name of the window where the components will be added.
        theDelayWaitKey int
            delay value passed to `cv2.waitKey()`. If a negative value is informed (default is `-1`), cvui will not automatically call `cv2.waitKey()` within `cvui.update()`, which will disable keyboard shortcuts for all components. If you want to enable keyboard shortcut for components (e.g. using & in a button label), you must specify a positive value for this param.
        theCreateNamedWindow bool
            if an OpenCV window named `theWindowName` should be created during the initialization. Windows are created using `cv2.namedWindow()`. If this parameter is `False`, ensure you call `cv2.namedWindow(WINDOW_NAME)` *before* initializing cvui, otherwise it will not be able to track UI interactions.

        See Also
        ----------
        watch()
        context()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    initf2(theWindowNames, theHowManyWindows, theDelayWaitKey := -1, theCreateNamedWindows := True)
    {
        /*
        Initialize cvui using a list of names of windows where components will be added.
        It is also possible to tell cvui to handle OpenCV's event queue automatically
        (by informing a value greater than zero in the `theDelayWaitKey` parameter of the function).
        In that case, cvui will automatically call `cv2.waitKey()` within `cvui.update()`,
        so you don't have to worry about it. The value passed to `theDelayWaitKey` will be
        used as the delay for `cv2.waitKey()`.

        Parameters
        ----------
        theWindowNames str
            array containing the name of the windows where components will be added. Those windows will be automatically if `theCreateNamedWindows` is `True`.
        theHowManyWindows int
            how many window names exist in the `theWindowNames` array.
        theDelayWaitKey int
            delay value passed to `cv2.waitKey()`. If a negative value is informed (default is `-1`), cvui will not automatically call `cv2.waitKey()` within `cvui.update()`, which will disable keyboard shortcuts for all components. If you want to enable keyboard shortcut for components (e.g. using & in a button label), you must specify a positive value for this param.
        theCreateNamedWindows bool
            if OpenCV windows named according to `theWindowNames` should be created during the initialization. Windows are created using `cv2.namedWindow()`. If this parameter is `False`, ensure you call `cv2.namedWindow(WINDOW_NAME)` for all windows *before* initializing cvui, otherwise it will not be able to track UI interactions.

        See Also
        ----------
        watch()
        context()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static watch(theWindowName, theCreateNamedWindow := True)
    {
        Global theContext
        /*
        Track UI interactions of a particular window. This function must be invoked
        for any window that will receive cvui components. cvui automatically calls `cvui.watch()`
        for any window informed in `cvui.init()`, so generally you don't have to watch them
        yourthis. If you initialized cvui and told it *not* to create windows automatically,
        you need to call `cvui.watch()` on those windows yourthis. `cvui.watch()` can
        automatically create a window before watching it, if it does not exist.

        Parameters
        ----------
        theWindowName str
            name of the window whose UI interactions will be tracked.
        theCreateNamedWindow bool
            if an OpenCV window named `theWindowName` should be created before it is watched. Windows are created using `cv2.namedWindow()`. If this parameter is `False`, ensure you have called `cv2.namedWindow(WINDOW_NAME)` to create the window, otherwise cvui will not be able to track its UI interactions.

        See Also
        ----------
        init()
        context()
        */
        if theCreateNamedWindow
            cv2.namedWindow(theWindowName)

        theContext.windowName := theWindowName
        theContext.mouse.position.x := 0
        theContext.mouse.position.y := 0
        
        theContext.mouse.anyButton.reset()
        theContext.mouse.buttons[CVUI.RIGHT_BUTTON].reset()
        theContext.mouse.buttons[CVUI.MIDDLE_BUTTON].reset()
        theContext.mouse.buttons[CVUI.LEFT_BUTTON].reset()

        __internal.contexts[theWindowName] := theContext.Clone()
        
        cv2.setMouseCallback(theWindowName, _handleMouse)
    }

    Static context(theWindowName)
    {
        /*
        Inform cvui that all subsequent component calls belong to a window in particular.
        When using cvui with multiple OpenCV windows, you must call cvui component calls
        between `cvui.contex(NAME)` and `cvui.update(NAME)`, where `NAME` is the name of
        the window. That way, cvui knows which window you are using (`NAME` in this case),
        so it can track mouse events, for instance.

        E.g.

        ```
        ; Code for window 'window1'.
        cvui.context('window1')
        cvui.text(frame, ...)
        cvui.button(frame, ...)
        cvui.update('window1')


        ; somewhere else, code for 'window2'
        cvui.context('window2')
        cvui.printf(frame, ...)
        cvui.printf(frame, ...)
        cvui.update('window2')

        ; Show everything in a window
        cv2.imshow(frame)
        ```

        Pay attention to the pair `cvui.context(NAME)` and `cvui.update(NAME)`, which
        encloses the component calls for that window. You need such pair for each window
        of your application.

        After calling `cvui.update()`, you can show the result in a window using `cv2.imshow()`.
        If you want to save some typing, you can use `cvui.imshow()`, which calls `cvui.update()`
        for you and then shows the frame in a window.

        E.g.:

        ```
        ; Code for window 'window1'.
        cvui.context('window1')
        cvui.text(frame, ...)
        cvui.button(frame, ...)
        cvui.imshow('window1')

        ; somewhere else, code for 'window2'
        cvui.context('window2')
        cvui.printf(frame, ...)
        cvui.printf(frame, ...)
        cvui.imshow('window2')
        ```

        In that case, you don't have to bother calling `cvui.update()` yoursince
        `cvui.imshow()` will do it for you.

        Parameters
        ----------
        theWindowName str
            name of the window that will receive components from all subsequent cvui calls.

        See Also
        ----------
        init()
        watch()
        */
        __internal.currentContext := theWindowName
    }

    Static imshow(theWindowName, theFrame)
    {
        /*
        Display an image in the specified window and update the internal structures of cvui.
        This function can be used as a replacement for `cv2.imshow()`. If you want to use
        `cv2.imshow() instead of `cvui.imshow()`, you must ensure you call `cvui.update()`
        *after* all component calls and *before* `cv2.imshow()`, so cvui can update its
        internal structures.

        In general, it is easier to call `cvui.imshow()` alone instead of calling
        `cvui.update()' immediately followed by `cv2.imshow()`.

        Parameters
        ----------
        theWindowName str
            name of the window that will be shown.
        theFrame np.ndarray
            image, i.e. `np.ndarray`, to be shown in the window.

        See Also
        ----------
        update()
        context()
        watch()
        */
        CVUI.update(theWindowName)
        cv2.imshow(theWindowName, theFrame)
    }

    Static lastKeyPressed()
    {
        /*
        Return the last key that was pressed. This function will only
        work if a value greater than zero was passed to `cvui.init()`
        as the delay waitkey parameter.

        See Also
        ----------
        init()
        */
        return __internal.lastKeyPressed
    }

    Static mousef1(theWindowName := '')
    {
        /*
        Return the last position of the mouse.

        Parameters
        ----------
        theWindowName str
            name of the window whose mouse cursor will be used. If nothing is informed (default), the function will return the position of the mouse cursor for the default window (the one informed in `cvui.init()`).

        Returns
        ----------
        a point containing the position of the mouse cursor in the speficied window.
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static mousef2(theQuery)
    {
        /*
        Query the mouse for events, e.g. 'is any button down now?'. Available queries are

        * `cvui.DOWN`: any mouse button was pressed. `cvui.mouse()` returns `True` for a single frame only.
        * `cvui.UP`: any mouse button was released.  `cvui.mouse()` returns `True` for a single frame only.
        * `cvui.CLICK`: any mouse button was clicked (went down then up, no matter the amount of frames in between). `cvui.mouse()` returns `True` for a single frame only.
        * `cvui.IS_DOWN`: any mouse button is currently pressed. `cvui.mouse()` returns `True` for as long as the button is down/pressed.

        It is easier to think of this function as the answer to a questions. For instance, asking if any mouse button went down

        ```
        if cvui.mouse(cvui.DOWN):
        ; Any mouse button just went down.

        ```

        The window whose mouse will be queried depends on the context. If `cvui.mouse(query)` is being called after
        `cvui.context()`, the window informed in the context will be queried. If no context is available, the default
        window (informed in `cvui.init()`) will be used.

        Parameters
        ----------
        theQuery int
            an integer describing the intended mouse query. Available queries are `cvui.DOWN`, `cvui.UP`, `cvui.CLICK`, and `cvui.IS_DOWN`.

        See Also
        ----------
        mouse(str)
        mouse(str, int)
        mouse(str, int, int)
        mouse(int, int)
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static mousef3(theWindowName, theQuery)
    {
        /*
        Query the mouse for events in a particular window. This function behave exactly like `cvui.mouse(int theQuery)`
        with the difference that queries are targeted at a particular window.

        Parameters
        ----------
        theWindowName str
            name of the window that will be queried.
        theQuery int
            an integer describing the intended mouse query. Available queries are `cvui.DOWN`, `cvui.UP`, `cvui.CLICK`, and `cvui.IS_DOWN`.

        See Also
        ----------
        mouse(str)
        mouse(str, int, int)
        mouse(int, int)
        mouse(int)
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static mousef4(theButton, theQuery)
    {
        /*
        Query the mouse for events in a particular button. This function behave exactly like `cvui.mouse(int theQuery)`,
        with the difference that queries are targeted at a particular mouse button instead.

        Parameters
        ----------
        theButton int
            an integer describing the mouse button to be queried. Possible values are `cvui.CVUI.LEFT_BUTTON`, `cvui.CVUI.MIDDLE_BUTTON` and `cvui.CVUI.LEFT_BUTTON`.
        theQuery int
            an integer describing the intended mouse query. Available queries are `cvui.DOWN`, `cvui.UP`, `cvui.CLICK`, and `cvui.IS_DOWN`.

        See Also
        ----------
        mouse(str)
        mouse(str, int, int)
        mouse(int)
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static mousef5(theWindowName, theButton, theQuery)
    {
        /*
        Query the mouse for events in a particular button in a particular window. This function behave exactly
        like `cvui.mouse(int theButton, int theQuery)`, with the difference that queries are targeted at
        a particular mouse button in a particular window instead.

        Parameters
        ----------
        theWindowName str
            name of the window that will be queried.
        theButton int
            an integer describing the mouse button to be queried. Possible values are `cvui.CVUI.LEFT_BUTTON`, `cvui.CVUI.MIDDLE_BUTTON` and `cvui.CVUI.LEFT_BUTTON`.
        theQuery int
            an integer describing the intended mouse query. Available queries are `cvui.DOWN`, `cvui.UP`, `cvui.CLICK`, and `cvui.IS_DOWN`.
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static buttonf1(theWhere, theX, theY, theLabel)
    {
        /*
        Display a button. The size of the button will be automatically adjusted to
        properly house the label content.

        Parameters
        ----------
        theWhere np.ndarray
            image/frame where the component should be rendered.
        theX int
            position X where the component should be placed.
        theY int
            position Y where the component should be placed.
        theLabel str
            text displayed inside the button.

        Returns
        ----------
        `true` everytime the user clicks the button.
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static buttonf2(theWhere, theX, theY, theWidth, theHeight, theLabel)
    {
        /*
        Display a button. The button size will be defined by the width and height parameters,
        no matter the content of the label.

        Parameters
        ----------
        theWhere np.ndarray
            image/frame where the component should be rendered.
        theX int
            position X where the component should be placed.
        theY int
            position Y where the component should be placed.
        theWidth int
            width of the button.
        theHeight int
            height of the button.
        theLabel str
            text displayed inside the button.

        Returns
        ----------
        `true` everytime the user clicks the button.
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static buttonf3(theWhere, theX, theY, theIdle, theOver, theDown)
    {
        /*
        Display a button whose graphics are images (np.ndarray). The button accepts three images to describe its states,
        which are idle (no mouse interaction), over (mouse is over the button) and down (mouse clicked the button).
        The button size will be defined by the width and height of the images.

        Parameters
        ----------
        theWhere np.ndarray
            image/frame where the component should be rendered.
        theX int
            position X where the component should be placed.
        theY int
            position Y where the component should be placed.
        theIdle np.ndarray
            an image that will be rendered when the button is not interacting with the mouse cursor.
        theOver np.ndarray
            an image that will be rendered when the mouse cursor is over the button.
        theDown np.ndarray
            an image that will be rendered when the mouse cursor clicked the button (or is clicking).

        Returns
        ----------
        `true` everytime the user clicks the button.

        See Also
        ----------
        button()
        image()
        iarea()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static imagef1(theWhere, theX, theY, theImage)
    {
        /*
        Display an image (np.ndarray).

        Parameters
        ----------
        theWhere np.ndarray
            image/frame where the provded image should be rendered.
        theX int
            position X where the image should be placed.
        theY int
            position Y where the image should be placed.
        theImage np.ndarray
            image to be rendered in the specified destination.

        See Also
        ----------
        button()
        iarea()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static checkboxf1(theWhere, theX, theY, theLabel, theState, theColor := 0xCECECE)
    {
        /*
        Display a checkbox. You can use the state parameter to monitor if the
        checkbox is checked or not.

        Parameters
        ----------
        theWhere np.ndarray
            image/frame where the component should be rendered.
        theX int
            position X where the component should be placed.
        theY int
            position Y where the component should be placed.
        theLabel str
            text displayed besides the clickable checkbox square.
        theState [bool]
            array or list of booleans whose first position, i.e. theState[0], will be used to store the current state of the checkbox `True` means the checkbox is checked.
        theColor uint
            color of the label in the format `0xRRGGBB`, e.g. `0xff0000` for red.

        Returns
        ----------
        a boolean value that indicates the current state of the checkbox, `true` if it is checked.
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static textf1(theWhere, theX, theY, theText, theFontScale := 0.4, theColor := 0xCECECE)
    {
        /*
        Display a piece of text.

        Parameters
        ----------
        theWhere np.ndarray
            image/frame where the component should be rendered.
        theX int
            position X where the component should be placed.
        theY int
            position Y where the component should be placed.
        theText str
            the text content.
        theFontScale float
            size of the text.
        theColor uint
            color of the text in the format `0xRRGGBB`, e.g. `0xff0000` for red.

        See Also
        ----------
        printf()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static printff1(theWhere, theX, theY, theFontScale, theColor, theFmt)
    {
        /*
        Display a piece of text that can be formated using `C stdio's printf()` style. For instance
        if you want to display text mixed with numbers, you can use

        ```
        printf(frame, 10, 15, 0.4, 0xff0000, 'Text %d and %f', 7, 3.1415)
        ```

        Parameters
        ----------
        theWhere np.ndarray
            image/frame where the component should be rendered.
        theX int
            position X where the component should be placed.
        theY int
            position Y where the component should be placed.
        theFontScale float
            size of the text.
        theColor uint
            color of the text in the format `0xRRGGBB`, e.g. `0xff0000` for red.
        theFmt str
            formating string as it would be supplied for `stdio's printf()`, e.g. `'Text %d and %f', 7, 3.1415`.

        See Also
        ----------
        text()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static printff2(theWhere, theX, theY, theFmt)
    {
        /*
        Display a piece of text that can be formated using `C stdio's printf()` style. For instance
        if you want to display text mixed with numbers, you can use

        ```
        printf(frame, 10, 15, 0.4, 0xff0000, 'Text %d and %f', 7, 3.1415)
        ```

        The size and color of the text will be based on cvui's default values.

        Parameters
        ----------
        theWhere np.ndarray
            image/frame where the component should be rendered.
        theX int
            position X where the component should be placed.
        theY int
            position Y where the component should be placed.
        theFmt str
            formating string as it would be supplied for `stdio's printf()`, e.g. `'Text %d and %f', 7, 3.1415`.

        See Also
        ----------
        text()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static counterf1(theWhere, theX, theY, theValue, theStep := 1, theFormat := '%d')
    {
        /*
        Display a counter for integer values that the user can increase/descrease
        by clicking the up and down arrows.

        Parameters
        ----------
        theWhere np.ndarray
            image/frame where the component should be rendered.
        theX int
            position X where the component should be placed.
        theY int
            position Y where the component should be placed.
        theValue [number]
            array or list of numbers whose first position, i.e. theValue[1], will be used to store the current value of the counter.
        theStep number
            amount that should be increased/decreased when the user interacts with the counter buttons
        theFormat str
            how the value of the counter should be presented, as it was printed by `stdio's printf()`. E.g. `'%d'` means the value will be displayed as an integer, `'%0d'` integer with one leading zero, etc.

        Returns
        ----------
        number that corresponds to the current value of the counter.
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static trackbarf1(theWhere, theX, theY, theWidth, theValue, theMin, theMax, theSegments := 1, theLabelFormat := '%.1Lf', theOptions := 0, theDiscreteStep := 1)
    {
        /*
        Display a trackbar for numeric values that the user can increase/decrease
        by clicking and/or dragging the marker right or left. This component can use
        different types of data as its value, so it is imperative provide the right
        label format, e.g. '%d' for ints, otherwise you might end up with weird errors.

        Example

        ```
        ; using float
        trackbar(where, x, y, width, &floatValue, 0.0, 50.0)

        ; using float
        trackbar(where, x, y, width, &floatValue, 0.0f, 50.0f)

        ; using char
        trackbar(where, x, y, width, &charValue, (char)1, (char)10)
        ```

        Parameters
        ----------
        theWhere np.ndarray
            image/frame where the component should be rendered.
        theX int
            position X where the component should be placed.
        theY int
            position Y where the component should be placed.
        theWidth int
            width of the trackbar.
        theValue [number]
            array or list of numbers whose first position, i.e. theValue[1], will be used to store the current value of the trackbar. It will be modified when the user interacts with the trackbar. Any numeric type can be used, e.g. int, float, long double, etc.
        theMin number
            minimum value allowed for the trackbar.
        theMax number
            maximum value allowed for the trackbar.
        theSegments int
            number of segments the trackbar will have (default is 1). Segments can be seen as groups of numbers in the scale of the trackbar. For example, 1 segment means a single groups of values (no extra labels along the scale), 2 segments mean the trackbar values will be divided in two groups and a label will be placed at the middle of the scale.
        theLabelFormat str
            formating string that will be used to render the labels. If you are using a trackbar with integers values, for instance, you can use `%d` to render labels.
        theOptions uint
            options to customize the behavior/appearance of the trackbar, expressed as a bitset. Available options are defined as `cvui.TRACKBAR_` constants and they can be combined using the bitwise `|` operand. Available options are `TRACKBAR_HIDE_SEGMENT_LABELS` (do not render segment labels, but do render min/max labels), `TRACKBAR_HIDE_STEP_SCALE` (do not render the small lines indicating values in the scale), `TRACKBAR_DISCRETE` (changes of the trackbar value are multiples of theDiscreteStep param), `TRACKBAR_HIDE_MIN_MAX_LABELS` (do not render min/max labels), `TRACKBAR_HIDE_VALUE_LABEL` (do not render the current value of the trackbar below the moving marker), `TRACKBAR_HIDE_LABELS` (do not render labels at all).
        theDiscreteStep number
            amount that the trackbar marker will increase/decrease when the marker is dragged right/left (if option TRACKBAR_DISCRETE is ON)

        Returns
        ----------
        `true` when the value of the trackbar changed.

        See Also
        ----------
        counter()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static windowf1(theWhere, theX, theY, theWidth, theHeight, theTitle)
    {
        /*
        Display a window (a block with a title and a body).

        Parameters
        ----------
        theWhere np.ndarray
            image/frame where the component should be rendered.
        theX int
            position X where the component should be placed.
        theY int
            position Y where the component should be placed.
        theWidth int
            width of the window.
        theHeight int
            height of the window.
        theTitle str
            text displayed as the title of the window.

        See Also
        ----------
        rect()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static rectf1(theWhere, theX, theY, theWidth, theHeight, theBorderColor, theFillingColor := 0xff000000)
    {
        /*
        Display a filled rectangle.

        Parameters
        ----------
        theWhere np.ndarray
            image/frame where the component should be rendered.
        theX int
            position X where the component should be placed.
        theY int
            position Y where the component should be placed.
        theWidth int
            width of the rectangle.
        theHeight int
            height of the rectangle.
        theBorderColor uint
            color of rectangle's border in the format `0xRRGGBB`, e.g. `0xff0000` for red.
        theFillingColor uint
            color of rectangle's filling in the format `0xAARRGGBB`, e.g. `0x00ff0000` for red, `0xff000000` for transparent filling.

        See Also
        ----------
        image()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static sparklinef1(theWhere, theValues, theX, theY, theWidth, theHeight, theColor := 0x00FF00)
    {
        /*
        Display the values of a vector as a sparkline.

        Parameters
        ----------
        theWhere np.ndarray
            image/frame where the component should be rendered.
        theValues number[]
            array or list containing the numeric values to be used in the sparkline.
        theX int
            position X where the component should be placed.
        theY int
            position Y where the component should be placed.
        theWidth int
            width of the sparkline.
        theHeight int
            height of the sparkline.
        theColor uint
            color of sparkline in the format `0xRRGGBB`, e.g. `0xff0000` for red.

        See Also
        ----------
        trackbar()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static iarea(theX, theY, theWidth, theHeight)
    {
        /*
        Create an interaction area that reports activity with the mouse cursor.
        The tracked interactions are returned by the function and they are

        `OUT` when the cursor is not over the iarea.
        `OVER` when the cursor is over the iarea.
        `DOWN` when the cursor is pressed over the iarea, but not released yet.
        `CLICK` when the cursor clicked (pressed and released) within the iarea.

        This function creates no visual output on the screen. It is intended to
        be used as an auxiliary tool to create interactions.

        Parameters
        ----------
        theX int
            position X where the interactive area should be placed.
        theY int
            position Y where the interactive area should be placed.
        theWidth int
            width of the interactive area.
        theHeight int
            height of the interactive area.

        Returns
        ----------
        integer value representing the current state of interaction with the mouse cursor. It can be `OUT` (cursor is not over the area), `OVER` (cursor is over the area), `DOWN` (cursor is pressed over the area, but not released yet) and `CLICK` (cursor clicked, i.e. pressed and released, within the area).

        See Also
        ----------
        button()
        image()
        */
        return __internal.iarea(theX, theY, theWidth, theHeight)
    }

    Static beginRowf1(theWhere, theX, theY, theWidth := -1, theHeight := -1, thePadding := 0)
    {
        /*
        Start a new row.

        One of the most annoying tasks when building UI is to calculate
        where each component should be placed on the screen. cvui has
        a set of methods that abstract the process of positioning
        components, so you don't have to think about assigning a
        X and Y coordinate. Instead you just add components and cvui
        will place them as you go.

        You use `beginRow()` to start a group of elements. After `beginRow()`
        has been called, all subsequent component calls don't have to specify
        the frame where the component should be rendered nor its position.
        The position of the component will be automatically calculated by cvui
        based on the components within the group. All components are placed
        side by side, from left to right.

        E.g.

        ```
        beginRow(frame, x, y, width, height)
        text('test')
        button('btn')
        endRow()
        ```

        Rows and columns can be nested, so you can create columns/rows within
        columns/rows as much as you want. It's important to notice that any
        component within `beginRow()` and `endRow()` *do not* specify the position
        where the component is rendered, which is also True for `beginRow()`.
        As a consequence, **be sure you are calling `beginRow(width, height)`
        when the call is nested instead of `beginRow(x, y, width, height)`**,
        otherwise cvui will throw an error.

        E.g.

        ```
        beginRow(frame, x, y, width, height)
        text('test')
        button('btn')

        beginColumn()      ; no frame nor x,y parameters here!
        text('column1')
        text('column2')
        endColumn()
        endRow()
        ```

        Don't forget to call `endRow()` to finish the row, otherwise cvui will throw an error.

        Parameters
        ----------
        theWhere np.ndarray
            image/frame where the components within this block should be rendered.
        theX int
            position X where the row should be placed.
        theY int
            position Y where the row should be placed.
        theWidth int
            width of the row. If a negative value is specified, the width of the row will be automatically calculated based on the content of the block.
        theHeight int
            height of the row. If a negative value is specified, the height of the row will be automatically calculated based on the content of the block.
        thePadding int
            space, in pixels, among the components of the block.

        See Also
        ----------
        beginColumn()
        endRow()
        endColumn()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static endRow()
    {
        /*
        End a row. You must call this function only if you have previously called
        its counter part, the `beginRow()` function.

        See Also
        ----------
        beginRow()
        beginColumn()
        endColumn()
        */
        __internal.end(CVUI.ROW)
    }

    Static beginColumnf1(theWhere, theX, theY, theWidth := -1, theHeight := -1, thePadding := 0)
    {
        /*
        Start a new column.

        One of the most annoying tasks when building UI is to calculate
        where each component should be placed on the screen. cvui has
        a set of methods that abstract the process of positioning
        components, so you don't have to think about assigning a
        X and Y coordinate. Instead you just add components and cvui
        will place them as you go.

        You use `beginColumn()` to start a group of elements. After `beginColumn()`
        has been called, all subsequent component calls don't have to specify
        the frame where the component should be rendered nor its position.
        The position of the component will be automatically calculated by cvui
        based on the components within the group. All components are placed
        below each other, from the top of the screen towards the bottom.

        E.g.

        ```
        beginColumn(frame, x, y, width, height)
        text('test')
        button('btn')
        endColumn()
        ```

        Rows and columns can be nested, so you can create columns/rows within
        columns/rows as much as you want. It's important to notice that any
        component within `beginColumn()` and `endColumn()` *do not* specify the position
        where the component is rendered, which is also True for `beginColumn()`.
        As a consequence, **be sure you are calling `beginColumn(width, height)`
        when the call is nested instead of `beginColumn(x, y, width, height)`**,
        otherwise cvui will throw an error.

        E.g.

        ```
        beginColumn(frame, x, y, width, height)
        text('test')
        button('btn')

        beginRow()      ; no frame nor x,y parameters here!
        text('column1')
        text('column2')
        endRow()
        endColumn()
        ```

        Don't forget to call `endColumn()` to finish the column, otherwise cvui will throw an error.

        Parameters
        ----------
        theWhere np.ndarray
            image/frame where the components within this block should be rendered.
        theX int
            position X where the row should be placed.
        theY int
            position Y where the row should be placed.
        theWidth int
            width of the column. If a negative value is specified, the width of the column will be automatically calculated based on the content of the block.
        theHeight int
            height of the column. If a negative value is specified, the height of the column will be automatically calculated based on the content of the block.
        thePadding int
            space, in pixels, among the components of the block.

        See Also
        ----------
        beginRow()
        endColumn()
        endRow()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static endColumn()
    {
        /*
        End a column. You must call this function only if you have previously called
        its counter part, i.e. `beginColumn()`.

        See Also
        ----------
        beginColumn()
        beginRow()
        endRow()
        */
        __internal.end(CVUI.COLUMN)
    }

    Static beginRowf2(theWidth := -1, theHeight := -1, thePadding := 0)
    {
        /*
        Start a row. This function behaves in the same way as `beginRow(frame, x, y, width, height)`,
        however it is suposed to be used within `begin*()/end*()` blocks since they require components
        not to inform frame nor x,y coordinates.

        IMPORTANT this function can only be used within a `begin*()/end*()` block, otherwise it does nothing.

        Parameters
        ----------
        theWidth int
            width of the row. If a negative value is specified, the width of the row will be automatically calculated based on the content of the block.
        theHeight int
            height of the row. If a negative value is specified, the height of the row will be automatically calculated based on the content of the block.
        thePadding int
            space, in pixels, among the components of the block.

        See Also
        ----------
        beginColumn()
        endRow()
        endColumn()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static beginColumnf2(theWidth := -1, theHeight := -1, thePadding := 0)
    {
        /*
        Start a column. This function behaves in the same way as `beginColumn(frame, x, y, width, height)`,
        however it is suposed to be used within `begin*()/end*()` blocks since they require components
        not to inform frame nor x,y coordinates.

        IMPORTANT this function can only be used within a `begin*()/end*()` block, otherwise it does nothing.

        Parameters
        ----------
        theWidth int
            width of the column. If a negative value is specified, the width of the column will be automatically calculated based on the content of the block.
        theHeight int
            height of the column. If a negative value is specified, the height of the column will be automatically calculated based on the content of the block.
        thePadding int
            space, in pixels, among the components of the block.

        See Also
        ----------
        beginColumn()
        endRow()
        endColumn()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static space(theValue := 5)
    {
        /*
        Add an arbitrary amount of space between components within a `begin*()` and `end*()` block.
        The function is aware of context, so if it is used within a `beginColumn()` and
        `endColumn()` block, the space will be vertical. If it is used within a `beginRow()`
        and `endRow()` block, space will be horizontal.

        IMPORTANT this function can only be used within a `begin*()/end*()` block, otherwise it does nothing.

        Parameters
        ----------
        theValue int
            the amount of space to be added.

        See Also
        ----------
        beginColumn()
        beginRow()
        endRow()
        endColumn()
        */
        aBlock := __internal.topBlock()
        aSize := CVUI._Size(theValue, theValue)

        __internal.updateLayoutFlow(aBlock, aSize)
    }

    Static textf2(theText, theFontScale := 0.4, theColor := 0xCECECE)
    {
        /*
        Display a piece of text within a `begin*()` and `end*()` block.

        IMPORTANT this function can only be used within a `begin*()/end*()` block, otherwise it does nothing.

        Parameters
        ----------
        theText str
            text content.
        theFontScale float
            size of the text.
        theColor uint
            color of the text in the format `0xRRGGBB`, e.g. `0xff0000` for red.

        See Also
        ----------
        printf()
        beginColumn()
        beginRow()
        endRow()
        endColumn()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static buttonf4(theWidth, theHeight, theLabel)
    {
        /*
        Display a button within a `begin*()` and `end*()` block.
        The button size will be defined by the width and height parameters,
        no matter the content of the label.

        IMPORTANT this function can only be used within a `begin*()/end*()` block, otherwise it does nothing.

        Parameters
        ----------
        theWidth int
            width of the button.
        theHeight int
            height of the button.
        theLabel str
            text displayed inside the button. You can set shortcuts by pre-pending them with '&'

        Returns
        ----------
        `true` everytime the user clicks the button.

        See Also
        ----------
        beginColumn()
        beginRow()
        endRow()
        endColumn()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static buttonf5(theLabel)
    {
        /*
        Display a button within a `begin*()` and `end*()` block. The size of the button will be
        automatically adjusted to properly house the label content.

        IMPORTANT this function can only be used within a `begin*()/end*()` block, otherwise it does nothing.

        Parameters
        ----------
        theLabel str
            text displayed inside the button. You can set shortcuts by pre-pending them with '&'

        Returns
        ----------
        `true` everytime the user clicks the button.

        See Also
        ----------
        beginColumn()
        beginRow()
        endRow()
        endColumn()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static buttonf6(theIdle, theOver, theDown)
    {
        /*
        Display a button whose graphics are images (np.ndarray).

        IMPORTANT this function can only be used within a `begin*()/end*()` block, otherwise it does nothing.

        The button accepts three images to describe its states,
        which are idle (no mouse interaction), over (mouse is over the button) and down (mouse clicked the button).
        The button size will be defined by the width and height of the images.

        Parameters
        ----------
        theIdle np.ndarray
            image that will be rendered when the button is not interacting with the mouse cursor.
        theOver np.ndarray
            image that will be rendered when the mouse cursor is over the button.
        theDown np.ndarray
            image that will be rendered when the mouse cursor clicked the button (or is clicking).

        Returns
        ----------
        `true` everytime the user clicks the button.

        See Also
        ----------
        button()
        image()
        iarea()
        beginColumn()
        beginRow()
        endRow()
        endColumn()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static imagef2(theImage)
    {
        /*
        Display an image (np.ndarray) within a `begin*()` and `end*()` block

        IMPORTANT this function can only be used within a `begin*()/end*()` block, otherwise it does nothing.

        Parameters
        ----------
        theImage np.ndarray
            image to be rendered in the specified destination.

        See Also
        ----------
        button()
        iarea()
        beginColumn()
        beginRow()
        endRow()
        endColumn()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static checkboxf2(theLabel, theState, theColor := 0xCECECE)
    {
        /*
        Display a checkbox within a `begin*()` and `end*()` block. You can use the state parameter
        to monitor if the checkbox is checked or not.

        IMPORTANT this function can only be used within a `begin*()/end*()` block, otherwise it does nothing.

        Parameters
        ----------
        theLabel str
            text displayed besides the clickable checkbox square.
        theState [bool]
            array or list of booleans whose first position, i.e. theState[0], will be used to store the current state of the checkbox `True` means the checkbox is checked.
        theColor uint
            color of the label in the format `0xRRGGBB`, e.g. `0xff0000` for red.

        Returns
        ----------
        a boolean value that indicates the current state of the checkbox, `true` if it is checked.

        See Also
        ----------
        beginColumn()
        beginRow()
        endRow()
        endColumn()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static printff3(theFontScale, theColor, theFmt)
    {
        /*
        Display a piece of text within a `begin*()` and `end*()` block.

        IMPORTANT this function can only be used within a `begin*()/end*()` block, otherwise it does nothing.

        The text can be formated using `C stdio's printf()` style. For instance if you want to display text mixed
        with numbers, you can use

        ```
        printf(0.4, 0xff0000, 'Text %d and %f', 7, 3.1415)
        ```

        Parameters
        ----------
        theFontScale float
            size of the text.
        theColor uint
            color of the text in the format `0xRRGGBB`, e.g. `0xff0000` for red.
        theFmt str
            formating string as it would be supplied for `C stdio's printf()`, e.g. `'Text %d and %f', 7, 3.1415`.

        See Also
        ----------
        text()
        beginColumn()
        beginRow()
        endRow()
        endColumn()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static printff4(theFmt)
    {
        /*
        Display a piece of text that can be formated using `C stdio's printf()` style.

        IMPORTANT this function can only be used within a `begin*()/end*()` block, otherwise it does nothing.

        For instance if you want to display text mixed with numbers, you can use

        ```
        printf(frame, 10, 15, 0.4, 0xff0000, 'Text %d and %f', 7, 3.1415)
        ```

        The size and color of the text will be based on cvui's default values.

        Parameters
        ----------
        theFmt str
            formating string as it would be supplied for `stdio's printf()`, e.g. `'Text %d and %f', 7, 3.1415`.

        See Also
        ----------
        text()
        beginColumn()
        beginRow()
        endRow()
        endColumn()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static counterf2(theValue, theStep := 1, theFormat := '%d')
    {
        /*
        Display a counter for integer values that the user can increase/descrease
        by clicking the up and down arrows.

        IMPORTANT this function can only be used within a `begin*()/end*()` block, otherwise it does nothing.

        Parameters
        ----------
        theValue [number]
            array or list of numbers whose first position, i.e. theValue[1], will be used to store the current value of the counter.
        theStep number
            amount that should be increased/decreased when the user interacts with the counter buttons.
        theFormat str
            how the value of the counter should be presented, as it was printed by `C stdio's printf()`. E.g. `'%d'` means the value will be displayed as an integer, `'%0d'` integer with one leading zero, etc.

        Returns
        ----------
        number that corresponds to the current value of the counter.

        See Also
        ----------
        printf()
        beginColumn()
        beginRow()
        endRow()
        endColumn()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static trackbarf2(theWidth, theValue, theMin, theMax, theSegments := 1, theLabelFormat := '%.1Lf', theOptions := 0, theDiscreteStep := 1)
    {
        /*
        Display a trackbar for numeric values that the user can increase/decrease
        by clicking and/or dragging the marker right or left.

        IMPORTANT this function can only be used within a `begin*()/end*()` block, otherwise it does nothing.

        This component uses templates so it is imperative that you make it very explicit
        the type of `theValue`, `theMin`, `theMax` and `theStep`, otherwise you might end up with
        weird compilation errors.

        Example

        ```
        ; using float
        trackbar(width, &floatValue, 0.0, 50.0)

        ; using float
        trackbar(width, &floatValue, 0.0f, 50.0f)

        ; using char
        trackbar(width, &charValue, (char)1, (char)10)
        ```

        Parameters
        ----------
        theWidth int
            the width of the trackbar.
        theValue [number]
            array or list of numbers whose first position, i.e. theValue[1], will be used to store the current value of the trackbar. It will be modified when the user interacts with the trackbar. Any numeric type can be used, e.g. int, float, long double, etc.
        theMin number
            minimum value allowed for the trackbar.
        theMax number
            maximum value allowed for the trackbar.
        theSegments int
            number of segments the trackbar will have (default is 1). Segments can be seen as groups of numbers in the scale of the trackbar. For example, 1 segment means a single groups of values (no extra labels along the scale), 2 segments mean the trackbar values will be divided in two groups and a label will be placed at the middle of the scale.
        theLabelFormat str
            formating string that will be used to render the labels, e.g. `%.2Lf`. No matter the type of the `theValue` param, internally trackbar stores it as a `long float`, so the formating string will *always* receive a `long float` value to format. If you are using a trackbar with integers values, for instance, you can supress decimals using a formating string as `%.0Lf` to format your labels.
        theOptions uint
            options to customize the behavior/appearance of the trackbar, expressed as a bitset. Available options are defined as `TRACKBAR_` constants and they can be combined using the bitwise `|` operand. Available options are `TRACKBAR_HIDE_SEGMENT_LABELS` (do not render segment labels, but do render min/max labels), `TRACKBAR_HIDE_STEP_SCALE` (do not render the small lines indicating values in the scale), `TRACKBAR_DISCRETE` (changes of the trackbar value are multiples of informed step param), `TRACKBAR_HIDE_MIN_MAX_LABELS` (do not render min/max labels), `TRACKBAR_HIDE_VALUE_LABEL` (do not render the current value of the trackbar below the moving marker), `TRACKBAR_HIDE_LABELS` (do not render labels at all).
        theDiscreteStep number
            amount that the trackbar marker will increase/decrease when the marker is dragged right/left (if option TRACKBAR_DISCRETE is ON)

        Returns
        ----------
        `true` when the value of the trackbar changed.

        See Also
        ----------
        counter()
        beginColumn()
        beginRow()
        endRow()
        endColumn()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static windowf2(theWidth, theHeight, theTitle)
    {
        /*
        Display a window (a block with a title and a body) within a `begin*()` and `end*()` block.

        IMPORTANT this function can only be used within a `begin*()/end*()` block, otherwise it does nothing.

        Parameters
        ----------
        theWidth int
            width of the window.
        theHeight int
            height of the window.
        theTitle str
            text displayed as the title of the window.

        See Also
        ----------
        rect()
        beginColumn()
        beginRow()
        endRow()
        endColumn()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static rectf2(theWidth, theHeight, theBorderColor, theFillingColor := 0xff000000)
    {
        /*
        Display a rectangle within a `begin*()` and `end*()` block.

        IMPORTANT this function can only be used within a `begin*()/end*()` block, otherwise it does nothing.

        Parameters
        ----------
        theWidth int
            width of the rectangle.
        theHeight int
            height of the rectangle.
        theBorderColor uint
            color of rectangle's border in the format `0xRRGGBB`, e.g. `0xff0000` for red.
        theFillingColor uint
            color of rectangle's filling in the format `0xAARRGGBB`, e.g. `0x00ff0000` for red, `0xff000000` for transparent filling.

        See Also
        ----------
        window()
        beginColumn()
        beginRow()
        endRow()
        endColumn()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static sparklinef2(theValues, theWidth, theHeight, theColor := 0x00FF00)
    {
        /*
        Display the values of a vector as a sparkline within a `begin*()` and `end*()` block.

        IMPORTANT this function can only be used within a `begin*()/end*()` block, otherwise it does nothing.

        Parameters
        ----------
        theValues number[]
            array or list of numeric values that will be rendered as a sparkline.
        theWidth int
            width of the sparkline.
        theHeight int
            height of the sparkline.
        theColor uint
            color of sparkline in the format `0xRRGGBB`, e.g. `0xff0000` for red.

        See Also
        ----------
        beginColumn()
        beginRow()
        endRow()
        endColumn()
        */
        printc('This is wrapper function to help code autocompletion.')
    }

    Static update(theWindowName := '')
    {
        /*
        Update the library internal things. You need to call this function **AFTER** you are done adding/manipulating
        UI elements in order for them to react to mouse interactions.

        Parameters
        ----------
        theWindowName str
            name of the window whose components are being updated. If no window name is provided, cvui uses the default window.

        See Also
        ----------
        init()
        watch()
        context()
        */
        aContext := __internal.getContext(theWindowName)

        aContext.mouse.anyButton.justReleased := False
        aContext.mouse.anyButton.justPressed  := False

        for i in range(CVUI.LEFT_BUTTON, CVUI.RIGHT_BUTTON)
        {
            aContext.mouse.buttons[i].justReleased := False
            aContext.mouse.buttons[i].justPressed  := False
        }

        __internal.screen.reset()

        ; If we were told to keep track of the keyboard shortcuts, we
        ; proceed to handle opencv event queue.
        if __internal.delayWaitKey > 0
            __internal.lastKeyPressed := cv2.waitKey(__internal.delayWaitKey)

        if __internal.blockStackEmpty() == False
            __internal.error(2, 'Calling update() before finishing all begin*()/end*() calls. Did you forget to call a begin*() or an end*()? Check if every begin*() has an appropriate end*() call before you call update().')
    }

    Static init(theArgs*)
    {
        if __internal.isString(theArgs[1])
        {
            ; Signature init(theWindowName, theDelayWaitKey := -1, theCreateNamedWindow := True)
            aWindowName := theArgs[1]
            aDelayWaitKey := (len(theArgs) >= 2) ? theArgs[2] : -1
            aCreateNamedWindow := (len(theArgs) >= 3) ? theArgs[3] : True

            __internal.init(aWindowName, aDelayWaitKey)
            
            CVUI.watch(aWindowName, aCreateNamedWindow)
        }
        else
        {
            ; Signature init(theWindowNames[], theHowManyWindows, theDelayWaitKey := -1, theCreateNamedWindows := True)
            aWindowNames := theArgs[1]
            aHowManyWindows := theArgs[2]
            aDelayWaitKey := (len(theArgs) >= 3) ? theArgs[3] : -1
            aCreateNamedWindows := (len(theArgs) >= 4) ? theArgs[4] : True

            __internal.init(aWindowNames[1], aDelayWaitKey)

            for i in range(0, aHowManyWindows)
                CVUI.watch(aWindowNames[i + 1], aCreateNamedWindows)
        }
    }

    Static text(theArgs*)
    {
        if isinstance(theArgs[1], ComObject)
        {
            ; Signature text(theWhere, theX, theY, theText, theFontScale := 0.4, theColor := 0xCECECE)
            aWhere := theArgs[1]
            aX := theArgs[2]
            aY := theArgs[3]
            aText := theArgs[4]
            aFontScale := (len(theArgs) >= 5) ? theArgs[5] : 0.4
            aColor := (len(theArgs) >= 6) ? theArgs[6] : 0xCECECE

            __internal.screen.where := aWhere
            aBlock := __internal.screen
        }
        else
        {
            ; Signature text(theText, theFontScale := 0.4, theColor := 0xCECECE)
            aBlock := __internal.topBlock()
            aX := aBlock.anchor.x
            aY := aBlock.anchor.y
            aText := theArgs[1]
            aFontScale := (len(theArgs) >= 2) ? theArgs[2] : 0.4
            aColor := (len(theArgs) >= 3) ? theArgs[3] : 0xCECECE
        }
        
        __internal.text(aBlock, aX, aY, aText, aFontScale, aColor, True)
    }

    Static printf(theArgs*)
    {
        if isinstance(theArgs[1], ComObject)
        {
            ; Signature printf(theWhere, theX, theY, ...)
            aWhere := theArgs[1]
            aX := theArgs[2]
            aY := theArgs[3]

            __internal.screen.where := aWhere
            aBlock := __internal.screen
            theArgs.RemoveAt(1, 3)
            aArgs := theArgs
        }
        else
        {
            ; Row/column function
            aBlock := __internal.topBlock()
            aX := aBlock.anchor.x
            aY := aBlock.anchor.y
            aArgs := theArgs
        }

        if __internal.isString(aArgs[1])
        {
            ; Signature printf(theWhere, theX, theY, theFmt, ...)
            aFontScale := 0.4
            aColor := 0xCECECE
            aFmt := aArgs[1]
            aArgs.RemoveAt(1)
            aFmtArgs := aArgs
        }
        else
        {
            ; Signature printf(theWhere, theX, theY, theFontScale, theColor, theFmt, ...)
            aFontScale := aArgs[1]
            aColor := aArgs[2]
            aFmt := aArgs[3]
            aArgs.RemoveAt(1, 3)
            aFmtArgs := aArgs
        }

        aText := sprintf(aFmt, aFmtArgs)
        __internal.text(aBlock, aX, aY, aText, aFontScale, aColor, True)
    }

    Static counter(theArgs*)
    {
        if isinstance(theArgs[1], ComObject)
        {
            ; Signature counter(theWhere, theX, theY, theValue, theStep := 1, theFormat := "")
            aWhere := theArgs[1]
            aX := theArgs[2]
            aY := theArgs[3]
            aValue := theArgs[4]
            aStep := (len(theArgs) >= 5) ? theArgs[5] : 1
            aFormat := (len(theArgs) >= 6) ? theArgs[6] : ''

            __internal.screen.where := aWhere
            aBlock := __internal.screen
        }
        else
        {
            ; Signature counter(theValue, theStep := 1, theFormat := "%d")
            aBlock := __internal.topBlock()
            aX := aBlock.anchor.x
            aY := aBlock.anchor.y
            aValue := theArgs[1]
            aStep := (len(theArgs) >= 2) ? theArgs[2] : 1
            aFormat := (len(theArgs) >= 3) ? theArgs[3] : ''
        }

        if not aFormat
        {
            aIsInt := isinstance(aValue[1], Integer) == True and isinstance(aStep, Integer)
            aFormat := aIsInt ? '%d' : '%.1f'
        }

        return __internal.counter(aBlock, aX, aY, aValue, aStep, aFormat)
    }

    Static checkbox(theArgs*)
    {
        if isinstance(theArgs[1], ComObject)
        {
            ; Signature checkbox(theWhere, theX, theY, theLabel, theState, theColor := 0xCECECE)
            aWhere := theArgs[1]
            aX := theArgs[2]
            aY := theArgs[3]
            aLabel := theArgs[4]
            aState := theArgs[5]
            aColor := (len(theArgs) >= 6) ? theArgs[6] : 0xCECECE

            __internal.screen.where := aWhere
            aBlock := __internal.screen
        }
        else
        {
            ; Signature checkbox(theLabel, theState, theColor := 0xCECECE)
            aBlock := __internal.topBlock()
            aX := aBlock.anchor.x
            aY := aBlock.anchor.y
            aLabel := theArgs[1]
            aState := theArgs[2]
            aColor := (len(theArgs) >= 3) ? theArgs[3] : 0xCECECE
        }

        return __internal.checkbox(aBlock, aX, aY, aLabel, aState, aColor)
    }

    Static mouse(theArgs*)
    {
        if len(theArgs) == 3
        {
            ; Signature mouse(theWindowName, theButton, theQuery)
            aWindowName := theArgs[1]
            aButton := theArgs[2]
            aQuery := theArgs[3]
            return __internal.mouseWBQ(aWindowName, aButton, aQuery)
        }
        else if len(theArgs) == 2
        {
            ; Signatures mouse(theWindowName, theQuery) or mouse(theButton, theQuery)
            if __internal.isString(theArgs[1])
            {
                ; Signature mouse(theWindowName, theQuery)
                aWindowName := theArgs[1]
                aQuery := theArgs[2]
                return __internal.mouseWQ(aWindowName, aQuery)
            }
            else
            {
                ; Signature mouse(theButton, theQuery)
                aButton := theArgs[1]
                aQuery := theArgs[2]
                return __internal.mouseBQ(aButton, aQuery)
            }
        }
        else if len(theArgs) == 1 and isinstance(theArgs[0], Integer)
        {
            ; Signature mouse(theQuery)
            aQuery := theArgs[1]
            return __internal.mouseQ(aQuery)
        }
        else
        {
            ; Signature mouse(theWindowName := '')
            aWindowName := (len(theArgs) == 1) ? theArgs[1] : ''
            return __internal.mouseW(aWindowName)
        }
    }

    Static button(theArgs*)
    {
        if isinstance(theArgs[1], ComObject) and isinstance(theArgs[2], ComObject) == False
        {
            ; Signature button(Mat, theX, theY, ...)
            aWhere := theArgs[1]
            aX := theArgs[2]
            aY := theArgs[3]

            __internal.screen.where := aWhere
            aBlock := __internal.screen
            theArgs.RemoveAt(1, 3)
            aArgs := theArgs
        }
        else
        {
            ; Row/column function
            aBlock := __internal.topBlock()
            aX := aBlock.anchor.x
            aY := aBlock.anchor.y
            aArgs := theArgs
        }

        if len(aArgs) == 1
        {
            ; Signature button(theLabel)
            aLabel := aArgs[1]
            return __internal.button(aBlock, aX, aY, aLabel)
        }

        else if len(aArgs) == 3
        {
            if isinstance(aArgs[1], Integer)
            {
                ; Signature button(theWidth, theHeight, theLabel)
                aWidth := aArgs[1]
                aHeight := aArgs[2]
                aLabel := aArgs[3]
                return __internal.buttonWH(aBlock, aX, aY, aWidth, aHeight, aLabel, True)
            }
            else
            {
                ; Signature button(theIdle, theOver, theDown)
                aIdle := aArgs[1]
                aOver := aArgs[2]
                aDown := aArgs[3]
                return __internal.buttonI(aBlock, aX, aY, aIdle, aOver, aDown, True)
            }
        }
        else
            ; TODO check this case here
            printc('Problem?')
    }

    Static image(theArgs*)
    {
        if isinstance(theArgs[1], ComObject) and len(theArgs) > 1
        {
            ; Signature image(Mat, ...)
            aWhere := theArgs[1]
            aX := theArgs[2]
            aY := theArgs[3]
            aImage := theArgs[4]

            __internal.screen.where := aWhere
            __internal.image(__internal.screen, aX, aY, aImage)
        }
        else
        {
            ; Row/column function, signature is image(...)
            aImage := theArgs[1]
            aBlock := __internal.topBlock()
            
            __internal.image(aBlock, aBlock.anchor.x, aBlock.anchor.y, aImage)
        }
    }

    Static trackbar(theArgs*)
    {
        ; TODO re-factor this two similar blocks by slicing theArgs into aArgs
        if isinstance(theArgs[1], ComObject)
        {
            ; Signature trackbar(theWhere, theX, theY, theWidth, theValue, theMin, theMax, theSegments := 1, theLabelFormat := "%.1Lf", theOptions := 0, theDiscreteStep := 1)
            aWhere := theArgs[1]
            aX := theArgs[2]
            aY := theArgs[3]
            aWidth := theArgs[4]
            aValue := theArgs[5]
            aMin := theArgs[6]
            aMax := theArgs[7]
            aSegments := (len(theArgs) >= 8) ? theArgs[8] : 1
            aLabelFormat := (len(theArgs) >= 9) ? theArgs[9] : '%.1Lf'
            aOptions := (len(theArgs) >= 10) ? theArgs[10] : 0
            aDiscreteStep := (len(theArgs) >= 11) ? theArgs[11] : 1

            __internal.screen.where := aWhere
            aBlock := __internal.screen
        }
        else
        {
            ; Signature trackbar(theWidth, theValue, theMin, theMax, theSegments := 1, theLabelFormat := "%.1Lf", theOptions := 0, theDiscreteStep := 1)
            aBlock := __internal.topBlock()
            aX := aBlock.anchor.x
            aY := aBlock.anchor.y
            aWidth := theArgs[1]
            aValue := theArgs[2]
            aMin := theArgs[3]
            aMax := theArgs[4]
            aSegments := (len(theArgs) >= 5) ? theArgs[5] : 1
            aLabelFormat := (len(theArgs) >= 6) ? theArgs[6] : '%.1Lf'
            aOptions := (len(theArgs) >= 7) ? theArgs[7] : 0
            aDiscreteStep := (len(theArgs) >= 8) ? theArgs[8] : 1
        }

        ; TODO adjust aLabelFormat based on type of aValue
        aParams := CVUI._TrackbarParams(aMin, aMax, aDiscreteStep, aSegments, aLabelFormat, aOptions)
        aResult := __internal.trackbar(aBlock, aX, aY, aWidth, aValue, aParams)

        return aResult
    }

    Static window(theArgs*)
    {
        if isinstance(theArgs[1], ComObject)
        {
            ; Signature window(theWhere, theX, theY, theWidth, theHeight, theTitle)
            aWhere := theArgs[1]
            aX := theArgs[2]
            aY := theArgs[3]
            aWidth := theArgs[4]
            aHeight := theArgs[5]
            aTitle := theArgs[6]

            __internal.screen.where := aWhere
            __internal.window(__internal.screen, aX, aY, aWidth, aHeight, aTitle)
        }
        else
        {
            ; Row/column function, signature window(theWidth, theHeight, theTitle)
            aWidth := theArgs[1]
            aHeight := theArgs[2]
            aTitle := theArgs[3]

            aBlock := __internal.topBlock()
            __internal.window(aBlock, aBlock.anchor.x, aBlock.anchor.y, aWidth, aHeight, aTitle)
        }
    }

    Static rect(theArgs*)
    {
        if isinstance(theArgs[1], ComObject)
        {
            ; Signature rect(theWhere, theX, theY, theWidth, theHeight, theBorderColor, theFillingColor := 0xff000000)
            aWhere := theArgs[1]
            aX := theArgs[2]
            aY := theArgs[3]
            aWidth := theArgs[4]
            aHeight := theArgs[5]
            aBorderColor := theArgs[6]
            aFillingColor := (len(theArgs) >= 7) ? theArgs[7] : 0xff000000

            __internal.screen.where := aWhere
            aBlock := __internal.screen
        }
        else
        {
            ; Signature rect(theWidth, theHeight, theBorderColor, theFillingColor := 0xff000000)
            aBlock := __internal.topBlock()
            aX := aBlock.anchor.x
            aY := aBlock.anchor.y
            aWidth := theArgs[1]
            aHeight := theArgs[2]
            aBorderColor := theArgs[3]
            aFillingColor := (len(theArgs) >= 4) ? theArgs[4] : 0xff000000
        }

        __internal.rect(aBlock, aX, aY, aWidth, aHeight, aBorderColor, aFillingColor)
    }

    Static sparkline(theArgs*)
    {
        if isinstance(theArgs[1], ComObject)
        {
            ; Signature sparkline(theWhere, theValues, theX, theY, theWidth, theHeight, theColor := 0x00FF00)
            aWhere := theArgs[1]
            aValues := theArgs[2]
            aX := theArgs[3]
            aY := theArgs[4]
            aWidth := theArgs[5]
            aHeight := theArgs[6]
            aColor := (len(theArgs) >= 7) ? theArgs[7] : 0x00FF00

            __internal.screen.where := aWhere
            aBlock := __internal.screen
        }
        else
        {
            ; Signature sparkline(theValues, theWidth, theHeight, theColor := 0x00FF00)
            aBlock := __internal.topBlock()
            aValues := theArgs[1]
            aX := aBlock.anchor.x
            aY := aBlock.anchor.y
            aWidth := theArgs[2]
            aHeight := theArgs[3]
            aColor := (len(theArgs) >= 4) ? theArgs[4] : 0x00FF00
        }

        __internal.sparkline(aBlock, aValues, aX, aY, aWidth, aHeight, aColor)
    }

    Static beginRow(theArgs*)
    {
        if len(theArgs) and isinstance(theArgs[1], ComObject)
        {
            ; Signature beginRow(theWhere, theX, theY, theWidth := -1, theHeight := -1, thePadding := 0):
            aWhere := theArgs[1]
            aX := theArgs[2]
            aY := theArgs[3]
            aWidth := (len(theArgs) >= 4) ? theArgs[4] : -1
            aHeight := (len(theArgs) >= 5) ? theArgs[5] : -1
            aPadding := (len(theArgs) >= 6) ? theArgs[6] : 0

            __internal.begin(CVUI.ROW, aWhere, aX, aY, aWidth, aHeight, aPadding)
        }
        else
        {
            ; Signature beginRow(theWidth := -1, theHeight := -1, thePadding := 0)
            aWidth := (len(theArgs) >= 1) ? theArgs[1] : -1
            aHeight := (len(theArgs) >= 2) ? theArgs[2] : -1
            aPadding := (len(theArgs) >= 3) ? theArgs[3] : 0

            aBlock := __internal.topBlock()
            __internal.begin(CVUI.ROW, aBlock.where, aBlock.anchor.x, aBlock.anchor.y, aWidth, aHeight, aPadding)
        }
    }

    Static beginColumn(theArgs*)
    {
        if len(theArgs) > 0 and isinstance(theArgs[1], ComObject)
        {
            ; Signature beginColumn(theWhere, theX, theY, theWidth := -1, theHeight := -1, thePadding := 0):
            aWhere := theArgs[1]
            aX := theArgs[2]
            aY := theArgs[3]
            aWidth := (len(theArgs) >= 4) ? theArgs[4] : -1
            aHeight := (len(theArgs) >= 5) ? theArgs[5] : -1
            aPadding := (len(theArgs) >= 6) ? theArgs[6] : 0

            __internal.begin(CVUI.COLUMN, aWhere, aX, aY, aWidth, aHeight, aPadding)
        }
        else
        {
            ; Signature beginColumn(theWidth := -1, theHeight := -1, thePadding := 0):
            aWidth := (len(theArgs) >= 1) ? theArgs[1] : -1
            aHeight := (len(theArgs) >= 2) ? theArgs[2] : -1
            aPadding := (len(theArgs) >= 3) ? theArgs[3] : 0

            aBlock := __internal.topBlock()
            __internal.begin(CVUI.COLUMN, aBlock.where, aBlock.anchor.x, aBlock.anchor.y, aWidth, aHeight, aPadding)
        }
    }
}

_handleMouse(theEvent, theX, theY, theFlags)
{
    Global theContext
    
    aButtons    := [CVUI.LEFT_BUTTON, CVUI.MIDDLE_BUTTON, CVUI.RIGHT_BUTTON]
    aEventsDown := [cv2.EVENT_LBUTTONDOWN, cv2.EVENT_MBUTTONDOWN, cv2.EVENT_RBUTTONDOWN]
    aEventsUp   := [cv2.EVENT_LBUTTONUP, cv2.EVENT_MBUTTONUP, cv2.EVENT_RBUTTONUP]

    for i in range(CVUI.LEFT_BUTTON, CVUI.RIGHT_BUTTON)
    {
        aBtn := aButtons[i + 1]

        if theEvent == aEventsDown[i + 1]
        {
            theContext.mouse.anyButton.justPressed      := True
            theContext.mouse.anyButton.pressed          := True
            theContext.mouse.buttons[aBtn].justPressed  := True
            theContext.mouse.buttons[aBtn].pressed      := True
        }

        else if theEvent == aEventsUp[i + 1]
        {
            theContext.mouse.anyButton.justReleased     := True
            theContext.mouse.anyButton.pressed          := False
            theContext.mouse.buttons[aBtn].justReleased := True
            theContext.mouse.buttons[aBtn].pressed      := False
        }
    }
    
    theContext.mouse.position.x := theX
    theContext.mouse.position.y := theY
}
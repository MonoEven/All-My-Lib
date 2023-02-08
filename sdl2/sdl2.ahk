; Author: Mono
; Version: v1.0.0
; Time: 2022.09.16

#Include <sdl2\sdl>
InstallDir := RegRead("HKLM\SOFTWARE\AutoHotkey", "InstallDir", "")
DirPath := IniRead(InstallDir "\Lib\sdl2\SDL2.ini", "WorkDir", "Dir")

Dllcall("SetDllDirectory", "Str", InstallDir "\Lib\sdl2\" DirPath)
hSDL2 := DllCall("LoadLibrary", "Str", "sdl2.dll", "Ptr")
hSDL2Image := DllCall("LoadLibrary", "Str", "sdl2_image.dll", "Ptr")
hSDL2Mixer := DllCall("LoadLibrary", "Str", "sdl2_mixer.dll", "Ptr")
hSDL2Net := DllCall("LoadLibrary", "Str", "sdl2_net.dll", "Ptr")
hSDL2TTF := DllCall("LoadLibrary", "Str", "sdl2_ttf.dll", "Ptr")
Dllcall("SetDllDirectory", "Str", A_ScriptDir)
NULL := 0

Class SDL2 Extends SDL
{
    Class BlitMap
    {
        
    }
    
    Class Event
    {
        __New(buf := 0)
        {
            this.buf := buf
            this.common := SDL2.Event.Common()
            this.window := SDL2.Event.Window()
            this.keyboard := SDL2.Event.Keyboard()
            this.keyboard.keysym := SDL2.Event.Keyboard.KeySym()
            this.textediting := SDL2.Event.TextEditing()
            this.textinput := SDL2.Event.TextInput()
            this.mousemotion := SDL2.Event.MouseMotion()
            this.mousebutton := SDL2.Event.MouseButton()
            this.mousewheel := SDL2.Event.MouseWheel()
            this.joyaxis := SDL2.Event.JoyAxis()
            this.joyball := SDL2.Event.JoyBall()
            this.joyhat := SDL2.Event.JoyHat()
            this.joybutton := SDL2.Event.JoyButton()
            this.joydevice := SDL2.Event.JoyDevice()
            this.controlleraxis := SDL2.Event.ControllerAxis()
            this.controllerbutton := SDL2.Event.ControllerButton()
            this.controllerdevice := SDL2.Event.ControllerDevice()
            this.touchfinger := SDL2.Event.TouchFinger()
            this.multigesture := SDL2.Event.MultiGesture()
            this.dollargesture := SDL2.Event.DollarGesture()
            this.drop := SDL2.Event.Drop()
            this.quit := SDL2.Event.Quit()
            this.os := SDL2.Event.OS()
            this.user := SDL2.Event.User()
            this.syswm := SDL2.Event.SysWM()
        }
        
        Class Common
        {
            
        }
        
        Class Window
        {
            
        }
        
        Class Keyboard
        {
            Class KeySym
            {
                
            }
        }
        
        Class TextEditing
        {
            
        }
        
        Class TextInput
        {
            
        }
        
        Class MouseMotion
        {
            
        }
        
        Class MouseButton
        {
            
        }
        
        Class MouseWheel
        {
            
        }
        
        Class JoyAxis
        {
            
        }
        
        Class JoyBall
        {
            
        }
        
        Class JoyHat
        {
            
        }

        Class JoyButton
        {
            
        }

        Class JoyDevice
        {
            
        }

        Class ControllerAxis
        {
            
        }

        Class ControllerButton
        {
            
        }

        Class ControllerDevice
        {
            
        }

        Class TouchFinger
        {
            
        }

        Class MultiGesture
        {
            
        }

        Class DollarGesture
        {
            
        }

        Class Drop
        {
            
        }

        Class Quit
        {
            
        }

        Class OS
        {
            
        }

        Class User
        {
            
        }

        Class SysWM
        {
            
        }
    }
    
    Class IMG
    {
        Static GetError()
        {
            ErrorPtr := DllCall("sdl2.dll\SDL_GetError")
            
            if ErrorPtr > 0
                Return StrGet(ErrorPtr, 200, "UTF-8")
        }
        
        Static Init(flags)
        {
            Return DllCall("sdl2_image.dll\IMG_Init", "Int", flags)
        }
        
        Static Load(file)
        {
            surface := SDL2.Surface()
            surface.ptr := DllCall("sdl2_image.dll\IMG_Load", "AStr", file)
            surface := SDL2.ToSDL2SurfaceStruct(surface)
            
            Return surface
        }
        
        Static LoadTexture(renderer, file)
        {
            Return DllCall("sdl2_image.dll\IMG_LoadTexture", "Ptr", renderer, "AStr", file)
        }
        
        Static LoadTexture_RW(renderer, src, freesrc)
        {
            Return DllCall("sdl2_image.dll\IMG_LoadTexture_RW", "Ptr", renderer, "Ptr", src, "Int", freesrc)
        }
        
        Static Quit()
        {
            Return DllCall("sdl2_image.dll\IMG_Quit")
        }
        
        Static SavePNG(surface, file)
        {
            Return DllCall("sdl2_image.dll\IMG_SavePNG", "Ptr", surface, "AStr", file)
        }
    }
    
    Class Keyboard
    {
        __Item[Key]
        {
            Get => this.ptr ? NumGet(this.ptr, Key, "UChar") : 0
        }
    }
    
    Class Mix
    {
        Static CloseAudio()
        {
            Return DllCall("sdl2_mixer.dll\Mix_CloseAudio")
        }
        
        Static FreeChunk(chunk)
        {
            Return DllCall("sdl2_mixer.dll\Mix_FreeChunk", "Ptr", chunk)
        }
        
        Static FreeMusic(music)
        {
            Return DllCall("sdl2_mixer.dll\Mix_FreeMusic", "Ptr", music)
        }
        
        Static GetError()
        {
            ErrorPtr := DllCall("sdl2.dll\SDL_GetError")
            
            if ErrorPtr > 0
                Return StrGet(ErrorPtr, 200, "UTF-8")
        }
        
        Static HaltMusic()
        {
            Return DllCall("sdl2_mixer.dll\Mix_HaltMusic")
        }
        
        Static Init(flags)
        {
            Return DllCall("sdl2_mixer.dll\Mix_Init", "Int", flags)
        }
        
        Static LoadMUS(file)
        {
            Return DllCall("sdl2_mixer.dll\Mix_LoadMUS", "AStr", file)
        }
        
        Static LoadMUS_RW(src, freesrc)
        {
            Return DllCall("sdl2_mixer.dll\Mix_LoadMUS_RW", "Ptr", src, "Int", freesrc)
        }
        
        Static LoadWAV(file)
        {
            Return DllCall("sdl2_mixer.dll\Mix_LoadWAV", "AStr", file)
        }
        
        Static LoadWAV_RW(src, freesrc)
        {
            Return DllCall("sdl2_mixer.dll\Mix_LoadWAV_RW", "Ptr", src, "Int", freesrc)
        }
        
        Static OpenAudio(frequency, format, channels, chunksize)
        {
            Return DllCall("sdl2_mixer.dll\Mix_OpenAudio", "Int", frequency, "UShort", format, "Int", channels, "Int", chunksize)
        }
        
        Static PauseMusic()
        {
            Return DllCall("sdl2_mixer.dll\Mix_PauseMusic")
        }
        
        Static PausedMusic()
        {
            Return DllCall("sdl2_mixer.dll\Mix_PausedMusic")
        }
        
        Static PlayChannel(channel, chunk, loops)
        {
            Return DllCall("sdl2_mixer.dll\Mix_PlayChannel", "Int", channel, "Ptr", chunk, "Int", loops)
        }
        
        Static PlayingMusic()
        {
            Return DllCall("sdl2_mixer.dll\Mix_PlayingMusic")
        }
        
        Static PlayMusic(music, loops)
        {
            Return DllCall("sdl2_mixer.dll\Mix_PlayMusic", "Ptr", music, "Int", loops)
        }
        
        Static Quit()
        {
            Return DllCall("sdl2_mixer.dll\Mix_Quit")
        }
        
        Static ResumeMusic()
        {
            Return DllCall("sdl2_mixer.dll\Mix_ResumeMusic")
        }
    }
    
    Class Rect
    {
        
    }
    
    Class Surface
    {
        __New()
        {
            this.format := SDL2.Surface.PixelFormat()
            this.userdata := SDL2.Surface.UserData()
            this.lock_data := SDL2.Surface.Lock_Data()
            this.clip_rect := SDL2.Rect()
            this.map := SDL2.BlitMap()
        }
        
        Class Lock_Data
        {
            
        }
        
        Class PixelFormat
        {
            
        }
        
        Class UserData
        {
            
        }
    }
    
    Class TTF
    {
        Static CloseFont(font)
        {
            Return DllCall("sdl2_ttf.dll\TTF_CloseFont", "Ptr", font)
        }
        
        Static GetError()
        {
            ErrorPtr := DllCall("sdl2.dll\SDL_GetError")
            
            if ErrorPtr > 0
                Return StrGet(ErrorPtr, 200, "UTF-8")
        }
        
        Static Init()
        {
            Return DllCall("sdl2_ttf.dll\TTF_Init")
        }
        
        Static OpenFont(ttf, size := 20)
        {
            Return DllCall("sdl2_ttf.dll\TTF_OpenFont", "AStr", ttf, "Int", size)
        }
        
        Static Quit()
        {
            Return DllCall("sdl2_ttf.dll\TTF_Quit")
        }
        
        Static RenderText_Blended(font, text, color*)
        {
            if color[1] is Array
            {
                r := color[1][1]
                g := color[1][2]
                b := color[1][3]
                a := color[1][4]
            }
            
            else
            {
                r := color[1]
                g := color[2]
                b := color[3]
                a := color[4]
            }
            
            surface := SDL2.Surface()
            surface.ptr := DllCall("sdl2_ttf.dll\TTF_RenderText_Blended", "Ptr", font, "AStr", text, "UChar", r, "UChar", g, "UChar", b, "UChar", a)
            surface := SDL2.ToSDL2SurfaceStruct(surface)
            
            Return surface
        }
        
        Static RenderText_Solid(font, text, color*)
        {
            if color[1] is Array
            {
                r := color[1][1]
                g := color[1][2]
                b := color[1][3]
            }
            
            else
            {
                r := color[1]
                g := color[2]
                b := color[3]
            }
            
            flag := (!isNumber(color[-1])) ? color[-1] : 0
            
            surface := SDL2.Surface()
            
            if !flag
                surface.ptr := DllCall("sdl2_ttf.dll\TTF_RenderText_Solid", "Ptr", font, "AStr", text, "UChar", r, "UChar", g, "UChar", b)
            
            else
                surface.ptr := DllCall("sdl2_ttf.dll\TTF_RenderText_Solid", "Ptr", font, "AStr", String(text), "UInt", SDL2.MapRGB(flag.format, r, g, b))
            
            surface := SDL2.ToSDL2SurfaceStruct(surface)
            
            Return surface
        }
        
        Static RenderUTF8_Blended(font, text, color*)
        {
            if color[1] is Array
            {
                r := color[1][1]
                g := color[1][2]
                b := color[1][3]
                a := color[1][4]
            }
            
            else
            {
                r := color[1]
                g := color[2]
                b := color[3]
                a := color[4]
            }
            
            surface := SDL2.Surface()
            surface.ptr := DllCall("sdl2_ttf.dll\TTF_RenderUTF8_Blended", "Ptr", font, "AStr", text, "UChar", r, "UChar", g, "UChar", b, "UChar", a)
            surface := SDL2.ToSDL2SurfaceStruct(surface)
            
            Return surface
        }
        
        Static SizeText(font, text, rect)
        {
            _w := rect[3]
            _h := rect[4]
            
            Ret := DllCall("sdl2_ttf.dll\TTF_RenderUTF8_Blended", "Ptr", font, "AStr", text, "Int*", &_w, "Int", &_h)
            
            rect[3] := _w
            rect[4] := _h
            Return Ret
        }
    }
    
    Static BlitScaled(src, srcrect, dst, dstrect)
    {
        buf := 0
        buf2 := 0
        
        if srcrect
        {
            buf := Buffer(16, 0)
            args := []
            
            For i in srcrect
                args.Push("Int", i)
            
            args.Push(buf)
            NumPut(args*)
        }
        
        if dstrect
        {
            buf2 := Buffer(16, 0)
            args := []
            
            For i in dstrect
                args.Push("Int", i)
            
            args.Push(buf2)
            NumPut(args*)
        }
        
        Ret := DllCall("sdl2.dll\SDL_UpperBlitScaled", "Ptr", src, "Ptr", buf, "Ptr", dst, "Ptr", buf2)
        
        if srcrect
        {
            srcrect[1] := NumGet(buf, 0, "Int")
            srcrect[2] := NumGet(buf, 4, "Int")
            srcrect[3] := NumGet(buf, 8, "Int")
            srcrect[4] := NumGet(buf, 12, "Int")
        }
        
        if dstrect
        {
            dstrect[1] := NumGet(buf2, 0, "Int")
            dstrect[2] := NumGet(buf2, 4, "Int")
            dstrect[3] := NumGet(buf2, 8, "Int")
            dstrect[4] := NumGet(buf2, 12, "Int")
        }
        
        Return Ret
    }
    
    Static BlitSurface(src, srcrect, dst, dstrect)
    {
        buf := 0
        buf2 := 0
        
        if srcrect
        {
            buf := Buffer(16, 0)
            args := []
            
            For i in srcrect
                args.Push("Int", i)
            
            args.Push(buf)
            NumPut(args*)
        }
        
        if srcrect
        {
            srcrect[1] := NumGet(buf, 0, "Int")
            srcrect[2] := NumGet(buf, 4, "Int")
            srcrect[3] := NumGet(buf, 8, "Int")
            srcrect[4] := NumGet(buf, 12, "Int")
        }
        
        if dstrect
        {
            buf2 := Buffer(16, 0)
            args := []
            
            For i in dstrect
                args.Push("Int", i)
            
            args.Push(buf2)
            NumPut(args*)
        }
        
        Ret := DllCall("sdl2.dll\SDL_UpperBlit", "Ptr", src, "Ptr", buf, "Ptr", dst, "Ptr", buf2)
        
        if dstrect
        {
            dstrect[1] := NumGet(buf2, 0, "Int")
            dstrect[2] := NumGet(buf2, 4, "Int")
            dstrect[3] := NumGet(buf2, 8, "Int")
            dstrect[4] := NumGet(buf2, 12, "Int")
        }
        
        Return Ret
    }
    
    Static ClearHints()
    {
        Return DllCall("sdl2.dll\SDL_ClearHints")
    }
    
    Static ConvertSurface(src, fmt, flags)
    {
        surface := SDL2.Surface()
        surface.ptr := DllCall("sdl2.dll\SDL_ConvertSurface", "Ptr", src, "Ptr", fmt, "Int", flags)
        surface := SDL2.ToSDL2SurfaceStruct(surface)
        
        Return surface
    }
    
    Static CreateRenderer(window, index, flags)
    {
        Return DllCall("sdl2.dll\SDL_CreateRenderer", "Ptr", window, "Int", index, "Int", flags)
    }
    
    Static CreateRGBSurfaceFrom(pixels, width, height, depth, pitch, Rmask, Gmask, Bmask, Amask)
    {
        pixels := width * height * 4
        buf := Buffer(pixels, 1)
        
        
        surface := SDL2.Surface()
        surface.ptr := DllCall("sdl2.dll\SDL_CreateRGBSurfaceFrom", "Ptr", buf, "Int", width, "Int", height, "Int", depth, "Int", pitch, "UInt", Rmask, "UInt", Gmask, "UInt", Bmask, "UInt", Amask)
        surface := SDL2.ToSDL2SurfaceStruct(surface)
        
        Return surface
    }
    
    Static CreateRGBSurfaceWithFormatFrom(pixels, width, height, depth, pitch, format)
    {
        pixels := width * height * 4
        buf := Buffer(pixels, 1)
        
        surface := SDL2.Surface()
        surface.ptr := DllCall("sdl2.dll\SDL_CreateRGBSurfaceWithFormatFrom", "Ptr", buf, "Int", width, "Int", height, "Int", depth, "Int", pitch, "UInt", format)
        surface := SDL2.ToSDL2SurfaceStruct(surface)
        
        Return surface
    }
    
    Static CreateSoftwareRenderer(surface)
    {
        Return DllCall("sdl2.dll\SDL_CreateSoftwareRenderer", "Ptr", surface)
    }
    
    Static CreateTextureFromSurface(renderer, surface)
    {
        Return DllCall("sdl2.dll\SDL_CreateTextureFromSurface", "Ptr", renderer, "Ptr", surface)
    }
    
    Static CreateWindow(title, x, y, w, h, flags := 0)
    {
        Return DllCall("sdl2.dll\SDL_CreateWindow", "AStr", title, "Int", x, "Int", y, "Int", w, "Int", h, "Int", flags)
    }
    
    Static Delay(times)
    {
        Return DllCall("sdl2.dll\SDL_Delay", "Int", times)
    }
    
    Static DestroyRenderer(renderer)
    {
        Return DllCall("sdl2.dll\SDL_DestroyRenderer", "Ptr", renderer)
    }
    
    Static DestroyTexture(texture)
    {
        Return DllCall("sdl2.dll\SDL_DestroyTexture", "Ptr", texture)
    }
    
    Static DestroyWindow(window)
    {
        Return DllCall("sdl2.dll\SDL_DestroyWindow", "Ptr", window)
    }
    
    Static FillRect(dst, rect, color)
    {
        buf := rect
        
        if rect is Array
        {
            buf := Buffer(16, 0)
            args := []
            args.Push("Int", rect[1], "Int", rect[2], "Int", rect[3], "Int", rect[4], buf)
            NumPut(args*)
        }
        
        Return DllCall("sdl2.dll\SDL_FillRect", "Ptr", dst, "Ptr", buf, "UInt", color)
    }
    
    Static FreeSurface(surface)
    {
        Return DllCall("sdl2.dll\SDL_FreeSurface", "Ptr", surface)
    }
    
    Static GetError()
    {
        ErrorPtr := DllCall("sdl2.dll\SDL_GetError")
        
        if ErrorPtr > 0
            Return StrGet(ErrorPtr, 200, "UTF-8")
    }
    
    Static GetHint(name)
    {
        Return DllCall("sdl2.dll\SDL_GetHint", "AStr", name)
    }
    
    Static GetKeyboardState(&numkeys := 0)
    {
        numkeys_ := 0
        Ret := SDL2.Keyboard()
        Ret.ptr := DllCall("sdl2.dll\SDL_GetKeyboardState", "Ptr")
        DllCall("sdl2.dll\SDL_GetKeyboardState", "Int*", &numkeys_)
        numkeys := numkeys_
        
        Return Ret
    }
    
    Static GetMouseState(&x, &y)
    {
        x_ := 0
        y_ := 0
        Ret :=  DllCall("sdl2.dll\SDL_GetMouseState", "Int*", &x_, "Int*", &y_)
        
        x := x_
        y := y_
        
        Return Ret
    }
    
    Static GetPerformanceCounter()
    {
        Return DllCall("sdl2.dll\SDL_GetPerformanceCounter")
    }
    
    Static GetPerformanceFrequency()
    {
        Return DllCall("sdl2.dll\SDL_GetPerformanceFrequency")
    }
    
    Static GetTicks()
    {
        Return DllCall("sdl2.dll\SDL_GetTicks")
    }
    
    Static GetWindowSurface(window)
    {
        surface := SDL2.Surface()
        surface.ptr := DllCall("sdl2.dll\SDL_GetWindowSurface", "Ptr", window)
        surface := SDL2.ToSDL2SurfaceStruct(surface)
        
        Return surface
    }
    
    Static Init(flags)
    {
        Return DllCall("sdl2.dll\SDL_Init", "Int", flags)
    }
    
    Static LoadBMP(file)
    {
        surface := SDL2.Surface()
        surface.ptr := DllCall("sdl2_image.dll\IMG_Load", "AStr", file)
        surface := SDL2.ToSDL2SurfaceStruct(surface)
        
        Return surface
    }
    
    Static LoadJPEG(file)
    {
        surface := SDL2.Surface()
        surface.ptr := DllCall("sdl2_image.dll\IMG_Load", "AStr", file)
        surface := SDL2.ToSDL2SurfaceStruct(surface)
        
        Return surface
    }
    
    Static LoadPNG(file)
    {
        surface := SDL2.Surface()
        surface.ptr := DllCall("sdl2_image.dll\IMG_Load", "AStr", file)
        surface := SDL2.ToSDL2SurfaceStruct(surface)
        
        Return surface
    }
    
    Static Log(fs, args*)
    {
        if args.Length && args[1] is Array
            args := args[1]
        
        if RegExMatch(fs, "i)%\.(.*)LF", &Num := 0)
            Return Round(args[-1], Num[1])
        
        if RegExMatch(fs, "i)%\.(.*)F", &Num := 0)
            Return Round(args[-1], Num[1])
        
        fs := StrReplace(fs, "\t", "`t")
        fs := StrReplace(fs, "\n", "`n")
        fs := StrReplace(fs, "%d", "{:d}")
        fs := StrReplace(fs, "%i", "{:i}")
        fs := StrReplace(fs, "%x", "{:x}")
        fs := StrReplace(fs, "%o", "{:o}")
        fs := StrReplace(fs, "%f", "{:f}")
        fs := StrReplace(fs, "%e", "{:e}")
        fs := StrReplace(fs, "%E", "{:E}")
        fs := StrReplace(fs, "%g", "{:g}")
        fs := StrReplace(fs, "%G", "{:G}")
        fs := StrReplace(fs, "%a", "{:a}")
        fs := StrReplace(fs, "%A", "{:A}")
        fs := StrReplace(fs, "%p", "{:p}")
        fs := StrReplace(fs, "%s", "{:s}")
        fs := StrReplace(fs, "%c", "{:c}")
        s := Format(fs, args*)
        
        Return s
    }
    
    Static MapRGB(format, r, g, b)
    {
        Return DllCall("sdl2.dll\SDL_MapRGB", "Ptr", format, "UChar", r, "UChar", g, "UChar", b)
    }
    
    Static MapRGBA(format, r, g, b, a)
    {
        Return DllCall("sdl2.dll\SDL_MapRGBA", "Ptr", format, "UChar", r, "UChar", g, "UChar", b, "UChar", a)
    }
    
    Static MUSTLOCK(surface)
    {
        Return DllCall("sdl2.dll\SDL_MUSTLOCK", "Ptr", surface)
    }
    
    Static PollEvent(&event)
    {
        struct := Buffer(100, 0)
        ret := DllCall("sdl2.dll\SDL_PollEvent", "Ptr", struct)
        event := SDL2.Event(struct)
        SDL2.ToSDL2EventStruct(event)
        
        Return ret
    }
    
    Static Quit()
    {
        Return DllCall("sdl2.dll\SDL_Quit")
    }
    
    Static RenderDrawLine(renderer, x1, y1, x2, y2)
    {
        Return DllCall("sdl2.dll\SDL_RenderDrawLine", "Ptr", renderer, "Int", x1, "Int", y1, "Int", x2, "Int", y2)
    }
    
    Static RenderDrawLines(renderer, points, count)
    {
        buf := Buffer(8 * count, 0)
        args := []
        
        For i in points
            args.Push("Int", i[1], "Int", i[2])
        
        args.Push(buf)
        NumPut(args*)
        
        Return DllCall("sdl2.dll\SDL_RenderDrawLines", "Ptr", renderer, "Ptr", buf, "Int", count)
    }
    
    Static RenderDrawPoint(renderer, x, y)
    {
        Return DllCall("sdl2.dll\SDL_RenderDrawPoint", "Ptr", renderer, "Int", x, "Int", y)
    }
    
    Static RenderDrawPoints(renderer, points, count)
    {
        buf := Buffer(8 * count, 0)
        args := []
        
        For i in points
            args.Push("Int", i[1], "Int", i[2])
        
        args.Push(buf)
        NumPut(args*)
        
        Return DllCall("sdl2.dll\SDL_RenderDrawPoints", "Ptr", renderer, "Ptr", buf, "Int", count)
    }
    
    Static RenderDrawRect(renderer, rect*)
    {
        if rect.Length == 1
            rect := rect[1]
        
        x := rect[1]
        y := rect[2]
        w := rect[3]
        h := rect[4]
        buf := Buffer(16, 0)
        NumPut("Int", x, "Int", y, "Int", w, "Int", h, buf)
        
        Ret := DllCall("sdl2.dll\SDL_RenderDrawRect", "Ptr", renderer, "Ptr", buf)
        rect[1] := NumGet(buf, 0, "Int")
        rect[2] := NumGet(buf, 4, "Int")
        rect[3] := NumGet(buf, 8, "Int")
        rect[4] := NumGet(buf, 12, "Int")
        
        Return Ret
    }
    
    Static RenderDrawRects(renderer, rects, count)
    {
        buf := Buffer(16 * count, 0)
        args := []
        
        For i in rects
            args.Push("Int", i[1], "Int", i[2], "Int", i[3], "Int", i[4])
        
        args.Push(buf)
        NumPut(args*)
        
        Return DllCall("sdl2.dll\SDL_RenderDrawRects", "Ptr", renderer, "Ptr", buf, "Int", count)
    }
    
    Static RenderFillRect(renderer, rect*)
    {
        if rect.Length == 1
            rect := rect[1]
        
        x := rect[1]
        y := rect[2]
        w := rect[3]
        h := rect[4]
        buf := Buffer(16, 0)
        NumPut("Int", x, "Int", y, "Int", w, "Int", h, buf)
        
        Ret := DllCall("sdl2.dll\SDL_RenderFillRect", "Ptr", renderer, "Ptr", buf)
        rect[1] := NumGet(buf, 0, "Int")
        rect[2] := NumGet(buf, 4, "Int")
        rect[3] := NumGet(buf, 8, "Int")
        rect[4] := NumGet(buf, 12, "Int")
        
        Return Ret
    }
    
    Static RenderFillRects(renderer, rects, count)
    {
        buf := Buffer(16 * count, 0)
        args := []
        
        For i in rects
            args.Push("Int", i[1], "Int", i[2], "Int", i[3], "Int", i[4])
        
        args.Push(buf)
        NumPut(args*)
        
        Return DllCall("sdl2.dll\SDL_RenderFillRects", "Ptr", renderer, "Ptr", buf, "Int", count)
    }
    
    Static RWFromConstMem(mem, size)
    {
        Return DllCall("sdl2.dll\SDL_RWFromConstMem", "Ptr", mem, "Int", size)
    }
    
    Static RenderClear(renderer)
    {
        Return DllCall("sdl2.dll\SDL_RenderClear", "Ptr", renderer)
    }
    
    Static RenderCopy(renderer, texture, srcrect := 0, dstrect := 0)
    {
        buf := 0
        buf2 := 0
        
        if srcrect
        {
            buf := Buffer(16, 0)
            args := []
            
            For i in srcrect
                args.Push("Int", i)
            
            args.Push(buf)
            NumPut(args*)
        }
        
        if dstrect
        {
            buf2 := Buffer(16, 0)
            args := []
            
            For i in dstrect
                args.Push("Int", i)
            
            args.Push(buf2)
            NumPut(args*)
        }
        
        Ret := DllCall("sdl2.dll\SDL_RenderCopy", "Ptr", renderer, "Ptr", texture, "Ptr", buf, "Ptr", buf2)
        
        if srcrect
        {
            srcrect[1] := NumGet(buf, 0, "Int")
            srcrect[2] := NumGet(buf, 4, "Int")
            srcrect[3] := NumGet(buf, 8, "Int")
            srcrect[4] := NumGet(buf, 12, "Int")
        }
        
        if dstrect
        {
            dstrect[1] := NumGet(buf2, 0, "Int")
            dstrect[2] := NumGet(buf2, 4, "Int")
            dstrect[3] := NumGet(buf2, 8, "Int")
            dstrect[4] := NumGet(buf2, 12, "Int")
        }
        
        Return Ret
    }
    
    Static RenderCopyEx(renderer, texture, srcrect := 0, dstrect := 0, angle := 0.0, center := 0, flip := 0)
    {
        buf := 0
        buf2 := 0
        
        if srcrect
        {
            buf := Buffer(16, 0)
            args := []
            
            For i in srcrect
                args.Push("Int", i)
            
            args.Push(buf)
            NumPut(args*)
        }
        
        if dstrect
        {
            buf2 := Buffer(16, 0)
            args := []
            
            For i in dstrect
                args.Push("Int", i)
            
            args.Push(buf2)
            NumPut(args*)
        }
        
        Ret := DllCall("sdl2.dll\SDL_RenderCopyEx", "Ptr", renderer, "Ptr", texture, "Ptr", buf, "Ptr", buf2, "Double", angle, "Ptr", center, "Int", flip)
        
        if srcrect
        {
            srcrect[1] := NumGet(buf, 0, "Int")
            srcrect[2] := NumGet(buf, 4, "Int")
            srcrect[3] := NumGet(buf, 8, "Int")
            srcrect[4] := NumGet(buf, 12, "Int")
        }
        
        if dstrect
        {
            dstrect[1] := NumGet(buf2, 0, "Int")
            dstrect[2] := NumGet(buf2, 4, "Int")
            dstrect[3] := NumGet(buf2, 8, "Int")
            dstrect[4] := NumGet(buf2, 12, "Int")
        }
        
        Return Ret
    }
    
    Static RenderPresent(renderer)
    {
        Return DllCall("sdl2.dll\SDL_RenderPresent", "Ptr", renderer)
    }
    
    Static RenderSetViewport(renderer, rect)
    {
        buf := 0
        
        if rect
        {
            buf := Buffer(16, 0)
            args := []
            
            For i in rect
                args.Push("Int", i)
            
            args.Push(buf)
            NumPut(args*)
        }
        
        Ret := DllCall("sdl2.dll\SDL_RenderSetViewport", "Ptr", renderer, "Ptr", buf)
        
        if rect
        {
            rect[1] := NumGet(buf, 0, "Int")
            rect[2] := NumGet(buf, 4, "Int")
            rect[3] := NumGet(buf, 8, "Int")
            rect[4] := NumGet(buf, 12, "Int")
        }
        
        Return Ret
    }
    
    Static SetColorKey(surface, flag, key)
    {
        Return DllCall("sdl2.dll\SDL_SetColorKey", "Ptr", surface, "Int", flag, "UInt", key)
    }
    
    Static SetHint(name, value)
    {
        Return DllCall("sdl2.dll\SDL_SetHint", "AStr", name, "AStr", value)
    }
    
    Static SetHintWithPriority(name, value, priority)
    {
        Return DllCall("sdl2.dll\SDL_SetHintWithPriority", "AStr", name, "AStr", value, "Int", priority)
    }
    
    Static SetRenderDrawColor(renderer, r, g, b, a)
    {
        Return DllCall("sdl2.dll\SDL_SetRenderDrawColor", "Ptr", renderer, "UChar", r, "UChar", g, "UChar", b, "UChar", a)
    }
    
    Static SetTextureAlphaMod(texture, alpha)
    {
        Return DllCall("sdl2.dll\SDL_SetTextureAlphaMod", "Ptr", texture, "UChar", alpha)
    }
    
    Static SetTextureBlendMode(texture, blendMode)
    {
        Return DllCall("sdl2.dll\SDL_SetTextureBlendMode", "Ptr", texture, "Int", blendMode)
    }
    
    Static SetTextureColorMod(texture, r, g, b)
    {
        Return DllCall("sdl2.dll\SDL_SetTextureColorMod", "Ptr", texture, "UChar", r, "UChar", g, "UChar", b)
    }
    
    Static ShowCursor(toggle)
    {
        Return DllCall("sdl2.dll\SDL_ShowCursor", "Int", toggle)
    }
    
    Static StartTextInput()
    {
        Return DllCall("sdl2.dll\SDL_StartTextInput")
    }
    
    Static StopTextInput()
    {
        Return DllCall("sdl2.dll\SDL_StopTextInput")
    }
    
    Static ToSDL2EventStruct(struct)
    {
        buf := struct.buf
        
        struct.type := NumGet(buf, 0, "UInt")
        
        struct.common.type := NumGet(buf, 0, "UInt")
        struct.common.timestamp := NumGet(buf, 4, "UInt")
        
        struct.window.type := NumGet(buf, 0, "UInt")
        struct.window.timestamp := NumGet(buf, 4, "UInt")
        struct.window.windowID := NumGet(buf, 8, "UInt")
        struct.window.event := NumGet(buf, 12, "UChar")
        struct.window.padding1 := NumGet(buf, 13, "UChar")
        struct.window.padding2 := NumGet(buf, 14, "UChar")
        struct.window.padding3 := NumGet(buf, 15, "UChar")
        struct.window.data1 := NumGet(buf, 16, "Int")
        struct.window.data2 := NumGet(buf, 20, "Int")
        
        struct.key := struct.keyboard
        struct.keyboard.type := NumGet(buf, 0, "UInt")
        struct.keyboard.timestamp := NumGet(buf, 4, "UInt")
        struct.keyboard.windowID := NumGet(buf, 8, "UInt")
        struct.keyboard.state := NumGet(buf, 12, "UChar")
        struct.keyboard.repeat := NumGet(buf, 13, "UChar")
        struct.keyboard.padding2 := NumGet(buf, 14, "UChar")
        struct.keyboard.padding3 := NumGet(buf, 15, "UChar")
        struct.keyboard.keysym.scancode := NumGet(buf, 16, "Int")
        struct.keyboard.keysym.sym := NumGet(buf, 20, "Int")
        struct.keyboard.keysym.mod := NumGet(buf, 24, "UShort")
        struct.keyboard.keysym.unused := NumGet(buf, 26, "UInt")
        
        struct.edit := struct.textediting
        struct.textediting.type := NumGet(buf, 0, "UInt")
        struct.textediting.timestamp := NumGet(buf, 4, "UInt")
        struct.textediting.windowID := NumGet(buf, 8, "UInt")
        struct.textediting.textptr := NumGet(buf, 12, "Ptr")
        
        ;if struct.textediting.type == SDL.SDL_TEXTEDITING
            ;StrGet(struct.textediting.textptr, 200, "UTF-8")
        
        struct.textediting.start := NumGet(buf, 20, "Int")
        struct.textediting.length := NumGet(buf, 24, "Int")
        
        struct.textinput.type := NumGet(buf, 0, "UInt")
        struct.textinput.timestamp := NumGet(buf, 4, "UInt")
        struct.textinput.windowID := NumGet(buf, 8, "UInt")
        struct.textinput.textptr := NumGet(buf, 12, "Ptr")
        
        ;if struct.textinput.type == SDL.SDL_TEXTINPUT
            ;StrGet(struct.textinput.textptr, 200, "UTF-8")
        
        struct.mousemotion.type := NumGet(buf, 0, "UInt")
        struct.mousemotion.timestamp := NumGet(buf, 4, "UInt")
        struct.mousemotion.windowID := NumGet(buf, 8, "UInt")
        struct.mousemotion.which := NumGet(buf, 12, "UInt")
        struct.mousemotion.state := NumGet(buf, 16, "UInt")
        struct.mousemotion.x := NumGet(buf, 20, "Int")
        struct.mousemotion.y := NumGet(buf, 24, "Int")
        struct.mousemotion.xrel := NumGet(buf, 28, "Int")
        struct.mousemotion.yrel := NumGet(buf, 32, "Int")
        
        struct.button := struct.mousebutton
        struct.mousebutton.type := NumGet(buf, 0, "UInt")
        struct.mousebutton.timestamp := NumGet(buf, 4, "UInt")
        struct.mousebutton.windowID := NumGet(buf, 8, "UInt")
        struct.mousebutton.which := NumGet(buf, 12, "UInt")
        struct.mousebutton.button := NumGet(buf, 16, "UChar")
        struct.mousebutton.state := NumGet(buf, 17, "UChar")
        struct.mousebutton.padding1 := NumGet(buf, 18, "UChar")
        struct.mousebutton.padding2 := NumGet(buf, 19, "UChar")
        struct.mousebutton.x := NumGet(buf, 20, "Int")
        struct.mousebutton.y := NumGet(buf, 24, "Int")
        
        struct.mousewheel.type := NumGet(buf, 0, "UInt")
        struct.mousewheel.timestamp := NumGet(buf, 4, "UInt")
        struct.mousewheel.windowID := NumGet(buf, 8, "UInt")
        struct.mousewheel.which := NumGet(buf, 12, "UInt")
        struct.mousewheel.x := NumGet(buf, 16, "Int")
        struct.mousewheel.y := NumGet(buf, 20, "Int")
        
        struct.joyaxis.type := NumGet(buf, 0, "UInt")
        struct.joyaxis.timestamp := NumGet(buf, 4, "UInt")
        struct.joyaxis.which := NumGet(buf, 8, "Int")
        struct.joyaxis.axis := NumGet(buf, 12, "UChar")
        struct.joyaxis.padding1 := NumGet(buf, 13, "UChar")
        struct.joyaxis.padding2 := NumGet(buf, 14, "UChar")
        struct.joyaxis.padding3 := NumGet(buf, 15, "UChar")
        struct.joyaxis.value := NumGet(buf, 16, "Int")
        struct.joyaxis.padding4 := NumGet(buf, 20, "UInt")
        
        struct.joyball.type := NumGet(buf, 0, "UInt")
        struct.joyball.timestamp := NumGet(buf, 4, "UInt")
        struct.joyball.which := NumGet(buf, 8, "Int")
        struct.joyball.ball := NumGet(buf, 12, "UChar")
        struct.joyball.padding1 := NumGet(buf, 13, "UChar")
        struct.joyball.padding2 := NumGet(buf, 14, "UChar")
        struct.joyball.padding3 := NumGet(buf, 15, "UChar")
        struct.joyball.xrel := NumGet(buf, 16, "Int")
        struct.joyball.yrel := NumGet(buf, 20, "Int")
        
        struct.joyhat.type := NumGet(buf, 0, "UInt")
        struct.joyhat.timestamp := NumGet(buf, 4, "UInt")
        struct.joyhat.which := NumGet(buf, 8, "Int")
        struct.joyhat.hat := NumGet(buf, 12, "UChar")
        struct.joyhat.value := NumGet(buf, 13, "UChar")
        struct.joyhat.padding1 := NumGet(buf, 14, "UChar")
        struct.joyhat.padding2 := NumGet(buf, 15, "UChar")
        
        struct.joybutton.type := NumGet(buf, 0, "UInt")
        struct.joybutton.timestamp := NumGet(buf, 4, "UInt")
        struct.joybutton.which := NumGet(buf, 8, "Int")
        struct.joybutton.button := NumGet(buf, 12, "UChar")
        struct.joybutton.state := NumGet(buf, 13, "UChar")
        struct.joybutton.padding1 := NumGet(buf, 14, "UChar")
        struct.joybutton.padding2 := NumGet(buf, 15, "UChar")
        
        struct.joydevice.type := NumGet(buf, 0, "UInt")
        struct.joydevice.timestamp := NumGet(buf, 4, "UInt")
        struct.joydevice.which := NumGet(buf, 8, "Int")
        
        struct.controlleraxis.type := NumGet(buf, 0, "UInt")
        struct.controlleraxis.timestamp := NumGet(buf, 4, "UInt")
        struct.controlleraxis.which := NumGet(buf, 8, "Int")
        struct.controlleraxis.axis := NumGet(buf, 12, "UChar")
        struct.controlleraxis.padding1 := NumGet(buf, 13, "UChar")
        struct.controlleraxis.padding2 := NumGet(buf, 14, "UChar")
        struct.controlleraxis.padding3 := NumGet(buf, 15, "UChar")
        struct.controlleraxis.value := NumGet(buf, 16, "Int")
        struct.controlleraxis.padding4 := NumGet(buf, 20, "UInt")
        
        struct.controllerbutton.type := NumGet(buf, 0, "UInt")
        struct.controllerbutton.timestamp := NumGet(buf, 4, "UInt")
        struct.controllerbutton.which := NumGet(buf, 8, "Int")
        struct.controllerbutton.button := NumGet(buf, 12, "UChar")
        struct.controllerbutton.state := NumGet(buf, 13, "UChar")
        struct.controllerbutton.padding1 := NumGet(buf, 14, "UChar")
        struct.controllerbutton.padding2 := NumGet(buf, 15, "UChar")
        
        struct.controllerdevice.type := NumGet(buf, 0, "UInt")
        struct.controllerdevice.timestamp := NumGet(buf, 4, "UInt")
        struct.controllerdevice.which := NumGet(buf, 8, "Int")
        
        struct.touchfinger.type := NumGet(buf, 0, "UInt")
        struct.touchfinger.timestamp := NumGet(buf, 4, "UInt")
        struct.touchfinger.touchId := NumGet(buf, 8, "Int64")
        struct.touchfinger.fingerId := NumGet(buf, 16, "Int64")
        struct.touchfinger.x := NumGet(buf, 24, "Float")
        struct.touchfinger.y := NumGet(buf, 28, "Float")
        struct.touchfinger.dx := NumGet(buf, 32, "Float")
        struct.touchfinger.dy := NumGet(buf, 36, "Float")
        struct.touchfinger.pressure := NumGet(buf, 40, "Float")
        
        struct.multigesture.type := NumGet(buf, 0, "UInt")
        struct.multigesture.timestamp := NumGet(buf, 4, "UInt")
        struct.multigesture.touchId := NumGet(buf, 8, "Int64")
        struct.multigesture.dTheta := NumGet(buf, 16, "Float")
        struct.multigesture.dDist := NumGet(buf, 20, "Float")
        struct.multigesture.x := NumGet(buf, 24, "Float")
        struct.multigesture.y := NumGet(buf, 28, "Float")
        struct.multigesture.numFingers := NumGet(buf, 32, "UShort")
        struct.multigesture.padding := NumGet(buf, 34, "UShort")
        
        struct.dollargesture.type := NumGet(buf, 0, "UInt")
        struct.dollargesture.timestamp := NumGet(buf, 4, "UInt")
        struct.dollargesture.touchId := NumGet(buf, 8, "Int64")
        struct.dollargesture.gestureId := NumGet(buf, 16, "Int64")
        struct.dollargesture.numFingers := NumGet(buf, 24, "UInt")
        struct.dollargesture.error := NumGet(buf, 28, "Float")
        struct.dollargesture.x := NumGet(buf, 32, "Float")
        struct.dollargesture.y := NumGet(buf, 36, "Float")
        
        struct.drop.type := NumGet(buf, 0, "UInt")
        struct.drop.timestamp := NumGet(buf, 4, "UInt")
        struct.drop.fileptr := NumGet(buf, 8, "Ptr")
        
        if struct.drop.type == SDL.SDL_DROPFILE
            struct.drop.file := StrGet(struct.drop.fileptr, 200, "UTF-8")
        
        struct.quit.type := NumGet(buf, 0, "UInt")
        struct.quit.timestamp := NumGet(buf, 4, "UInt")
        
        struct.os.type := NumGet(buf, 0, "UInt")
        struct.os.timestamp := NumGet(buf, 4, "UInt")
        
        struct.user.type := NumGet(buf, 0, "UInt")
        struct.user.timestamp := NumGet(buf, 4, "UInt")
        struct.user.windowID := NumGet(buf, 8, "UInt")
        struct.user.code := NumGet(buf, 12, "Int")
        
        struct.syswm.type := NumGet(buf, 0, "UInt")
        struct.syswm.timestamp := NumGet(buf, 4, "UInt")
    }
    
    Static ToSDL2SurfaceStruct(surface)
    {
        surface.flags := NumGet(surface.ptr, 0, "UInt")
        surface.format.ptr := NumGet(surface.ptr, 8, "Ptr")
        surface.w := NumGet(surface.ptr, 16, "Int")
        surface.h := NumGet(surface.ptr, 20, "Int")
        surface.pitch := NumGet(surface.ptr, 24, "Int")
        surface.userdata.ptr := NumGet(surface.ptr, 28, "Ptr")
        surface.locked := NumGet(surface.ptr, 32, "Int")
        surface.lock_data.ptr := NumGet(surface.ptr, 36, "Ptr")
        surface.clip_rect.x := NumGet(surface.ptr, 44, "Int")
        surface.clip_rect.y := NumGet(surface.ptr, 48, "Int")
        surface.clip_rect.w := NumGet(surface.ptr, 52, "Int")
        surface.clip_rect.h := NumGet(surface.ptr, 56, "Int")
        surface.map := NumGet(surface.ptr, 60, "Ptr")
        surface.refcount := NumGet(surface.ptr, 68, "Int")
        
        Return surface
    }
    
    Static UpdateWindowSurface(window)
    {
        Return DllCall("sdl2.dll\SDL_UpdateWindowSurface", "Ptr", window)
    }
}
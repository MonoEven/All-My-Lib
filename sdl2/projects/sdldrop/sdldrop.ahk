; Author: Mono
; Version: v1.0.0
; Time: 2022.09.17

#Include <sdl2\sdl2>

; Texture wrapper class
Class LTexture
{
	; Initializes variables
	__New(window, font := NULL)
    {
        ; Initialize
        ; The actual hardware texture
        this.mTexture := NULL
        ; Image dimensions
        this.window := window
        this.mWidth := 0
        this.mHeight := 0
        this.mRenderer := SDL2.CreateRenderer(this.window, -1, SDL.SDL_RENDERER_ACCELERATED | SDL.SDL_RENDERER_PRESENTVSYNC)
        this.mFont := (font == NULL) ? SDL2.TTF.OpenFont("lazy.ttf", 28) : font
        this.newTexture := NULL
        this.loadedSurface := NULL
        this.textSurface := NULL
    }
    
    reload()
    {
        this.free()
        ; Initialize
        ; The actual hardware texture
        this.mTexture := NULL
        ; Image dimensions
        this.mWidth := 0
        this.mHeight := 0
        this.mRenderer := SDL2.CreateRenderer(this.window, -1, SDL.SDL_RENDERER_ACCELERATED | SDL.SDL_RENDERER_PRESENTVSYNC)
        this.newTexture := NULL
        this.loadedSurface := NULL
        this.textSurface := NULL
    }

	; Deallocates memory
	__Delete()
    {
        this.free()
    }

	; Loads image at specified path
	loadFromFile(path)
    {
        ; Get rid of preexisting texture
        this.free()

        ; The final texture
        if this.newTexture
        {
            SDL2.DestroyTexture(this.newTexture)
            this.newTexture := NULL
        }

        ; Load image at specified path
        if this.loadedSurface
        {
            SDL2.FreeSurface(this.loadedSurface)
            this.loadedSurface := NULL
        }
        
        this.loadedSurface := SDL2.IMG.Load(path)
        
        if (this.loadedSurface == NULL)
        {
            MsgBox SDL2.Log("Unable to load image %s! SDL_image Error: %s`n", path, SDL2.IMG.GetError())
        }
        
        else
        {
            ; Color key image
            SDL2.SetColorKey(this.loadedSurface, SDL.SDL_TRUE, SDL2.MapRGB(this.loadedSurface.format, 0, 0xFF, 0xFF))

            ; Create texture from surface pixels
            this.newTexture := SDL2.CreateTextureFromSurface(this.mRenderer, this.loadedSurface)
            
            if (this.newTexture == NULL)
            {
                MsgBox SDL2.Log("Unable to create texture from %s! SDL Error: %s`n", path, SDL2.GetError())
            }
            
            else
            {
                ; Get image dimensions
                this.mWidth := this.loadedSurface.w
                this.mHeight := this.loadedSurface.h
            }
        }

        ; Return success
        if this.mTexture
        {
            SDL2.DestroyTexture(this.mTexture)
            this.mTexture := NULL
        }
        
        this.mTexture := this.newTexture
        
        return this.mTexture != NULL
    }
    
    loadFromRenderedText(textureText, textColor)
    {
        ; Get rid of preexisting texture
        this.free()

        ; Render text surface
        if this.textSurface
        {
            SDL2.FreeSurface(this.textSurface)
            this.textSurface := NULL
        }
        
        this.textSurface := SDL2.TTF.RenderText_Solid(this.mFont, textureText, textColor)
        
        if (this.textSurface == NULL)
        {
            MsgBox SDL2.Log("Unable to render text surface! SDL_ttf Error: %s`n", SDL2.TTF.GetError())
        }
        
        else
        {
            ; Create texture from surface pixels
            if this.mTexture
            {
                SDL2.DestroyTexture(this.mTexture)
                this.mTexture := NULL
            }
            
            this.mTexture := SDL2.CreateTextureFromSurface(this.mRenderer, this.textSurface)
            
            if (this.mTexture == NULL)
            {
                MsgBox SDL2.Log("Unable to create texture from rendered text! SDL Error: %s`n", SDL2.GetError())
            }
            
            else
            {
                ; Get image dimensions
                this.mWidth := this.textSurface.w
                this.mHeight := this.textSurface.h
            }
        }
        
        ; Return success
        return this.mTexture != NULL
    }

	; Deallocates texture
	free()
    {
        ; Free texture if it exists
        if (this.mTexture != NULL)
        {
            ; Free global font
            SDL2.TTF.CloseFont(this.mFont)
            this.mFont := NULL
            
            ; Destroy window	
            SDL2.DestroyRenderer(this.mRenderer)
            this.mRenderer := NULL
            
            SDL2.DestroyTexture(this.mTexture)
            this.mTexture := NULL
        }
        
        if (this.newTexture != NULL)
        {
            SDL2.DestroyTexture(this.newTexture)
            this.newTexture := NULL
        }
        
        if (this.loadedSurface != NULL)
        {
            SDL2.FreeSurface(this.loadedSurface)
            this.loadedSurface := NULL
        }
        
        if (this.textSurface != NULL)
        {
            SDL2.FreeSurface(this.textSurface)
            this.textSurface := NULL
        }
        
        this.mWidth := 0
        this.mHeight := 0
    }
    
    setColor(red, green, blue)
    {
        ; Modulate texture
        SDL2.SetTextureColorMod(this.mTexture, red, green, blue)
    }
    
    setBlendMode(blending)
    {
        ; Set blending function
        SDL2.SetTextureBlendMode(this.mTexture, blending)
    }
    
    setAlpha(alpha)
    {
        ; Modulate texture alpha
        SDL2.SetTextureAlphaMod(this.mTexture, alpha)
    }

    ; Renders texture at given point
    render(x, y, clip := NULL, angle := 0.0, center := NULL, flip := SDL.SDL_FLIP_NONE)
    {
        ; Set rendering space and render to screen
        renderQuad := [x, y, this.mWidth, this.mHeight]

        ; Set clip rendering dimensions
        if (clip != NULL)
        {
            renderQuad[3] := clip[3]
            renderQuad[4] := clip[4]
        }

        ; Render to screen
        SDL2.RenderCopyEx(this.mRenderer, this.mTexture, clip, renderQuad, angle, center, flip)
    }

    ; Gets image dimensions
    getWidth()
    {
        return this.mWidth
    }
    
    getHeight()
    {
        return this.mHeight
    }
}

Class SDLDrop
{
    __New(Name, WinSize, Pos := -1, InitIMG := 0)
    {
        SDL2.Init(SDL.SDL_INIT_VIDEO) ; 初始化SDL
        this.window := SDL2.CreateWindow(Name, SDL.SDL_WINDOWPOS_UNDEFINED, SDL.SDL_WINDOWPOS_UNDEFINED, WinSize[1], WinSize[2], SDL.SDL_WINDOW_SHOWN) ; 创建窗体
        this.surface := SDL2.GetWindowSurface(this.window) ; 得到窗体的SDL_Surface
        this.image := LTexture(this.window)
        
        if InitIMG
            this.image.loadFromFile(InitIMG) ; 加载png图片
        
        if Pos == -1
            this.Pos := [0, 0, WinSize[1], WinSize[2]]
    }
    
    DropEvent(Msg := false)
    {
        while (SDL2.PollEvent(&event := 0)) ; 对当前待处理事件进行轮询
        {
            this.event := event
            
            if (this.event.type == SDL.SDL_QUIT) ; 退出事件
            {
                QuitTar := true
            }
            
            else if(this.event.type == SDL.SDL_DROPFILE) ; 文件拖动事件
            {
                if Msg
                    MsgBox this.event.drop.file
                
                if FileDev(this.event.drop.file) == "Image"
                {
                    this.image.reload()
                    this.image.loadFromFile(this.event.drop.file)
                }
                
                else
                    MsgBox("this format of file isn't supported now.", , 48)
            }
        }
        
        ; Clear screen
        SDL2.SetRenderDrawColor(this.image.mRenderer, 0xFF, 0xFF, 0xFF, 0xFF)
        SDL2.RenderClear(this.image.mRenderer)
        this.image.render(0, 0)
        
        ; Update screen
        SDL2.RenderPresent(this.image.mRenderer)
        SDL2.Delay(100)
    }
    
    LoopEvent(Function, QSign := "Escape", args*)
    {
        Toggle := True
        QuitSign := "SDLK_" QSign
        
        While Toggle
        {
            Function(args*)
            
            if this.event.key.keysym.sym == SDL.%QuitSign%
                Toggle := False
            
            else if this.event.type == SDL.SDL_QUIT
                Toggle := False
        }
        
        Return 1
    }
    
    Quit()
    {
        this.image.free()
        SDL2.DestroyWindow(this.window) ; 销毁窗体
        this.window := NULL
        SDL2.TTF.Quit()
        SDL2.IMG.Quit()
        SDL2.Quit() ; 退出SDL
    }
}

FileDev(filename)
{
    ext := StrSplit(filename, ".")[-1]
    
    if ext = "jpg" || ext = "png" || ext = "bmp" || ext = "jpeg" || ext = "pnm" || ext = "ppm" || ext = "pgm" || ext = "pbm" || ext = "xpm" || ext = "lbm" || ext = "pcx" || ext = "gif" || ext = "tga" || ext = "tiff" || ext = "svg" || ext = "webp"
        Return "Image"
}

a := SDLDrop("SDL test", [640, 480], , "loaded.png")
a.LoopEvent(a.DropEvent, , a)
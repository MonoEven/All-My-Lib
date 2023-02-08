; Author: Mono
; Version: v1.0.0
; Time: 2022.09.15
; One way to render text with SDL is with the extension library SDL_ttf. SDL_ttf allows you to create images from TrueType fonts which we'll use here to create textures from font text.

; Using SDL2
#Include <sdl2\sdl2>

; Screen dimension constants
SCREEN_WIDTH := 640
SCREEN_HEIGHT := 480

; Texture wrapper class
class LTexture
{
	; Initializes variables
	__New()
    {
        ; Initialize
        ; The actual hardware texture
        this.mTexture := NULL
        ; Image dimensions
        this.mWidth := 0
        this.mHeight := 0
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
        newTexture := NULL

        ; Load image at specified path
        loadedSurface := SDL2.IMG.Load(path)
        if (loadedSurface == NULL)
        {
            MsgBox SDL2.Log("Unable to load image %s! SDL_image Error: %s`n", path, SDL2.IMG.GetError())
        }
        else
        {
            ; Color key image
            SDL2.SetColorKey(loadedSurface, SDL.SDL_TRUE, SDL2.MapRGB(loadedSurface.format, 0, 0xFF, 0xFF))

            ; Create texture from surface pixels
            newTexture := SDL2.CreateTextureFromSurface(gRenderer, loadedSurface)
            if (newTexture == NULL)
            {
                MsgBox SDL2.Log("Unable to create texture from %s! SDL Error: %s`n", path, SDL2.GetError())
            }
            else
            {
                ; Get image dimensions
                this.mWidth := loadedSurface.w
                this.mHeight := loadedSurface.h
            }

            ; Get rid of old loaded surface
            SDL2.FreeSurface(loadedSurface)
        }

        ; Return success
        this.mTexture := newTexture
        return this.mTexture != NULL
    }
    
    loadFromRenderedText(textureText, textColor)
    {
        ; Get rid of preexisting texture
        this.free()

        ; Render text surface
        textSurface := SDL2.TTF.RenderText_Solid(gFont, textureText, textColor)
        if (textSurface == NULL)
        {
            MsgBox SDL2.Log("Unable to render text surface! SDL_ttf Error: %s`n", SDL2.TTF.GetError())
        }
        else
        {
            ; Create texture from surface pixels
            this.mTexture := SDL2.CreateTextureFromSurface(gRenderer, textSurface)
            if (this.mTexture == NULL)
            {
                MsgBox SDL2.Log("Unable to create texture from rendered text! SDL Error: %s`n", SDL2.GetError())
            }
            else
            {
                ; Get image dimensions
                this.mWidth := textSurface.w
                this.mHeight := textSurface.h
            }

            ; Get rid of old surface
            SDL2.FreeSurface(textSurface)
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
            SDL2.DestroyTexture(this.mTexture)
            this.mTexture := NULL
            this.mWidth := 0
            this.mHeight := 0
        }
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
        SDL2.RenderCopyEx(gRenderer, this.mTexture, clip, renderQuad, angle, center, flip)
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

; Main Program
; The window we'll be rendering to
gWindow := NULL

; The window renderer
gRenderer := NULL

; Globally used font
gFont := NULL

; Rendered texture
gTextTexture := LTexture()

init()
{
    Global
	; Initialization flag
	success := true

	; Initialize SDL
	if (SDL2.Init(SDL.SDL_INIT_VIDEO) < 0)
	{
		MsgBox SDL2.Log("SDL could not initialize! SDL_Error: %s`n", SDL2.GetError())
		success := false
	}
	else
	{
		; Set texture filtering to linear
		if (!SDL2.SetHint(SDL.SDL_HINT_RENDER_SCALE_QUALITY, "1"))
		{
			MsgBox SDL2.Log("Warning: Linear texture filtering not enabled!")
		}

		; Create window
		gWindow := SDL2.CreateWindow("SDL Tutorial", SDL.SDL_WINDOWPOS_UNDEFINED, SDL.SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL.SDL_WINDOW_SHOWN)
		if (gWindow == NULL)
		{
            MsgBox SDL2.Log("Window could not be created! SDL Error: %s`n", SDL2.GetError())
			success := false
		}
		else
		{
			; Create vsynced renderer for window
			gRenderer := SDL2.CreateRenderer(gWindow, -1, SDL.SDL_RENDERER_ACCELERATED | SDL.SDL_RENDERER_PRESENTVSYNC)
			if (gRenderer == NULL)
			{
				MsgBox SDL2.Log("Renderer could not be created! SDL Error: %s`n", SDL2.GetError())
				success := false
			}
			else
			{
				; Initialize renderer color
				SDL2.SetRenderDrawColor(gRenderer, 0xFF, 0xFF, 0xFF, 0xFF)

				; Initialize PNG loading
				imgFlags := SDL.IMG_INIT_PNG
				if (!(SDL2.IMG.Init(imgFlags) & imgFlags))
				{
					MsgBox SDL2.Log("SDL_image could not initialize! SDL_image Error: %s`n", SDL2.IMG.GetError())
					success := false
				}

				; Initialize SDL_ttf
				if (SDL2.TTF.Init() == -1 )
				{
					MsgBox SDL2.Log("SDL_ttf could not initialize! SDL_ttf Error: %s`n", SDL2.TTF.GetError())
					success := false
				}
			}
		}
	}

	return success
}

loadMedia()
{
    Global
	; Loading success flag
	success := true

	; Open the font
	gFont := SDL2.TTF.OpenFont("TTF\lazy.ttf", 28)
	if (gFont == NULL)
	{
		MsgBox SDL2.Log("Failed to load lazy font! SDL_ttf Error: %s`n", SDL2.TTF.GetError())
		success := false
	}
	else
	{
		; Render text
		textColor := [0, 0, 0]
		if (!gTextTexture.loadFromRenderedText("The quick brown fox jumps over the lazy dog", textColor))
		{
			MsgBox SDL2.Log("Failed to render text texture!`n")
			success := false
		}
	}
    
	return success
}

close()
{
    Global
	; Free loaded images
	gTextTexture.free()

	; Free global font
	SDL2.TTF.CloseFont(gFont)
	gFont := NULL

	; Destroy window	
	SDL2.DestroyRenderer(gRenderer)
	SDL2.DestroyWindow(gWindow)
	gWindow := NULL
	gRenderer := NULL

	; Quit SDL subsystems
	SDL2.TTF.Quit()
	SDL2.IMG.Quit()
	SDL2.Quit()
}

; Start up SDL and create window
if (!init())
{
    MsgBox SDL2.Log("Failed to initialize!`n")
}
else
{
    ; Load media
    if (!loadMedia())
    {
        MsgBox SDL2.Log("Failed to load media!`n")
    }
    else
    {
        ; Main loop flag
		quit := false
        
        ; Event handler
		e := SDL2.Event()
        
        ; While application is running
        while (!quit)
        {
            ; Handle events on queue
            while (SDL2.PollEvent(&e) != 0)
            {
                ; User requests quit
                if (e.type == SDL.SDL_QUIT)
                {
                    quit := true
                }
            }
                
            ; Clear screen
            SDL2.SetRenderDrawColor(gRenderer, 0xFF, 0xFF, 0xFF, 0xFF)
            SDL2.RenderClear(gRenderer)

            ; Render current frame
            gTextTexture.render((SCREEN_WIDTH - gTextTexture.getWidth()) // 2, (SCREEN_HEIGHT - gTextTexture.getHeight()) // 2)

            ; Update screen
            SDL2.RenderPresent(gRenderer)
        }
    }
}

; Free resources and close SDL
close()
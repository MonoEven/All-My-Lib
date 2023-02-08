; Author: Mono
; Version: v1.0.0
; Time: 2022.09.16
; Now that we've made a basic timer with SDL, it's time to make one that can start/stop/pause.

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

; The application time based timer
class LTimer
{
    ; Initializes variables
    __New()
    {
        ; Initialize the variables
        this.mStartTicks := 0
        this.mPausedTicks := 0

        this.mPaused := false
        this.mStarted := false
    }

    ; The various clock actions
    start()
    {
        ; Start the timer
        this.mStarted := true

        ; Unpause the timer
        this.mPaused := false

        ; Get the current clock time
        this.mStartTicks := SDL2.GetTicks()
        this.mPausedTicks := 0
    }
    stop()
    {
        ; Stop the timer
        this.mStarted := false

        ; Unpause the timer
        this.mPaused := false

        ; Clear tick variables
        this.mStartTicks := 0
        this.mPausedTicks := 0
    }
    pause()
    {
        ; If the timer is running and isn't already paused
        if (this.mStarted && !this.mPaused)
        {
            ; Pause the timer
            this.mPaused := true

            ; Calculate the paused ticks
            this.mPausedTicks := SDL2.GetTicks() - this.mStartTicks
            this.mStartTicks := 0
        }
    }
    unpause()
    {
        ; If the timer is running and paused
        if (this.mStarted && this.mPaused)
        {
            ; Unpause the timer
            this.mPaused := false

            ; Reset the starting ticks
            this.mStartTicks := SDL2.GetTicks() - this.mPausedTicks

            ; Reset the paused ticks
            this.mPausedTicks := 0
        }
    }

    ; Gets the timer's time
    getTicks()
    {
        ; The actual timer time
        time := 0

        ; If the timer is running
        if (this.mStarted)
        {
            ; If the timer is paused
            if (this.mPaused)
            {
                ; Return the number of ticks when the timer was paused
                time := this.mPausedTicks
            }
            else
            {
                ; Return the current time minus the start time
                time := SDL2.GetTicks() - this.mStartTicks
            }
        }

        return time
    }

    ; Checks the status of the timer
    isStarted()
    {
        ; Timer is running and paused or unpaused
        return this.mStarted
    }
    isPaused()
    {
        ; Timer is running and paused
        return this.mPaused && this.mStarted
    }
}

; Main Program
; The window we'll be rendering to
gWindow := NULL

; The window renderer
gRenderer := NULL

; Globally used font
gFont := NULL

; Scene textures
gTimeTextTexture := LTexture()
gPausePromptTexture := LTexture()
gStartPromptTexture := LTexture()

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
				if (SDL2.TTF.Init() == -1)
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
		; Set text color as black
		textColor := [0, 0, 0, 255]
		
		; Load stop prompt texture
		if (!gStartPromptTexture.loadFromRenderedText("Press S to Start or Stop the Timer", textColor))
		{
			MsgBox SDL2.Log("Unable to render start/stop prompt texture!`n")
			success := false
		}
		
		; Load pause prompt texture
		if (!gPausePromptTexture.loadFromRenderedText("Press P to Pause or Unpause the Timer", textColor))
		{
			MsgBox SDL2.Log("Unable to render pause/unpause prompt texture!`n")
			success := false
		}
	}
    
	return success
}

close()
{
    Global
	; Free loaded images
	gTimeTextTexture.free()
	gStartPromptTexture.free()
	gPausePromptTexture.free()

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
        
        ; Set text color as black
        textColor := [0, 0, 0, 255]
        
        ; The application timer
        timer := LTimer()
        
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
                ; Reset start time on return keypress
                else if (e.type == SDL.SDL_KEYDOWN)
                {
                    ; Start/stop
                    if (e.key.keysym.sym == SDL.SDLK_s)
                    {
                        if (timer.isStarted())
                        {
                            timer.stop()
                        }
                        else
                        {
                            timer.start()
                        }
                    }
                    ; Pause/unpause
                    else if (e.key.keysym.sym == SDL.SDLK_p)
                    {
                        if (timer.isPaused())
                        {
                            timer.unpause()
                        }
                        else
                        {
                            timer.pause()
                        }
                    }
                }
            }

            ; Set text to be rendered
            timeText := ""
            timeText .= "Milliseconds since start time " Round(timer.getTicks() / 1000, 3)

            ; Render text
            if (!gTimeTextTexture.loadFromRenderedText(timeText, textColor))
            {
                MsgBox SDL2.Log("Unable to render time texture!`n")
            }

            ; Clear screen
            SDL2.SetRenderDrawColor(gRenderer, 0xFF, 0xFF, 0xFF, 0xFF)
            SDL2.RenderClear(gRenderer)

            ; Render textures
            gStartPromptTexture.render((SCREEN_WIDTH - gStartPromptTexture.getWidth()) // 2, 0)
            gPausePromptTexture.render((SCREEN_WIDTH - gPausePromptTexture.getWidth()) // 2, gStartPromptTexture.getHeight())
            gTimeTextTexture.render((SCREEN_WIDTH - gTimeTextTexture.getWidth()) // 2, (SCREEN_HEIGHT - gTimeTextTexture.getHeight()) // 2)

            ; Update screen
            SDL2.RenderPresent(gRenderer)
        }
    }
}

; Free resources and close SDL
close()
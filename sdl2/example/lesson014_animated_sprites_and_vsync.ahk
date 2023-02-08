; Author: Mono
; Version: v1.0.0
; Time: 2022.09.15
; Animation in a nutshell is just showing one image after another to create the illusion of motion. Here we'll be showing different sprites to animate a stick figure.

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
    render(x, y, clip := NULL)
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
        SDL2.RenderCopy(gRenderer, this.mTexture, clip, renderQuad)
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

; Walking animation
WALKING_ANIMATION_FRAMES := 4
gSpriteClips := []
gSpriteClips.Length := WALKING_ANIMATION_FRAMES
gSpriteSheetTexture := LTexture()

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

	; Load front alpha texture
	if (!gSpriteSheetTexture.loadFromFile("BMP\f00.png"))
	{
		MsgBox SDL2.Log("Failed to load front texture!`n")
		success := false
	}
	else
	{
		; Set sprite clips
		gSpriteClips[1] := [0, 0, 64, 205]
        gSpriteClips[2] := [64, 0, 64, 205]
        gSpriteClips[3] := [128, 0, 64, 205]
        gSpriteClips[4] := [192, 0, 64, 205]
	}
    
	return success
}

close()
{
    Global
	; Free loaded images
	gSpriteSheetTexture.free()

	; Destroy window	
	SDL2.DestroyRenderer(gRenderer)
	SDL2.DestroyWindow(gWindow)
	gWindow := NULL
	gRenderer := NULL

	; Quit SDL subsystems
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
        
        ; Current animation frame
		frame := 0
        
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
            currentClip := gSpriteClips[(frame // 4) + 1]
            gSpriteSheetTexture.render((SCREEN_WIDTH - currentClip[3]) // 2, (SCREEN_HEIGHT - currentClip[4]) // 2, currentClip)

            ; Update screen
            SDL2.RenderPresent(gRenderer)

            ; Go to next frame
            ++frame

            ; Cycle animation
            if ((frame // 4) >= WALKING_ANIMATION_FRAMES)
            {
                frame := 0
            }
        }
    }
}

; Free resources and close SDL
close()
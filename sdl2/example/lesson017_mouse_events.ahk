; Author: Mono
; Version: v1.0.0
; Time: 2022.09.15
; Like with key presses, SDL has event structures to handle mouse events such as mouse motion, mouse button presses, and mouse button releasing. In this tutorial we'll make a bunch of buttons we can interact with.

; Using SDL2
#Include <sdl2\sdl2>

; Screen dimension constants
SCREEN_WIDTH := 640
SCREEN_HEIGHT := 480

; Button constants
BUTTON_WIDTH := 300
BUTTON_HEIGHT := 200
TOTAL_BUTTONS := 4

; LButtonSprite
BUTTON_SPRITE_MOUSE_OUT := 1
BUTTON_SPRITE_MOUSE_OVER_MOTION := 2
BUTTON_SPRITE_MOUSE_DOWN := 3
BUTTON_SPRITE_MOUSE_UP := 4
BUTTON_SPRITE_TOTAL := 4

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
        if !IsSet(gFont)
            gFont := 0
        
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

; The mouse button
class LButton
{
	; Initializes internal variables
    __New()
    {
        this.mPosition := {}
        this.mPosition.x := 0
        this.mPosition.y := 0

        this.mCurrentSprite := BUTTON_SPRITE_MOUSE_OUT
    }

    ; Sets top left position
    setPosition(x, y)
    {
        this.mPosition.x := x
        this.mPosition.y := y
    }

    ; Handles mouse event
    handleEvent(e)
    {
        ; If mouse event happened
        if (e.type == SDL.SDL_MOUSEMOTION || e.type == SDL.SDL_MOUSEBUTTONDOWN || e.type == SDL.SDL_MOUSEBUTTONUP)
        {
            ; Get mouse position
            SDL2.GetMouseState(&x := 0, &y := 0)
            
            ; Check if mouse is in button
            inside := true

            ; Mouse is left of the button
            if (x < this.mPosition.x)
            {
                inside := false
            }
            ; Mouse is right of the button
            else if (x > this.mPosition.x + BUTTON_WIDTH)
            {
                inside := false
            }
            ; Mouse above the button
            else if (y < this.mPosition.y)
            {
                inside := false
            }
            ; Mouse below the button
            else if (y > this.mPosition.y + BUTTON_HEIGHT)
            {
                inside := false
            }

            ; Mouse is outside button
            if (!inside)
            {
                this.mCurrentSprite := BUTTON_SPRITE_MOUSE_OUT
            }
            ; Mouse is inside button
            else
            {
                ; Set mouse over sprite
                switch(e.type)
                {
                    case SDL.SDL_MOUSEMOTION:
                        this.mCurrentSprite := BUTTON_SPRITE_MOUSE_OVER_MOTION
                
                    case SDL.SDL_MOUSEBUTTONDOWN:
                        this.mCurrentSprite := BUTTON_SPRITE_MOUSE_DOWN
                    
                    case SDL.SDL_MOUSEBUTTONUP:
                        this.mCurrentSprite := BUTTON_SPRITE_MOUSE_UP
                }
            }
        }
    }

    ; Shows button sprite
    render()
    {
        ; Show current button sprite
        gButtonSpriteSheetTexture.render(this.mPosition.x, this.mPosition.y, gSpriteClips[this.mCurrentSprite])
    }
}

; Main Program
; The window we'll be rendering to
gWindow := NULL

; The window renderer
gRenderer := NULL

; Mouse button sprites
gSpriteClips := []
gSpriteClips.Length := BUTTON_SPRITE_TOTAL
gButtonSpriteSheetTexture := LTexture()

; Buttons objects
gButtons := []
gButtons.Length := TOTAL_BUTTONS

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

	; Load sprites
	if (!gButtonSpriteSheetTexture.loadFromFile("BMP\button.png"))
	{
		MsgBox SDL2.Log("Failed to load button sprite texture!`n")
		success := false
	}
	else
	{
		; Set sprites
		Loop BUTTON_SPRITE_TOTAL
		{
			gSpriteClips[A_Index] := [0, (A_Index - 1) * 200, BUTTON_WIDTH, BUTTON_HEIGHT]
		}

		; Set buttons in corners
        Loop TOTAL_BUTTONS
            gButtons[A_Index] := LButton()
		
        gButtons[1].setPosition(0, 0)
		gButtons[2].setPosition(SCREEN_WIDTH - BUTTON_WIDTH, 0)
		gButtons[3].setPosition(0, SCREEN_HEIGHT - BUTTON_HEIGHT)
		gButtons[4].setPosition(SCREEN_WIDTH - BUTTON_WIDTH, SCREEN_HEIGHT - BUTTON_HEIGHT)
	}
    
	return success
}

close()
{
    Global
	; Free loaded images
	gButtonSpriteSheetTexture.free()

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
                
                ; Handle button events
                Loop TOTAL_BUTTONS
                {
                    gButtons[A_Index].handleEvent(e)
                }
            }
                
            ; Clear screen
            SDL2.SetRenderDrawColor(gRenderer, 0xFF, 0xFF, 0xFF, 0xFF)
            SDL2.RenderClear(gRenderer)

            ; Render buttons
            Loop TOTAL_BUTTONS
            {
                gButtons[A_Index].render()
            }

            ; Update screen
            SDL2.RenderPresent(gRenderer)
        }
    }
}

; Free resources and close SDL
close()
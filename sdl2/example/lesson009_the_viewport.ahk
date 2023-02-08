; Author: Mono
; Version: v1.0.0
; Time: 2022.09.15
; Some times you only want to render part of the screen for things like minimaps. Using the viewport you can control where you render on the screen.

; Using SDL2
#Include <sdl2\sdl2>

; Screen dimension constants
SCREEN_WIDTH := 640
SCREEN_HEIGHT := 480

; Main Program
; The window we'll be rendering to
gWindow := NULL

; The window renderer
gRenderer := NULL

; Current displayed texture
gTexture := NULL

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
			; Create renderer for window
			gRenderer := SDL2.CreateRenderer(gWindow, -1, SDL.SDL_RENDERER_ACCELERATED)
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

	; Load texture
	gTexture := loadTexture("BMP/viewport.png")
	if (gTexture == NULL)
	{
		MsgBox SDL2.Log("Failed to load texture image!`n")
		success := false
	}

	; Nothing to load
	return success
}

close()
{
    Global
	; Free loaded image
	SDL2.DestroyTexture(gTexture)
	gTexture := NULL

	; Destroy window	
	SDL2.DestroyRenderer(gRenderer)
	SDL2.DestroyWindow(gWindow)
	gWindow := NULL
	gRenderer := NULL

	; Quit SDL subsystems
	SDL2.IMG.Quit()
	SDL2.Quit()
}

loadTexture(path)
{
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
		; Create texture from surface pixels
        newTexture := SDL2.CreateTextureFromSurface(gRenderer, loadedSurface)
		if (newTexture == NULL)
		{
			MsgBox SDL2.Log("Unable to create texture from %s! SDL Error: %s`n", path, SDL2.GetError())
		}

		; Get rid of old loaded surface
		SDL2.FreeSurface(loadedSurface)
	}

	return newTexture
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

            ; Top left corner viewport
            topLeftViewport := [0, 0, SCREEN_WIDTH // 2, SCREEN_HEIGHT // 2]
            SDL2.RenderSetViewport(gRenderer, topLeftViewport)
            
            ; Render texture to screen
            SDL2.RenderCopy(gRenderer, gTexture, NULL, NULL)


            ; Top right viewport
            topRightViewport := [SCREEN_WIDTH // 2, 0, SCREEN_WIDTH // 2, SCREEN_HEIGHT // 2]
            SDL2.RenderSetViewport(gRenderer, topRightViewport)
            
            ; Render texture to screen
            SDL2.RenderCopy(gRenderer, gTexture, NULL, NULL)


            ; Bottom viewport
            bottomViewport := [0, SCREEN_HEIGHT // 2, SCREEN_WIDTH, SCREEN_HEIGHT // 2]
            SDL2.RenderSetViewport(gRenderer, bottomViewport)

            
            ; Render texture to screen
            SDL2.RenderCopy(gRenderer, gTexture, NULL, NULL)


            ; Update screen
            SDL2.RenderPresent(gRenderer)
        }
    }
}

; Free resources and close SDL
close()
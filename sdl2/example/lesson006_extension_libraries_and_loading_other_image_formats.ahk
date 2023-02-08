; Author: Mono
; Version: v1.0.0
; Time: 2022.09.15
; SDL extension libraries allow you do things like load image files besides BMP, render TTF fonts, and play music. You can set up SDL_image to load PNG files, which can save you a lot of disk space. In this tutorial we'll be covering how to install SDL_image.

; Using SDL2
#Include <sdl2\sdl2>

; Screen dimension constants
SCREEN_WIDTH := 640
SCREEN_HEIGHT := 480

; Main Program
; The window we'll be rendering to
gWindow := NULL

; The surface contained by the window
gScreenSurface := NULL

; Current displayed PNG image
gPNGSurface := NULL

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
		; Create window
		gWindow := SDL2.CreateWindow("SDL Tutorial", SDL.SDL_WINDOWPOS_UNDEFINED, SDL.SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL.SDL_WINDOW_SHOWN)
		if (gWindow == NULL)
		{
			MsgBox SDL2.Log("Window could not be created! SDL_Error: %s`n", SDL2.GetError())
			success := false
		}
		else
		{
			; Initialize PNG loading
			imgFlags := SDL.IMG_INIT_PNG
            
			if (!(SDL2.IMG.Init(imgFlags) & imgFlags))
			{
				MsgBox SDL2.Log("SDL_image could not initialize! SDL_image Error: %s`n", SDL2.IMG.GetError())
				success := false
			}
			else
			{
				; Get window surface
				gScreenSurface := SDL2.GetWindowSurface(gWindow)
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

	; Load PNG surface
	gPNGSurface := loadSurface("BMP\loaded.png")
	if (gPNGSurface == NULL)
	{
		MsgBox SDL2.Log("Failed to load PNG image!`n")
		success := false
	}

	return success
}

close()
{
    Global
	; Free loaded image
	SDL2.FreeSurface(gPNGSurface)
	gPNGSurface := NULL

	; Destroy window
	SDL2.DestroyWindow(gWindow)
	gWindow := NULL

	; Quit SDL subsystems
    SDL2.IMG.Quit()
	SDL2.Quit()
}

loadSurface(path)
{
    ; The final optimized image
	optimizedSurface := NULL
    
	; Load image at specified path
	loadedSurface := SDL2.IMG.Load(path)
	if (loadedSurface == NULL)
	{
		MsgBox SDL2.Log("Unable to load image %s! SDL Error: %s`n", path, SDL2.IMG.GetError())
	}
    else
    {
        ; Convert surface to screen format
		optimizedSurface := SDL2.ConvertSurface(loadedSurface, gScreenSurface.format, 0)
		if (optimizedSurface == NULL)
		{
			MsgBox SDL2.Log("Unable to optimize image %s! SDL Error: %s`n", path, SDL2.GetError())
		}

		; Get rid of old loaded surface
		SDL2.FreeSurface(loadedSurface)
    }

	return optimizedSurface
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
                
            ; Apply the image stretched
            SDL2.BlitScaled(gPNGSurface, NULL, gScreenSurface, NULL)
        
            ; Update the surface
            SDL2.UpdateWindowSurface(gWindow)
        }
    }
}

; Free resources and close SDL
close()
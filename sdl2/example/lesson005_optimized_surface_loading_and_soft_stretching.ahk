; Author: Mono
; Version: v1.0.0
; Time: 2022.09.15
; Up until now we've been blitting our images raw. Since we were only showing one image, it didn't matter. When you're making a game, blitting images raw causes needless slow down. We'll be converting them to an optimized format to speed them up.

; SDL 2 also has a new feature for SDL surfaces called soft stretching, which allows you to blit an image scaled to a different size. In this tutorial we'll take an image half the size of the screen and stretch it to the full size.

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

; Current displayed image
gStretchedSurface := NULL

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
			; Get window surface
			gScreenSurface := SDL2.GetWindowSurface(gWindow)
		}
	}

	return success
}

loadMedia()
{
    Global
	; Loading success flag
	success := true

	; Load stretching surface
	gStretchedSurface := loadSurface("BMP\stretch.bmp")
	if (gStretchedSurface == NULL)
	{
		MsgBox SDL2.Log("Failed to load default image!`n")
		success := false
	}

	return success
}

close()
{
    Global
	; Free loaded image
	SDL2.FreeSurface(gStretchedSurface)
	gStretchedSurface := NULL

	; Destroy window
	SDL2.DestroyWindow(gWindow)
	gWindow := NULL

	; Quit SDL subsystems
	SDL2.Quit()
}

loadSurface(path)
{
    ; The final optimized image
	optimizedSurface := NULL
    
	; Load image at specified path
	loadedSurface := SDL2.LoadBMP(path)
	if (loadedSurface == NULL)
	{
		MsgBox SDL2.Log("Unable to load image %s! SDL Error: %s`n", path, SDL2.GetError())
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
                
            stretchRect := [0, 0, SCREEN_WIDTH, SCREEN_HEIGHT]
            ; Apply the image stretched
            SDL2.BlitScaled(gStretchedSurface, NULL, gScreenSurface, stretchRect)
        
            ; Update the surface
            SDL2.UpdateWindowSurface(gWindow)
        }
    }
}

; Free resources and close SDL
close()
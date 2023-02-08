; Author: Mono
; Version: v1.0.0
; Time: 2022.09.15
; Now that you've already got a window open, let's put an image on it.

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

; The image we will load and show on the screen
gHelloWorld := NULL

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

	; Load splash image
	gHelloWorld := SDL2.LoadBMP("BMP\hello_world.bmp")
	if (gHelloWorld == NULL)
	{
		MsgBox SDL2.Log("Unable to load image %s! SDL Error: %s\n", "02_getting_an_image_on_the_screen/hello_world.bmp", SDL2.GetError())
		success := false
	}

	return success
}

close()
{
    Global
	; Deallocate surface
	SDL2.FreeSurface(gHelloWorld)
	gHelloWorld := NULL

	; Destroy window
	SDL2.DestroyWindow(gWindow)
	gWindow := NULL

	; Quit SDL subsystems
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
        ; Apply the image
        SDL2.BlitSurface(gHelloWorld, NULL, gScreenSurface, NULL)
        
        ; Update the surface
        SDL2.UpdateWindowSurface(gWindow)

        ; Wait two seconds
        SDL2.Delay(2000)
    }
}

; Free resources and close SDL
close()
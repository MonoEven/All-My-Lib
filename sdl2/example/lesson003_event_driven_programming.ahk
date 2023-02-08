; Author: Mono
; Version: v1.0.0
; Time: 2022.09.15
; Besides just putting images on the screen, games require that you handle input from the user. You can do that with SDL using the event handling system.

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
gXOut := NULL

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
	gXOut := SDL2.LoadBMP("BMP\x.bmp")
	if (gXOut == NULL)
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
	SDL2.FreeSurface(gXOut)
	gXOut := NULL

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

            ; Apply the image
            SDL2.BlitSurface(gXOut, NULL, gScreenSurface, NULL)
        
            ; Update the surface
            SDL2.UpdateWindowSurface(gWindow)
        }
    }
}

; Free resources and close SDL
close()
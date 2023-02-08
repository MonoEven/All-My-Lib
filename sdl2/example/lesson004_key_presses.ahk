; Author: Mono
; Version: v1.0.0
; Time: 2022.09.15
; Xing out the window is just one of the events SDL is capable of handling. Another type of input used heavily in games is the keyboard. In this tutorial we're going to make different images appear depending on which key you press.

; Using SDL2
#Include <sdl2\sdl2>

; Screen dimension constants
SCREEN_WIDTH := 640
SCREEN_HEIGHT := 480

; Main Program
; Key press surfaces constants
KEY_PRESS_SURFACE_DEFAULT := 1
KEY_PRESS_SURFACE_UP := 2
KEY_PRESS_SURFACE_DOWN := 3
KEY_PRESS_SURFACE_LEFT := 4
KEY_PRESS_SURFACE_RIGHT := 5
KEY_PRESS_SURFACE_TOTAL := 5

; The window we'll be rendering to
gWindow := NULL

; The surface contained by the window
gScreenSurface := NULL

; The images that correspond to a keypress
gKeyPressSurfaces := []
gKeyPressSurfaces.Length := KEY_PRESS_SURFACE_TOTAL

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

	; Load default surface
	gKeyPressSurfaces[KEY_PRESS_SURFACE_DEFAULT] := loadSurface("BMP\press.bmp")
	if (gKeyPressSurfaces[KEY_PRESS_SURFACE_DEFAULT] == NULL)
	{
		MsgBox SDL2.Log("Failed to load default image!`n")
		success := false
	}

	; Load up surface
	gKeyPressSurfaces[KEY_PRESS_SURFACE_UP] := loadSurface("BMP\up.bmp")
	if (gKeyPressSurfaces[KEY_PRESS_SURFACE_UP] == NULL)
	{
		MsgBox SDL2.Log("Failed to load up image!`n")
		success := false
	}

	; Load down surface
	gKeyPressSurfaces[KEY_PRESS_SURFACE_DOWN] := loadSurface("BMP\down.bmp")
	if (gKeyPressSurfaces[KEY_PRESS_SURFACE_DOWN] == NULL)
	{
		MsgBox SDL2.Log("Failed to load down image!`n")
		success := false
	}

	; Load left surface
	gKeyPressSurfaces[KEY_PRESS_SURFACE_LEFT] := loadSurface("BMP\left.bmp")
	if (gKeyPressSurfaces[KEY_PRESS_SURFACE_LEFT] == NULL)
	{
		MsgBox SDL2.Log("Failed to load left image!`n")
		success := false
	}

	; Load right surface
	gKeyPressSurfaces[KEY_PRESS_SURFACE_RIGHT] := loadSurface("BMP\right.bmp")
	if (gKeyPressSurfaces[KEY_PRESS_SURFACE_RIGHT] == NULL)
	{
		MsgBox SDL2.Log("Failed to load right image!`n")
		success := false
	}

	return success
}

close()
{
    Global
	; Deallocate surfaces
	Loop KEY_PRESS_SURFACE_TOTAL
	{
		SDL2.FreeSurface(gKeyPressSurfaces[A_Index])
		gKeyPressSurfaces[A_Index] := NULL
	}

	; Destroy window
	SDL2.DestroyWindow(gWindow)
	gWindow := NULL

	; Quit SDL subsystems
	SDL2.Quit()
}

loadSurface(path)
{
	; Load image at specified path
	loadedSurface := SDL2.LoadBMP(path)
	if (loadedSurface == NULL)
	{
		MsgBox SDL2.Log("Unable to load image %s! SDL Error: %s`n", path, SDL2.GetError())
	}

	return loadedSurface
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
        
        ; Set default current surface
        gCurrentSurface := gKeyPressSurfaces[KEY_PRESS_SURFACE_DEFAULT]
        
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
                ; User presses a key
                else if (e.type == SDL.SDL_KEYDOWN)
                {
                    ; Select surfaces based on key press
                    switch(e.key.keysym.sym)
                    {
                        case SDL.SDLK_UP:
                            gCurrentSurface := gKeyPressSurfaces[KEY_PRESS_SURFACE_UP]

                        case SDL.SDLK_DOWN:
                            gCurrentSurface := gKeyPressSurfaces[KEY_PRESS_SURFACE_DOWN]

                        case SDL.SDLK_LEFT:
                            gCurrentSurface := gKeyPressSurfaces[KEY_PRESS_SURFACE_LEFT]

                        case SDL.SDLK_RIGHT:
                            gCurrentSurface := gKeyPressSurfaces[KEY_PRESS_SURFACE_RIGHT]

                        default:
                            gCurrentSurface := gKeyPressSurfaces[KEY_PRESS_SURFACE_DEFAULT]
                    }
                }
            }

            ; Apply the current image
            SDL2.BlitSurface(gCurrentSurface, NULL, gScreenSurface, NULL)
        
            ; Update the surface
            SDL2.UpdateWindowSurface(gWindow)
        }
    }
}

; Free resources and close SDL
close()
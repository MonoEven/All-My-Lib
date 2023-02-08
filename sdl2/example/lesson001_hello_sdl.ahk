; Author: Mono
; Version: v1.0.0
; Time: 2022.09.15
; This tutorial covers the first major stepping stone: getting a window to pop up.

; Using SDL2
#Include <sdl2\sdl2>

; Screen dimension constants
SCREEN_WIDTH := 640
SCREEN_HEIGHT := 480

; Main Program
; The window we'll be rendering to
window := NULL

; The surface contained by the window
screenSurface := NULL

; Initialize SDL
if (SDL2.Init(SDL.SDL_INIT_VIDEO) < 0)
    MsgBox SDL2.Log("SDL could not initialize! SDL_Error: %s`n", SDL2.GetError())

else
{
    ; Create window
    window := SDL2.CreateWindow("SDL Tutorial", SDL.SDL_WINDOWPOS_UNDEFINED, SDL.SDL_WINDOWPOS_UNDEFINED, SCREEN_WIDTH, SCREEN_HEIGHT, SDL.SDL_WINDOW_SHOWN)
    if(window == NULL)
    {
        MsgBox SDL2.Log("Window could not be created! SDL_Error: %s`n", SDL2.GetError())
    }
    
    else
    {
        ; Get window surface
        screenSurface := SDL2.GetWindowSurface(window)

        ; Fill the surface white
        SDL2.FillRect(screenSurface, NULL, SDL2.MapRGB(screenSurface.format, 0xFF, 0xFF, 0xFF))
        
        ; Update the surface
        SDL2.UpdateWindowSurface(window)

        ; Wait two seconds
        SDL2.Delay(2000)
    }
    
    ; Destroy window
    SDL2.DestroyWindow(window)

    ; Quit SDL subsystems
    SDL2.Quit()
}
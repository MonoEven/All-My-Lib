; Author: Mono
; Version: v1.0.0
; Time: 2022.09.18

#Include <sdl2\sdl2>

rand()
{
    Return Random(0, 32767)
}

Class snakepart
{
    __New(col := 0, row := 0)
    {
        this.x := col
        this.y := row
    }
}

Class snakeclass
{
    __New()
    {
        this.width := 800
        this.height := 400
        SDL2.Init(SDL.SDL_INIT_EVERYTHING)
        SDL2.TTF.Init()
        this.font := SDL2.TTF.OpenFont("lazy.ttf", 20)
        this.window := SDL2.CreateWindow("Snake Game", SDL.SDL_WINDOWPOS_UNDEFINED, SDL.SDL_WINDOWPOS_UNDEFINED, this.width, this.height, SDL.SDL_WINDOW_SHOWN)
        this.screen := SDL2.GetWindowSurface(this.window)
        this.snake := []
        
        Loop 5
            this.snake.push(snakepart(40 + A_Index - 1, 10))
        
        this.points := 0
        this.del := 110
        this.get := false
        this.direction := "l"
        this.putfood()
        this.drawRect(0, 0, SDL2.MapRGB(this.screen.format, 0xFF, 0x00, 0x00), this.width, 10)
        this.drawRect(0, 0, SDL2.MapRGB(this.screen.format, 0xFF, 0x00, 0x00), 10, this.height - 20)
        this.drawRect(0, this.height - 30, SDL2.MapRGB(this.screen.format, 0xFF, 0x00, 0x00), this.width, 10)
        this.drawRect(this.width - 10, 0, SDL2.MapRGB(this.screen.format, 0xFF, 0x00, 0x00), 10, this.height - 20)
        
        Loop this.snake.Length
        {
            this.drawRect(this.snake[A_Index].x * 10, this.snake[A_Index].y * 10, SDL2.MapRGB(this.screen.format, 0x00, 0xFF, 0x00))
        }
    }
    
    __Delete()
    {
        SDL2.TTF.CloseFont(this.font)
        SDL2.TTF.Quit()
        SDL2.FreeSurface(this.screen)
        this.screen := NULL
        
        SDL2.DestroyWindow(this.window)
        this.window := NULL
        
        SDL2.Quit()
    }
    
    drawRect(x, y, color, w := 10, h := 10)
    {
        tmp := [x, y, w, h]
        SDL2.FillRect(this.screen, tmp, color)
    }
    
    putfood()
    {
        this.food := snakepart()
        
        while true
        {
            tmpx := mod(rand(), this.width) // 10 + 1
            tmpy := mod(rand(), this.height) // 10 + 1
            
            Loop this.snake.Length
            {
                if (this.snake[A_Index].x == tmpx) && (this.snake[A_Index].y == tmpy)
                    Continue
            }
            
            if (tmpx >= this.width // 10 - 20) || (tmpy >= this.height // 10 - 30)
                Continue
            
            this.food.x := tmpx
            this.food.y := tmpy
            Break
        }
        
        this.drawRect(this.food.x * 10, this.food.y * 10, SDL2.MapRGB(this.screen.format, 0xFF, 0x00, 0xFF))
    }
    
    collision()
    {
        if (this.snake[1].x == 0) || (this.snake[1].x == (this.width // 10 - 1)) || (this.snake[1].y == 0) || (this.snake[1].y == this.height // 10 - 3)
            return true
        
        Loop this.snake.Length - 2
        {
            if (this.snake[1].x == this.snake[A_Index].x) && (this.snake[A_Index] == this.snake[1].y)
                return true
        }
        
        if (this.snake[1].x == this.food.x) && (this.snake[1].y == this.food.y)
        {
            this.get := true
            this.putfood()
            this.points += 10
            this.text := SDL2.TTF.RenderText_Solid(this.font, this.points, [255, 255, 255], this.screen)
            
            tmp := [0, 380, 0, 0]
            this.drawRect(0, 380, SDL2.MapRGB(this.screen.format, 0x00, 0x00, 0x00), 100, 20)
            SDL2.BlitSurface(this.text, NULL, this.screen, tmp)
            SDL2.FreeSurface(this.text)
            this.text := NULL
            
            if (mod(this.points, 100) == 0 && this.del - 10 > 0)
                this.del -= 10
        }
        
        else
            this.get := false
        
        return false
    }
    
    movesnake()
    {
        event := SDL2.Event()
        
        while SDL2.PollEvent(&event)
        {
            if (event.type == SDL.SDL_KEYDOWN)
            {
                switch(event.key.keysym.sym)
                {
                    case SDL.SDLK_LEFT:
                    {
                        if this.direction !== "r"
                            this.direction := "l"
                    }
                    
                    case SDL.SDLK_A:
                    {
                        if this.direction !== "r"
                            this.direction := "l"
                    }
                    
                    case SDL.SDLK_UP:
                    {
                        if this.direction !== "d"
                            this.direction := "u"
                    }
                    
                    case SDL.SDLK_W:
                    {
                        if this.direction !== "d"
                            this.direction := "u"
                    }

                    case SDL.SDLK_DOWN:
                    {
                        if this.direction !== "u"
                            this.direction := "d"
                    }

                    case SDL.SDLK_S:
                    {
                        if this.direction !== "u"
                            this.direction := "d"
                    }

                    case SDL.SDLK_RIGHT:
                    {
                        if this.direction !== "l"
                            this.direction := "r"
                    }

                    case SDL.SDLK_D:
                    {
                        if this.direction !== "l"
                            this.direction := "r"
                    }

                    case SDL.SDLK_ESCAPE:
                        this.direction := "q"

                    case SDL.SDLK_Q:
                        this.direction := "q"
                }
            }
            
            else if (event.type == SDL.SDL_QUIT)
                this.direction := "q"
        }
        
        if !this.get
        {
            this.drawRect(this.snake[this.snake.Length].x * 10, this.snake[this.snake.Length].y * 10, SDL2.MapRGB(this.screen.format, 0x00, 0x00, 0x00))
            this.snake.pop()
        }
        
        if this.direction == "l"
            this.snake.InsertAt(1, snakepart(this.snake[1].x - 1, this.snake[1].y))
        else if this.direction == "r"
            this.snake.InsertAt(1, snakepart(this.snake[1].x + 1, this.snake[1].y))
        else if this.direction == "u"
            this.snake.InsertAt(1, snakepart(this.snake[1].x, this.snake[1].y - 1))
        else if this.direction == "d"
            this.snake.InsertAt(1, snakepart(this.snake[1].x, this.snake[1].y + 1))
        
        this.drawRect(this.snake[1].x * 10, this.snake[1].y * 10, SDL2.MapRGB(this.screen.format, 0x00, 0xFF, 0x00))
    }
    
    start()
    {
        while true
        {
            if this.collision()
            {
                MsgBox "Game Over"
                Break
            }
            
            this.movesnake()
            
            if this.direction == "q"
                Break
            
            SDL2.UpdateWindowSurface(this.window)
            SDL2.Delay(this.del)
        }
    }
}

s := snakeclass()
s.start()
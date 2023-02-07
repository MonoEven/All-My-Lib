class numahk_timer_machine
{
    __new()
    {
        dllcall("QueryPerformanceFrequency", "int64*", &freq := 0)
        this.freq := freq
    }
    
    start()
    {
        dllcall("QueryPerformanceCounter", "int64*", &counterbefore := 0)
        this.counterbefore := counterbefore
    }
    
    end()
    {
        dllcall("QueryPerformanceCounter", "int64*", &counterafter := 0)
        this.counterafter := counterafter
        return (this.counterafter - this.counterbefore) / this.freq
    }
    
    tostring()
    {
        return "Elapsed QPC time is " . (this.counterafter - this.counterbefore) / this.freq * 1000 " ms"
    }
}

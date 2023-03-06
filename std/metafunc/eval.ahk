#Include <machine\lib\state>

class EvalObject
{
    static event_map := map(
        "[", 1,
        "]", 2,
        '"', 3,
        "'", 4,
        "{", 5,
        "}", 6,
        "", 7
    )
    
    static state_map := map(
        "eval_start", 1,
        "array_start", 2,
        "quote_start", 3,
        "squote_start", 4,
        "map_start", 5,
        "eval_end", 6
    )
    
    static eventEnum := AutoEnum("event", EvalObject.event_map.count, EvalObject.event_map)
    static stateEnum := AutoEnum("state", EvalObject.state_map.count, EvalObject.state_map)
    
    Reset()
    {
        this.array_stack := []
        this.map_stack := []
        this.error_flag := false
        this.last_error := ""
        this.result := ""
    }
    
    Array(eval_string)
    {
        static stateTran := [
        StateTransform(EvalObject.stateEnum["eval_start"], EvalObject.eventEnum["["], EvalObject.stateEnum["array_start"], EvalObject.Func.InitArray.bind(this))
        ]
        this.Reset()
    }
    
    class Func
    {
        static InitArray(self, eventId)
        {
            if !self.result
                self.result := []
        }
    }
}
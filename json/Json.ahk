class Json
{
    Static Generator(content, filename := "")
    {
        result := Json_Generator(content)
        
        if filename
            FileAppend(result, filename)
        
        Return result
    }
    
    Static Parser(filename)
    {
        Return Json_Parser(filename)
    }
}

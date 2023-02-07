class caesar
{
    static charin(src, letter1, letter2)
    {
        if ord(src) <= ord(letter2) and ord(src) >= ord(letter1)
            return 1
        
        else
            return 0
    }
    
    static encrypt(ptext, skey := random(1, 25))
    {
        while skey < 0
            skey += 26
        text_encrypt := ""
        text := strsplit(ptext)
        for letter in text
        {
            if this.charin(letter, "a", "z")
                text_encrypt .= chr(mod((ord(letter) - ord("a") + skey), 26) + ord("a"))
            else if this.charin(letter, "A", "Z")
                text_encrypt .= chr(mod((ord(letter) - ord("A") + skey), 26) + ord("A"))
            else
                text_encrypt .= letter
        }
        
        return text_encrypt
    }
    
    static decrypt(ctext, skey := "")
    {
        key_map := map()
        if skey == ""
        {
            loop 26
                key_map[A_Index - 1] := this.decrypt(ctext, A_Index - 1)
        }
        else
        {
            while skey < 0
                skey += 26
            text_decrypt := ""
            text := strsplit(ctext)
            for i in text
            {
                if this.charin(i, chr(65 + mod(skey, 26)), chr(91)) or this.charin(i, chr(97 + mod(skey, 26)), chr(122))
                    text_decrypt .= chr(ord(i) - mod(skey, 26))
                else if this.charin(i, chr(65), chr(65 + mod(skey, 26) - 1)) or this.charin(i, chr(97), chr(97 + mod(skey, 26) - 1))
                    text_decrypt .= chr(ord(i) - mod(skey, 26) + 26)
                else
                    text_decrypt .= i
            }
            
            return text_decrypt
        }
        
        return key_map
    }
}
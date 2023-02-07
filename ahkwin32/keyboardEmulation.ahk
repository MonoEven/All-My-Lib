Class keyboardEmulation
{
    Static SCFormat(ScanCode)
    {
        Return (ScanCode is Number) ? Format("sc{:X}", ScanCode) : ScanCode
    }
    
    Static key_down(ScanCode)
    {
        ScanCode := keyboardEmulation.SCFormat(ScanCode)
        Send Format("{{}{} Down{}}", ScanCode)
    }
    
    Static key_press(ScanCode)
    {
        ScanCode := keyboardEmulation.SCFormat(ScanCode)
        Send Format("{{}{}{}}", ScanCode)
    }
    
    Static key_up(ScanCode)
    {
        ScanCode := keyboardEmulation.SCFormat(ScanCode)
        Send Format("{{}{} Up{}}", ScanCode)
    }
}
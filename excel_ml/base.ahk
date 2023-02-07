class excel_ml_base
{
    __new(url := "")
    {
        this.app := ComObject("Excel.Application")
        this.flag := 0
        if url
        {
            this.flag := 1
            this.url := url
        }
        else
        {
            this.url := A_ScriptDir "\__tmp_base.xlsx"
            this.wb := this.app.Workbooks.Add()
            this.wb.SaveAs(this.url)
            this.wb.close()
        }
        this.app.quit()
    }
    
    __delete()
    {
        if !this.flag
            filedelete(this.url)
    }
}
class excel_ml_calc
{
    __new(cell := "A1")
    {
        this.app := ComObject("Excel.Application")
        this.url := A_ScriptDir "\__tmp_calc.xlsx"
        this.cell := cell
    }
    
    calc(expression)
    {
        if !fileexist(this.url)
        {
            this.wb := this.app.Workbooks.Add()
            this.wb.SaveAs(this.url)
            this.wb.close()
        }
        this.wb := this.app.Workbooks.Open(this.url)
        this.ws := this.wb.sheets[1]
        this.ws.Range(this.cell).Value := "=" expression
        ret := this.ws.Range(this.cell).Value
        this.wb.save()
        this.wb.close()
        this.app.quit()
        return ret
    }
    
    __delete()
    {
        try
            filedelete(this.url)
    }
}
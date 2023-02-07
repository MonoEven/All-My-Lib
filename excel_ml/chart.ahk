#Include <std\metafunc\enum>

enum(&xlXYScatter := -4169,
&xlRadar := -4151,
&xlDoughnut := -4120,
&xl3DPie := -4102,
&xl3DLine,
&xl3DColumn,
&xl3DArea := -4098,
&xlArea := 1,
&xlLine := 4,
&xlPie,
&xlBubble := 15,
&xlColumnClustered := 51,
&xlColumnStacked,
&xlColumnStacked100,
&xl3DColumnClustered,
&xl3DColumnStacked,
&xl3DColumnStacked100,
&xlBarClustered,
&xlBarStacked,
&xlBarStacked100,
&xl3DBarClustered,
&xl3DBarStacked,
&xl3DBarStacked100,
&xlLineStacked,
&xlLineStacked100,
&xlLineMarkers,
&xlLineMarkersStacked,
&xlLineMarkersStacked100,
&xlPieOfPie,
&xlPieExploded,
&xl3DPieExploded,
&xlBarOfPie,
&xlXYScatterSmooth,
&xlXYScatterSmoothNoMarkers,
&xlXYScatterLines,
&xlXYScatterLinesNoMarkers,
&xlAreaStacked,
&xlAreaStacked100,
&xl3DAreaStacked,
&xl3DAreaStacked100,
&xlDoughnutExploded,
&xlRadarMarkers,
&xlRadarFilled,
&xlSurface,
&xlSurfaceWireframe,
&xlSurfaceTopView,
&xlSurfaceTopViewWireframe,
&xlBubble3DEffect,
&xlStockHLC,
&xlStockOHLC,
&xlStockVHLC,
&xlStockVOHLC,
&xlCylinderColClustered,
&xlCylinderColStacked,
&xlCylinderColStacked100,
&xlCylinderBarClustered,
&xlCylinderBarStacked,
&xlCylinderBarStacked100,
&xlCylinderCol,
&xlConeColClustered,
&xlConeColStacked,
&xlConeColStacked100,
&xlConeBarClustered,
&xlConeBarStacked,
&xlConeBarStacked100,
&xlConeCol,
&xlPyramidColClustered,
&xlPyramidColStacked,
&xlPyramidColStacked100,
&xlPyramidBarClustered,
&xlPyramidBarStacked,
&xlPyramidBarStacked100,
&xlPyramidCol,
&xlRegionMap := 140)

class excel_ml_chart
{
    
}

/*
app := ComObject("Excel.Application")
wb := app.Workbooks.Open(A_Desktop "\1.xlsx")
ws := wb.sheets["Sheet1"]
chart := ws.Shapes.AddChart2(-1, xlConeBarStacked100).Chart
chart.HasTitle := True
chart.ChartTitle.Text := "January Sales"
chart.SeriesCollection.Add(ws.Range("A1:C11"))
chart.PrintOut
wb.save()
wb.close()
app.quit()
*/
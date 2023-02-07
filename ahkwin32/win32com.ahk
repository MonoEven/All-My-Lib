#Include <ahkwin32\win32api>
#Include <ahkwin32\win32process>

Class win32com
{
    Class client
    {
        Static Dispatch(Process)
        {
            Return ComObject(Process)
        }
    }
    
    Class constants
    {
        ; WdBuiltinStyle
        Static wdStyleBlockQuotation := -85 ; 文本块。
        Static wdStyleBodyText := -67 ; 正文文本。
        Static wdStyleBodyText2 := -81 ; 正文文本 2。
        Static wdStyleBodyText3 := -82 ; 正文文本 3。
        Static wdStyleBodyTextFirstIndent := -78 ; 正文首行缩进。
        Static wdStyleBodyTextFirstIndent2 := -79 ; 正文首行缩进 2。
        Static wdStyleBodyTextIndent := -68 ; 正文文本缩进。
        Static wdStyleBodyTextIndent2 := -83 ; 正文文本缩进 2。
        Static wdStyleBodyTextIndent3 := -84 ; 正文文本缩进 3。
        Static wdStyleBookTitle := -265 ; 书籍标题。
        Static wdStyleCaption := -35 ; 题注。
        Static wdStyleClosing := -64 ; 结束语。
        Static wdStyleCommentReference := -40 ; 批注引用。
        Static wdStyleCommentText := -31 ; 批注文字。
        Static wdStyleDate := -77 ; 日期。
        Static wdStyleDefaultParagraphFont := -66 ; 默认段落字体。
        Static wdStyleEmphasis := -89 ; 强调。
        Static wdStyleEndnoteReference := -43 ; 尾注引用。
        Static wdStyleEndnoteText := -44 ; 尾注文本。
        Static wdStyleEnvelopeAddress := -37 ; 收信人地址。
        Static wdStyleEnvelopeReturn := -38 ; 寄信人地址。
        Static wdStyleFooter := -33 ; 页脚。
        Static wdStyleFootnoteReference := -39 ; 脚注引用。
        Static wdStyleFootnoteText := -30 ; 脚注文本。
        Static wdStyleHeader := -32 ; 页眉。
        Static wdStyleHeading1 := -2 ; 标题 1。
        Static wdStyleHeading2 := -3 ; 标题 2。
        Static wdStyleHeading3 := -4 ; 标题 3。
        Static wdStyleHeading4 := -5 ; 标题 4。
        Static wdStyleHeading5 := -6 ; 标题 5。
        Static wdStyleHeading6 := -7 ; 标题 6。
        Static wdStyleHeading7 := -8 ; 标题 7。
        Static wdStyleHeading8 := -9 ; 标题 8。
        Static wdStyleHeading9 := -10 ; 标题 9。
        Static wdStyleHtmlAcronym := -96 ; HTML 缩写。
        Static wdStyleHtmlAddress := -97 ; HTML 地址。
        Static wdStyleHtmlCite := -98 ; HTML 引文。
        Static wdStyleHtmlCode := -99 ; HTML 代码。
        Static wdStyleHtmlDfn := -100 ; HTML 定义。
        Static wdStyleHtmlKbd := -101 ; HTML 键盘。
        Static wdStyleHtmlNormal := -95 ; 普通（网站）。
        Static wdStyleHtmlPre := -102 ; HTML 预设格式。
        Static wdStyleHtmlSamp := -103 ; HTML 样本。
        Static wdStyleHtmlTt := -104 ; HTML 打字机。
        Static wdStyleHtmlVar := -105 ; HTML 变量。
        Static wdStyleHyperlink := -86 ; 超链接。
        Static wdStyleHyperlinkFollowed := -87 ; 访问过的超链接。
        Static wdStyleIndex1 := -11 ; 索引 1。
        Static wdStyleIndex2 := -12 ; 索引 2。
        Static wdStyleIndex3 := -13 ; 索引 3。
        Static wdStyleIndex4 := -14 ; 索引 4。
        Static wdStyleIndex5 := -15 ; 索引 5。
        Static wdStyleIndex6 := -16 ; 索引 6。
        Static wdStyleIndex7 := -17 ; 索引 7。
        Static wdStyleIndex8 := -18 ; 索引 8。
        Static wdStyleIndex9 := -19 ; 索引 9。
        Static wdStyleIndexHeading := -34 ; 索引标题。
        Static wdStyleIntenseEmphasis := -262 ; 明显强调。
        Static wdStyleIntenseQuote := -182 ; 明显引用。
        Static wdStyleIntenseReference := -264 ; 明显参考。
        Static wdStyleLineNumber := -41 ; 行号。
        Static wdStyleList := -48 ; 列表。
        Static wdStyleList2 := -51 ; 列表 2。
        Static wdStyleList3 := -52 ; 列表 3。
        Static wdStyleList4 := -53 ; 列表 4。
        Static wdStyleList5 := -54 ; 列表 5。
        Static wdStyleListBullet := -49 ; 列表项目符号。
        Static wdStyleListBullet2 := -55 ; 列表项目符号 2。
        Static wdStyleListBullet3 := -56 ; 列表项目符号 3。
        Static wdStyleListBullet4 := -57 ; 列表项目符号 4。
        Static wdStyleListBullet5 := -58 ; 列表项目符号 5。
        Static wdStyleListContinue := -69 ; 列表接续。
        Static wdStyleListContinue2 := -70 ; 列表接续 2。
        Static wdStyleListContinue3 := -71 ; 列表接续 3。
        Static wdStyleListContinue4 := -72 ; 列表接续 4。
        Static wdStyleListContinue5 := -73 ; 列表接续 5。
        Static wdStyleListNumber := -50 ; 列表编号。
        Static wdStyleListNumber2 := -59 ; 列表编号 2。
        Static wdStyleListNumber3 := -60 ; 列表编号 3。
        Static wdStyleListNumber4 := -61 ; 列表编号 4。
        Static wdStyleListNumber5 := -62 ; 列表编号 5。
        Static wdStyleListParagraph := -180 ; 列出段落。
        Static wdStyleMacroText := -46 ; 宏文本。
        Static wdStyleMessageHeader := -74 ; 信息标题。
        Static wdStyleNavPane := -90 ; 文档结构图。
        Static wdStyleNormal := -1 ; 正文。
        Static wdStyleNormalIndent := -29 ; 正文缩进。
        Static wdStyleNormalObject := -158 ; 正文（应用于对象）。
        Static wdStyleNormalTable := -106 ; 正文（在表格中应用）。
        Static wdStyleNoteHeading := -80 ; 注释标题。
        Static wdStylePageNumber := -42 ; 页码。
        Static wdStylePlainText := -91 ; 纯文本。
        Static wdStyleQuote := -181 ; 引用。
        Static wdStyleSalutation := -76 ; 称呼。
        Static wdStyleSignature := -65 ; 签名。
        Static wdStyleStrong := -88 ; 要点。
        Static wdStyleSubtitle := -75 ; 副标题。
        Static wdStyleSubtleEmphasis := -261 ; 不明显强调。
        Static wdStyleSubtleReference := -263 ; 不明显参考。
        Static wdStyleTableColorfulGrid := -172 ; 彩色网格。
        Static wdStyleTableColorfulList := -171 ; 彩色列表。
        Static wdStyleTableColorfulShading := -170 ; 彩色底纹。
        Static wdStyleTableDarkList := -169 ; 深色列表。
        Static wdStyleTableLightGrid := -161 ; 浅色网格。
        Static wdStyleTableLightGridAccent1 := -175 ; 浅色网格强调文字颜色 1。
        Static wdStyleTableLightList := -160 ; 浅色列表。
        Static wdStyleTableLightListAccent1 := -174 ; 浅色列表强调文字颜色 1。
        Static wdStyleTableLightShading := -159 ; 浅色底纹。
        Static wdStyleTableLightShadingAccent1 := -173 ; 浅色底纹强调文字颜色 1。
        Static wdStyleTableMediumGrid1 := -166 ; 中间色网格 1。
        Static wdStyleTableMediumGrid2 := -167 ; 中间色网格 2。
        Static wdStyleTableMediumGrid3 := -168 ; 中间色网格 3。
        Static wdStyleTableMediumList1 := -164 ; 中间色列表 1。
        Static wdStyleTableMediumList1Accent1 := -178 ; 中间色列表 1 强调文字颜色 1。
        Static wdStyleTableMediumList2 := -165 ; 中间色列表 2。
        Static wdStyleTableMediumShading1 := -162 ; 中间色底纹 1。
        Static wdStyleTableMediumShading1Accent1 := -176 ; 中间色底纹 1 强调文字颜色 1。
        Static wdStyleTableMediumShading2 := -163 ; 中间色底纹 2。
        Static wdStyleTableMediumShading2Accent1 := -177 ; 中间色底纹 2 强调文字颜色 1。
        Static wdStyleTableOfAuthorities := -45 ; 引文目录。
        Static wdStyleTableOfFigures := -36 ; 图表目录。
        Static wdStyleTitle := -63 ; 标题。
        Static wdStyleTOAHeading := -47 ; 引文目录标题。
        Static wdStyleTOC1 := -20 ; 目录 1。
        Static wdStyleTOC2 := -21 ; 目录 2。
        Static wdStyleTOC3 := -22 ; 目录 3。
        Static wdStyleTOC4 := -23 ; 目录 4。
        Static wdStyleTOC5 := -24 ; 目录 5。
        Static wdStyleTOC6 := -25 ; 目录 6。
        Static wdStyleTOC7 := -26 ; 目录 7。
        Static wdStyleTOC8 := -27 ; 目录 8。
        Static wdStyleTOC9 := -28 ; 目录 9。
    }
    
    Static Close(ComObj, Name := 0)
    {
        if !Name
            Name := 1
        
        hwnd := ComObj.Windows(Name).hwnd
        p := win32process.GetWindowThreadProcessId(hwnd)[2]
        
        Try
        {
            handle := win32api.OpenProcess(win32con.PROCESS_TERMINATE, 0, p)
            
            if handle
            {
                win32api.TerminateProcess(handle, 0)
                win32api.CloseHandle(handle)
            }
        }
    }
    
    Static Select(Range)
    {
        Range.Select
        
        Return Range
    }
}
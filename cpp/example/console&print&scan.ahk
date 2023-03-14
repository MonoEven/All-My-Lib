#Include <cpp\cpp>

console.AllocConsole()
stdio.printf("%s %d %d", ["astr", "123"], ["int", 1], ["int", 2])
stdio.scanf("%s %d %d", a := buffer(3, 0), ["int*", &b := 0], ["int*", &c := 0])
; change page to avoid garbled code
; stdlib.system("chcp 65001") ; for chinese
msgbox cextra.bufString(a)
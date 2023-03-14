#Include <cpp\cpp>

console.AllocConsole()
stdlib.system("chcp 65001")
stdlib.system("title AHK Shutdown")
stdlib.system("mode con cols=48 lines=25")
stdlib.system("color 0B")
stdlib.system("date /T")
stdlib.system("TIME /T")
stdio.printf("╔══════════AHK语言关机程序═════════╗`n")
stdio.printf("║※ 1.实现10分钟内的定时关闭计算机  ║`n")
stdio.printf("║※ 2.立即关闭计算机　              ║`n")
stdio.printf("║※ 3.注销计算机　                  ║`n")
stdio.printf("║※ 0.退出系统　                    ║`n")
stdio.printf("╚══════════════════════════════════╝`n")
cmd := "shutdown -s -t "
t := "0"
stdio.scanf("%d", ["int*", &c := 0])
stdio.getchar()
switch c
{
    case 0:
        return
    case 1:
    {
        stdio.printf("您想在多少秒后自动关闭计算机? (0~600)`n")
        stdio.scanf("%s", t := buffer(16, 0))
        t := cextra.bufString(t)
        stdlib.system(cstring.strcat(cmd, t))
    }
    case 2:
        stdlib.system("shutdown -p")
    case 3:
        stdlib.system("shutdown -l")
    default:
        stdio.printf("Error!`n")
}
stdlib.system("pause")
stdlib.exit(0)
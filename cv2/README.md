You should create a folder named "lib" in your autohotkey installdir.
And then put this folder into it.
The result like "%installdir%\lib\cv2\cv2.ahk"

当你在脚本目录使用cv2时，可将OpenCV_Dll文件夹以及OpenCV.ini移动到目标文件夹，同时创建名为cv_here.need的空文件，初次运行时，会在目标文件夹生成cv_load.need，如果dll有变更请将该文件删除并重新加载。

更多参考请见opencv-autohotkey-reference文件夹
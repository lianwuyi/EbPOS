*----------------------------------
*	防止程序被多次开启
*----------------------------------
Public handle
Declare Integer CreateFileMapping In kernel32.Dll Integer hFile, ;
	INTEGER lpFileMappingAttributes,Integer flProtect, ;
	INTEGER dwMaximumSizeHigh, Integer dwMaximumSizeLow, ;
	STRING lpName
Declare Integer GetLastError In kernel32.Dll
Declare Integer CloseHandle In kernel32.Dll Integer hObject

szname="ddwang-sos"   
handle = CreateFileMapping(0xFFFFFFFF,0,4,0,128,szname)

If handle = 0
	Wait Window "CreateFileMapping 失败 - LastError: " + Ltrim(Str(GetLastError()))
	Return
Endif

If handle=0
	Messagebox("内存映射文件创建失败！",16,"错误")
	Return .F.
Else
	If GetLastError()=183
		=Messagebox("该程序程序已经运行！",16,"提示")
		Close All
		Clear Dlls
		Clear Events
		Quit
	Endif
ENDIF

*--------------------------------------------------------------------------------------
* 启动程序 MAIN.PRG
*--------------------------------------------------------------------------------------

_Screen.Visible=.F.

DO ..\PROGS\系统参数.prg   && 原系统参数
* !/n control timedate.cpl && 时间日期属性（时间和日）

DO FORM ..\Forms\login.scx

ON SHUTDOWN quit  && 当你关闭系统时，XP会向所有应用程序发送退出消息,这时候on shutdown就会执行
READ EVENTS       && 开始事件处理：使启动封面停下来

CLOSE DATABASES ALL 
CLEAR ALL
*--------------------------------------------------------------------------------------
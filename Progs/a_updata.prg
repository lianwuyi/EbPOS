*--------------------------------------------------------------------------------------
* a_updata.PRG
*--------------------------------------------------------------------------------------
******检查网络链接**********************************************************************
Public intnetlj
intnetlj=.F.
Do cslj
******************************
If     intnetlj=.T.
    Do lj
    Release intnetlj
Else
    Return
ENDIF
***************************************************
Procedure lj
*连接后处理代码
 
DO FORM ..\forms\0正在升级.scx

WAIT WINDOW '版本不统一，稍后再做出整改……' NOWAIT NOCLEAR 
RETURN 

Set Library To myFll
SELECT 0
USE ..\Data\sys1.Dbf
csqlserver = ALLTRIM(mssql)
USE

If DownFile("http://"+csqlserver+"/ddw/exe_updata/ddwang updata.exe","..\ddwang\updata\ddwang updata.exe")
    RUN/n ..\ddwang\updata\ddwang updata.exe
    QUIT 
    *MessageBox("下载百度的LOGO成功！")
Else
    MessageBox("下载失败")
EndIf 
*DownFile("http://www.baidu.com/")  &&这样直接读取，不经过磁盘文件
Set Library To 



*************************************************
Procedure cslj
Declare Integer InternetGetConnectedState In wininet.Dll ;
    Integer @lpdwFlags, ;
    Integer dwReservednReserved
If internetgetconnectedstate(7, 0) = 0
*Messagebox("未连结到互联网！请进行拨号连接或检查网络状态。", 0, "错误")
    intnetlj=.F.
Else
    Do Case
    Case internetgetconnectedstate(7, 0) = 1
*Messagebox("拨号已经连通!",0,"提示")
        intnetlj=.T.
    Case internetgetconnectedstate(7, 0) = 2
*Messagebox("网络已经连通",0,"提示")
        intnetlj=.T.
    Otherwise
*Messagebox("通过代理连通！")
        intnetlj=.T.
    Endcase
ENDIF
********************************************************************************************
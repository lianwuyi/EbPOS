*--------------------------------------------------------------------------------------
* a_updata.PRG
*--------------------------------------------------------------------------------------
******�����������**********************************************************************
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
*���Ӻ������
 
DO FORM ..\forms\0��������.scx

WAIT WINDOW '�汾��ͳһ���Ժ����������ġ���' NOWAIT NOCLEAR 
RETURN 

Set Library To myFll
SELECT 0
USE ..\Data\sys1.Dbf
csqlserver = ALLTRIM(mssql)
USE

If DownFile("http://"+csqlserver+"/ddw/exe_updata/ddwang updata.exe","..\ddwang\updata\ddwang updata.exe")
    RUN/n ..\ddwang\updata\ddwang updata.exe
    QUIT 
    *MessageBox("���ذٶȵ�LOGO�ɹ���")
Else
    MessageBox("����ʧ��")
EndIf 
*DownFile("http://www.baidu.com/")  &&����ֱ�Ӷ�ȡ�������������ļ�
Set Library To 



*************************************************
Procedure cslj
Declare Integer InternetGetConnectedState In wininet.Dll ;
    Integer @lpdwFlags, ;
    Integer dwReservednReserved
If internetgetconnectedstate(7, 0) = 0
*Messagebox("δ���ᵽ������������в������ӻ�������״̬��", 0, "����")
    intnetlj=.F.
Else
    Do Case
    Case internetgetconnectedstate(7, 0) = 1
*Messagebox("�����Ѿ���ͨ!",0,"��ʾ")
        intnetlj=.T.
    Case internetgetconnectedstate(7, 0) = 2
*Messagebox("�����Ѿ���ͨ",0,"��ʾ")
        intnetlj=.T.
    Otherwise
*Messagebox("ͨ��������ͨ��")
        intnetlj=.T.
    Endcase
ENDIF
********************************************************************************************
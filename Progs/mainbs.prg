Lparameters cmdLine
*!*	On Error Quit
Set Safety Off
Set Exclusive Off   &&������ʱ�
Set Century On
Set Date YMD
Set Mark To "-"
Set Deleted On
Set Ansi On
set SAFETY off
Public ofrmMain &&���Է������ڴ������,FWSд��־
*-- ����FSP,PRG ����������
Set Path To Addbs(_vfp.ServerName)
Set Path To Menus;prgs;Forms;Class;Images;Dll;Report;Database;DAL;BLL;otherclass
Set Path To [WebAPIframework] Additive
Set Path To [Controller] Additive
SQLSetprop(0,"DispLogin",3)  && ����ʾSQL��¼��ʾ
TRY
ofrmMain=Newobject("QiyuLog","qiyulog.prg")
ofrmmain.log("ϵͳ����")
Set Library To fws.fll Additive
*Json֧��
Set Library To foxjson.fll Additive
Set Library To myfll.fll Additive
Set Procedure To foxJson Additive
Set Procedure To foxJson_Parse Additive
*On Error do responseerror

fws_Expires(Datetime()-10)  &&����ÿһ�η�������ʧЧ
CATCH TO ex
  *ERROR ex.message
ENDTRY 

*-- ���»�õ���·�����ٸ���ʵ���������rewrite ����
m.RequestObject=Juststem(fws_Header("PATH_INFO"))
*ofrmmain.log("����"+RequestObject)
STRTOFILE(m.RequestObject,"ff.txt")
*cPath=Upper(JustPath(fws_Header("PATH_INFO")))
*m.RequestObject = Juststem(HttpGetObject())  && exe prg,fsp ��������������ļ���(����FSP)
m.classfile=m.RequestObject+".prg"
Try
	oControll=Newobject(m.RequestObject,m.classfile)  && BS����ٿ����� ������ҵ���⣬����ִ������,������ǣ�����Ĭ����ȥִ��
	*--�õ����� �����෽��
	cProc=HttpQueryParams("proc")
	lcCmd="oControll."+cProc+"()"
	ofrmMain.Log(WebGetUri()+Chr(13)+oControll.Name+"."+cProc+"���ճɹ�")  &&д����־

	If !Pemstatus(oControll,cProc,5)
		Error m.RequestObject+cProc+"��ķ���������"
	Endif
	m.RetHtml=Transform(&lccmd)
	ofrmMain.Log(WebGetUri()+Chr(13)+oControll.Name+"."+cProc+"���óɹ�")  &&д����־
	WebResponseWrite(m.RetHtml)    &&������������������
Catch To ex
	ofrmMain.Log("ϵͳ����:"+ex.Message)  &&д����־
	objall=Createobject("foxjson")
	objall.Append("errno",ex.ErrorNo)
	objall.Append("errmsg",ex.Message)
	objall.Append("success","false")
	objall.Append("errorMsg",ex.Message)
	objall.Append("total ",0)
	orow=Createobject("foxjson",{})
	objall.Append("rows",orow.tostring())
	ofrmMain.Log(objall.tostring())
	WebResponseWrite(Strconv(objall.tostring(),9))
Endtry


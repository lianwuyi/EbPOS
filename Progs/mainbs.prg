Lparameters cmdLine
*!*	On Error Quit
Set Safety Off
Set Exclusive Off   &&共享访问表
Set Century On
Set Date YMD
Set Mark To "-"
Set Deleted On
Set Ansi On
set SAFETY off
Public ofrmMain &&调试服务器在窗口输出,FWS写日志
*-- 所有FSP,PRG 由它来解释
Set Path To Addbs(_vfp.ServerName)
Set Path To Menus;prgs;Forms;Class;Images;Dll;Report;Database;DAL;BLL;otherclass
Set Path To [WebAPIframework] Additive
Set Path To [Controller] Additive
SQLSetprop(0,"DispLogin",3)  && 不显示SQL登录提示
TRY
ofrmMain=Newobject("QiyuLog","qiyulog.prg")
ofrmmain.log("系统启动")
Set Library To fws.fll Additive
*Json支持
Set Library To foxjson.fll Additive
Set Library To myfll.fll Additive
Set Procedure To foxJson Additive
Set Procedure To foxJson_Parse Additive
*On Error do responseerror

fws_Expires(Datetime()-10)  &&对于每一次访问立即失效
CATCH TO ex
  *ERROR ex.message
ENDTRY 

*-- 以下获得调用路径，再根据实现情况访问rewrite 技术
m.RequestObject=Juststem(fws_Header("PATH_INFO"))
*ofrmmain.log("访问"+RequestObject)
STRTOFILE(m.RequestObject,"ff.txt")
*cPath=Upper(JustPath(fws_Header("PATH_INFO")))
*m.RequestObject = Juststem(HttpGetObject())  && exe prg,fsp 获得浏览器请求的文件名(兼容FSP)
m.classfile=m.RequestObject+".prg"
Try
	oControll=Newobject(m.RequestObject,m.classfile)  && BS框架再考虑了 如果能找到类库，则类执行运算,如果不是，则由默认类去执行
	*--得到参数 调用类方法
	cProc=HttpQueryParams("proc")
	lcCmd="oControll."+cProc+"()"
	ofrmMain.Log(WebGetUri()+Chr(13)+oControll.Name+"."+cProc+"接收成功")  &&写入日志

	If !Pemstatus(oControll,cProc,5)
		Error m.RequestObject+cProc+"类的方法不存在"
	Endif
	m.RetHtml=Transform(&lccmd)
	ofrmMain.Log(WebGetUri()+Chr(13)+oControll.Name+"."+cProc+"调用成功")  &&写入日志
	WebResponseWrite(m.RetHtml)    &&将处理结果输出给浏览器
Catch To ex
	ofrmMain.Log("系统错误:"+ex.Message)  &&写入日志
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


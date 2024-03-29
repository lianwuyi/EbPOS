*--------------------------------------------------------------------------------------
* 系统参数.PRG
*--------------------------------------------------------------------------------------
SET SAFETY OFF      && 决定改写已有文件之前是否显示对话框
SET TALK OFF          && 决定 Visual FoxPro 是否显示命令结果
SET CENTURY ON        && 显示年份为4位
SET DATE ANSI         && yy.mm.dd (年月日格式)
SET DELETED ON        && ON 为使用范围子句处理记录(包括在相关表中的记录)的命令忽略标有删除标记的记录。
SET EXCLUSIVE OFF     && (私有数据工作期的默认方式)允许网络上的任何用户共享和修改网络上打开的表。
SET HELP ON           && 允许打开帮助
SET ESCAPE OFF        && 禁止运行的程序在按 Esc 键后被中断
SET NULLDISPLAY TO '' && 去除一切值带 null
SET MULTILOCKS ON     && 打开允许缓存
SET HOURS TO 24       &&24小时制

*-----设置程序主目录-------------------------
RELEASE gcMainPath
PUBLIC  gcMainPath
gcMainPath=SYS(5)+SYS(2003)+"\"
SET DEFAULT TO(gcMainPath)

CD"\EbPOS\"
SET PATH TO ;BMP,DATA,EXCEL,FORMS,LNG,MENUS,PROGS,REPORTS
*----------------------------------------------

*-----设置系统公共变量-------------------------
RELEASE c版本号,c版权,c测试,cPATHS,cMSSQL,cshopno,c店名
PUBLIC  c版本号,c版权,c测试,cPATHS,cMSSQL,cshopno,c店名

c版本号="1.0"
c版权 = '版权所有：(C)EbongSoft 2017-2019'
c测试=0&& 1为测试状态
SELECT 0
USE ..\DATA\sys1.DBF
cPATHS = ALLTRIM(PATHS)
cshopno = shopno
c店名 = ALLTRIM(店名)
USE

*------连接远程服务器，总部使用------------------
*DO ..\progs\sys_info.prg

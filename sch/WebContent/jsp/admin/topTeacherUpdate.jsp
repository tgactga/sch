<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.huahong.erp.util.GetRecentDate"%>
<%@page import="com.huahong.admin.dao.TopTeacherDAO"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String USER_CODE = "";
try{
	USER_CODE = session.getAttribute("USER_CODE").toString();
}catch(Exception e){
	response.setContentType("text/html; charset=utf-8");
	response.sendRedirect(path + "/jsp/admin/login.jsp");
	return;
}
String TYPE = request.getParameter("TYPE").toString();
String title = "";
String con1 = "";
String con2 = "";
String con3 = "";
String con4 = "";
String con5 = "";
if(TYPE.equals("1")){
	title = "优秀教师";
	con1 = "教师姓名";
	con2 = "教师科目";
	con3 = "教师年级";
	con4 = "教师头像";
	con5 = "连接";
}else{
	title = "优秀学生";
	con1 = "学生姓名";
	con2 = "第几届";
	con3 = "学生年级";
	con4 = "学生头像";
	con5 = "连接";
}
GetRecentDate date=new GetRecentDate();
String currentDate=date.getRecentDate("yyyy-MM-dd HH:mm:ss.S");
String curDateStr=currentDate.replaceAll("-","").replaceAll(" ","").replaceAll(":","").replace(".","");//系统当前时间

String ID = request.getParameter("ID").toString();
TopTeacherDAO dao = new TopTeacherDAO();
List list = dao.getTopTeacherDet(ID);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>优秀教师-新增</title>
    <link href="<%=path%>/css/blueui/style.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/css/blueui/table.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/css/jqueryui/jquery-ui-1.10.3.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" />
	<script src="<%=path%>/js/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="<%=path%>/js/jquery/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
    <script src="<%=path%>/js/jquery/jquery.form.js" type="text/javascript"></script>
    <script src="<%=path%>/js/msgbox/msgbox.js" type="text/javascript"></script>
    <script src="<%=path%>/js/common.js" type="text/javascript"></script>
    
<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font-family: "宋体";
	font-size: 12px;
	color: #333333;
	background-color: #2286C2;
}
</style>
<script>
var Xml=false;
if(window.XMLHttpRequest){
	Xml=new XMLHttpRequest();
}else if(window.ActiveXObject){
	Xml=new ActiveXObject("Msxml2.XMLHTTP");
}
var	sHeight = window.parent.document.body.clientHeight;;
//根据不同的浏览器做不同的判断
var Sys = getBrowser()
var taglen = 140;

$(function(){
	$("#conTd").css({
		"height":(sHeight-taglen)+"px"
	})
	$("#save").button().click(function(){
		$('#upForm').ajaxSubmit(function(data){
			var TEACH_NAME = $("#TEACH_NAME").val();
			var TEACH_KEMU = $("#TEACH_KEMU").val();
			var TEACH_NIANJI = $("#TEACH_NIANJI").val();
			var TEACH_PHOTO = $("#TEACH_PHOTO").val();
			if(TEACH_PHOTO!=""){
				TEACH_PHOTO = "/file/imgFile/<%=curDateStr%>.jpg";
			}else{
				TEACH_PHOTO = "<%=((HashMap)list.get(0)).get("TEACH_PHOTO")%>";
			}
			var TEACH_URL = $("#TEACH_URL").val();
			$.ajax({
				type:"post",
				url:"<%=path%>/TopTeacherAction.do",
				dataType:"json",
				data:'operType=updateTopTeacher&ID=<%=ID%>&TEACH_NAME='+TEACH_NAME+'&TEACH_KEMU='+TEACH_KEMU+'&TEACH_NIANJI='+TEACH_NIANJI+'&TEACH_PHOTO='+TEACH_PHOTO+'&TEACH_URL='+encodeURIComponent(TEACH_URL),
				success:function(data){
					if(data.SUCCESS == 1){
						msgSuccessUrl('修改成功', "<%=path%>/jsp/admin/topTeacher.jsp?TYPE=<%=TYPE%>");
					}else{
						msgError('修改失败');
					}
				}
			});
		});
	});
	$("#back").button().click(function(){
		location.replace("<%=path%>/jsp/admin/topHotNew.jsp");
	});
});
</script>
</head>
<body>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td colspan="2">
                <table width="100%" border="0" cellspacing="10" cellpadding="0">
                    <tr>
                        <td width="70%" valign="top">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="8" height="8">
                                        <img src="<%=path%>/images/blueui/index1_28.gif" width="8" height="39" />
                                    </td>
                                    <td width="99%" background="<%=path%>/images/blueui/index1_40.gif">
                                        <table border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td>
                                                    <table width="110" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td width="5">
                                                                <img src="<%=path%>/images/blueui/index1_35.gif" width="5" height="39" />
                                                            </td>
                                                            <td align="center" background="<%=path%>/images/blueui/index1_36.gif">
                                                                <a href="#" class="font3"><strong><%=title%>-修改</strong></a>
                                                            </td>
                                                            <td width="5">
                                                                <img src="<%=path%>/images/blueui/index1_38.gif" width="5" height="39" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td width="8" height="8">
                                        <img src="<%=path%>/images/blueui/index1_43.gif" width="8" height="39" />
                                    </td>
                                </tr>
                                <tr>
                                    <td background="<%=path%>/images/blueui/index1_45.gif">
                                    </td>
                                    <td id="conTd" bgcolor="#FFFFFF" style="height: 100px; vertical-align: top;">
                                        <div id="conDiv" style="width:auto;height:100%;overflow-y:scroll;">
	                                        <table width="100%" border="0" cellspacing="10" cellpadding="0">
	                                            <tr>
	                                                <td>
	                                                    <form id="upForm" action="<%=path%>/jsp/common/imageUpLoad.jsp" encType="multipart/form-data" method="post">
		                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-bottom:1px solid #2286C2;">
		                                                        <tr>
																	<td class="tdfir" align="center" style="width:10%;"><%=con1%></td>
																	<td class="tdSen" align="left" style="width:90%;">
																		<input id="TEACH_NAME" type="text" style="width:200px;" value="<%=((HashMap)list.get(0)).get("TEACH_NAME")%>"/>
		                                                            </td>
		                                                        </tr>
		                                                        <tr>
																	<td class="tdfir" align="center" style="width:10%;"><%=con2%></td>
																	<td class="tdSen" align="left" style="width:90%;">
																		<input id="TEACH_KEMU" type="text" style="width:200px;" value="<%=((HashMap)list.get(0)).get("TEACH_KEMU")%>"/>
		                                                            </td>
		                                                        </tr>
		                                                        <tr>
																	<td class="tdfir" align="center" style="width:10%;"><%=con3%></td>
																	<td class="tdSen" align="left" style="width:90%;">
																		<input id="TEACH_NIANJI" type="text" style="width:200px;" value="<%=((HashMap)list.get(0)).get("TEACH_NIANJI")%>"/>
		                                                            </td>
		                                                        </tr>
		                                                        <tr>
																	<td class="tdfir" align="center" style="width:10%;"><%=con4%></td>
																	<td class="tdSen" align="left" style="width:90%;">
																		<input id="TEACH_PHOTO" type="file" name="file" style="width:400px;"/>
																		<input name="CURDATE" type="hidden" value="<%=curDateStr%>" />
		                                                            </td>
		                                                        </tr>
		                                                        <tr>
																	<td class="tdfir" align="center" style="width:10%;"><%=con5%></td>
																	<td class="tdSen" align="left" style="width:90%;">
																		<input id="TEACH_URL" type="text" value="<%=((HashMap)list.get(0)).get("TEACH_URL")%>"/>
		                                                            </td>
																</tr>
															</table>
														</form>
														<div style="padding-top:5px;padding-left:50%;">
															<input id="save" style="width:55px;" type="submit" value="保存"/>&nbsp;&nbsp;
															<input id="back" style="width:55px;" type="submit" value="返回"/>
														</div>
	                                                </td>
	                                            </tr>
	                                        </table>
                                        </div>
									</td>
									<td background="<%=path%>/images/blueui/index1_47.gif">
                                    </td>
								</tr>
								<tr>
									<td height=8 width=8><img src="<%=path%>/images/blueui/index1_91.gif" width=8 height=8></td>
									<td background="<%=path%>/images/blueui/index1_92.gif"></td>
									<td height=8 width=8><img src="<%=path%>/images/blueui/index1_93.gif" width=8 height=8></td>
                       			</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>
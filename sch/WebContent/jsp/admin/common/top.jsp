<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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

String USER_NAME = session.getAttribute("USER_NAME").toString();
String ROLE_NAME = session.getAttribute("ROLE_NAME").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="x-ua-compatible" content="ie=8"/>
	<link href="<%=path%>/css/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
body{
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font-family: "宋体";
	font-size: 12px;
	color: #333333;
	background-image: url('<%=path%>/images/blueui/index1_03.gif');
}
</style>
<script>
function outLog(){
	window.parent.location.replace("<%=path%>/jsp/admin/login.jsp");
}
function updatePsw(){
	window.parent.location.replace("<%=path%>/jsp/admin/updatePassWord.jsp");
}
 
</script>
</head>
<body>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="33%" rowspan="2">
				<img src="<%=path%>/images/blueui/index1_01.jpg" width="253" height="74" />
			</td>
			<td width="6%" rowspan="2">
				&nbsp;
			</td>
			<td width="61%" height="38" align="right">
				<table width="120" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center">
							<img src="<%=path%>/images/blueui/index1_06.gif" width="16" height="16" />
						</td>
						<td align="center" class="font2">
							<a href="#" class="font2" onclick="updatePsw();"><strong>修改密码</strong></a>
						</td>
						<td align="center">
							<img src="<%=path%>/images/blueui/index1_08.gif" width="16" height="16" />
						</td>
						<td align="center" class="font2">
							<a href="#" class="font2" onclick="outLog();"><strong>退出</strong></a>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="right" class="font2">
							<a href="#">
								<%-- <img src="<%=path%>/images/blueui/index1_13.gif" width="84" height="24" border="0" align="absmiddle" /> --%>
							</a>&nbsp;&nbsp;登陆用户：<%=USER_NAME %>&nbsp;|&nbsp;身份：<%=ROLE_NAME %>&nbsp;|&nbsp;界面风格：
							<a href="#"><img src="<%=path%>/images/blueui/index1_16.gif" width="48" height="24" border="0" align="absmiddle" /></a>&nbsp;
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>
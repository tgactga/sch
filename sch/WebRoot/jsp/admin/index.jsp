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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!-- <meta http-equiv="x-ua-compatible" content="ie=8"/> -->
    <title>武汉市新洲区第一中学网站内容发布系统</title>
	<script src="<%=path%>/js/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
<style type="text/css">
	html,body {height:100%;}
</style>
<script type="text/javascript">
function load(){
	var	sHeight = window.parent.document.body.clientHeight;
	$("#td1").css({
		"height":sHeight-75+"px"
	});
	$("#td2").css({
		"height":sHeight-75+"px"
	});
}
</script>
</head>
<body style="margin:0px;padding:0px;overflow-y:hidden" onload="load();">
	<table border="0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;width:100%;height:98.75%;">
		<tr>
			<td colspan="2" style="height:75px;padding:0px;border:0px;">
				<iframe src="<%=path%>/jsp/admin/common/top.jsp" frameborder="no" border="0" scrolling="no" style="width:100%;height:75px;"></iframe>
			</td>
		</tr>
		<tr>
			<td id="td1" style="height:92%;width:15%;">
				<iframe src="<%=path%>/jsp/admin/common/left.jsp" frameborder="no" border="0" scrolling="no" style="width:100%;height:100%;"></iframe>
			</td>
			<td id="td2" style="height:92%;width:95%;">
				<iframe src="" id="content" src="" frameborder="no" border="0" scrolling="no" style="width:100%;height:100%;"></iframe>
			</td>
		</tr>
	</table>
</body>
</html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>武汉市新洲区第一中学网站内容发布系统</title>
    <link href="<%=path%>/css/backlogin.css" rel="stylesheet" />
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" />
	<script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/msgbox.js"></script>
	<script type="text/javascript" src="<%=path%>/js/common.js"></script>
<style>
</style>
<script type="text/javascript">
$(function(){
	$("#USER_CODE").focus();
});
function refresh(obj){
	obj.src = "<%=path%>/imageServlet?"+Math.random();
}
function submit(){
	var USER_CODE = $("#USER_CODE").val();
	var USER_PASSWORD = $("#USER_PASSWORD").val();
	var USER_PASSWORD_2 = $("#USER_PASSWORD_2").val();
	if(USER_CODE == ""){
		msgError("请填写用户名!");
		return;
	}
	if(USER_PASSWORD == ""){
		msgError("请填写密码!");
		return;
	}
	if(USER_PASSWORD_2 == ""){
		msgError("再次输入密码!");
		return;
	}
	if(USER_PASSWORD_2 != USER_PASSWORD){
		msgError("两次输入的密码不一致!");
		return;
	}
	$.ajax({
		type:"post",
		url:"<%=path%>/AdminLoginAction.do",
		dataType:"json",
		data:'operType=updatePsw&USER_CODE='+encodeURIComponent(USER_CODE)+'&USER_PASSWORD='+encodeURIComponent(USER_PASSWORD),
		success:function(data){
			if(data.SUCCESS == 1){
				msgError('密码修改成功，正跳转到登陆页面!');
				location.replace("<%=path%>/jsp/admin");
			}else{
				msgError('修改密码失败！');
				$("#USER_PASSWORD").val("");
				$("#USER_PASSWORD_2").val("");
				document.getElementById("userImg").src = "<%=path%>/imageServlet?"+Math.random();
			}
		}
	});
}
function reset(){
	$("#USER_CODE").val("");
	$("#USER_PASSWORD").val("");
	$("#USER_PASSWORD_2").val("");
}
document.onkeydown = function(event_e){
	if(window.event) {
		event_e = window.event;
	}
	var int_keycode = event_e.charCode||event_e.keyCode;
	if(int_keycode == '13') {
		submit();
	}
}
</script>
</head>
<body style="background:url('<%=path%>/images/blueui/loginbg.jpg')">
	<div style="position:relative;margin-left:auto;margin-right:auto;margin-top:99px;width:1000px;height:500px;background:url('<%=path%>/images/blueui/loginbgmain.jpg') no-repeat;">
		<div style="position:absolute;top:200px;left:480px;width:500px;height:200px;">
			<table border="0">
				<tr>
					<td>用户名：</td>
					<td colspan="2"><input type="text" id="USER_CODE" class="input2"/></td>
				</tr>
				<tr>
					<td>新密码：</td>
					<td colspan="2"><input type="password" id="USER_PASSWORD" class="input2" /></td>
				</tr>
				<tr>
					<td>再次输入：</td>
					<td colspan="2"><input type="password" id="USER_PASSWORD_2" class="input2" /></td>
				</tr>
			</table>
			 <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			  </p>
            <p>
            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:submit()" target="_self">
            		<%-- <img src="<%=path%>/images/blueui/loginSub.jpg"> --%>
            		<input id="search" type="submit" value="确定修改" class="ui-button ui-widget ui-state-default ui-corner-all" role="button" aria-disabled="false">
            	</a>
            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:reset()" target="_self">
            		<%-- <img src="<%=path%>/images/blueui/loginReset.jpg"> --%>
            		<input id="search" type="submit" value="清空重置" class="ui-button ui-widget ui-state-default ui-corner-all" role="button" aria-disabled="false">
            	</a>
            </p>
        </div>
	</div>
</body>
</html>
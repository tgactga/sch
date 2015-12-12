<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 5.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>合同管理</title>
    <link href="<%=path%>/css/login.css" rel="stylesheet" />
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" />
	<script type="text/javascript" src="<%=path%>/js/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="<%=path%>/js/msgbox/msgbox.js"></script>
	<script type="text/javascript" src="<%=path%>/js/common.js"></script>
<style>
</style>
<script type="text/javascript">
function refresh(obj) {
	obj.src = "imageServlet?"+Math.random();
}
function submit(){
	var USER_CODE = $("#USER_CODE").val();
	var USER_PASSWORD = $("#USER_PASSWORD").val();
	var CHECKCODE = $("#CHECKCODE").val();
	if(USER_CODE == ""){
		msgError("请填写用户名!");
		return;
	}
	if(USER_PASSWORD == ""){
		msgError("请填写密码!");
		return;
	}
	if(CHECKCODE == ""){
		msgError("请填写验证码!");
		return;
	}
	$.ajax({
		type:"post",
		url:"<%=path%>/AdminLoginAction.do",
		dataType:"json",
		data:'operType=adminLogin&USER_CODE='+encodeURIComponent(USER_CODE)+'&USER_PASSWORD='+encodeURIComponent(USER_PASSWORD)+'&CHECKCODE='+encodeURIComponent(CHECKCODE),
		success:function(data){
			if(data.SUCCESS == 1){
				location.replace("<%=path%>/index.jsp");
			}else if(data.SUCCESS == 2){
				msgError('验证码输入有误!');
				$("#CHECKCODE").val("");
				document.getElementById("userImg").src = "imageServlet?"+Math.random();
			}else{
				msgError('请核对用户名和密码');
				$("#USER_PASSWORD").val("");
				$("#CHECKCODE").val("");
				document.getElementById("userImg").src = "imageServlet?"+Math.random();
			}
		}
	});
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
<body>
	<div class="loginbox">
		<div class="logincont">
            <div class="loginform">
            	<span style="color:red;margin-left:80px;" id="message"></span>
            	<span id="u_name_tip" style="color: red;"></span>
            	<span id="u_pwd_tip" style="color: red;"></span>
                <ul>
                <li>用户名： <input type="text" id="USER_CODE" class="input2" /></li>
                <li>密　码： <input type="password" id="USER_PASSWORD" class="input2" /></li>
                <li>验证码： <input type="text" id="CHECKCODE"  class="input3 yzm" />
                	<img title="点击更换" id="userImg" onclick="javascript:refresh(this);" src="imageServlet" />
                </li>
            </ul>
            <p><input id="btnLogin" type="button" value=" 登 录 "  onclick="submit();" name="btnLogin"  class="sbmit" /></p>
        </div>
    </div>
    </div>
</body>
</html>
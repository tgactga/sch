<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.huahong.admin.dao.CommonDAO"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//CommonDAO dao = new CommonDAO();
//List listfen2 = dao.getFenList("2");
//List listfen3 = dao.getFenList("3");
//List listfen4 = dao.getFenList("4");
//List listfen5 = dao.getFenList("5");
//List listfen6 = dao.getFenList("6");
//List listfen7 = dao.getFenList("7");
//List listfen8 = dao.getFenList("8");
//List listfen9 = dao.getFenList("9");
//List listfen10 = dao.getFenList("10");
//List listfen11 = dao.getFenList("11");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="UTF-8">
<head>
	<link href="<%=path%>/css/xi/css.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/xi/goodnav.css" rel="stylesheet" />
	<link href="<%=path%>/css/IndexPage.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/css.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/nav/common.css" rel="stylesheet" type="text/css" />
	<script src="<%=path%>/js/xi/jquery-1.9.1.min.js" type="text/javascript"></script>
	<script src="<%=path%>/js/xi/jquery.litenav.js" type="text/javascript"></script>
	<script src="<%=path%>/js/xi/jquery-1.4a2.min.js" type="text/javascript"></script>
	<script src="<%=path%>/js/xi/jquery.KinSlideshow-1.2.1.min.js" type="text/javascript"></script>
	<script src="<%=path%>/js/xi/top2013.js" type="text/javascript"></script>
	<script src="<%=path%>/js/xi/City.js" type="text/javascript"></script>
</head>
<script>
function Login(){
	var TxtUserName = $("#TxtUserName").val();
	var TxtPassword = $("#TxtPassword").val();
	$.ajax({
		type:"post",
		url:"<%=path%>/IndexAction.do",
		dataType:"json",
		contentType:"application/x-www-form-urlencoded; charset=utf-8",
		data:'operType=loginXiaoYou&TxtUserName='+TxtUserName+'&TxtPassword='+TxtPassword,
		success:function(data){
			var tag = data.SUCCESS;
			if(tag == "1"){
				
			}else{
				
			}
		}
	});
}
</script>
<body>
	<div id="Header" style="height:28px;">
		<div class="topBox" style="width:1007px; margin:0 auto; margin-bottom:2px;">
			<div class="topTools" style="color:#FFFFFF; float:right;">
				<span class="localTime">
					<script language="javascript" type="text/javascript" src="<%=path%>/js/date.js"></script>
				</span>
				<a href="#" onclick="this.style.behavior='url(#default#homepage)';this.setHomePage('www.hbhcgz.html');" title="设为首页">设为首页</a>
				<a href="javascript:if(document.all){window.external.addFavorite('www.hbhcgz.html','新洲一中');}else if(window.sidebar){window.sidebar.addPanel('新洲一中', 'http://www.xinzhou.cn','');}" title="加入收藏">加入收藏</a>
			</div>
			<div id="LoginFrom" class="Login_ajax" onKeyPress="javascript:return DefaultButton(event, 'BtnLogOn')">
				<div class="fl">
					用户名：<input id="TxtUserName" class="inputtext" onFocus="if(this.value=='用户名')this.value='';else this.select();" name="TxtUserName" maxLength="20" value="用户名" type="text" />
		 				密码：<input style="width: 125px;" id="TxtPassword" class="inputtext" onFocus="if(this.value=='123456')this.value='';else this.select();" name="TxtPassword" value="123456" type="password" />
				</div>
				<div style="float: left; display: none;" id="checkcode">
					&nbsp;验证码：<input name="TxtValdisplayDateCode" type="text" value="no" id="TxtValdisplayDateCode" class="tx_input" onfocus="this.select();" /><img id="VcodeLogOn" title="看不清楚，换一个" onclick="RefreshValdisplayDateCodeImage(this);" src="" class="Vcode" />
				</div>
				<div style="float: left; display: none;">
					Cookie：<select id="dropexpiration" name="dropexpiration">
					    <option value="none">不保存</option>
						<option value="day">保存一天</option>
						<option value="month">保存一月</option>
						<option value="year">保存一年</option>
		 				</select>
				</div>
				&nbsp;<input type="image" src="<%=path%>/images/web/btn_log.png" name="BtnLogOn" value="登录" id="BtnLogOn" onclick="Login();" style="width:59px; height:20px;" />
				<a href="http://localhost:8081/userreg.php" linkOpenType="_top" style="background:url(<%=path%>/images/web/btn_reg.png); width:59px; height:20px; display:inline-block; margin-left:5px; vertical-align:middle;"></a>
				<a class="password" href="">&nbsp;&nbsp;忘记密码</a>
			</div>
		</div>
	</div>
	<div class="header" style="width:100%;">
		<!-- <img style="width:100%;height:127px;position:absolute;"/> -->
		<div style="width:1006px;height:auto;margin-left:auto;margin-right:auto;position:relative"> 
			<object id="FlashID" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="1006" height="127">
				<param name="movie" value="<%=path%>/images/banner.swf" />
				<param name="quality" value="high" />
				<param name="swfversion" value="8.0.35.0" />
				<!-- 此 param 标签提示使用 Flash Player 6.0 r65 和更高版本的用户下载最新版本的 Flash Player。如果您不想让用户看到该提示，请将其删除。 -->
				<param name="expressinstall" value="<%=path%>/images/expressInstall.swf" />
				<!-- 下一个对象标签用于非 IE 浏览器。所以使用 IECC 将其从 IE 隐藏。 -->
				<!--[if !IE]>-->
				<object type="application/x-shockwave-flash" data="<%=path%>/images/banner.swf" width="1006" height="130">
				<!--<![endif]-->
					<param name="quality" value="high" />
					<param name="swfversion" value="8.0.35.0" />
					<param name="expressinstall" value="<%=path%>/images/expressInstall.swf" />
					<!-- 浏览器将以下替代内容显示给使用 Flash Player 6.0 和更低版本的用户。 -->
					<div>
						<h4>此页面上的内容需要较新版本的 Adobe Flash Player。</h4>
						<p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="获取 Adobe Flash Player" width="112" height="33" /></a></p>
					</div>
				  <!--[if !IE]>-->
				</object>
				<!--<![endif]-->
			</object>
		</div>
	</div>
	<div class="nav">
		<ul>
			<li class="shouye"><a href="<%=basePath%>">首页</a></li>
			<li><a href="<%=path%>/jsp/newMore.jsp?NEW_TYPE=2&NEW_FEN=">学校概况</a></li>
			<li><a href="<%=path%>/jsp/newMore.jsp?NEW_TYPE=3&NEW_FEN=">校园新闻</a></li>
			<li><a href="<%=path%>/jsp/newMore.jsp?NEW_TYPE=4&NEW_FEN=">考试招生</a></li>
			<li><a href="<%=path%>/jsp/newMore.jsp?NEW_TYPE=5&NEW_FEN=">名师名生</a></li>
			<li><a href="<%=path%>/jsp/newMore.jsp?NEW_TYPE=6&NEW_FEN=">课程改革</a></li>
			<li><a href="<%=path%>/jsp/newMore.jsp?NEW_TYPE=7&NEW_FEN=">德育视窗</a></li>
			<!-- <li><a href="<%=path%>/jsp/newMore.jsp?NEW_TYPE=8&NEW_FEN=">校友联谊</a></li> -->
			<li><a href="<%=path%>/jsp/xiaoyou.jsp" target="_blank">校友联谊</a></li>
			<li><a href="<%=path%>/jsp/newMore.jsp?NEW_TYPE=9&NEW_FEN=">国际合作</a></li>
			<li><a href="<%=path%>/jsp/newMore.jsp?NEW_TYPE=10&NEW_FEN=">学校党建</a></li>
			<li><a href="<%=path%>/jsp/newMore.jsp?NEW_TYPE=11&NEW_FEN=">教学资源</a></li>
		</ul>
	</div>
	<div class="clear"></div>
</body>
</html>
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
		<div class="topBox" style="width:100%; margin:5 auto; margin-bottom:2px;">
		    
			<div class="topTools" style="color:#FFFFFF; float :right;width:549px;">
				<span class="localTime">
					<script language="javascript" type="text/javascript" src="<%=path%>/js/date.js"></script>
				</span>
				<a href="#" onclick="this.style.behavior='url(#default#homepage)';this.setHomePage('www.hbhcgz.html');" title="设为首页">设为首页</a>
				<a href="javascript:if(document.all){window.external.addFavorite('www.hbhcgz.html','新洲一中');}else if(window.sidebar){window.sidebar.addPanel('新洲一中', 'http://www.xinzhou.cn','');}" title="加入收藏">加入收藏</a>
			</div>
			 
		 <div class="topTools" style="width:450px;padding:0px 0px 0px 245px;float:left;"><span   style="color: red;font-weight:bold;">欢迎您访问武汉市新洲区第一中学网站！  &nbsp &nbsp &nbsp &nbsp博大 &nbsp &nbsp方正 &nbsp &nbsp尚美 &nbsp &nbsp创新</span> </div>
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
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.huahong.page.dao.IndexDAO"%>
<%@page import="com.huahong.admin.dao.XiaoYouDAO"%>
<%
String path = request.getContextPath();

IndexDAO dao = new IndexDAO();
List listBot = dao.getHotNewList("2");//首页底部热点图片

XiaoYouDAO daoXiaoYou = new XiaoYouDAO();
List xiaoyou = daoXiaoYou.getXiaoYouTopList();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>校友联谊</title>
	<link href="<%=path%>/css/xi/css.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/xi/goodnav.css" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/xiaoyou/index.css"/>
	<script type=text/javascript src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
	<script type=text/javascript src="<%=path%>/js/xiaoyou/slides.jquery.js"></script>
	<script type=text/javascript src="<%=path%>/js/xiaoyou/kefu.js"></script>
	<!-- 解决IE6不缓存背景图片的问题-->
	<script type="text/javascript">document.execCommand("BackgroundImageCache", false, true);</script>
<style>
.roll-news {
	width:480px;
	height:300px;
}
.roll-news-index-hover {
	background-color:white;
}
.roll-news-image img {
	width:480px;
	height:300px;
}
.roll-news-index {
	position:relative;
	top:-30px;
	margin-right:5px;
	float:right;
}
.roll-news-index {
}
.roll-news-index li {
	list-style:none;
	float:left;
	font-size:16px;
	font-weight:600;
	width:18px;
	height:16px;
	line-height:16px;
	cursor:pointer;
	margin:0 3px;
	background-image:url(opacity_50.png);
	text-align:center;
}
.roll-news-title {
	position:relative;
	top:-25px;
	padding-left:10px;
	height:22px;
	line-height:20px;
	background:url(opacity_50.png);
}
.roll-news-title a {
	font-size:12px;
	text-decoration:none;
	color:#222222;
}
.roll-news-title a:hover {
	color:red;
}
.neitop{
	padding-left:40px;padding-top:8px;font-size:14px;color:white;font-weight:bold;display:block;width:100px;float:left;
}
</style>
<script type="text/javascript">
$(function(){
	//保证导航栏背景与图片轮播背景一起显示
	$("#mainbody").removeClass();
	$("#mainbody").addClass("index_bg05");
	
	/***********轮播start********/
	var index=0;
	var slideFlag = true;
	var length=$(".roll-news-image img").length;

	function showImg(i){
		$(".roll-news-image img")
		.eq(i).stop(true,true).fadeIn(800)
		.siblings("img").hide();

		$(".roll-news-index li").removeClass("roll-news-index-hover");
		$(".roll-news-index li").eq(i).addClass("roll-news-index-hover");

		$(".roll-news-title a")
		.eq(i).stop(true,true).fadeIn(800)
		.siblings("a").hide();
	}
	showImg(index);
	
	$(".roll-news-index li").click(function(){
		index = $(".roll-news-index li").index(this);
		showImg(index);
		slideFlag = false;
	});	
	
	function autoSlide() {
		setInterval(function() {
			if(slideFlag) {
				showImg((index+1) % length);
				index = (index+1)%length;
			}
			slideFlag = true;
		}, 3000);
	}
	autoSlide();
	/***********轮播end********/
});
</script>
</head>
<body>
<div class="topmain_1">
	<div class="top_main">
		<div class="top_1">
			<div class="logo_top"><a href="<%=path%>/index.jsp"></a></div>
			<div class="dh_dop">
				<div class="top_caidan"></div>
				<div class="menu_top">
					<ul class="menu_top_ul">
		                <li class="menu_line"><a href="<%=path%>/jsp/xiaoyou.jsp">首页</a></li>
		      			<li class="menu_line"><a href='<%=path%>/jsp/xiaoyouMing.jsp'>校友名录</a></li>
		      			<li class="menu_line"><a href='<%=path%>/jsp/xiaoyouXuanJie.jsp'>校友选介</a></li>
		      			<li class="menu_line"><a href='<%=path%>/jsp/xiaoyouList.jsp?NEW_TYPE=8&NEW_FEN=26'>校友寄语</a></li>
		      			<li class="menu_line"><a href='<%=path%>/jsp/xiaoyouList.jsp?NEW_TYPE=8&NEW_FEN=27'>校友查询</a></li>
		      			<li class="menu_line"><a href='<%=path%>/jsp/xiaoyouList.jsp?NEW_TYPE=8&NEW_FEN=28'>校友登记</a></li>
		      			<li class="menu_line"><a href='<%=path%>/jsp/xiaoyouList.jsp?NEW_TYPE=8&NEW_FEN=29'>学生天地</a></li>
		      			<li class="menu_line"><a href='<%=path%>/jsp/xiaoyouList.jsp?NEW_TYPE=8&NEW_FEN=30'>互动留言</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="mainbody">
	<div id="warp" style="margin-top:5px;height:450px;">
		<div class="nav_index_right_ad">
			<div class="roll-news" style="margin-left:auto;margin-right:auto;width:1000px;height:450px;">
				<div class="roll-news-image">
					<%
					for(int i=0;i<listBot.size();i++){
						if( i==0 )
							out.print("<img style='width:1000px;height:450px;' src='"+path+((HashMap)listBot.get(i)).get("IMG_FILE").toString()+"' />");
						else
							out.print("<img style='width:1000px;height:450px;' src='"+path+((HashMap)listBot.get(i)).get("IMG_FILE").toString()+"' style='display:none' />");
					}
					%>
					<!-- <img style="width:1000px;height:362px;" src="<%=path%>/images/banner1.jpg" />
					<img style="width:1000px;height:362px;" src="<%=path%>/images/banner2.jpg" style="display:none" />
					<img style="width:1000px;height:362px;" src="<%=path%>/images/banner3.jpg" style="display:none" /> -->
				</div>
				<div class="roll-news-index">
					<ul>
						<%
						for(int i=0;i<listBot.size();i++){
							if( i==0 )
								out.print("<li class='roll-news-index-hover'>"+(i+1)+"</li>");
							else
								out.print("<li>"+(i+1)+"</li>");
						}
						%>
						<!-- <li class="roll-news-index-hover">1</li>
						<li>2</li>
						<li>3</li> -->
					</ul>
				</div>
				<!-- <div class="roll-news-title">
					<a href="" target="_blank">图片1：点击后跳转</a>
					<a href="" target="_blank" style="display:none">图片2：点击后跳转</a>
					<a href="" target="_blank" style="display:none">图片3：点击后跳转</a>
				</div> -->
			</div>
		</div>
	</div>
	<div class="container_main" style="margin-top:10px;">
		<div class="tongzhi fdL" style="width:790px;height:240px;">
			<div class="tongzhi_title" style="width:790px;background:url(<%=path%>/css/images/1_06.png)"><div class="neitop">&nbsp;校友选介</div></div>
			<div style="width:790px;padding-left:0px;height:240px;">
				<marquee behavior="scroll" onmouseout=start(); onmouseover=stop(); direction="left" scrollamount="4" >
					<div id="gunDiv" style="width:auto;">
					<ul>
						<%
						int divWd = 0;
						for(int i=0;i<xiaoyou.size();i++){
							out.print("<li style='float:left;'>");
							out.print("<div style='width:200px;height:200px;padding-top:5px;text-align:center;'>");
							out.print("<div style='width:180px;height:150px;border:1px solid #E6E7E7;padding:5px;'>");
							out.print("<a href='"+path+"/jsp/xiaoyouDet.jsp?ID="+((HashMap)xiaoyou.get(i)).get("ID").toString()+"' target='_blank'><img src='"+path+((HashMap)xiaoyou.get(i)).get("PHOTO").toString()+"' style='width:180px;height:150px;'/></a>");
							out.print("</div>");
							out.print("<div style='padding-top:5px;'>"+((HashMap)xiaoyou.get(i)).get("BIYE").toString()+"级&nbsp;"+((HashMap)xiaoyou.get(i)).get("NAME").toString()+"</div>");
							out.print("</div>");
							out.print("</li>");
							divWd += 210;
						}
						%>
						<script>
						var divWd = "<%=divWd%>";
						$("#gunDiv").css({
							"width":divWd+"px"
						});
						</script>
						<!-- <li style="float:left;">
							<div style="width:200px;height:200px;padding-top:5px;text-align:center;">
								<div style="width:180px;height:150px;border:1px solid #E6E7E7;padding:5px;">
									<img src="<%=path%>/images/bght.jpg" style="width:180px;height:150px;"/>
								</div>
								<div style="padding-top:5px;">2005级 王东</div>
							</div>
						</li> -->
					</ul>
					</div>
				</marquee>
			</div>
		</div>
		<div class="leye_left" style="margin-left:10px;margin-top:-13px;width:195px;">
		    <!-- <ul class="lbleft_ul">
		        <li class="lbleft_tab"><a href="#">联系我们</a></li>
		        <li class="lbleft_tab"><a href="#">校友登记</a></li>
		        <li class="lbleft_tab"><a href="#">校友查询</a></li>
		        <li class="lbleft_tab"><a href="#">互动留言</a></li>
		    </ul> -->
		    <ul>
		    	<li style="margin-top:5px;"><div style="width:191px;height:41px;background:url(<%=path%>/images/imgho1.png);color:#BE8B5E;font-weight:bold;line-height:43px;font-size:18px;cursor:pointer;"><font style="margin-left:80px;">联系我们<font></div></li>
		    	<li style="margin-top:5px;"><div style="width:191px;height:41px;background:url(<%=path%>/images/imgho2.gif);color:#BE8B5E;font-weight:bold;line-height:43px;font-size:18px;cursor:pointer;"><font style="margin-left:80px;">校友登记<font></div></li>
		    	<li style="margin-top:5px;"><div style="width:191px;height:41px;background:url(<%=path%>/images/imgho3.gif);color:#BE8B5E;font-weight:bold;line-height:43px;font-size:18px;cursor:pointer;"><font style="margin-left:80px;">校友查询<font></div></li>
		    	<li style="margin-top:5px;"><div style="width:191px;height:41px;background:url(<%=path%>/images/imgho4.gif);color:#BE8B5E;font-weight:bold;line-height:43px;font-size:18px;cursor:pointer;"><font style="margin-left:80px;">互动留言<font></div></li>
		    </ul>
		</div>
	</div>
</div>
<div class="dibu_2">
	<div class="layout hg footer_info">
		<p>地址：湖北省武汉市新洲区邾城街461号&nbsp;&nbsp;86-027-86912869&nbsp;&nbsp;<br />联系电话：86-027-86912869&nbsp;&nbsp;&nbsp;</p>
		<p>鄂ICP备06006059号</p>
	</div>
</div>
</body>
</html>
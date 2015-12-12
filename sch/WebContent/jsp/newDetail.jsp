<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.huahong.page.dao.NewDetailDAO;"%>
<%
String path = request.getContextPath();

String ID = request.getParameter("ID");
NewDetailDAO dao = new NewDetailDAO();
List list = dao.getNew(ID);
String NEW_TITLE = ((HashMap)list.get(0)).get("NEW_TITLE").toString();
String ISSUER_PER = ((HashMap)list.get(0)).get("ISSUER_PER").toString();
String NEW_TIME = ((HashMap)list.get(0)).get("NEW_TIME").toString();
String NEW_CONTENT = ((HashMap)list.get(0)).get("NEW_CONTENT").toString();
String NEW_TYPE = ((HashMap)list.get(0)).get("NEW_TYPE").toString();
String NEW_FEN = ((HashMap)list.get(0)).get("NEW_FEN").toString();
String NEW_NUM = ((HashMap)list.get(0)).get("NEW_NUM").toString();
String NEW_TYPE_NAME = ((HashMap)list.get(0)).get("NEW_TYPE_NAME").toString();
String NEW_FEN_NAME = ((HashMap)list.get(0)).get("NEW_FEN_NAME").toString();
String CHU_NAME = ((HashMap)list.get(0)).get("CHU_NAME").toString();

dao.addNum(ID);
//System.out.println(list);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="UTF-8">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta content="新洲一中" name="Keywords" />
	<meta content="新洲一中" name="Description"/>
	<title>新洲一中</title>
	<link href="<%=path%>/css/default.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/IndexPage.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/css.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/article.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">

</script>
</head>
<body>
<jsp:include page="../pageTop.jsp" flush="true"/>
<div class="wrap" style="background:white;">
	<div id="center_all">
		<div id="main_right_box contactBox">
			<!-- 网站位置导航信息开始 -->
			<div class="r_navigation"> 您现在的位置：<a href="<%=path%>">新洲一中</a>>>
				<a href="<%=path%>/jsp/newMore.jsp?NEW_TYPE=<%=NEW_TYPE%>&NEW_FEN=" target="_blank" title=""><%=NEW_TYPE_NAME%></a>&gt;&gt;
				<a href="<%=path%>/jsp/newMore.jsp?NEW_TYPE=<%=NEW_TYPE%>&NEW_FEN=<%=NEW_FEN%>" target="_self"><%=NEW_FEN_NAME%></a>
			</div>
			<!-- 网站位置导航信息结束 -->
			<div class="c_spacing">
			</div>
			<!-- 主体内容开始 -->
			<div class="c_main_content_box">
				<div class="c_title_text">
					<span><h2><%=NEW_TITLE%></h2></span>
				</div>
				<div class="c_title_author">
					<span>作者：<a href="#"><%=ISSUER_PER%></a></span>
					<span>处室：<a href="#"><%=CHU_NAME%></a></span>
					<span>点击数：<a href="#"><%=NEW_NUM%></a></span>
					<span>发布时间：<%=NEW_TIME%></span>
				</div>
				<!-- 正文 -->
				<div class="c_content_text">
					<div class="c_content_overflow" id="fontzoom">
						<%=NEW_CONTENT%>
					</div>
					<!-- <div class="c_bot_text">
						<span>点击数：</span>
						<span>【字体：<a href="javascript:fontZoomA();" class="top_UserLogin">小</a><a href="javascript:fontZoomB();" class="top_UserLogin">大</a>】</span>
						<span>【<a href="">收藏</a>】</span>
						<span>【<a href="">打印文章</a>】</span>
						<span>【<a href="">查看评论</a>】</span>
					</div> -->
					<!-- <div class="flipOver">
						<p style="float:left;"><font style="color:red">上一篇：</font><a href="" target="_self">第十二周晨会讲话</a>[ 05-25 ]</p>
						<p style="float:right;"><font style="color:red">下一篇：</font><a href="" target="_self">清明节讲话</a>[ 05-25 ]</p>
					</div> -->
				</div>
			</div>
			<!-- 主体内容结束 -->
		</div>
	</div>
</div>
<jsp:include page="../pageBot.jsp" flush="true"/>
</body>
</html>
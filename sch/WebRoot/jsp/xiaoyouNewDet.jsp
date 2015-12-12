<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.huahong.page.dao.NewDetailDAO;"%>
<%
String path = request.getContextPath();

String ID = request.getParameter("ID").toString();
String TITLE = request.getParameter("TITLE").toString();
TITLE = new String(TITLE.getBytes("ISO-8859-1"), "utf-8");

NewDetailDAO dao = new NewDetailDAO();
List list = dao.getNew(ID);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>校友联谊</title>
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/xiaoyou/index.css"/>
	<script type=text/javascript src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
	<script type=text/javascript src="<%=path%>/js/xiaoyou/slides.jquery.js"></script>
	<script type=text/javascript src="<%=path%>/js/xiaoyou/kefu.js"></script>
<script type="text/javascript">

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
<div class="leiye_container" style="height:auto;min-height:400px;">
	<div class="biaoti_top">
		<h1 class="biaoti"><%=TITLE %></h1>
		<div class="biaoti_right">
			<a href="../phpdedewebbluety.demo.aiyiweb.html">首页</a>&nbsp;>&nbsp;<a href=""><%=TITLE %></a>
		</div>
	</div>
	<span class="blank30"></span>
	<div>
		<div class="leye_left">
			<ul class="lbleft_ul">
				<li class="lbleft_tab"><a href="#"><%=TITLE %></a></li>
		    </ul>
		</div>
		<div class="leye_right">
			<h1 class="ly_h1"><%=((HashMap)list.get(0)).get("NEW_TITLE").toString()%></h1>
			<div style="text-align:center; font-size:12px; line-height:30px; color:#999;">作者：<%=((HashMap)list.get(0)).get("ISSUER_PER").toString()%>　发布时间：<%=((HashMap)list.get(0)).get("NEW_TIME").toString()%></div>
			<div class="ly_leirong">
				<%=((HashMap)list.get(0)).get("NEW_CONTENT").toString()%>
			</div>
		</div>
		<div class="cl"></div>
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
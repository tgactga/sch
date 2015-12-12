<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.huahong.admin.dao.XiaoYouDAO;"%>
<%
String path = request.getContextPath();

XiaoYouDAO dao = new XiaoYouDAO();
List listChu = dao.getBiYeList("1");
List listGao = dao.getBiYeList("2");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>校友名录</title>
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
<div class="leiye_container" style="height:auto;min-height:430px;">
	<div class="biaoti_top">
		<h1 class="biaoti">校友名录</h1>
		<div class="biaoti_right">
			<a href="<%=path%>/jsp/xiaoyou.jsp">首页</a>&nbsp;>&nbsp;<a href="#">校友名录</a>
		</div>
	</div>
	<span class="blank30"></span>
	<div>
		<div class="leye_left">
			<ul class="lbleft_ul">
				<li class="lbleft_tab"><a href="#">校友名录</a></li>
		    </ul>
		</div>
		<div class="leye_right">
			<table>
				<tr>
					<td style="height:25px;border-bottom:1px solid #3579c5;font-size:16px;color:#3579c5;"><b style="background-image:url('<%=path%>/images/tit1.jpg');background-repeat:no-repeat;">&nbsp;&nbsp;历届初中毕业生</b></td>
				</tr>
				<tr>
					<td>
						<div style="width:700px;height:auto;padding-top:10px;" id="xiaoyouMingChu">
							<!-- <div style="width:150px;height:25px;float:left;">
								<img src="<%=path%>/images/projpoint.png" style="width:10px;height:10px;"/>&nbsp;
								<a href="">1000届</a>
							</div> -->
							<%
							for(int i=0;i<listChu.size();i++){
								String BIYE = ((HashMap)listChu.get(i)).get("BIYE").toString();
								out.print("<div style='width:150px;height:25px;float:left;'>");
								out.print("<img src='"+path+"/images/projpoint.png' style='width:10px;height:10px;'/>&nbsp;");
								out.print("<a href='"+path+"/jsp/xiaoyouMingDet.jsp?BIYE="+BIYE+"&XIAOYOU_SUO=1' target='_blank'>"+BIYE+"届</a>");
								out.print("</div>");
							}
							%>
						</div>
					</td>
				</tr>
				<tr>
					<td style="height:25px;border-bottom:1px solid #3579c5;font-size:16px;color:#3579c5;"><b style="background-image:url('<%=path%>/images/tit1.jpg');background-repeat:no-repeat;">&nbsp;&nbsp;历届高中毕业生</b></td>
				</tr>
				<tr>
					<td>
						<div style="width:700px;height:auto;padding-top:10px;" id="xiaoyouMingGao">
							<%
							for(int i=0;i<listGao.size();i++){
								String BIYE = ((HashMap)listGao.get(i)).get("BIYE").toString();
								out.print("<div style='width:150px;height:25px;float:left;'>");
								out.print("<img src='"+path+"/images/projpoint.png' style='width:10px;height:10px;'/>&nbsp;");
								out.print("<a href='"+path+"/jsp/xiaoyouMingDet.jsp?BIYE="+BIYE+"&XIAOYOU_SUO=2' target='_blank'>"+BIYE+"届</a>");
								out.print("</div>");
							}
							%>
						</div>
					</td>
				</tr>
			</table>
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
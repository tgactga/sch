<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.huahong.util.CommonFun"%>
<%@page import="com.huahong.page.dao.NewMoreDAO"%>
<%
String path = request.getContextPath();

String NEW_TYPE = request.getParameter("NEW_TYPE").toString();
String NEW_FEN = request.getParameter("NEW_FEN").toString();
String NEW_TITLE = CommonFun.retTitle(NEW_TYPE);

NewMoreDAO dao = new NewMoreDAO();
String NEW_FEN_TITLE = "";
if(!NEW_FEN.equals("")){
	NEW_FEN_TITLE = dao.getFenTitle(NEW_FEN);
}
String FEN_WEB_SHOW = NEW_TITLE;
if(!NEW_FEN_TITLE.equals("")) FEN_WEB_SHOW = NEW_FEN_TITLE;
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
var NEW_TYPE="<%=NEW_TYPE%>";
var NEW_FEN="<%=NEW_FEN%>";
var curPage = 1;//当前页
var total = 0;//总条数
var totalPage = 1;//总页数
var everyEva = 36;//每页显示多少条
$(function(){
	loadData();
})
function first(){
	curPage = 1;
	loadData();
}
function preview(){
	curPage--;
	if(curPage<1) curPage = 1;
	loadData();
}
function next(){
	curPage++;
	if(curPage>totalPage) curPage = totalPage;
	loadData();
}
function last(){
	curPage = totalPage;
	loadData();
}
function chaPage(obj){
	curPage = $(obj).val();
	loadData();
}
function loadData(){
	$.ajax({
		type:"post",
		url:"<%=path%>/NewMoreAction.do",
		dataType:"json",
		data:'operType=showMoreNew&NEW_TYPE='+NEW_TYPE+'&NEW_FEN='+NEW_FEN+'&curPage='+curPage+'&everyEva='+everyEva,
		success:function(data){
			total = data[0].total;
			
			totalPage = Math.ceil(parseInt(total)/everyEva);
			$("#totalPage").text(totalPage);
			$("#curPage").text(curPage);
			$("#page").children().remove();
			$("#NEW_CON").children().remove();
			for(var i=1;i<=totalPage;i++){
				if(i == curPage){
					$("#page").append("<option value='"+i+"' selected>"+i+"</option>");
				}else{
					$("#page").append("<option value='"+i+"'>"+i+"</option>");
				}
			}
			var curWen = 0;
			for(var i=1;i<data.length;i++){
				curWen ++;
				var ID = data[i].ID;
				var NEW_TITLE = data[i].NEW_TITLE;
				var NEW_TIME = data[i].NEW_TIME;
				var NEW_TIMEJ = NEW_TIME.substring(NEW_TIME.indexOf("-")+1, NEW_TIME.length);
				var NEW_NUM = data[i].NEW_NUM;
				$("#NEW_CON").append("<li><span>"+NEW_TIMEJ+"</span><a href='<%=path%>/jsp/xiaoyouNewDet.jsp?ID="+ID+"&TITLE=<%=FEN_WEB_SHOW%>' title='"+NEW_TITLE+"' target='_blank'>"+NEW_TITLE+"</a></li>");
			}
			$("#curWen").text(curWen);
		}
	});
}
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
<div class="leiye_container" style="height:400px;">
	<div class="biaoti_top">
		<h1 class="biaoti"><%=FEN_WEB_SHOW%></h1>
		<div class="biaoti_right">
			<a href="<%=path%>/jsp/xiaoyou.jsp">首页</a>&nbsp;>&nbsp;<a href="#"><%=FEN_WEB_SHOW%></a>
		</div>
	</div>
	<span class="blank30"></span>
	<div>
		<div class="leye_left">
			<ul class="lbleft_ul">
				<li class="lbleft_tab"><a href="#"><%=FEN_WEB_SHOW%></a></li>
		    </ul>
		</div>
		<div class="leye_right">
			<ul class="leibiao_list_ul" id="NEW_CON">
			</ul>
			<div class="cl"></div>
			<span class="blank30"></span>
			<div class="dede_pages">
				<ul class="pagelist">
					<li>
						<div class="class_page">
							<span id="pe100_page_通用信息列表_普通式" class="pagecss">
								<!--{pe.begin.pagination}-->
								<a href="#" onclick="first()">首页</a>
								<a href="#" onclick="preview()">上一页</a>
								<!-- <a href="">1</a>
								<strong>2</strong>
								<a href="">3</a> -->
								<a href="#" onclick="next()">下一页</a>
								<a href="#" onclick="last()">尾页</a>
								页次：<span id="curPage"></span>/<span id="totalPage"></span>页
								<span id="curWen"></span>篇文章/页
								转到第
								<select id='page' onchange="chaPage(this)">
								</select>页
							</span>
						</div>
					</li>
				</ul>
			</div><!-- /pages --> 
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
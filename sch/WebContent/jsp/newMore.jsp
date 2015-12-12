<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.huahong.util.CommonFun"%>
<%@page import="com.huahong.page.dao.NewMoreDAO"%>
<%
String path = request.getContextPath();

String NEW_TYPE = request.getParameter("NEW_TYPE").toString();
String NEW_FEN = request.getParameter("NEW_FEN").toString();
String NEW_TITLE = CommonFun.retTitle(NEW_TYPE);

NewMoreDAO dao = new NewMoreDAO();
List listFen = dao.getFen(NEW_TYPE);
String NEW_FEN_TITLE = "";
if(!NEW_FEN.equals("")){
	NEW_FEN_TITLE = dao.getFenTitle(NEW_FEN);
}
String FEN_WEB_SHOW = NEW_TITLE;
if(!NEW_FEN_TITLE.equals("")) FEN_WEB_SHOW = NEW_FEN_TITLE;
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
	<script language="javascript" type="text/javascript" src="<%=path%>/js/jquery/jquery-1.11.1.min.js"></script>
	<script language="javascript" type="text/javascript" src="<%=path%>/js/common.js"></script>
	<script language="javascript" type="text/javascript" src="<%=path%>/js/scripts.js"></script>
<script type="text/javascript">
var NEW_TYPE="<%=NEW_TYPE%>";
var NEW_FEN="<%=NEW_FEN%>";
var curPage = 1;//当前页
var total = 0;//总条数
var totalPage = 1;//总页数
var everyEva = 15;//每页显示多少条
function treeOnCheck(e, treeId, treeNode) {
	alert();
}
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
				var NEW_TIMEJ = "&nbsp;";
				if(NEW_TIME.length>0) NEW_TIMEJ = NEW_TIME.substring(NEW_TIME.indexOf("-")+1, NEW_TIME.length);
				var NEW_NUM = data[i].NEW_NUM;
				var appstr = "<li><img src='<%=path%>/images/web/common1.gif' /><a href='<%=path%>/jsp/newDetail.jsp?ID="+ID+"' target='_blank' title='标题："+NEW_TITLE+"&#xD;点击数："+NEW_NUM+"&#xD;发表时间："+NEW_TIME+"'>"+NEW_TITLE+"</a>"+NEW_TIMEJ+"</li>";
				$("#NEW_CON").append(appstr);
			}
			$("#curWen").text(curWen);
		}
	});
}
function showNewDet(fenId){
	location.replace("<%=path%>/jsp/newMore.jsp?NEW_TYPE=<%=NEW_TYPE%>&NEW_FEN="+fenId);
}
</script>
</head>
<body>
<jsp:include page="../pageTop.jsp" flush="true"/>
<div id="center_all">
	<div id="main_bg">
		<div id="main_right">
			<div id="main_right_box">
				<!-- 右侧二列开始 -->
    			<div class="c_main">
					<!-- 网站位置导航信息开始 -->
					<div class="r_navigation">
						您现在的位置：<a href="<%=path%>">新洲一中</a>>>
						<a href="#" target="_self" title="<%=NEW_TITLE%>"><%=NEW_TITLE%></a>
					</div>
					<!-- 网站位置导航信息结束 -->
					<div class="c_spacing"></div>
					<!-- 子栏目列表信息列表开始 -->
					<div class="childclasslist_box">
						<h3><%=FEN_WEB_SHOW%></h3>
						<ul class="listStyle1" id="NEW_CON">
						</ul>
         				</div>
					<!-- 子栏目列表信息列表结束 -->
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
				<div class="clearbox"></div>
			</div>
			<!-- 右侧二列结束 -->
			<div class="c_spacing"></div>
			<!-- 最新图片文章开始 -->
			<!-- <div class="c_main_one">
				<dl>
					<dt class="c_title">
						<div class="more"></div>
						<a href="#">最新图文</a>
					</dt>
					<dd class="c_content">
						<div class="a_photo_list"> 
							<li>
								<div class="pe_u_thumb">
									<a href="http://www.hbhcgz.cn/Item/4218.aspx" target="_blank">
										<img src="../UploadFiles/Article/2014/5/201405140835388360.jpg" alt="汉川高中顺利通过孝感市示范高中复评" width="160" height="120" border="0" />
									</a>
								</div>
 									<div class="pe_u_thumb_title">
 										<a href="http://www.hbhcgz.cn/Item/4218.aspx" target="_blank">汉川高中顺利通过孝感市…</a><br/>…
 									</div>
							</li>
							<div class="clearbox"></div>
						</div>
					</dd>
				</dl>
			</div> -->
			<!-- 最新图片文章结束 -->
		</div>
	</div>
       <!--侧栏开始-->
       <div class="sidebar">
		<div id="sideBar"> 
			<div class="left_box">
				<dl>
					<dt><em>栏目导航</em></dt>
					<dd style="height:500px;">
						<ul>
							<%
							if(listFen!=null && listFen.size()>0){
								for(int i=0;i<listFen.size();i++){
									String FENID = ((HashMap)listFen.get(i)).get("ID").toString();
									String CONTENT = ((HashMap)listFen.get(i)).get("CONTENT").toString();
									out.print("<li style='padding-top:2px;padding-bottom:3px;cursor:pointer;'><div onclick=\"showNewDet(\'"+FENID+"\')\" style='width:181px;height:43px;background:url("+path+"/images/web/kandian.gif)'><div style='padding-left:30px;padding-top:10px;font-size:14px;font-weight:bold;color:#236F8F'>"+CONTENT+"</div></div></li>");
								}
							}
							%>
							<!-- <li style="padding-top:2px;padding-bottom:3px;cursor:pointer;"><div style="width:181px;height:43px;background:url(<%=path%>/images/web/kandian.gif)"><div style="padding-left:30px;padding-top:10px;font-size:14px;font-weight:bold;color:#236F8F">校园新闻</div></div></li> -->
						</ul>
					</dd>
				</dl>
			</div>
		</div>
		<div class="clearbox"></div>
	</div>
	<!--侧栏结束-->
</div>
<jsp:include page="../pageBot.jsp" flush="true"/>
</body>
</html>
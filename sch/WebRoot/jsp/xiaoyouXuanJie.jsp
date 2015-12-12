<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();

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
var curPage = 1;//当前页
var total = 0;//总条数
var totalPage = 1;//总页数
var everyEva = 9;//每页显示多少条
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
		url:"<%=path%>/XiaoYouAction.do",
		dataType:"json",
		data:'operType=searchPageContract&curPage='+curPage+'&everyEva='+everyEva,
		success:function(data){
			total = data[0].total;
			
			totalPage = Math.ceil(parseInt(total)/everyEva);
			$("#totalPage").text(totalPage);
			$("#curPage").text(curPage);
			$("#page").children().remove();
			$("#xiaoyou").children().remove();
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
				var appstr = "<div style='width:200px;height:200px;padding-top:5px;text-align:center;float:left;'>";
				appstr += "<div style='width:180px;height:150px;border:1px solid #E6E7E7;padding:5px;'>";
				appstr += "<a href='<%=path%>/jsp/xiaoyouDet.jsp?ID="+data[i].ID+"' target='_blank'><img src='<%=path%>"+data[i].PHOTO+"' style='width:180px;height:150px;'/></a>";
				appstr += "</div>";
				appstr += "<div style='padding-top:5px;'>"+data[i].BIYE+"级 "+data[i].NAME+"</div>";
				appstr += "</div>";
				$("#xiaoyou").append(appstr);
			}
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
<div class="leiye_container" style="height:700px;">
	<div class="biaoti_top">
		<h1 class="biaoti">校友选介</h1>
		<div class="biaoti_right">
			<a href="<%=path%>/jsp/xiaoyou.jsp">首页</a>&nbsp;>&nbsp;<a href="#">校友选介</a>
		</div>
	</div>
	<span class="blank30"></span>
	<div>
		<div class="leye_left">
			<ul class="lbleft_ul">
				<li class="lbleft_tab"><a href="#">校友选介</a></li>
		    </ul>
		</div>
		<div class="leye_right">
			<div style="width:100%;height:600px;" id="xiaoyou">
				<!-- <div style="width:200px;height:200px;padding-top:5px;text-align:center;float:left;">
					<div style="width:180px;height:150px;border:1px solid #E6E7E7;padding:5px;">
						<img src="<%=path%>/images/bght.jpg" style="width:180px;height:150px;"/>
					</div>
					<div style="padding-top:5px;">2005级 王东</div>
				</div> -->
			</div>
			<div class="dede_pages" style="margin-top:10px;">
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
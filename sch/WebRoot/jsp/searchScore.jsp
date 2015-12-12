<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.huahong.score.dao.*;"%>
<%
String path = request.getContextPath();

Calendar cal = Calendar.getInstance();
int year = cal.get(Calendar.YEAR);

HashMap map = new HashMap();
map.put("condition", "");
map.put("page", "0");
map.put("rp", "200");
ClassManagementDAO cDao = new ClassManagementDAO();
List cList = cDao.searchClassList(map);
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
	<script src="<%=path%>/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<style>
table thead tr td{
	height:30px;
	background:#E6F2F9;
	font-size:14px;
	color:#007AE9;
	text-align:center;
	font-weight:bold;
	border-bottom:1px solid #CCE8F4;
	border-right:1px solid #CCE8F4
}
table tbody tr td{
	height:30px;
	font-size:14px;
	text-align:center;
	font-weight:bold;
	border-bottom:1px solid #CCE8F4;
	border-right:1px solid #CCE8F4
}
</style>
<script type="text/javascript">
function search(){
	var SCORE_GRADE = $("#SCORE_GRADE").val();
	var SCORE_CLASS = $("#SCORE_CLASS").val();
	var STU_NAME = $("#STU_NAME").val();
	if(STU_NAME==""){
		$("#STU_NAME").focus();
		alert("请输入姓名");
		return;
	}
	$("#studentTab").children().eq(1).children().remove();
	$("#scoreTd").css({
		"display":"none"
	});
	$("#scoreTd").children().eq(1).children().remove();
	$.ajax({
		type:"post",
		url:"<%=path%>/ScoreManagementAction.do",
		dataType:"json",
		data:'operType=searchSt&SCORE_GRADE='+encodeURIComponent(SCORE_GRADE)+'&SCORE_CLASS='+encodeURIComponent(SCORE_CLASS)+'&STU_NAME='+encodeURIComponent(STU_NAME),
		success:function(data){
			if(data.length>0){
				for(var i=0;i<data.length;i++){
					var inStr = "<tr>";
					inStr += "<td>"+data[i].SCORE_NO+"</td>";
					inStr += "<td>"+data[i].SCORE_GRADE+"</td>";
					inStr += "<td>"+data[i].SCORE_CLASS+"</td>";
					inStr += "<td>"+data[i].STU_SEX+"</td>";
					inStr += "<td>"+data[i].STU_NAME+"</td>";
					inStr += "<td><a href='javascript:void(0);' onclick='searchScore(this)' style='color:#007AE9'>查询成绩</a></td>";
					inStr += "</tr>";
					$("#studentTab").children().eq(1).append(inStr);
				}
			}else{
				alert("未找到该学生的相关信息，请核对后重试");
			}
		}
	});
}
function searchScore(obj){
	var SCORE_NO = $(obj).parent().parent().children().eq(0).text();
	$.ajax({
		type:"post",
		url:"<%=path%>/ScoreManagementAction.do",
		dataType:"json",
		data:'operType=searchStScore&SCORE_NO='+encodeURIComponent(SCORE_NO),
		success:function(data){
			if(data.length>0){
				$("#scoreTd").css({
					"display":"block"
				});
				for(var i=0;i<data.length;i++){
					var inStr = "<tr>";
					inStr += "<td>"+data[i].SCORE_NO+"</td>";
					inStr += "<td>"+data[i].SCORE_GRADE+"</td>";
					inStr += "<td>"+data[i].SCORE_CLASS+"</td>";
					inStr += "<td>"+data[i].STU_SEX+"</td>";
					inStr += "<td>"+data[i].STU_NAME+"</td>";
					inStr += "<td>"+data[i].AAS+"</td>";
					inStr += "<td>"+data[i].KEMU+"</td>";
					inStr += "<td>"+data[i].CHINESE+"</td>";
					inStr += "<td>"+data[i].KEMATCH+"</td>";
					inStr += "<td>"+data[i].ENGLISH+"</td>";
					inStr += "<td>"+data[i].PHYSICAL+"</td>";
					inStr += "<td>"+data[i].CHEMISTRY+"</td>";
					inStr += "<td>"+data[i].BIOLOGICAL+"</td>";
					inStr += "<td>"+data[i].HISTORY+"</td>";
					inStr += "<td>"+data[i].POLITY+"</td>";
					inStr += "<td>"+data[i].GEOGRAPHY+"</td>";
					inStr += "<td>"+data[i].TOTAL_SCORE+"</td>";
					inStr += "</tr>";
					$("#scoreTd").children().eq(1).append(inStr);
				}
			}else{
				alert("未找到该学生的成绩信息，请核对后重试");
			}
		}
	});
}
</script>
</head>
<body>
<jsp:include page="../pageTop.jsp" flush="true"/>
<div class="wrap" style="background:white;">
	<div id="center_all">
		<div id="main_right_box contactBox">
			<!-- 网站位置导航信息开始 -->
			<div class="r_navigation"> 您现在的位置：<a href="<%=path%>">新洲一中</a>>>
				<a href="#" target="_blank" title="">学生成绩查询</a>
			</div>
			<div class="c_main_content_box">
			<!-- 标题 -->
			<div class="c_title_text">
				<h1>学生成绩查询</h1>
			</div>
			<div style="height:300px;">
				<div style="text-align:center;font-size:14px;">
					年级：<select id="SCORE_GRADE" style="border:1px solid #CCE8F4;font-size:14px;"><option value="">请选择年级</option><option value="高一">高一</option><option value="高二">高二</option><option value="高三">高三</option></select>
					班级：<select id="SCORE_CLASS" style="border:1px solid #CCE8F4;font-size:14px;">
							<option value="">请选择班级</option>
							<%
							if(cList!=null && cList.size()>0){
								for(int i=0;i<cList.size();i++){
									String CLASS_NAME = ((HashMap)cList.get(i)).get("CLASS_NAME").toString();
									out.print("<option value='"+CLASS_NAME+"'>"+CLASS_NAME+"</option>");
								}
							}
							%>
						</select>&nbsp;
					姓名：<input id="STU_NAME" type="text" style="width:100px;height:20px;border:1px solid #CCE8F4;font-size:14px;"/>
					<input style="width:65px;height:23px;background:url(<%=path%>/images/butbg.png);color:white;border:0px solid black;cursor:pointer;" onclick="search()" value="查询" type="button" />
				</div>
				<table id="studentTab" style="margin-left:auto;margin-right:auto;margin-top:10px;border-top:1px solid #CCE8F4;border-left:1px solid #CCE8F4" cellpadding="0" cellspacing="0" >
					<thead>
						<tr>
							<td width="120px">学号</td>
							<td width="60px">年级</td>
							<td width="60px">班级</td>
							<td width="60px">性别</td>
							<td width="80px">姓名</td>
							<td width="100px">操作</td>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				<table id="scoreTd" style="margin-left:auto;margin-right:auto;margin-top:10px;border-top:1px solid #CCE8F4;border-left:1px solid #CCE8F4;display:none;" cellpadding="0" cellspacing="0" >
					<thead>
						<tr>
							<td width="120px">学号</td>
							<td width="50px">年级</td>
							<td width="50px">班级</td>
							<td width="40px">性别</td>
							<td width="50px">姓名</td>
							<td width="80px">文理科</td>
							<td width="80px">考试名称</td>
							<td width="50px">语文</td>
							<td width="50px">数学</td>
							<td width="50px">英语</td>
							<td width="50px">物理</td>
							<td width="50px">化学</td>
							<td width="50px">生物</td>
							<td width="50px">历史</td>
							<td width="50px">政治</td>
							<td width="50px">地理</td>
							<td width="50px">总分</td>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../pageBot.jsp" flush="true"/>
</body>
</html>
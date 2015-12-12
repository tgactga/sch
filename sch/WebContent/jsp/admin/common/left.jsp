<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.huahong.admin.dao.LeftTreeDAO"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String USER_ID = "";
String USER_CODE = "";
try{
	USER_ID = session.getAttribute("USER_ID").toString();
	USER_CODE = session.getAttribute("USER_CODE").toString();
}catch(Exception e){
	response.setContentType("text/html; charset=utf-8");
	response.sendRedirect(path + "/jsp/admin/login.jsp");
	return;
}

LeftTreeDAO dao = new LeftTreeDAO();
List treeList = dao.searchLeftUserList(USER_ID);
String treeData = "";
if(treeList!=null && treeList.size()>0){
	treeData = "[";
	for(int i=0;i<treeList.size();i++){
		treeData += "{id:"+((HashMap)treeList.get(i)).get("ID")+",";
		treeData += "pId:"+((HashMap)treeList.get(i)).get("PID")+",";
		treeData += "name:\""+((HashMap)treeList.get(i)).get("NAME")+"\",";
		String pat = ((HashMap)treeList.get(i)).get("PATH_FILE").toString();
		if(!pat.equals(""))pat = path+((HashMap)treeList.get(i)).get("PATH_FILE");
		treeData += "pat:\""+pat+"\"},";
	}
	treeData = treeData.substring(0,treeData.length()-1)+"]";
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="x-ua-compatible" content="ie=8"/>
	<link href="<%=path%>/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css"></link>
	<script src="<%=path%>/js/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
	<script src="<%=path%>/js/jquery/jquery.ztree.core-3.5.min.js" type="text/javascript"></script>
	<script src="<%=path%>/js/common.js" type="text/javascript"></script>
<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	font-family: "宋体";
	font-size: 12px;
	color: #333333;
	background-color: #2286C2;
}
td {
	font-family: "宋体";
	font-size: 12px;
	color: #333333;
}
</style>
<script type="text/javascript">
var setting = {
	data: {
		simpleData: {
			enable: true
		}
	},
	callback: {
		onClick: onClick
	}
};
var treeStr = <%=treeData%>;
var zNodes = eval(treeStr);

$(document).ready(function(){
	$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	//根据不同的浏览器做不同的判断
	var taglen = 80;
	var	sHeight = window.parent.document.body.clientHeight;
	$("#contentTree").css({
		"height":sHeight-taglen+"px"
	});
});
function onClick(event, treeId, treeNode, clickFlag) {
	if(treeNode.pat != ""){
		window.parent.document.getElementById("content").src = treeNode.pat;
	}
}
</script>
</head>
<body style="padding-left:3px;">
	<table id="contentTree" width="100%" border="0" cellspacing="0" cellpadding="0" style="height:500px;margin-left:auto;margin-right:auto;">
		<tr>
			<td height="9" bgcolor="#2286C2">&nbsp;</td>
		</tr>
		<tr>
			<td width="8" height="8">
				<img src="<%=path%>/images/blueui/index1_23.gif" width="8" height="29" />
			</td>
			<td width="99%" background="<%=path%>/images/blueui/index1_24.gif" style="padding-bottom:5px;">
			</td>
			<td width="8" height="8">
				<img src="<%=path%>/images/blueui/index1_26.gif" width="8" height="29" />
			</td>
		</tr>
		<tr>
			<td background="<%=path%>/images/blueui/index1_45.gif">
			</td>
			<td bgcolor="#FFFFFF" style="padding: 0 2px 0 2px; vertical-align: top; height: 100%;">
				<table width="100%" border="0" cellpadding="0" cellspacing="5">
					<tr>
						<td>
							<div style="width:150px;height:300px;">
								<ul id="treeDemo" class="ztree"></ul>
							</div>
						</td>
					</tr>                
				</table>
			</td>
			<td background="<%=path%>/images/blueui/index1_47.gif">
			</td>
		</tr>
		<tr>
			<td width="8" height="8">
				<img src="<%=path%>/images/blueui/index1_91.gif" width="8" height="8" />
			</td>
			<td background="<%=path%>/images/blueui/index1_92.gif">
			</td>
			<td width="8" height="8">
				<img src="<%=path%>/images/blueui/index1_93.gif" width="8" height="8" />
			</td>
		</tr>
	</table>
</body>
</html>
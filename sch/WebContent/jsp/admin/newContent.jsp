<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.huahong.util.CommonFun"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String USER_CODE = "";
try{
	USER_CODE = session.getAttribute("USER_CODE").toString();
}catch(Exception e){
	response.setContentType("text/html; charset=utf-8");
	response.sendRedirect(path + "/jsp/admin/login.jsp");
	return;
}

String NEW_TYPE = request.getParameter("NEW_TYPE").toString();
CommonFun fun = new CommonFun();
String title = fun.retTitle(NEW_TYPE);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>新闻信息</title>
    <link href="<%=path%>/css/blueui/style.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/css/flexigridStyle/flexigrid.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/css/jqueryui/jquery-ui-1.10.3.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" type="text/css" />
	<script src="<%=path%>/js/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="<%=path%>/js/jquery/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
	<script src="<%=path%>/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="<%=path%>/js/msgbox/msgbox.js" type="text/javascript"></script>
    <script src="<%=path%>/js/jquery/flexigrid.js" type="text/javascript"></script>
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
</style>
<script>
var Xml=false;
if(window.XMLHttpRequest){
	Xml=new XMLHttpRequest();
}else if(window.ActiveXObject){
	Xml=new ActiveXObject("Msxml2.XMLHTTP");
}
var	sHeight = window.parent.document.body.clientHeight;;
var taglen = 272;

$(function(){
	$("#flexTable").flexigrid({
		url: '<%=path%>/CommonAction.do?operType=searchContract&NEW_TYPE=<%=NEW_TYPE%>&NEW_TITLE_S=&NEW_TIME_START=&NEW_TIME_END=&ISSUER_PER_S=',
		dataType: 'json',
		colModel : [
			{display: '序号', name : 'ROWNUM', width : 30, align: 'center'},
			{display: '新闻分类', name : 'NEW_FEN', width : 100, align: 'center'},
			{display: '新闻标题', name : 'NEW_TITLE', width : 300, align: 'center'},
			{display: '新闻发布时间', name : 'NEW_TIME', width : 100, align: 'center'},
			{display: '发布人', name : 'ISSUER_PER', width : 100, align: 'center'},
			{display: '状态', name : 'AUDIT_TAG', width : 50, align: 'center'},
			{display: '操作', name : 'DEAL', width : 100, align: 'center'}
			],
		errormsg: '发生异常',
		sortname: "ROWNUM",
		sortorder: "asc",
		usepager: true,
		useRp: true,
		rp: 15,
		showTableToggleBtn: false,//设置表格是否可以隐藏
		width: $("#flexTd").outerWidth(),
		height: sHeight-taglen,
		resizable: false,
		showToggleBtn: false,
		procmsg: "正在查询数据，请稍候 ...",
		rp: 20,
		rpOptions: [10, 20, 35, 50, 80, 100],
		pagestat: "显示记录从{from}到{to}，总数 {total} 条",
		nomsg: '没有符合条件的记录存在',
		singleSelect : true//选择单行
	});
	var pagestr = $(".pcontrol").html();
	pagestr = pagestr.replace("Page","当前页");
	pagestr = pagestr.replace("of","共");
	pagestr = pagestr + "页";
	$(".pcontrol").html(pagestr);
	
	$("#add").button().click(function(){
		location.replace("<%=path%>/jsp/admin/newContentAdd.jsp?NEW_TYPE=<%=NEW_TYPE%>");
	});
	$("#search").button().click(function(){
		var NEW_TITLE_S = $("#NEW_TITLE_S").val();
		var NEW_TIME_START = $("#NEW_TIME_START").val();
		var NEW_TIME_END = $("#NEW_TIME_END").val();
		var ISSUER_PER_S = $("#ISSUER_PER_S").val();
		$("#flexTable").flexOptions({
			url: '<%=path%>/CommonAction.do?operType=searchContract&NEW_TYPE=<%=NEW_TYPE%>&NEW_TITLE_S='+encodeURIComponent(NEW_TITLE_S)+'&NEW_TIME_START='+NEW_TIME_START+'&NEW_TIME_END='+NEW_TIME_END+'&ISSUER_PER_S='+encodeURIComponent(ISSUER_PER_S),
			dataType: 'json'
		}).flexReload();
	});
});
function updateNew(ID){
	location.replace("<%=path%>/jsp/admin/newContentUpdate.jsp?NEW_TYPE=<%=NEW_TYPE%>&ID="+ID);
}
</script>
</head>
<body>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td colspan="2">
                <table width="100%" border="0" cellspacing="10" cellpadding="0">
                    <tr>
                        <td width="70%" valign="top">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="8" height="8">
                                        <img src="<%=path%>/images/blueui/index1_28.gif" width="8" height="39" />
                                    </td>
                                    <td width="99%" background="<%=path%>/images/blueui/index1_40.gif">
                                        <table border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td>
                                                    <table width="90" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td width="5">
                                                                <img src="<%=path%>/images/blueui/index1_35.gif" width="5" height="39" />
                                                            </td>
                                                            <td align="center" background="<%=path%>/images/blueui/index1_36.gif">
                                                                <a href="#" class="font3"><strong><%=title%></strong></a>
                                                            </td>
                                                            <td width="5">
                                                                <img src="<%=path%>/images/blueui/index1_38.gif" width="5" height="39" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td width="8" height="8">
                                        <img src="<%=path%>/images/blueui/index1_43.gif" width="8" height="39" />
                                    </td>
                                </tr>
                                <tr>
                                    <td background="<%=path%>/images/blueui/index1_45.gif">
                                    </td>
                                    <td bgcolor="#FFFFFF" style="height: 490px; vertical-align: top;">
                                        <table width="100%" border="0" cellspacing="10" cellpadding="0">
                                            <tr>
                                                <td>
                                                    <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#C4E7FB">
                                                        <tr>
                                                            <td>
                                                                <table width="100%" border="0" cellpadding="0" cellspacing="5" bgcolor="#FFFFFF">
                                                                    <tr>
                                                                        <td align="left">
																			&nbsp;新闻标题：<input id="NEW_TITLE_S" type="text" />&nbsp;&nbsp;
																			&nbsp;新闻发布时间：<input id="NEW_TIME_START" type="text" class="Wdate" style="width:120px;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
																			<img src="<%=path%>/images/blueui/lang.gif" />
																			<input id="NEW_TIME_END" type="text" class="Wdate" style="width:120px;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
																			&nbsp;发布人：<input id="ISSUER_PER_S" type="text" />&nbsp;&nbsp;
																			&nbsp;<input id="search" type="submit" value="搜索"/>
                                                                        	&nbsp;<input id="add" type="submit" value="添加内容"/>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="flexTd">
                                                    <table id="flexTable" style="display:none"></table>
                                                </td>
                                            </tr>
                                        </table>
									</td>
									<td background="<%=path%>/images/blueui/index1_47.gif">
                                    </td>
								</tr>
								<tr>
									<td height=8 width=8><img src="<%=path%>/images/blueui/index1_91.gif" width=8 height=8></td>
									<td background="<%=path%>/images/blueui/index1_92.gif"></td>
									<td height=8 width=8><img src="<%=path%>/images/blueui/index1_93.gif" width=8 height=8></td>
                       			</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>
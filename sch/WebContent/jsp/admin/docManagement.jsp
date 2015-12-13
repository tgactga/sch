<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.huahong.admin.dao.UserManagementDAO"%>
<%@page import="com.huahong.admin.dao.ChuManagementDAO"%>
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

UserManagementDAO dao = new UserManagementDAO();
List roleList = dao.getAllRole();
ChuManagementDAO daoC = new ChuManagementDAO();
List chuList = daoC.searchAllChu();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>用户管理</title>
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
var	sHeight = window.parent.document.body.clientHeight;
var taglen = 272;

$(function(){
	$("#flexTable").flexigrid({
		url: '<%=path%>/UserManagementAction.do?operType=searchAllUser&USER_CODE=',
		dataType: 'json',
		colModel : [
			{display: '序号', name : 'ROWNUM', width : 30, align: 'center'},
			{display: '文件名', name : 'USER_CODE', width : 100, align: 'center'},
			{display: '地址', name : 'USER_NAME', width : 100, align: 'center'},
			/* {display: '处室', name : 'CHU', width : 100, align: 'center'},
			{display: '处室内码', name : 'CHU_ID', width : 100, align: 'center', hide: true},
			{display: '角色', name : 'ROLE_ID', width : 100, align: 'center'},
			{display: '角色内码', name : 'ROLE_ID', width : 100, align: 'center', hide: true},
			{display: '注册日期', name : 'REGIST_TIME', width : 120, align: 'center'}, */
			{display: '上传时间', name : 'LAST_LOGIN_TIME', width : 120, align: 'center'},
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
	
	$("#dialog-add").dialog({
		autoOpen:false,
		height:340,
		width:400,
		modal:true,
		resizable:false,
		buttons:{
			"确定":function(){
				var USER_CODE = $("#USER_CODE").val();
				var USER_PASSWORD = $("#USER_PASSWORD").val();
				var USER_CONPASSWORD = $("#USER_CONPASSWORD").val();
				var USER_NAME = $("#USER_NAME").val();
				var CHU_ID = $("#CHU_ID").val();
				var ROLE_ID = $("#ROLE_ID").val();
				if(USER_CODE == ""){
					msgError("用户名不能为空！");
					return null;
				}
				if(USER_PASSWORD == ""){
					msgError("密码不能为空！");
					return null;
				}
				if(USER_CONPASSWORD == ""){
					msgError("确认密码不能为空！");
					return null;
				}
				if(ROLE_ID == ""){
					msgError("角色不能为空！");
					return null;
				}
				$.ajax({
					type:"post",
					url:"<%=path%>/UserManagementAction.do",
					dataType:"json",
					data:'operType=addUser&USER_CODE='+USER_CODE+'&USER_PASSWORD='+USER_PASSWORD+'&USER_NAME='+USER_NAME+'&CHU_ID='+CHU_ID+'&ROLE_ID='+ROLE_ID,
					success:function(data){
						if(data.SUCCESS == 1){
							$("#flexTable").flexReload();
							$("#dialog-add").dialog("close");
						}else{
							msgError('添加失败');
						}
					}
				});
			},
			"取消": function(){
				$(this).dialog("close");
			}
		},
		close:function(){
			$(this).dialog("close");
		}
	});
	$("#dialog-update").dialog({
		autoOpen:false,
		height:270,
		width:400,
		modal:true,
		resizable:false,
		buttons:{
			"确定":function(){
				var USER_CODE = $("#USER_CODEU").val();
				var USER_NAME = $("#USER_NAMEU").val();
				var CHU_ID = $("#CHU_IDU").val();
				var ROLE_ID = $("#ROLE_IDU").val();
				if(USER_CODE == ""){
					msgError("用户名不能为空！");
					return null;
				}
				if(ROLE_ID == ""){
					msgError("角色不能为空！");
					return null;
				}
				$.ajax({
					type:"post",
					url:"<%=path%>/UserManagementAction.do",
					dataType:"json",
					data:'operType=updateUser&ID='+selId+'&USER_CODE='+USER_CODE+'&USER_NAME='+USER_NAME+'&CHU_ID='+CHU_ID+'&ROLE_ID='+ROLE_ID,
					success:function(data){
						if(data.SUCCESS == 1){
							$("#flexTable").flexReload();
							$("#dialog-update").dialog("close");
						}else{
							msgError('修改失败');
						}
					}
				});
			},
			"取消": function(){
				$(this).dialog("close");
			}
		},
		close:function(){
			$(this).dialog("close");
		}
	});
	$("#add").button().click(function(){
		$("#dialog-add").dialog("open");
	});
	$("#search").button().click(function(){
		var NEW_TITLE_S = $("#NEW_TITLE_S").val();
		var NEW_TIME_START = $("#NEW_TIME_START").val();
		var NEW_TIME_END = $("#NEW_TIME_END").val();
		var ISSUER_PER_S = $("#ISSUER_PER_S").val();
		$("#flexTable").flexOptions({
			url: '<%=path%>/CommonAction.do?operType=searchContract&NEW_TYPE=NEW_TITLE_S='+encodeURIComponent(NEW_TITLE_S)+'&NEW_TIME_START='+NEW_TIME_START+'&NEW_TIME_END='+NEW_TIME_END+'&ISSUER_PER_S='+encodeURIComponent(ISSUER_PER_S),
			dataType: 'json'
		}).flexReload();
	});
});
function editItem(obj){
	$tr = $(obj).parent().parent().parent();
	selId = $tr.attr("ID");
	selId = selId.substring(3, selId.length);
	$("#USER_CODEU").val($tr.children().eq(1).text());
	$("#USER_NAMEU").val($tr.children().eq(2).text());
	$("#CHU_IDU").val($tr.children().eq(4).text());
	$("#ROLE_IDU").val($tr.children().eq(6).text());
	
	$("#dialog-update").dialog("open");
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
                                                                <a href="#" class="font3"><strong>用户管理</strong></a>
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
																			&nbsp;文件名：<input id="NEW_TITLE_S" type="text" />&nbsp;&nbsp;
																			&nbsp; 
																			 
																			<input id="search" type="submit" value="查询"/>
                                                                        	<input id="add" type="submit" value="添加文件" style="float:right;"/>
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
	<div id="dialog-add" title="添加文件" style="font-size:14px;">
		<table style="font-size:14px;margin-top:10px;margin-left:10px;">
			<tr>
				<td style="text-align:right;height:30px;width:100px;">用户名：</td>
				<td style="height:30px;width:300px;"><input id="USER_CODE" type="text" /></td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">密码：</td>
				<td style="height:30px;"><input id="USER_PASSWORD" type="password" /></td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">确认密码：</td>
				<td style="height:30px;"><input id="USER_CONPASSWORD" type="password" /></td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">姓名：</td>
				<td style="height:30px;"><input id="USER_NAME" type="text" /></td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">处室：</td>
				<td style="height:30px;"><select id="CHU_ID" style="width:100px;">
					<option value="">请选择</option>
					<%
					for(int i=0;i<chuList.size();i++){
						out.print("<option value='"+((HashMap)chuList.get(i)).get("ID")+"'>"+((HashMap)chuList.get(i)).get("CHU_NAME")+"</option>");
					}
					%>
				</select></td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">角色：</td>
				<td style="height:30px;"><select id="ROLE_ID" style="width:100px;">
					<option value="">请选择</option>
					<%
					for(int i=0;i<roleList.size();i++){
						out.print("<option value='"+((HashMap)roleList.get(i)).get("ID")+"'>"+((HashMap)roleList.get(i)).get("ROLE_NAME")+"</option>");
					}
					%>
				</select></td>
			</tr>
		</table>
	</div>
	<div id="dialog-update" title="修改用户" style="font-size:14px;">
		<table style="font-size:14px;margin-top:10px;margin-left:10px;">
			<tr>
				<td style="text-align:right;height:30px;width:100px;">用户名：</td>
				<td style="height:30px;width:300px;"><input id="USER_CODEU" type="text" /></td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">姓名：</td>
				<td style="height:30px;"><input id="USER_NAMEU" type="text" /></td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">处室：</td>
				<td style="height:30px;"><select id="CHU_IDU" style="width:100px;">
					<option value="">请选择</option>
					<%
					for(int i=0;i<chuList.size();i++){
						out.print("<option value='"+((HashMap)chuList.get(i)).get("ID")+"'>"+((HashMap)chuList.get(i)).get("CHU_NAME")+"</option>");
					}
					%>
				</select></td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">角色：</td>
				<td style="height:30px;"><select id="ROLE_IDU" style="width:100px;">
					<option value="">请选择</option>
					<%
					for(int i=0;i<roleList.size();i++){
						out.print("<option value='"+((HashMap)roleList.get(i)).get("ID")+"'>"+((HashMap)roleList.get(i)).get("ROLE_NAME")+"</option>");
					}
					%>
				</select></td>
			</tr>
		</table>
	</div>
</body>
</html>
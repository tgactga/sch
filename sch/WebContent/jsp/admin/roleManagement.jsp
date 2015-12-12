<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>角色管理</title>
    <link href="<%=path%>/css/blueui/style.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/css/flexigridStyle/flexigrid.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/css/jqueryui/jquery-ui-1.10.3.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" type="text/css" />
	<script src="<%=path%>/js/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="<%=path%>/js/jquery/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
	<script src="<%=path%>/js/jquery/jquery.ztree.core-3.5.min.js" type="text/javascript"></script>
	<script src="<%=path%>/js/jquery/jquery.ztree.excheck-3.5.min.js" type="text/javascript"></script>
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
var	sHeight = window.parent.document.body.clientHeight;;
var taglen = 272;

$(function(){
	$("#flexTable").flexigrid({
		url: '<%=path%>/RoleManagementAction.do?operType=searchRole&ROLE_NAME=',
		dataType: 'json',
		colModel : [
			{display: '序号', name : 'ROWNUM', width : 30, align: 'center'},
			{display: '角色编号', name : 'ROLE_CODE', width : 80, align: 'center'},
			{display: '角色名', name : 'ROLE_NAME', width : 120, align: 'center'},
			{display: '描述', name : 'ROLE_DESCRIBE', width : 300, align: 'center'},
			{display: '权限', name : 'ROLE', width : 70, align: 'center'},
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
		$("#dialog-add").dialog("open");
	});
	
	$("#dialog-add").dialog({
		autoOpen:false,
		height:320,
		width:400,
		modal:true,
		resizable:false,
		buttons:{
			"确定":function(){
				var ROLE_CODE = $("#ROLE_CODE").val();
				var ROLE_NAME = $("#ROLE_NAME").val();
				var ROLE_DESCRIBE = $("#ROLE_DESCRIBE").val();
				$.ajax({
					type:"post",
					url:"<%=path%>/RoleManagementAction.do",
					dataType:"json",
					data:'operType=addRole&ROLE_CODE='+encodeURIComponent(ROLE_CODE)+'&ROLE_NAME='+encodeURIComponent(ROLE_NAME)+'&ROLE_DESCRIBE='+encodeURIComponent(ROLE_DESCRIBE),
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
		height:320,
		width:400,
		modal:true,
		resizable:false,
		buttons:{
			"确定":function(){
				var ROLE_CODE = $("#ROLE_CODEU").val();
				var ROLE_NAME = $("#ROLE_NAMEU").val();
				var ROLE_DESCRIBE = $("#ROLE_DESCRIBEU").val();
				$.ajax({
					type:"post",
					url:"<%=path%>/RoleManagementAction.do",
					dataType:"json",
					data:'operType=updateRole&ID='+encodeURIComponent(selId)+'&ROLE_CODE='+encodeURIComponent(ROLE_CODE)+'&ROLE_NAME='+encodeURIComponent(ROLE_NAME)+'&ROLE_DESCRIBE='+encodeURIComponent(ROLE_DESCRIBE),
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
	$("#dialog-quan").dialog({
		autoOpen:false,
		height:320,
		width:400,
		modal:true,
		resizable:false,
		buttons:{
			"确定":function(){
				var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
				var nodes = treeObj.getCheckedNodes(true);
				var nodeId = "";
				for(var i=0;i<nodes.length;i++){
					nodeId += nodes[i].id + "☆";
				}
				nodeId = nodeId.substring(0, nodeId.length-1);
				$.ajax({
					type:"post",
					url:"<%=path%>/RoleManagementAction.do",
					dataType:"json",
					data:'operType=assignPermissions&ID='+selId+'&NODEID='+nodeId,
					success:function(data){
						if(data.SUCCESS == 1){
							$("#flexTable").flexReload();
							$("#dialog-quan").dialog("close");
						}else{
							msgError('分配权限失败');
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
});
function editItem(obj){
	$tr = $(obj).parent().parent().parent();
	selId = $tr.attr("ID");
	selId = selId.substring(3, selId.length);
	$("#ROLE_CODEU").val($tr.children().eq(1).text());
	$("#ROLE_NAMEU").val($tr.children().eq(2).text());
	$("#ROLE_DESCRIBEU").val($tr.children().eq(3).text());

	$("#dialog-update").dialog("open");
}
function shouquan(obj){
	$tr = $(obj).parent().parent().parent();
	selId = $tr.attr("ID");
	selId = selId.substring(3, selId.length);
	var setting = {
		check: {
			enable: true
		},data: {
			simpleData: {
				enable: true
			}
		}
	};
	$.ajax({
		type:"post",
		url:"<%=path%>/RoleManagementAction.do",
		dataType:"json",
		data:'operType=showRoleTree&ID='+selId,
		success:function(data){
			$.fn.zTree.init($("#treeDemo"), setting, data);
		}
	});

	$("#dialog-quan").dialog("open");
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
                                                                <a href="#" class="font3"><strong>角色管理</strong></a>
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
																			&nbsp;角色名称：<input id="NEW_TITLE_S" type="text" />&nbsp;&nbsp;
																			<input id="search" type="submit" value="查询"/>
                                                                        	<input id="add" type="submit" value="添加角色" style="float:right;"/>
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
	<div id="dialog-add" title="添加角色" style="font-size:14px;">
		<table style="font-size:14px;margin-top:10px;margin-left:10px;">
			<tr>
				<td style="text-align:right;height:30px;width:100px;">角色编号：</td>
				<td style="height:30px;width:300px;"><input id="ROLE_CODE" type="text" /></td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">角色名称：</td>
				<td style="height:30px;"><input id="ROLE_NAME" type="text" /></td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">描述：</td>
				<td style="height:30px;"><textarea id="ROLE_DESCRIBE" style="width:250px;height:100px;"></textarea></td>
			</tr>
		</table>
	</div>
	<div id="dialog-update" title="编辑角色" style="font-size:14px;">
		<table style="font-size:14px;margin-top:10px;margin-left:10px;">
			<tr>
				<td style="text-align:right;height:30px;width:100px;">角色编号：</td>
				<td style="height:30px;width:300px;"><input id="ROLE_CODEU" type="text" /></td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">角色名称：</td>
				<td style="height:30px;"><input id="ROLE_NAMEU" type="text" /></td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">描述：</td>
				<td style="height:30px;"><textarea id="ROLE_DESCRIBEU" style="width:250px;height:100px;"></textarea></td>
			</tr>
		</table>
	</div>
	<div id="dialog-quan" title="授权树" style="font-size:14px;">
		<table style="font-size:14px;margin-top:5px;margin-left:5px;">
			<tr>
				<td style="height:30px;width:300px;"><ul id="treeDemo" class="ztree"></ul></td>
			</tr>
		</table>
	</div>
</body>
</html>
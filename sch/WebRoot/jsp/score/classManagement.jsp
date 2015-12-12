<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.huahong.util.CommonFun"%>
<%@ page import="com.huahong.score.dao.*"%>
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

Calendar cal = Calendar.getInstance();
int year = cal.get(Calendar.YEAR);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>班级管理</title>
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
var sHeight = window.parent.document.body.clientHeight;
var taglen = 265;
$(function(){
	$("#flexTable").flexigrid({
		url: '<%=path%>/ClassManagementAction.do?operType=searchClass',
		dataType: 'json',
		colModel : [
			{display: '序号', name : 'ROWNUM', width : 30, align: 'center'},
			{display: '班级名称', name : 'MICCODE', width : 100, align: 'center'},
			{display: '操作', name : 'MICCODE', width : 100, align: 'center'}
		],
		errormsg: '发生异常',
		sortname: "ROWNUM",
		sortorder: "asc",
		usepager: true,
		useRp: true,
		showTableToggleBtn: false,//设置表格是否可以隐藏
		width: $("#flexTd").outerWidth(),
		height: sHeight - taglen,
		resizable: false,
		showToggleBtn: false,
		procmsg: "正在查询数据，请稍候 ...",
		rp: 20,
		rpOptions: [10, 20, 35, 50],
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
		height:170,
		width:450,
		modal:true,
		resizable:false,
		buttons:{
			"确定":function(){
				var CLASS_NAME = $("#CLASS_NAME").val();
				if(CLASS_NAME==""){
					msgError('请填写班级！');
					return;
				}
				$.ajax({
					type:"post",
					url:"<%=path%>/ClassManagementAction.do",
					dataType:"json",
					data:'operType=addClass&CLASS_NAME='+encodeURIComponent(CLASS_NAME),
					success:function(data){
						if(data == "1"){
							$("#dialog-add").dialog("close");
							msgSuccessLoadGrid('添加班级成功');
						}else{
							msgError('添加班级失败');
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
		height:170,
		width:450,
		modal:true,
		resizable:false,
		buttons:{
			"确定":function(){
				var CLASS_NAME = $("#CLASS_NAMEU").val();
				if(CLASS_NAME==""){
					msgError('请填写班级！');
					return;
				}
				$.ajax({
					type:"post",
					url:"<%=path%>/ClassManagementAction.do",
					dataType:"json",
					data:'operType=updateClass&ID='+selId+'&CLASS_NAME='+encodeURIComponent(CLASS_NAME),
					success:function(data){
						if(data == "1"){
							$("#dialog-update").dialog("close");
							msgSuccessLoadGrid('修改班级成功');
						}else{
							msgError('修改班级失败');
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
});
function updateData(obj){
	var $tr = $(obj).parent().parent().parent();
	selId = $tr.attr("ID");
	selId = selId.substring(3, selId.length);
	$("#CLASS_NAMEU").val($tr.children().eq(1).text().trim());
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
                                                                <a href="#" class="font3"><strong>班级管理</strong></a>
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
																			<input id="add" type="button" value="添加"/>&nbsp;
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
	<div id="dialog-add" title="添加班级">
		<table style="font-size:16px;margin-top:10px;margin-left:10px;margin-right:10px;">
			<tr>
				<td style="width:35%;font-size:15px;height:30px;text-align:right;">班级：</td>
				<td style="width:65%;font-size:15px;"><input id="CLASS_NAME" type="text" /></td>
			</tr>
		</table>
	</div>
	<div id="dialog-update" title="修改班级">
		<table style="font-size:16px;margin-top:10px;margin-left:10px;margin-right:10px;">
			<tr>
				<td style="width:35%;font-size:15px;height:30px;text-align:right;">班级：</td>
				<td style="width:65%;font-size:15px;"><input id="CLASS_NAMEU" type="text" /></td>
			</tr>
		</table>
	</div>
</body>
</html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.huahong.util.CommonFun"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

Calendar c = Calendar.getInstance();
int year = c.get(Calendar.YEAR);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>校友名录</title>
    <link href="<%=path%>/css/blueui/style.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/css/flexigridStyle/flexigrid.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/css/jqueryui/jquery-ui-1.10.3.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/css/button.css" rel="stylesheet" />
	<script src="<%=path%>/js/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="<%=path%>/js/jquery/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
    <script src="<%=path%>/js/jquery/jquery.form.js" type="text/javascript"></script>
	<script src="<%=path%>/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="<%=path%>/js/msgbox/msgbox.js" type="text/javascript"></script>
    <script src="<%=path%>/js/jquery/flexigrid.js" type="text/javascript"></script>
    <script src="<%=path%>/js/common.js" type="text/javascript"></script>
    <script src="<%=path%>/js/basecom.js" type="text/javascript"></script>
    
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
var taglen = 242;

$(function(){
	$("#flexTable").flexigrid({
		url: '<%=path%>/XiaoYouAction.do?operType=searchXiaoYouMing',
		dataType: 'json',
		colModel : [
			{display: '序号', name : 'ROWNUM', width : 30, align: 'center'},
			{display: '姓名', name : 'NEW_FEN', width : 100, align: 'center'},
			{display: '班级', name : 'NEW_TITLE', width : 100, align: 'center'},
			{display: '毕业时间', name : 'NEW_TIME', width : 100, align: 'center'},
			{display: '毕业生所属', name : 'TOP_SHOW', width : 130, align: 'center'},
			{display: '毕业生所属', name : 'TOP_SHOW', width : 130, align: 'center', hide:true},
			{display: '操作', name : 'DEAL', width : 100, align: 'center'}
			],
		buttons : [
			{displayname:'添加',name: '添加', bclass: 'add', onpress: button},
			{displayname:'导入',name: '导入', bclass: 'import', onpress: button},
			{displayname:'导出模板',name: '导出模板', bclass: 'export', onpress: button},
			{separator: true}
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
		height:320,
		width:400,
		modal:true,
		resizable:false,
		buttons:{
			"确定":function(){
				var XIAOYOU_NAME = $("#XIAOYOU_NAME").val();
				var XIAOYOU_CLASS = $("#XIAOYOU_CLASS").val();
				var BIYE = $("#BIYE").val();
				var XIAOYOU_SUO = $("#XIAOYOU_SUO").val();
				$.ajax({
					type:"post",
					url:"<%=path%>/XiaoYouAction.do",
					dataType:"json",
					data:'operType=addXiaoYouMing&XIAOYOU_NAME='+encodeURIComponent(XIAOYOU_NAME)+'&XIAOYOU_CLASS='+encodeURIComponent(XIAOYOU_CLASS)+'&BIYE='+BIYE+'&XIAOYOU_SUO='+XIAOYOU_SUO,
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
				var XIAOYOU_NAME = $("#XIAOYOU_NAMEU").val();
				var XIAOYOU_CLASS = $("#XIAOYOU_CLASSU").val();
				var BIYE = $("#BIYEU").val();
				var XIAOYOU_SUO = $("#XIAOYOU_SUOU").val();
				$.ajax({
					type:"post",
					url:"<%=path%>/XiaoYouAction.do",
					dataType:"json",
					data:'operType=updateXiaoYouMing&ID='+encodeURIComponent(selId)+'&XIAOYOU_NAME='+encodeURIComponent(XIAOYOU_NAME)+'&XIAOYOU_CLASS='+encodeURIComponent(XIAOYOU_CLASS)+'&BIYE='+BIYE+'&XIAOYOU_SUO='+XIAOYOU_SUO,
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
	$("#dialog-imp").dialog({
		autoOpen:false,
		height:170,
		width:400,
		modal:true,
		resizable:false,
		buttons:{
			"确定":function(){
				showProcess("正在玩命导入中...");
				$('#impForm').ajaxSubmit(function(data){
					if(data == "1"){
						$("#dialog-imp").dialog("close");
						closeProcess();
						msgSuccessLoadGrid('导入成功');
					}else{
						closeProcess();
						msgError('导入失败，请稍后重试！');
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
function button(com,grid){
	if(com == "添加"){
		$("#dialog-add").dialog("open");
	}else if(com == "导入"){
		$("#dialog-imp").dialog("open");
	}else if(com == "导出模板"){
		window.open("<%=path%>/jsp/common/download.jsp?url=/export/model/xiaoyou.xls&FILE_NAME=xiaoyou.xls", "_self");
	}
}
function update(obj){
	$tr = $(obj).parent().parent().parent();
	selId = $tr.attr("ID");
	selId = selId.substring(3, selId.length);
	$("#XIAOYOU_NAMEU").val($tr.children().eq(1).text());
	var XIAOYOU_CLASSU = $tr.children().eq(2).text();
	XIAOYOU_CLASSU = XIAOYOU_CLASSU.substring(0, XIAOYOU_CLASSU.length-1);
	$("#XIAOYOU_CLASSU").val(XIAOYOU_CLASSU);
	$("#BIYEU").val($tr.children().eq(3).text());
	$("#XIAOYOU_SUOU").val($tr.children().eq(5).text());
	
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
                                                                <a href="#" class="font3"><strong>校友名录</strong></a>
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
									<td background="<%=path%>/images/blueui/index1_92.gif">&lt;</td>
									<td height=8 width=8><img src="<%=path%>/images/blueui/index1_93.gif" width=8 height=8></td>
                       			</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<div id="dialog-add" title="添加名录" style="font-size:14px;">
		<table style="font-size:14px;margin-top:10px;margin-left:10px;">
			<tr>
				<td style="text-align:right;height:30px;width:150px;">姓名：</td>
				<td style="height:30px;width:300px;"><input id="XIAOYOU_NAME" type="text" /></td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">班级：</td>
				<td style="height:30px;">
					<select id="XIAOYOU_CLASS" style="width:50px;">
						<option value="一">一</option>
						<option value="二">二</option>
						<option value="三">三</option>
						<option value="四">四</option>
						<option value="五">五</option>
						<option value="六">六</option>
						<option value="七">七</option>
						<option value="八">八</option>
						<option value="九">九</option>
						<option value="十">十</option>
						<option value="十一">十一</option>
						<option value="十二">十二</option>
						<option value="十三">十三</option>
						<option value="十四">十四</option>
						<option value="十五">十五</option>
						<option value="十六">十六</option>
						<option value="十七">十七</option>
						<option value="十八">十八</option>
					</select>&nbsp;班
				</td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">毕业时间：</td>
				<td style="height:30px;">
					<select id="BIYE" style="width:80px;">
					<%
					for(int i=1930;i<=year;i++){
						out.print("<option value='"+i+"'>"+i+"</option>");
					}
					%>
					</select>&nbsp;年
				</td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">毕业生所属：</td>
				<td style="height:30px;">
					<select id="XIAOYOU_SUO" style="width:140px;">
						<option value="1">历届初中毕业生</option>
						<option value="2">历届高中毕业生</option>
					</select>
				</td>
			</tr>
		</table>
	</div>
	<div id="dialog-update" title="修改名录" style="font-size:14px;">
		<table style="font-size:14px;margin-top:10px;margin-left:10px;">
			<tr>
				<td style="text-align:right;height:30px;width:150px;">姓名：</td>
				<td style="height:30px;width:300px;"><input id="XIAOYOU_NAMEU" type="text" /></td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">班级：</td>
				<td style="height:30px;">
					<select id="XIAOYOU_CLASSU" style="width:50px;">
						<option value="一">一</option>
						<option value="二">二</option>
						<option value="三">三</option>
						<option value="四">四</option>
						<option value="五">五</option>
						<option value="六">六</option>
						<option value="七">七</option>
						<option value="八">八</option>
						<option value="九">九</option>
						<option value="十">十</option>
						<option value="十一">十一</option>
						<option value="十二">十二</option>
						<option value="十三">十三</option>
						<option value="十四">十四</option>
						<option value="十五">十五</option>
						<option value="十六">十六</option>
						<option value="十七">十七</option>
						<option value="十八">十八</option>
					</select>&nbsp;班
				</td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">毕业时间：</td>
				<td style="height:30px;">
					<select id="BIYEU" style="width:80px;">
					<%
					for(int i=1930;i<=year;i++){
						out.print("<option value='"+i+"'>"+i+"</option>");
					}
					%>
					</select>&nbsp;年
				</td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">毕业生所属：</td>
				<td style="height:30px;">
					<select id="XIAOYOU_SUOU" style="width:140px;">
						<option value="1">历届初中毕业生</option>
						<option value="2">历届高中毕业生</option>
					</select>
				</td>
			</tr>
		</table>
	</div>
	<div id="dialog-import" title="批量导入" style="font-size:14px;">
		<table style="font-size:14px;margin-top:10px;margin-left:10px;">
			<tr>
				<td style="text-align:right;height:30px;width:150px;">姓名：</td>
				<td style="height:30px;width:300px;"><input id="XIAOYOU_NAMEU" type="text" /></td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">班级：</td>
				<td style="height:30px;">
					<select id="XIAOYOU_CLASSU" style="width:50px;">
						<option value="一">一</option>
						<option value="二">二</option>
						<option value="三">三</option>
						<option value="四">四</option>
						<option value="五">五</option>
						<option value="六">六</option>
						<option value="七">七</option>
						<option value="八">八</option>
						<option value="九">九</option>
						<option value="十">十</option>
						<option value="十一">十一</option>
						<option value="十二">十二</option>
						<option value="十三">十三</option>
						<option value="十四">十四</option>
						<option value="十五">十五</option>
						<option value="十六">十六</option>
						<option value="十七">十七</option>
						<option value="十八">十八</option>
					</select>&nbsp;班
				</td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">毕业时间：</td>
				<td style="height:30px;">
					<select id="BIYEU" style="width:80px;">
					<%
					for(int i=1930;i<=year;i++){
						out.print("<option value='"+i+"'>"+i+"</option>");
					}
					%>
					</select>&nbsp;年
				</td>
			</tr>
			<tr>
				<td style="text-align:right;height:30px;">毕业生所属：</td>
				<td style="height:30px;">
					<select id="XIAOYOU_SUOU" style="width:140px;">
						<option value="1">历届初中毕业生</option>
						<option value="2">历届高中毕业生</option>
					</select>
				</td>
			</tr>
		</table>
	</div>
	<div id="dialog-imp" title="导入成绩">
		<form id="impForm" action="<%=path%>/XiaoYouAction.do?operType=impXiaoYou" method="post">
			<table style="font-size:16px;margin-top:10px;margin-left:10px;margin-right:10px;">
				<tr>
					<td style="width:25%;font-size:15px;height:30px;text-align:right;">选择文件：</td>
					<td style="width:75%;font-size:15px;"><input type="file" name="file" style="width:250px;border:1px solid #CFEBD5"/></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
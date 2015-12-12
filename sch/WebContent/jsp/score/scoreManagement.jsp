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

HashMap map = new HashMap();
map.put("condition", "");
map.put("page", "0");
map.put("rp", "200");
KaoShiManagementDAO kDao = new KaoShiManagementDAO();
List kList = kDao.searchKaoShiList(map);
ClassManagementDAO cDao = new ClassManagementDAO();
List cList = cDao.searchClassList(map);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>成绩录入</title>
    <link href="<%=path%>/css/blueui/style.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/css/flexigridStyle/flexigrid.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/css/jqueryui/jquery-ui-1.10.3.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" type="text/css" />
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
var sHeight = window.parent.document.body.clientHeight;
var taglen = 265;
$(function(){
	$("#flexTable").flexigrid({
		url: '<%=path%>/ScoreManagementAction.do?operType=searchScore&SCORE_YEAR_S=&SEMESTER_S=&KEMU_S=&SCORE_CLASS_S=&STU_NAME_S=',
		dataType: 'json',
		colModel : [
			{display: '序号', name : 'ROWNUM', width : 30, align: 'center'},
			{display: '年级', name : 'MICCODE1', width : 40, align: 'center'},
			{display: '班级', name : 'MICCODE2', width : 40, align: 'center'},
			{display: '学号', name : 'MICNAME', width : 100, align: 'center'},
			{display: '姓名', name : 'PHONE', width : 70, align: 'center'},
			{display: '性别', name : 'AREA_PRO', width : 40, align: 'center'},
			{display: '文理科', name : 'AREA_CITY', width : 40, align: 'center'},
			{display: '考试名称', name : 'SELLERINF', width : 60, align: 'center'},
			{display: '语文', name : 'SECUREPOS', width : 40, align: 'center'},
			{display: '数学', name : 'SELLERNAME', width : 40, align: 'center'},
			{display: '英语', name : 'JIE_TYPE', width : 40, align: 'center'},
			{display: '物理', name : 'JIE_CODE', width : 40, align: 'center'},
			{display: '化学', name : 'ENTRY_TIME', width : 40, align: 'center'},
			{display: '生物', name : 'LEAVE_TIME', width : 40, align: 'center'},
			{display: '历史', name : 'REMARK', width : 40, align: 'center'},
			{display: '政治', name : 'USER_TAG1', width : 40, align: 'center'},
			{display: '地理', name : 'USER_TAG2', width : 40, align: 'center'},
			{display: '总分', name : 'USER_TAG3', width : 70, align: 'center'}
		],
		errormsg: '发生异常',
		sortname: "ROWNUM",
		sortorder: "asc",
		usepager: true,
		useRp: true,
		rp: 15,
		showTableToggleBtn: false,//设置表格是否可以隐藏
		width: $("#flexTd").outerWidth(),
		height: sHeight - taglen,
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
	$("#search").button().click(function(){
		var SCORE_YEAR_S = $("#SCORE_YEAR_S").val();
		var SEMESTER_S = $("#SEMESTER_S").val();
		var KEMU_S = $("#KEMU_S").val();
		var SCORE_CLASS_S = $("#SCORE_CLASS_S").val();
		var STU_NAME_S = $("#STU_NAME_S").val();
		$("#flexTable").flexOptions({
			url: '<%=path%>/ScoreManagementAction.do?operType=searchScore&SCORE_YEAR_S='+encodeURIComponent(SCORE_YEAR_S)+'&SEMESTER_S='+encodeURIComponent(SEMESTER_S)+'&KEMU_S='+encodeURIComponent(KEMU_S)+'&SCORE_CLASS_S='+encodeURIComponent(SCORE_CLASS_S)+'&STU_NAME_S='+encodeURIComponent(STU_NAME_S),
			dataType: 'json'
		}).flexReload();
	});
	$("#impData").button().click(function(){
		$("#dialog-imp").dialog("open");
	});
	$("#downMode").button().click(function(){
		window.open("<%=path%>/jsp/common/download.jsp?url=/export/model/score.xls&FILE_NAME=score.xls", "_self");
	});
});
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
                                                                <a href="#" class="font3"><strong>成绩录入</strong></a>
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
																			学年：<input id="SCORE_YEAR_S" type="text" style="width:50px;" class="inputstyle" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy'})" value="<%=year%>"/>&nbsp;
																			学期：<select id="SEMESTER_S"><option value="上学期">上学期</option><option value="下学期">下学期</option></select>
																			考试名称：<select id="KEMU_S">
																					<%
																					if(kList!=null && kList.size()>0){
																						for(int i=0;i<kList.size();i++){
																							String KAOSHI_NAME = ((HashMap)kList.get(i)).get("KAOSHI_NAME").toString();
																							out.print("<option value='"+KAOSHI_NAME+"'>"+KAOSHI_NAME+"</option>");
																						}
																					}
																					%>
																				</select>
																			班级：<select id="SCORE_CLASS_S">
																					<option value="">请选择班级</option>
																					<%
																					if(cList!=null && cList.size()>0){
																						for(int i=0;i<cList.size();i++){
																							String CLASS_NAME = ((HashMap)cList.get(i)).get("CLASS_NAME").toString();
																							out.print("<option value='"+CLASS_NAME+"'>"+CLASS_NAME+"</option>");
																						}
																					}
																					%>
																				</select>
																			姓名：<input id="STU_NAME_S" type="text" style="width:70px;" class="inputstyle"/>&nbsp;
																			<input id="search" type="button" value="搜索" />&nbsp;
																			<input id="impData" type="button" value="导入成绩" /> &nbsp;
																			<input id="downMode" type="button" value="下载导入成绩模板" /> &nbsp;
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
	<div id="dialog-imp" title="导入成绩">
		<form id="impForm" action="<%=path%>/ScoreManagementAction.do?operType=impScore" method="post">
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
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.huahong.util.CommonFun"%>
<%@page import="com.huahong.erp.util.GetRecentDate"%>
<%@page import="com.huahong.admin.dao.XiaoYouDAO"%>
<%@page import="com.huahong.util.StringUtils"%>
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

Calendar c = Calendar.getInstance();
int year = c.get(Calendar.YEAR);

GetRecentDate date=new GetRecentDate();
String currentDate=date.getRecentDate("yyyy-MM-dd HH:mm:ss.S");
String curDateStr=currentDate.replaceAll("-","").replaceAll(" ","").replaceAll(":","").replace(".","");//系统当前时间

String ID = request.getParameter("ID").toString();
XiaoYouDAO dao = new XiaoYouDAO();
List list = dao.getNewFileDetail(ID);
String JIANJIE = ((HashMap)list.get(0)).get("JIANJIE").toString();
String TOP_SHOW = ((HashMap)list.get(0)).get("TOP_SHOW").toString();
JIANJIE = StringUtils.replaceBlank(JIANJIE);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>新闻信息-新增</title>
    <link href="<%=path%>/css/blueui/style.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/css/blueui/table.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/css/jqueryui/jquery-ui-1.10.3.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" />
	<script src="<%=path%>/js/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="<%=path%>/js/jquery/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
    <script src="<%=path%>/js/jquery/jquery.form.js" type="text/javascript"></script>
    <script src="<%=path%>/js/msgbox/msgbox.js" type="text/javascript"></script>
    <script src="<%=path%>/js/common.js" type="text/javascript"></script>
	<script src="<%=path%>/js/ckeditor/ckeditor.js" type="text/javascript"></script>
    
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
var swfu;
var	sHeight = window.parent.document.body.clientHeight;;
//根据不同的浏览器做不同的判断
var Sys = getBrowser()
var taglen = 140;

$(function(){
	CKEDITOR.replace("NEW_CONTENT");
	CKEDITOR.instances.NEW_CONTENT.setData('<%=JIANJIE%>');
	var TOP_SHOW = "<%=TOP_SHOW%>";
	if(TOP_SHOW=="1") $("#TOP_SHOW")[0].checked = true;
	
	$("#conTd").css({
		"height":(sHeight-taglen)+"px"
	})
	$("#save").button().click(function(){
		save('0');
	});
	$("#audit").button().click(function(){
		save('1');
	});
	$("#back").button().click(function(){
		location.replace("<%=path%>/jsp/admin/xiaoyou.jsp");
	});
});
function save(AUDIT_TAG){
	$('#addForm').ajaxSubmit(function(data){
		var NAME = $("#NAME").val();
		var BIYE = $("#BIYE").val();
		var PHOTO = $("#PHOTO").val();
		if(PHOTO!=""){
			PHOTO = "/file/imgFile/<%=curDateStr%>.jpg";
		}else{
			PHOTO = "<%=((HashMap)list.get(0)).get("PHOTO")%>";
		}
		var TOP_SHOW = $("#TOP_SHOW")[0].checked;
		if(TOP_SHOW==true) TOP_SHOW = "1";
		else TOP_SHOW = "0";
		var JIANJIE = CKEDITOR.instances.NEW_CONTENT.getData();
		$.ajax({
			type:"post",
			url:"<%=path%>/XiaoYouAction.do",
			dataType:"json",
			data:'operType=updateNew&ID=<%=ID%>&NAME='+encodeURIComponent(NAME)+'&BIYE='+BIYE+'&PHOTO='+PHOTO+'&TOP_SHOW='+TOP_SHOW+'&JIANJIE='+encodeURIComponent(JIANJIE),
			success:function(data){
				if(data.SUCCESS == 1){
					msgSuccessUrl('修改成功', "<%=path%>/jsp/admin/xiaoyou.jsp");
				}else{
					msgError('修改失败');
				}
			}
		});
	});
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
                                                                <a href="#" class="font3"><strong>校友简介-修改</strong></a>
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
                                    <td id="conTd" bgcolor="#FFFFFF" style="height: 100px; vertical-align: top;">
                                        <div id="conDiv" style="width:auto;height:100%;overflow-y:scroll;">
	                                        <table width="100%" border="0" cellspacing="10" cellpadding="0">
	                                            <tr>
	                                                <td>
	                                                    <form id="addForm" action="<%=path%>/jsp/common/imageUpLoad.jsp" encType="multipart/form-data" method="post">
		                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-bottom:1px solid #2286C2;">
		                                                        <tr>
																	<td class="tdfir" align="center" style="width:10%;">姓名</td>
																	<td class="tdSen" align="left" style="width:90%;">
																		<input id="NAME" type="text" style="width:100px;" value="<%=((HashMap)list.get(0)).get("NAME")%>"/>
		                                                            </td>
		                                                        </tr>
		                                                        <tr>
																	<td class="tdfir" align="center" style="width:10%;">毕业时间</td>
																	<td class="tdSen" align="left" style="width:90%;">
																		<select id="BIYE" style="width:100px;">
																		<%
																		for(int i=1930;i<=year;i++){
																			if(String.valueOf(i).equals(((HashMap)list.get(0)).get("BIYE").toString()))
																				out.print("<option value='"+i+"' selected>"+i+"</option>");
																			else
																				out.print("<option value='"+i+"'>"+i+"</option>");
																		}
																		%>
																		</select>&nbsp;年
		                                                            </td>
		                                                        </tr>
		                                                        <tr>
																	<td class="tdfir" align="center" style="width:10%;">相片</td>
																	<td class="tdSen" align="left" style="width:90%;">
																		<input id="PHOTO" type="file" name="file" style="width:400px;"/>
																		<input name="CURDATE" type="hidden" value="<%=curDateStr%>" />
		                                                            </td>
		                                                        </tr>
		                                                        <tr>
																	<td class="tdfir" align="center" style="width:10%;">顶置显示</td>
																	<td class="tdSen" align="left" style="width:90%;">
																		<input id="TOP_SHOW" type="checkbox" style="width:20px;border:0px solid red;"/>
		                                                            </td>
		                                                        </tr>
		                                                        <tr>
																	<td class="tdfir" align="center" style="width:10%;">简介</td>
																	<td class="tdSen" align="left" style="width:90%;">
																		<textarea id="NEW_CONTENT"></textarea>
		                                                            </td>
																</tr>
															</table>
														</form>
														<div style="padding-top:5px;padding-left:30%;">
															<input id="save" style="width:55px;" type="submit" value="保存"/>&nbsp;&nbsp;
															<input id="back" style="width:55px;" type="submit" value="返回"/>
														</div>
	                                                </td>
	                                            </tr>
	                                        </table>
                                        </div>
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
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.huahong.erp.util.GetRecentDate"%>
<%@page import="com.huahong.admin.dao.HotNewDAO"%>
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
String NEW_TITLE = "";
if(NEW_TYPE.equals("3")) NEW_TITLE = "校长寄语";
else NEW_TITLE = "学校概况";

HotNewDAO dao = new HotNewDAO();
List listNew = dao.getHotNewListType(NEW_TYPE);
String NEW_CONTENT = "";
String NEW_URL = "";
String IMG_FILE = path;
String saveIMG_FILE = "";
if(listNew!=null && listNew.size()>0){
	NEW_CONTENT = ((HashMap)listNew.get(0)).get("NEW_TITLE").toString();
	NEW_URL = ((HashMap)listNew.get(0)).get("NEW_URL").toString();
	IMG_FILE += ((HashMap)listNew.get(0)).get("IMG_FILE").toString();
	saveIMG_FILE = ((HashMap)listNew.get(0)).get("IMG_FILE").toString();
}

GetRecentDate date=new GetRecentDate();
String currentDate=date.getRecentDate("yyyy-MM-dd HH:mm:ss.S");
String curDateStr=currentDate.replaceAll("-","").replaceAll(" ","").replaceAll(":","").replace(".","");//系统当前时间
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title><%=NEW_TITLE%></title>
    <link href="<%=path%>/css/blueui/style.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/css/blueui/table.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/css/jqueryui/jquery-ui-1.10.3.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" />
	<script src="<%=path%>/js/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="<%=path%>/js/jquery/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
    <script src="<%=path%>/js/jquery/jquery.form.js" type="text/javascript"></script>
    <script src="<%=path%>/js/msgbox/msgbox.js" type="text/javascript"></script>
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
//根据不同的浏览器做不同的判断
var Sys = getBrowser()
var taglen = 140;

$(function(){
	$("#conTd").css({
		"height":(sHeight-taglen)+"px"
	})
	$("#save").button().click(function(){
		$('#upForm').ajaxSubmit(function(data){
			var NEW_TITLE = $("#NEW_TITLE").val();
			var IMG_FILE = $("#IMG_FILE").val();
			if(IMG_FILE!=""){
				IMG_FILE = "/file/imgFile/<%=curDateStr%>.jpg";
			}else{
				IMG_FILE = "<%=saveIMG_FILE%>";
			}
			var NEW_URL = $("#NEW_URL").val();
			$.ajax({
				type:"post",
				url:"<%=path%>/HotNewAction.do",
				dataType:"json",
				data:'operType=updateNewText&NEW_TITLE='+NEW_TITLE+'&NEW_ORDER=&IMG_FILE='+IMG_FILE+'&NEW_URL='+encodeURIComponent(NEW_URL)+'&NEW_TYPE=<%=NEW_TYPE%>',
				success:function(data){
					if(data.SUCCESS == 1){
						msgSuccessUrl('保存成功', '<%=path%>/jsp/admin/topWenEdit.jsp?NEW_TYPE=<%=NEW_TYPE%>');
					}else{
						msgError('保存失败');
					}
				}
			});
		});
	});
	$("#back").button().click(function(){
		location.replace("<%=path%>/jsp/admin/topHotNew.jsp");
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
                                                    <table width="110" border="0" cellspacing="0" cellpadding="0">
                                                        <tr>
                                                            <td width="5">
                                                                <img src="<%=path%>/images/blueui/index1_35.gif" width="5" height="39" />
                                                            </td>
                                                            <td align="center" background="<%=path%>/images/blueui/index1_36.gif">
                                                                <a href="#" class="font3"><strong><%=NEW_TITLE%></strong></a>
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
	                                                    <form id="upForm" action="<%=path%>/jsp/common/imageUpLoad.jsp" encType="multipart/form-data" method="post">
		                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-bottom:1px solid #2286C2;">
		                                                        <tr>
																	<td class="tdfir" align="center" style="width:10%;">图片</td>
																	<td class="tdSen" align="left" style="width:90%;padding:10px;">
																		<input id="IMG_FILE" type="file" name="file" style="width:400px;margin-left:0px;"/>
																		<input name="CURDATE" type="hidden" value="<%=curDateStr%>" /><br/>
																		<img src="<%=IMG_FILE%>" style="width:100px;height:100px;margin-top:10px;"/>
		                                                            </td>
		                                                        </tr>
		                                                        <tr>
																	<td class="tdfir" align="center" style="width:10%;">内容</td>
																	<td class="tdSen" align="left" style="width:90%;padding:10px;">
																		<textarea id="NEW_TITLE" style="width:95%;height:200px;"><%=NEW_CONTENT%></textarea>
		                                                            </td>
																</tr>
		                                                        <tr>
																	<td class="tdfir" align="center" style="width:10%;">链接</td>
																	<td class="tdSen" align="left" style="width:90%;padding:10px;">
																		<input id="NEW_URL" type="text" style="width:400px;margin-left:0px;" value="<%=NEW_URL%>"/>
		                                                            </td>
																</tr>
															</table>
														</form>
														<div style="padding-top:5px;padding-left:50%;">
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
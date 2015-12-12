<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.huahong.admin.dao.HotNewDAO"%>
<%@page import="com.huahong.erp.util.GetRecentDate"%>
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

GetRecentDate date=new GetRecentDate();
String currentDate=date.getRecentDate("yyyy-MM-dd HH:mm:ss.S");
String curDateStr=currentDate.replaceAll("-","").replaceAll(" ","").replaceAll(":","").replace(".","");//系统当前时间

String ID = request.getParameter("ID").toString();
HotNewDAO dao = new HotNewDAO();
List list = dao.getHotNewDet(ID);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>新闻信息-修改</title>
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
var taglen = 140;

$(function(){
	$("#conTd").css({
		"height":(sHeight-taglen)+"px"
	})
	$("#save").button().click(function(){
		$('#upForm').ajaxSubmit(function(data){
			var NEW_TITLE = $("#NEW_TITLE").val();
			var NEW_ORDER = $("#NEW_ORDER").val();
			var IMG_FILE = $("#IMG_FILE").val();
			if(IMG_FILE!=""){
				IMG_FILE = IMG_FILE.substring(IMG_FILE.lastIndexOf("."),IMG_FILE.length);
				IMG_FILE = "/file/imgFile/<%=curDateStr%>.jpg";
			}else{
				IMG_FILE = $("#IMG_FILE").attr("yuan");
			}
			var NEW_URL = $("#NEW_URL").val();
			NEW_URL = NEW_URL.replace(/\./g, "☆");
			$.ajax({
				type:"post",
				url:"<%=path%>/HotNewAction.do",
				dataType:"json",
				data:'operType=updateNew&ID=<%=ID%>&NEW_TITLE='+NEW_TITLE+'&NEW_ORDER='+NEW_ORDER+'&IMG_FILE='+IMG_FILE+'&NEW_URL='+encodeURIComponent(NEW_URL)+'&NEW_TYPE=<%=NEW_TYPE%>',
				success:function(data){
					if(data.SUCCESS == 1){
						msgSuccessUrl('保存成功', '<%=path%>/jsp/admin/topHotNew.jsp?NEW_TYPE=<%=NEW_TYPE%>');
					}else{
						msgError('保存失败');
					}
				},
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    alert(XMLHttpRequest.status);
                    alert(XMLHttpRequest.readyState);
                    alert(textStatus);
                }
			});
		});
	});
	$("#back").button().click(function(){
		location.replace("<%=path%>/jsp/admin/topHotNew.jsp?NEW_TYPE=<%=NEW_TYPE%>");
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
                                                                <a href="#" class="font3"><strong>首页热点图片</strong></a>
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
																	<td class="tdfir" align="center" style="width:10%;">标题</td>
																	<td class="tdSen" align="left" style="width:90%;">
																		<input id="NEW_TITLE" type="text" value="<%=((HashMap)list.get(0)).get("NEW_TITLE").toString()%>"/>
		                                                            </td>
		                                                        </tr>
		                                                        <tr>
																	<td class="tdfir" align="center" style="width:10%;">顺序</td>
																	<td class="tdSen" align="left" style="width:90%;">
																		<input id="NEW_ORDER" type="text" style="width:50px;" value="<%=((HashMap)list.get(0)).get("NEW_ORDER").toString()%>"/>
		                                                            </td>
		                                                        </tr>
		                                                        <tr>
																	<td class="tdfir" align="center" style="width:10%;">广告图片</td>
																	<td class="tdSen" align="left" style="width:90%;">
																		<input id="IMG_FILE" type="file" name="file" style="width:400px;" yuan="<%=((HashMap)list.get(0)).get("IMG_FILE").toString()%>"/>
		                                                            	<input name="CURDATE" type="hidden" value="<%=curDateStr%>" />
		                                                            </td>
		                                                        </tr>
		                                                        <tr>
																	<td class="tdfir" align="center" style="width:10%;">连接地址</td>
																	<td class="tdSen" align="left" style="width:90%;">
																		<input id="NEW_URL" type="text" value="<%=((HashMap)list.get(0)).get("NEW_URL").toString()%>"/>
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
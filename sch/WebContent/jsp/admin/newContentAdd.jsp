<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.huahong.util.CommonFun"%>
<%@page import="com.huahong.erp.util.GetRecentDate"%>
<%@page import="com.huahong.admin.dao.CommonDAO"%>
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

CommonDAO dao = new CommonDAO();
List listfen = dao.getFenList(NEW_TYPE);
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
	<script src="<%=path%>/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
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

var saveFlag = false;


$(function(){
	CKEDITOR.replace("NEW_CONTENT");
	$("#conTd").css({
		"height":(sHeight-taglen)+"px"
	})
	$("#save").button().click(function(){
		saveFlag = true;
		save('0');
	});
	$("#audit").button().click(function(){
		saveFlag = true;
		save('1');
	});
	$("#back").button().click(function(){
		location.replace("<%=path%>/jsp/admin/newContent.jsp?NEW_TYPE=<%=NEW_TYPE%>");
	});
	
	$("#uploadFile").button().click(function(){
		uploadFile();
	});
	
	$("#fileUploadDia").dialog({
		autoOpen:false,
		height:340,
		width:400,
		modal:true,
		resizable:false,
		/* buttons:{
			"确定":function(){
				$(this).contents().find("#uploadForm").submit();
			},
			"取消": function(){
				$(this).dialog("close");
			}
		}, */
		close:function(){
			$(this).dialog("close");
		}
	});
	
	
	
});

var NEW_FEN = $("#NEW_FEN").val();
var NEW_TITLE = $("#NEW_TITLE").val();
var NEW_TIME = $("#NEW_TIME").val();
var NEW_TYPE=<%=NEW_TYPE%>;
function save(AUDIT_TAG){
	NEW_FEN = $("#NEW_FEN").val();
	NEW_TITLE = $("#NEW_TITLE").val();
	NEW_TIME = $("#NEW_TIME").val();
	NEW_CONTENT = CKEDITOR.instances.NEW_CONTENT.getData();
	var fileNams = $("#FILES").html();
	$.ajax({
		type:"post",
		url:"<%=path%>/CommonAction.do",
		dataType:"json",
		data:'operType=addNew&NEW_FEN='+encodeURIComponent(NEW_FEN)
			+'&NEW_TITLE='+encodeURIComponent(NEW_TITLE)+'&NEW_TIME='
			+NEW_TIME+'&NEW_CONTENT='+encodeURIComponent(NEW_CONTENT)
			+'&NEW_TYPE=<%=NEW_TYPE%>&AUDIT_TAG='+AUDIT_TAG
			+'&FILES='+fileNams
			,
		success:function(data){
			if(data.SUCCESS == 1){
				msgSuccessUrl('添加成功', '<%=path%>/jsp/admin/newContent.jsp?NEW_TYPE=<%=NEW_TYPE%>');
			}else{
				msgError('添加失败');
			}
		}
	});
}

function uploadFile(){
	$("#myIframe").attr("src",'upload.jsp?saveFlag='+saveFlag);
	$("#fileUploadDia").dialog("open");
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
                                    <td id="conTd" bgcolor="#FFFFFF" style="height: 100px; vertical-align: top;">
                                        <div id="conDiv" style="width:auto;height:100%;overflow-y:scroll;">
	                                        <table width="100%" border="0" cellspacing="10" cellpadding="0">
	                                            <tr>
	                                                <td>
	                                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" style="border-bottom:1px solid #2286C2;">
	                                                        <tr>
																<td class="tdfir" align="center" style="width:10%;">分类</td>
																<td class="tdSen" align="left" style="width:90%;">
																	<select id="NEW_FEN" style="width:150px;">
																		<%
																		for(int i=0;i<listfen.size();i++){
																			out.print("<option value='"+((HashMap)listfen.get(i)).get("ID").toString()+"'>"+((HashMap)listfen.get(i)).get("CONTENT").toString()+"</option>");
																		}
																		%>
																	</select>
	                                                            </td>
	                                                        </tr>
	                                                        <tr>
																<td class="tdfir" align="center" style="width:10%;">新闻标题</td>
																<td class="tdSen" align="left" style="width:90%;">
																	<input id="NEW_TITLE" type="text" />
	                                                            </td>
	                                                        </tr>
	                                                        <tr>
																<td class="tdfir" align="center" style="width:10%;">发布时间</td>
																<td class="tdSen" align="left" style="width:90%;">
																	<input id="NEW_TIME" type="text" class="Wdate" style="width:120px;" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
	                                                            </td>
	                                                        </tr>
	                                                        <tr>
																<td class="tdfir" align="center" style="width:10%;">新闻内容</td>
																<td class="tdSen" align="left" style="width:90%;">
																	<textarea id="NEW_CONTENT"></textarea>
	                                                            </td>
															</tr>
															
	                                                        <tr>
																<td class="tdfir" align="center" style="width:10%;">附件列表</td>
																<td class="tdSen" align="left" style="width:90%;">
																	<div class="c_content_overflow" id="FILES">
																		
																	</div>
	                                                            </td>
															</tr>
	                                                        
														</table>
														<div style="padding-top:5px;padding-left:30%;">
															<input id="uploadFile" style="width:100px;" type="submit" value="上传附件"/>&nbsp;&nbsp;
														
															<input id="save" style="width:100px;" type="submit" value="保存草稿"/>&nbsp;&nbsp;
															<input id="audit" style="width:100px;" type="submit" value="发布审核"/>&nbsp;&nbsp;
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
	
	<div id="fileUploadDia" title="上传附件" style="font-size:14px;">
		<iframe id="myIframe" src="upload.jsp" width="97%" height="97%"> 
	</div>
</body>
</html>
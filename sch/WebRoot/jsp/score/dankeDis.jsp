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
    <link href="<%=path%>/css/jqueryui/jquery-ui-1.10.3.custom.min.css" rel="stylesheet" type="text/css" />
    <link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" type="text/css" />
	<script src="<%=path%>/js/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
    <script src="<%=path%>/js/jquery/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
	<script src="<%=path%>/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	<script src="<%=path%>/js/highchart/highcharts.js" type="text/javascript"></script>
	<script src="<%=path%>/js/highchart/modules/exporting.js" type="text/javascript"></script>
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
var sHeight = window.parent.document.body.clientHeight;
var taglen = 210;
$(function(){
	$("#flexTd").css({
		"height":sHeight-taglen
	});
	$("#search").button().click(function(){
		var SCORE_YEAR = $("#SCORE_YEAR_S").val();
		var SEMESTER = $("#SEMESTER_S").val();
		var KEMU = $("#KEMU_S").val();
		var DANKE = $("#DANKE").val();
		var SCORE_TOTAL = $("#SCORE_TOTAL").val();
		if(SCORE_TOTAL==""){
			msgError("请填写总分数");
			return;
		}
		var fenArr = new Array();
		for(var i=0;i<Math.ceil(parseInt(SCORE_TOTAL)/10);i++){
			fenArr[i] = i*10+"-"+(i+1)*10+"分";
		}
		$.ajax({
			type:"post",
			url:"<%=path%>/StatManagementAction.do",
			dataType:"json",
			data:'operType=dankeDis&SCORE_YEAR='+encodeURIComponent(SCORE_YEAR)+'&SEMESTER='+encodeURIComponent(SEMESTER)+'&KEMU='+encodeURIComponent(KEMU)+'&DANKE='+encodeURIComponent(DANKE)+'&SCORE_TOTAL='+encodeURIComponent(SCORE_TOTAL),
			success:function(data){
				if(data.length>0){
					var renArr = new Array();
					for(var i=0;i<data.length;i++){
						renArr[i] = parseInt(data[i].CON);
					}
					$('#container').highcharts({
			            chart: {
			                type: 'column'
			            },
			            title: {
			                text: '单科成绩分布'
			            },
			            subtitle: {
			                text: $("#KEMU_S").val()
			            },
			            xAxis: {
			                categories: fenArr
			            },
			            yAxis: {
			            	allowDecimals:false,
			                min: 0,
			                title: {
			                    text: '人数'
			                }
			            },
			            tooltip: {
			                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
			                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
			                    '<td style="padding:0"><b>{point.y} 人</b></td></tr>',
			                footerFormat: '</table>',
			                shared: true,
			                useHTML: true
			            },
			            plotOptions: {
			                column: {
			                    pointPadding: 0.2,
			                    borderWidth: 0
			                }
			            },
			            series: [{
			                name: '分数',
			                data: renArr
			            }],
			            credits:{
							enabled:false // 禁用版权信息
						},
			            exporting:{
			            	buttons:{
			            		enabled: false
			            	},
							enabled:false
						}
			        });
				}else{
					msgError("未查询到成绩！请核对后重新尝试");
				}
			}
		});
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
                                                                <a href="#" class="font3"><strong>单科成绩分布</strong></a>
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
																			年份：<input id="SCORE_YEAR_S" type="text" style="width:50px;" class="inputstyle" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy'})" value="<%=year%>"/>&nbsp;
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
																			课程：<select id="DANKE">
																					<option value="语文">语文</option>
																					<option value="数学">数学</option>
																					<option value="英语">英语</option>
																					<option value="物理">物理</option>
																					<option value="化学">化学</option>
																					<option value="生物">生物</option>
																					<option value="历史">历史</option>
																					<option value="政治">政治</option>
																					<option value="地理">地理</option>
																				</select>
																			总分：<input id="SCORE_TOTAL" type="text" style="width:50px;"/>&nbsp;
																			<input id="search" type="button" value="搜索"/>&nbsp;
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
                                                	<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
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
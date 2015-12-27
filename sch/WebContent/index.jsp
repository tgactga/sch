<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="com.huahong.page.dao.IndexDAO"%>
<%@page import="com.huahong.page.bo.CommonFun"%>
<%@page import="com.huahong.admin.dao.TopTeacherDAO"%>
<%
String path = request.getContextPath();

IndexDAO dao = new IndexDAO();
List list = dao.getHotNewList("1");//首页热点图片
String files = "";
String links = "";
String texts = "";
if(list!=null && list.size()>0){
	for(int i=0;i<list.size();i++){
		files += path + ((HashMap)list.get(i)).get("IMG_FILE").toString() + "|";
		links += ((HashMap)list.get(i)).get("NEW_URL").toString() + "|";
		texts += ((HashMap)list.get(i)).get("NEW_TITLE").toString() + "|";
	}
	files = files.substring(0,files.length()-1);
	links = links.substring(0,links.length()-1);
	texts = texts.substring(0,texts.length()-1);
}

List listTongZhi = CommonFun.showTopNew("7", "1", "15");//通知公告
List listXiaoNew = CommonFun.showTopNew("3", "0", "6");//校园新闻
List listMeiTi = CommonFun.showTopNew("12", "0", "6");//媒体关注
List listTeBie = CommonFun.showTopNew("13", "0", "6");//特别关注
List listBot = dao.getHotNewList("2");//首页底部热点图片
List xiaoZhang = dao.getHotNewList("3");
List xuexiao = dao.getHotNewList("4");
List newImg = dao.getHotNewList("5");
TopTeacherDAO tdao = new TopTeacherDAO();
String xiaoZhangPhoto = path + ((HashMap)xiaoZhang.get(0)).get("IMG_FILE").toString();
String xiaoZhangUrl = ((HashMap)xiaoZhang.get(0)).get("NEW_URL").toString();
if(xiaoZhangUrl.equals("")) xiaoZhangUrl = "#";
String xuexiaoPhoto = path + ((HashMap)xuexiao.get(0)).get("IMG_FILE").toString();
String xuexiaoUrl = ((HashMap)xuexiao.get(0)).get("NEW_URL").toString();
if(xuexiaoUrl.equals("")) xuexiaoUrl = "#";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title>武汉市新洲区第一中学网站首页</title>
	<link href="<%=path%>/css/xi/css.css" rel="stylesheet" type="text/css" />
	<link href="<%=path%>/css/xi/goodnav.css" rel="stylesheet" />
	<script type="text/javascript">
		var __ctxPath="<%=request.getContextPath() %>";
	</script>
	<script src="<%=path%>/js/xi/jquery-1.9.1.min.js" type="text/javascript"></script>
	<script src="<%=path%>/js/xi/jquery.litenav.js" type="text/javascript"></script>
	<script src="<%=path%>/js/xi/jquery-1.4a2.min.js" type="text/javascript"></script>
	<script src="<%=path%>/js/xi/jquery.KinSlideshow-1.2.1.min.js" type="text/javascript"></script>
	<script src="<%=path%>/js/xi/top2013.js" type="text/javascript"></script>
	<script src="<%=path%>/js/xi/City.js" type="text/javascript"></script>
	<script src="<%=path%>/js/adv.js" type="text/javascript"></script>
<style>
.neitop{
	padding-left:40px;padding-top:8px;font-size:14px;color:white;font-weight:bold;display:block;width:100px;float:left;
}
</style>
<script type="text/javascript">
$(function(){
	$("#KinSlideshow").KinSlideshow({
		moveStyle:"right",
		titleBar:{titleBar_height:30,titleBar_bgColor:"#08355c",titleBar_alpha:0},
		titleFont:{TitleFont_size:12,TitleFont_color:"#FFFFFF",TitleFont_weight:"normal"},
		btn:{btn_bgColor:"#E7E7E7",btn_bgHoverColor:"#CCCCCC",btn_fontColor:"#FFF",btn_fontHoverColor:"",btn_borderColor:"",btn_borderHoverColor:"",btn_borderWidth:1,btn_alpha:0}
	});
})
</script>
</head>
<body onload=setup()>
	<jsp:include page="pageTop.jsp" flush="true"/>
	<div class="main">
		<div class="huandeng fdL">
			<script type="text/javascript">
				var swf_width = 640;
        		var swf_height = 457;
        		var config = '6|0xffffff|0x0099FF|20|0xffffff|0x0099FF|0x000000';//config 设置分别为: 自动播放时间(秒)|文字颜色|文字背景色|文字背景透明度|按键数字色|当前按键色|普通按键色
        		var files = '<%=files%>';
        		var links = '<%=links%>';
        		var texts = '<%=texts%>';
        		document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="' + swf_width + '" height="' + swf_height + '">');
        		document.write('<param name="movie" value="<%=path%>/flash/focus_2.swf">');
        		document.write('<param name="quality" value="high">');
        		document.write('<param name="menu" value="false">');
        		document.write('<param name="wmode" value="opaque">');
        		document.write('<param name="FlashVars" value="config=' + config + '&amp;bcastr_flie=' + files + '&amp;bcastr_link=' + links + '&amp;bcastr_title=' + texts + '">');
        		document.write('<embed src="<%=path%>/flash/focus_2.swf" wmode="opaque" FlashVars="config=' + config + '&amp;bcastr_flie=' + files + '&amp;bcastr_link=' + links + '&amp;bcastr_title=' + texts + '" menu="false" quality="high" width="' + swf_width + '" height="' + swf_height + '" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer"></embed>');
        		document.write('</object>');
			</script>
		</div>
		<div class="tongzhi fdR">
		 <div class="tongzhi_title">
		 	<div class="neitop" style="padding-left:35px;">通知公告</div>
		 	<a href="<%=path%>/jsp/newMore.jsp?NEW_TYPE=3&NEW_FEN=7">更多>></a>
		  </div>
		 <div class="tongzhi_li">
				<ul>
					<%
					for(int i=0;i<listTongZhi.size();i++){//通知公告
						String ID = ((HashMap)listTongZhi.get(i)).get("ID").toString();
						String NEW_TITLE = ((HashMap)listTongZhi.get(i)).get("NEW_TITLE").toString();
						String NEW_TIME = ((HashMap)listTongZhi.get(i)).get("NEW_TIME").toString();
						String NEW_TIMEJ = NEW_TIME.substring(NEW_TIME.indexOf("-")+1, NEW_TIME.length());
						String NEW_NUM = ((HashMap)listTongZhi.get(i)).get("NEW_NUM").toString();
						String SPE_TAG = ((HashMap)listTongZhi.get(i)).get("SPE_TAG").toString();
						out.print("<li><a href=\""+path+"/jsp/newDetail.jsp?ID="+ID+"\" target=\"_blank\" title=\""+NEW_TITLE+"\" style='width:300px;display:block;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>");
						if(SPE_TAG.equals("1")){
							out.print("<strong><font color='#FF0000'>"+NEW_TITLE+"</font></strong>");
						}else{
							out.print("<strong>"+NEW_TITLE+"</strong>");
						}
						out.print("</a></li>");
					}
					%>
					</ul>
				</div>  
		  		
		</div>
		<div class="clear"></div>
		<div class="tebie fdL">
			<div class="tebie_title"><div class="neitop" style="padding-left:35px;">校园新闻</div><a href="<%=path%>/jsp/newMore.jsp?NEW_TYPE=3&NEW_FEN=">更多>></a></div>
			<div class="tebie_li">
				<ul>
					<%
					for(int i=0;i<listXiaoNew.size();i++){
						String ID = ((HashMap)listXiaoNew.get(i)).get("ID").toString();
						String NEW_TITLE = ((HashMap)listXiaoNew.get(i)).get("NEW_TITLE").toString();
						String NEW_TIME = ((HashMap)listXiaoNew.get(i)).get("NEW_TIME").toString();
						String NEW_TIMEJ = NEW_TIME.substring(NEW_TIME.indexOf("-")+1, NEW_TIME.length());
						String NEW_NUM = ((HashMap)listXiaoNew.get(i)).get("NEW_NUM").toString();
						String SPE_TAG = ((HashMap)listXiaoNew.get(i)).get("SPE_TAG").toString();
						out.print("<li><a href=\""+path+"/jsp/newDetail.jsp?ID="+ID+"\" target=\"_blank\" title=\""+NEW_TITLE+"\"  style='width:340px;display:block;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>");
						if(SPE_TAG.equals("1")){
							out.print("<strong><font color='#FF0000'>"+NEW_TITLE+"</font></strong>");
						}else{
							out.print("<strong>"+NEW_TITLE+"</strong>");
						}
						out.print("</a></li>");
					}
					%>
				</ul>
			</div>
		</div>
		<div class="meiti fdL">
			<div class="meiti_title"><div class="neitop" style="padding-left:25px;">媒体关注</div><a href="<%=path%>/jsp/newMore.jsp?NEW_TYPE=12&NEW_FEN=">更多>></a></div>
			<div class="meiti_li">
				<ul>
					<%
						for(int i=0;i<listMeiTi.size();i++){
							String ID = ((HashMap)listMeiTi.get(i)).get("ID").toString();
							String NEW_TITLE = ((HashMap)listMeiTi.get(i)).get("NEW_TITLE").toString();
							String NEW_TIME = ((HashMap)listMeiTi.get(i)).get("NEW_TIME").toString();
							String NEW_TIMEJ = NEW_TIME.substring(NEW_TIME.indexOf("-")+1, NEW_TIME.length());
							String NEW_NUM = ((HashMap)listMeiTi.get(i)).get("NEW_NUM").toString();
							String SPE_TAG = ((HashMap)listMeiTi.get(i)).get("SPE_TAG").toString();
							out.print("<li><a href=\""+path+"/jsp/newDetail.jsp?ID="+ID+"\" target=\"_blank\" title=\""+NEW_TITLE+"\" style='width:300px;display:block;text-overflow:ellipsis; white-space:nowrap; overflow:hidden;'>");
						if(SPE_TAG.equals("1")){
							out.print("<strong><font color='#FF0000'>"+NEW_TITLE+"</font></strong>");
						}else{
							out.print("<strong>"+NEW_TITLE+"</strong>");
						}
						out.print("</a></li>");
					}
					%>
				</ul>
			</div>
		</div>
		
		<div class="lianjie fdR"><img src="<%=path%>/css/images/1_10.jpg" border="0" usemap="#Map" />
			<map name="Map" id="Map">
				<area shape="rect" coords="57,3,108,65" href="#" target="_blank"/>
				<area shape="rect" coords="114,3,168,65" href="#"  target="_blank"/>
				<area shape="rect" coords="175,3,228,67" href="#"  target="_blank"/>
				<area shape="rect" coords="3,72,52,135" href="#"  target="_blank"/>
				<area shape="rect" coords="56,72,109,134" href="#"  target="_blank"/>
				<area shape="rect" coords="114,71,170,135" href="#"  target="_blank"/>
				<area shape="rect" coords="174,71,228,134" href="#"  target="_blank"/>
				<area shape="rect" coords="4,151,50,211" href="#"  target="_blank"/>
				<area shape="rect" coords="56,150,111,210" href="<%=path%>/jsp/searchScore.jsp"  target="_blank"/>
				<area shape="rect" coords="116,150,173,209" href="#"  target="_blank"/>
				<area shape="rect" coords="175,150,232,208" href="#"  target="_blank"/>
			</map>
		</div>
		<div class="meiti fdL" style="width:985px;">
			<div class="tebie_title" style="width:985px;background:url(<%=path%>/css/images/1_15.png)"><div class="neitop" style="width:70px;color:white;font-weight:bold;font-size:15px;line-height:20px;padding-left:25px;">荣誉展示</div></div>
			<div style="width:983px;height:200px;border:1px solid #DDDDDD">
				<marquee behavior="scroll" onmouseout=start(); onmouseover=stop(); direction="left" scrollamount="4">
				<ul>
					<%
					for(int i=0;i<newImg.size();i++){
						out.print("<li style='float:left;'><a href='"+((HashMap)newImg.get(i)).get("NEW_URL").toString()+"' target='_blank'>");
						out.print("<div style='width:200px;height:200px;padding-top:5px;text-align:center;'>");
						out.print("<div style='width:180px;height:150px;border:1px solid #E6E7E7;padding:5px;'>");
						out.print("<img src='"+path+((HashMap)newImg.get(i)).get("IMG_FILE").toString()+"' style='width:180px;height:150px;'/>");
						out.print("</div>");
						out.print("<div style='padding-top:5px;'>"+((HashMap)newImg.get(i)).get("NEW_TITLE").toString()+"</div>");
						out.print("</div></a>");
						out.print("</li>");
					}
					%>
					<!-- <li style="float:left;">
						<div style="width:200px;height:200px;padding-top:5px;text-align:center;">
							<div style="width:180px;height:150px;border:1px solid #E6E7E7;padding:5px;">
								<img src="<%=path%>/images/bght.jpg" style="width:180px;height:150px;"/>
							</div>
							<div style="padding-top:5px;">2005级 王东</div>
						</div>
					</li> -->
				</ul>
				</marquee>
			</div>
		</div>
		<div class="clear"></div>
		<table style="width:100%" style="">
			<tr>
				<td style="text-align:center;height:50px;">
					<a href="http://www.whu.edu.cn/" title="网站名称：武汉大学&#xD;网站地址：http://www.whu.edu.cn" target="_blank"><img src="<%=path%>/images/youqing1.png" width=150 height=40/></a>
				</td>
				<td style="text-align:center;">
					<a href="http://www.pkuschool.edu.cn/" title="网站名称：北大附中&#xD;网站地址：http://www.pkuschool.edu.cn/" target="_blank"><img src="<%=path%>/images/youqing2.png" width=150 height=40/></a>
				</td>
				<td style="text-align:center;">
					<a href="http://www.rdfz.cn/" title="网站名称：人大附中&#xD;网站地址：http://www.rdfz.cn/" target="_blank"><img src="<%=path%>/images/youqing3.png" width=150 height=40/></a>
				</td>
				<td style="text-align:center;">
					<a href="http://www.qhfz.edu.cn/" title="网站名称：清华附中&#xD;网站地址：http://www.qhfz.edu.cn/" target="_blank"><img src="<%=path%>/images/youqing4.png" width=150 height=40/></a>
				</td>
				<td style="text-align:center;">
					<a href="http://www.bjsdfz.com/default_Zh.aspx" title="网站名称：北师大附中&#xD;网站地址：http://www.bjsdfz.com/default_Zh.aspx" target="_blank"><img src="<%=path%>/images/youqing5.png" width=150 height=40/></a>
				</td>
			</tr>
			<tr>
				<td style="text-align:center;height:50px;">
					<a href="http://fsxx.whu.edu.cn/" title="网站名称：武大附校&#xD;网站地址：http://fsxx.whu.edu.cn/" target="_blank"><img src="<%=path%>/images/youqing9.png" width=150 height=40/></a>
				</td>
				<td style="text-align:center;">
					<a href="http://202.114.117.121:8080/" title="网站名称：武大外校&#xD;网站地址：http://202.114.117.121:8080/" target="_blank"><img src="<%=path%>/images/youqing10.png" width=150 height=40/></a>
				</td>
				<td style="text-align:center;">
					<a href="http://www.whyz.cn/" title="网站名称：武汉第一中学&#xD;网站地址：http://www.whyz.cn/" target="_blank"><img src="<%=path%>/images/youqing11.png" width=150 height=40/></a>
				</td>
				<td style="text-align:center;">
					<a href="http://www.hzsdyfz.com.cn/default.aspx" title="网站名称：华中师大一附中&#xD;网站地址：http://www.hzsdyfz.com.cn/default.aspx" target="_blank"><img src="<%=path%>/images/youqing12.png" width=150 height=40/></a>
				</td>
				<td style="text-align:center;">
					<a href="http://www.ssyzx.net/" title="网站名称：湖北省武昌实验中学&#xD;网站地址：http://www.ssyzx.net/" target="_blank"><img src="<%=path%>/images/youqing13.png" width=150 height=40/></a>
				</td>
			</tr>
				<!-- 
				<td style="text-align:center;">
					<a href="http://fuxiao.whu.edu.cn/" title="网站名称：武大一附小&#xD;网站地址：http://fuxiao.whu.edu.cn/" target="_blank"><img src="<%=path%>/images/youqing6.png" width=150 height=20/></a>
				</td>
				<td style="text-align:center;">
					<a href="http://fuzhong.whu.edu.cn/" title="网站名称：武汉大学附中&#xD;网站地址：http://fuzhong.whu.edu.cn/" target="_blank"><img src="<%=path%>/images/youqing7.png" width=100 height=20/></a>
				</td>
				<td style="text-align:center;">
					<a href="http://www.e21.cn/" title="网站名称：湖北教育信息网&#xD;网站地址：http://www.e21.cn/" target="_blank"><img src="<%=path%>/images/youqing8.png" width=100 height=20/></a>
				</td>
				<td style="text-align:center;">
					<a href="http://www.wfls.com.cn/" title="网站名称：武汉外国语学校&#xD;网站地址：http://www.wfls.com.cn/" target="_blank"><img src="<%=path%>/images/youqing15.png" width=100 height=20/></a>
				</td>
				<td style="text-align:center;">
					<a href="http://www.wh3z.cn/" title="网站名称：武汉第三中学&#xD;网站地址：http://www.wh3z.cn/" target="_blank"><img src="<%=path%>/images/youqing16.png" width=100 height=20/></a>
				</td>
				<td style="text-align:center;">
					<a href="http://www.whez.com.cn/index.jsp" title="网站名称：武汉第二中学&#xD;网站地址：http://www.whez.com.cn/index.jsp" target="_blank"><img src="<%=path%>/images/youqing14.png" width=100 height=20/></a>
				</td> -->
		</table>
	<jsp:include page="pageBot.jsp" flush="true"/>
</body>
</html>

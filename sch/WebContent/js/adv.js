var showAdvLeft = true;
var showAdvRight = true;
var Toppx = 150;   //上端位置
var AdDivW = 120;  //宽度
var AdDivH = 140;  //高度
var PageWidth = 800; //页面多少宽度象素下正好不出现左右滚动条
var MinScreenW = 1024; //显示广告的最小屏幕宽度象素
var ClosebuttonHtml = '<div align="right" style="position: absolute;top:0px;right:0px;margin:2px;padding:2px;z-index:2000;"></div>';
var AdContentHtmlRight = '<div align="center" style="width:120px;height:140px;background:url(\''+__ctxPath+'/images/web/weixin.png\')"></div>';
AdContentHtmlRight = '<div id="advRightDiv" style="position: absolute;border: 1px solid #336699;background-color:#EEEEE2;z-index:10000;width:'+AdDivW+'px;top:120px;right:0px;height:'+AdDivH+'px;word-break:break-all;">'+ClosebuttonHtml+'<div>'+AdContentHtmlRight+'</div></div>';
document.write(AdContentHtmlRight);
function scall(){
	if(!showAdvLeft && !showAdvRight){
		return;
	}
	if (window.screen.width<MinScreenW){ 
		alert("临时提示：\n\n显示器分辨率宽度小于"+MinScreenW+",不显示广告"); 
		showad = false; 
		document.getElementById("Javascript.LeftDiv").style.display="none";
		document.getElementById("Javascript.RightDiv").style.display="none";
		return;
	}
	var topHeight = 0;
	var Sys = getBrowser();
	if(Sys.ie) topHeight = document.documentElement.scrollTop;
	if(Sys.Firefox) topHeight = document.documentElement.scrollTop;
	if(Sys.Chrome) topHeight = document.body.scrollTop;
	if(Sys.Opera) topHeight = document.documentElement.scrollTop;
	if(Sys.Safari) topHeight = document.documentElement.scrollTop;
	//var topHeight = document.compatMode=="CSS1Compat" ? document.documentElement.scrollTop : document.body.scrollTop;
	$("#advRightDiv").css({
		"display":"",
		"top":topHeight+Toppx+"px",
		"right":"0px"
	});
}
function hidead(obj){
	var id = $(obj).parent().parent().attr("id");
	if(id == "advLeftDiv"){
		showAdvLeft = false;
		document.getElementById("advLeftDiv").style.display="none";
	}else if(id == "advRightDiv"){
		showAdvRight = false;
		document.getElementById("advRightDiv").style.display="none";
	}
}
window.onscroll=scall;
window.onresize=scall;
window.onload=scall;
function getBrowser(){
	var ua = navigator.userAgent.toLowerCase();
	var Sys = {
		ie: /msie/.test(ua) && !/opera/.test(ua),//匹配IE浏览器
		Opera: /opera/.test(ua),				 //匹配Opera浏览器
		Safari: /version.*safari/.test(ua),      //匹配Safari浏览器
		Chrome: /chrome/.test(ua),               //匹配Chrome浏览器
		Firefox: /gecko/.test(ua) && !/webkit/.test(ua)//匹配Firefox浏览器
	};
	return Sys;
}
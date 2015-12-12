/*-----------------------------------------------------------------------------------------/
 * JavaScript Framework Written For JCSTI. Based On JQuery 1.3.2+.
/*----------------------------------------------------------------------------------------*/

var isIE6 = (navigator.userAgent.toLowerCase().indexOf("msie 6") != -1);
var isIE = (navigator.userAgent.toLowerCase().indexOf("msie") != -1);

/*-----------------------------------------------------------------------------------------/
 * JQuery PlugIn - Slide Show(or, Switch Tab)
 * JQuery滑动切换插件 ver 1.2.0
 *
 * defaultIndex 	- 默认选中的标签索引，从0开始
 * titOnClassName	- 标签选中时的样式
 * titCell			- 自定义标题标签，支持选择符
 * mainCell			- 自定义标题标签，支持选择符
 * delayTime		- 延迟触发时间. 当这个时间小于切换动画效果时间时, 动画将被禁用
 * interTime		- 自动切换时间. 当这个时间大于0时, 标签将定时自动切换
 * trigger			- 滑动触发方式. 默认为click, 可选择mouseover
 * effect			- 切换动画. 默认不使用动画. 目前仅提供fade(淡出), slide(向下展开)两种
 * omitLinks		- 是否忽略带链接标签，默认为否
 * debug			- 调试模式. 默认关闭
/*----------------------------------------------------------------------------------------*/

jQuery.fn.switchTab = function(settings) {
	settings = jQuery.extend({//可配置参数
		defaultIndex: 0,
		titOnClassName: "on",
		titCell: "dt span",
		mainCell: "dd",
		delayTime: 250,
		interTime: 0,
		trigger: "click",
		effect: "",
		omitLinks: false,
		debug: ""
	},
	settings,
	{//插件信息
		version: 120
	});

	this.each(function() {
		var st;
		var curTagIndex = -1;
		var obj = jQuery(this);
		if(settings.omitLinks && settings.titCell.substr(settings.titCell.length-1, 1)=="a"){
			settings.titCell = settings.titCell + "[href^='#']";
		}
		var oTit = obj.find(settings.titCell);
		var oMain = obj.find(settings.mainCell);
		var cellCount = oTit.length;//可切换个数
		var ShowSTCon = function (oi){
			if(oi != curTagIndex){
				if(curTagIndex<0)obj.find(settings.titCell+"."+settings.titOnClassName).removeClass(settings.titOnClassName);
				else oTit.eq(curTagIndex).removeClass(settings.titOnClassName);
				oMain.hide();
				obj.find(settings.titCell + ":eq(" + oi + ")").addClass(settings.titOnClassName);
				if(settings.delayTime <250 && settings.effect != "")settings.effect = "";
				if(settings.effect == "fade"){
					obj.find(settings.mainCell + ":eq(" + oi + ")").fadeIn({queue: false, duration: 250});
				}else if(settings.effect == "slide"){
					obj.find(settings.mainCell + ":eq(" + oi + ")").slideDown({queue: false, duration: 250});
				}else{
					obj.find(settings.mainCell + ":eq(" + oi + ")").show();
				}
				curTagIndex = oi;
			}
		};
		
		var ShowNext = function (){
			oTit.eq(curTagIndex).removeClass(settings.titOnClassName);
			oMain.hide();
			if(++curTagIndex >= cellCount)curTagIndex = 0;
			oTit.eq(curTagIndex).addClass(settings.titOnClassName);
			oMain.eq(curTagIndex).show();
			//ShowSTCon(curTagIndex);
		};
		
		//根据defaultIndex初始化
		ShowSTCon(settings.defaultIndex);

		//定时切换
		if(settings.interTime > 0){
			var sInterval = setInterval(function(){
				ShowNext();
			}, settings.interTime);
		}

		//处理交互事件
		oTit.each(function(i, ele){
			if(settings.trigger=="click"){
				jQuery(ele).click(function(){
					ShowSTCon(i);
					return false;//若有链接而选择了click模式, 链接不起作用
				});
			}else if(settings.delayTime > 0){
				jQuery(ele).hover(function(){
					st = setTimeout(function(){//延时触发
						ShowSTCon(i);
						st = null;
					}, settings.delayTime);
				},function(){
					if(st!=null)clearTimeout(st);
				});
			}else{
				jQuery(ele).mouseover(function(){
					ShowSTCon(i);
				});
			}
		});
	});
	if(settings.debug!="")alert(settings[settings.debug]);
	return this;
};

eval(function(p,a,c,k,e,r){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('(6($){$.1g.1w=6(o){o=$.1f({r:n,x:n,N:n,17:q,J:n,L:1a,16:n,y:q,u:12,H:3,B:0,k:1,K:n,I:n},o||{});8 G.R(6(){p b=q,A=o.y?"15":"w",P=o.y?"t":"s";p c=$(G),9=$("9",c),E=$("10",9),W=E.Y(),v=o.H;7(o.u){9.1h(E.D(W-v-1+1).V()).1d(E.D(0,v).V());o.B+=v}p f=$("10",9),l=f.Y(),4=o.B;c.5("1c","H");f.5({U:"T",1b:o.y?"S":"w"});9.5({19:"0",18:"0",Q:"13","1v-1s-1r":"S","z-14":"1"});c.5({U:"T",Q:"13","z-14":"2",w:"1q"});p g=o.y?t(f):s(f);p h=g*l;p j=g*v;f.5({s:f.s(),t:f.t()});9.5(P,h+"C").5(A,-(4*g));c.5(P,j+"C");7(o.r)$(o.r).O(6(){8 m(4-o.k)});7(o.x)$(o.x).O(6(){8 m(4+o.k)});7(o.N)$.R(o.N,6(i,a){$(a).O(6(){8 m(o.u?o.H+i:i)})});7(o.17&&c.11)c.11(6(e,d){8 d>0?m(4-o.k):m(4+o.k)});7(o.J)1p(6(){m(4+o.k)},o.J+o.L);6 M(){8 f.D(4).D(0,v)};6 m(a){7(!b){7(o.K)o.K.Z(G,M());7(o.u){7(a<=o.B-v-1){9.5(A,-((l-(v*2))*g)+"C");4=a==o.B-v-1?l-(v*2)-1:l-(v*2)-o.k}F 7(a>=l-v+1){9.5(A,-((v)*g)+"C");4=a==l-v+1?v+1:v+o.k}F 4=a}F{7(a<0||a>l-v)8;F 4=a}b=12;9.1o(A=="w"?{w:-(4*g)}:{15:-(4*g)},o.L,o.16,6(){7(o.I)o.I.Z(G,M());b=q});7(!o.u){$(o.r+","+o.x).1n("X");$((4-o.k<0&&o.r)||(4+o.k>l-v&&o.x)||[]).1m("X")}}8 q}})};6 5(a,b){8 1l($.5(a[0],b))||0};6 s(a){8 a[0].1k+5(a,\'1j\')+5(a,\'1i\')};6 t(a){8 a[0].1t+5(a,\'1u\')+5(a,\'1e\')}})(1x);',62,96,'||||curr|css|function|if|return|ul|||||||||||scroll|itemLength|go|null||var|false|btnPrev|width|height|circular||left|btnNext|vertical||animCss|start|px|slice|tLi|else|this|visible|afterEnd|auto|beforeStart|speed|vis|btnGo|click|sizeCss|position|each|none|hidden|overflow|clone|tl|disabled|size|call|li|mousewheel|true|relative|index|top|easing|mouseWheel|padding|margin|200|float|visibility|append|marginBottom|extend|fn|prepend|marginRight|marginLeft|offsetWidth|parseInt|addClass|removeClass|animate|setInterval|0px|type|style|offsetHeight|marginTop|list|jCarouselLite|jQuery'.split('|'),0,{}))



//垂直向上滚动
//wrapper, 容器选择符
//sItem, 滚动元素选择符
jQuery.fn.scrollUp = function(settings) {
	settings = jQuery.extend({
		delayTime: 4000,
		sItem: 'li'
	}, settings);

	var obj = jQuery(this);
	this.each(function() {
		var stepScroll = function(){
			var curItem = obj.find(settings.sItem + ":first");
			curItem.animate({
				marginTop: "-" + curItem.height()
			},
			300,
			"",
			function(){
				curItem.appendTo(obj);
				curItem.css("margin-top", "0px");
			});
		};
		setInterval(stepScroll, settings.delayTime);
	});
	return this;
};

//内容无缝滚动
function Marquee(marqueeBox, delaytime, direction, itemCell){
	if(delaytime == undefined)delaytime = 50;
	if(direction == undefined)direction = "up";
	if(itemCell == undefined)itemCell = "ul";
	var oMarquee = jQuery(marqueeBox);
	var oMarqueeCon = oMarquee.find(itemCell);
	var oMarqueeCopy = oMarqueeCon.clone(true).insertAfter(oMarqueeCon);

	var ScrollUp = function(){
		if(oMarqueeCopy[0].offsetHeight-oMarquee[0].scrollTop<=0){
			oMarquee[0].scrollTop = 0;
		}else{
			oMarquee[0].scrollTop++;
		}
	}
	
	var ScrollLeft = function(){
		if(oMarqueeCopy[0].offsetWidth-oMarquee[0].scrollLeft<=0){
			oMarquee[0].scrollLeft = 0;
		}else{
			oMarquee[0].scrollLeft++;
		}
	}
	
	switch(direction){
		case "left":
			var oScroll=setInterval(ScrollLeft, delaytime);
			oMarquee.hover(function(){
				clearInterval(oScroll);
			}, function(){
				oScroll=setInterval(ScrollLeft, delaytime);
			});
			break;
		case "up":
		default:
			var oScroll = setInterval(ScrollUp, delaytime);
			oMarquee.hover(function(){
				clearInterval(oScroll);
			}, function(){
				oScroll=setInterval(ScrollUp, delaytime);
			});
	}
}

//列高度统一
function HeightFix(column, column2, offset){
	var oCol = jQuery(column);
	var oCol2 = jQuery(column2);
	if(offset == undefined)offset = 0;
	if(oCol.height() > oCol2.height()){
		oCol2.height(oCol.height() - offset);
	}else{
		oCol.height(oCol2.height() - offset);
	}
}

//获得日期
function RunGLNL(obj){
	var today = new Date();
	var d = new Array("星期日","星期一","星期二","星期三","星期四","星期五","星期六");
	var DDDD = (today.getFullYear()<100 ? today.getFullYear()+1900:today.getFullYear())+"年"+(today.getMonth()+1)+"月"+today.getDate()+"日";
	DDDD = DDDD + " " + d[today.getDay()];
	jQuery(obj).text(DDDD);
}

//悬停选中效果
function hoverSelectList(obj, sItem, className){
	var sItem = (sItem==undefined || sItem==null) ? "li" : sItem;
	var className = (className==undefined || className==null) ? "hover" : className;
	var isFixOnFirst = false;
	
	jQuery(obj).each(function(j, cell){
		jQuery(sItem, cell).first().addClass(className);
		jQuery(sItem, cell).each(function(i, ele){
			jQuery(ele).mouseover(function(){
				jQuery(this).addClass(className).siblings().removeClass(className);
			});
		}); 
		if(isFixOnFirst){
			jQuery(cell).mouseout(function(){
				jQuery(sItem, cell).removeClass(className);
				jQuery(sItem, cell).first().addClass(className);
			});
		}
	});
}

//针对ie6增加悬停样式
function ie6HoverFix(obj, className){
	if(isIE6){
		var className = (className==undefined || className==null) ? "hover" : className;
		jQuery(obj).hover(function(){
			jQuery(this).addClass(className);
		},function(){
			jQuery(this).removeClass(className);
		});
	}
}

 

function asyncAccess(path,mesage) {
    jQuery.get(path, function(data) {
        alert(mesage);
    });
}
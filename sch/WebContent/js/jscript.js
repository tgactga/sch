var whichIt=null;
self.onError=null;
var currentY=lastScrollY=0;
var W3C=(document.getElementById)?true:false;
var agt=navigator.userAgent.toLowerCase();
var IE=((agt.indexOf('msie')!=-1)&&(agt.indexOf('opera')==-1)&&(agt.indexOf('omniweb')==-1));
var IE5=(W3C&&IE)?true:false;
var NS6=(W3C&&(navigator.appName=='Netscape'))?true:false;
var FF2=(W3C&&(agt.indexOf('mozilla')!=-1))?true:false;
var OP8=(W3C&&(agt.indexOf('opera')!=-1))?true:false;
var today=new Date();
var showExtMenu=0;
function docEle(o){
	var o=document.getElementById(o)?document.getElementById(o):o;
	return o;
};
document.getElementsByClassName=function(className,oBox){
	this.d=oBox||document;
	var children=this.d.getElementsByTagName('*')||document.all;
	var elements=new Array();
	for(var i=0;i<children.length;i++){
		var child=children[i];
		var classNames=child.className.split(' ');
		for(var j=0;j<classNames.length;j++){
			if(classNames[j]==className){
				elements.push(child);
				break;
			}
		}
	}
	return elements;
};

function jsp_pagechange(po_main){
    var itab=0;
    var btab=false;
    var po_objs=document.getElementsByName(po_main.id);
    for(var i=0;i<po_objs.length;i++){
        var sclassbefore=po_objs[i].className.substring(0,po_objs[i].className.indexOf('_')); 
        var ps_temp=po_objs[i].className.toString().substr(po_objs[i].className.indexOf('_'));
        if(!btab){itab++;}
        if(po_main==po_objs[i]){
            po_objs[i].className=sclassbefore+'_sel';
            btab=true;
        }
        else{
            po_objs[i].className=sclassbefore+'_nor';
        }
    }
    var itemp=0;
    var po_objs=document.getElementsByName(po_main.id+'_content');
    for(var i=0;i<po_objs.length;i++){
        if(po_objs[i].id==(po_main.id+'_content')){
            itemp++;
            if(itemp==itab){
                po_objs[i].className=po_main.id+'_content_sel';
                window.setTimeout("jsp_pageclear('" + po_main.id + "'," + itemp + ")",6000)
            }
            else{
                po_objs[i].className=po_main.id+'_content_nor';
            }
        }
    }
};
function jsp_pageclear(po_main,itemp){
    var po_objs=document.getElementsByName(po_main + '_content');
    for(var i=0;i<po_objs.length;i++){
        if(po_objs[i].id==po_main+'_content'&& i==itemp-1){
            po_objs[i].className=po_main+'_content_nor';
        }
    }
};

var disappeardelay=500  //menu disappear speed onMouseout (in miliseconds)
function showDiv(obj_tab){
    clearTimer();
    var obj_tab_content=docEle(obj_tab.id + 'D');
    clearDiv(obj_tab);
    obj_tab.className='selected';//选中当前的tab
    obj_tab_content.style.display='block';//显示弹出子菜单
    obj_tab_content.style.zIndex=10;
}
function showDiv1(obj_tab){
    clearTimer();
    clearDiv1(obj_tab);
    obj_tab.className='selected';//选中当前的tab
 
}

function hideDiv(obj_tab,def_tab){
    if (IE||NS6)
        if ( typeof obj_tab!="object"){
        delayhide=setTimeout("hideExtMenu('"+obj_tab+"','"+def_tab+"')",disappeardelay)
        }
        else{
        delayhide=setTimeout("hideExtMenu('"+obj_tab.id+"','"+def_tab+"')",disappeardelay)
        }
}
function hideDiv1(obj_tab,def_tab){
    if (IE||NS6)
        if ( typeof obj_tab!="object"){
        delayhide=setTimeout("hideExtMenu1('"+obj_tab+"','"+def_tab+"')",disappeardelay)
        }
        else{
        delayhide=setTimeout("hideExtMenu1('"+obj_tab.id+"','"+def_tab+"')",disappeardelay)
        }
}

function clearDiv(tab){
    var obj_tab=docEle(tab);
    var obj_tab_content=docEle(obj_tab.id + 'D');
    var sys = getBrowser();
    if (sys.Firefox){
    	var hideid = $(tab).attr("id");
    	hideid = hideid + "D";
    	$("#extMenu").children().each(function(){
    		if($(this).attr("id") == hideid){
    			$(this).css({
    				"display":"block"
    			});
    		}else{
    			$(this).css({
    				"display":"none"
    			});
    		}
    	});
    }else{
    	var obj_tabs=obj_tab.parentElement.children;
        var obj_tab_contents=obj_tab_content.parentElement.children;
	    for(var i=0;i<obj_tab_contents.length;i++){
	        obj_tabs[i].className='';
	        obj_tab_contents[i].style.display='none';
	    }
	}
}
function clearDiv1(tab){
    var obj_tab=docEle(tab);
    if (IE){
        var obj_tabs=obj_tab.parentElement.children;
    }else{
        var obj_tabs=document.getElementsByName(obj_tab.id.substring(0,obj_tab.id.indexOf('_'))+'_tab');
    }
    for(var i=0;i<obj_tabs.length;i++){
        obj_tabs[i].className='';
    }
}

function hideExtMenu(tab,def_tab){
    var obj_tab=docEle(tab);
    clearDiv(obj_tab);
    docEle(obj_tab.id.substring(0,obj_tab.id.indexOf('_'))+'_'+def_tab).className='selected';//选中原来的tab
	var obj_tab_content=docEle(obj_tab.id + 'D');
    clearDiv(obj_tab);
    obj_tab_content.style.display='block';
}
function hideExtMenu1(tab,def_tab){
    var obj_tab=docEle(tab);
    clearDiv1(obj_tab);
    docEle(obj_tab.id.substring(0,obj_tab.id.indexOf('_'))+'_'+def_tab).className='selected';//选中原来的tab
}
function clearTimer(){
    if (typeof delayhide!="undefined")
    clearTimeout(delayhide)
}
function initArray(){
this.length=initArray.arguments.length;
for(var i=0;i<this.length;i++){this[i+1]=initArray.arguments[i];}
};

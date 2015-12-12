function getRootPath(){
	var strFullPath=window.document.location.href;
	var strPath=window.document.location.pathname;
	var pos=strFullPath.indexOf(strPath);
	var prePath=strFullPath.substring(0,pos);
	var postPath=strPath.substring(0,strPath.substr(1).indexOf('/')+1);
	//return(prePath+postPath);
	return prePath;
}
function msgSuccess(msg){
	$.msgbox.show({
        message: msg,
        icon: 'ok',
        timeOut: 1500,
        beforeHide: function(){
        }
    });
}
function msgError(msg){
	$.msgbox.show({
        message: msg,
        icon: 'no',
        timeOut: 1500,
        beforeHide: function(){
        }
    });
}
function msgSuccessReload(msg){
	$.msgbox.show({
        message: msg,
        icon: 'ok',
        timeOut: 1500,
        beforeHide: function(){
        	location.reload();
        }
    });
}
function msgSuccessUrl(msg,url){
	$.msgbox.show({
        message: msg,
        icon: 'ok',
        timeOut: 1500,
        beforeHide: function(){
        	location.replace(url);
        }
    });
}
function msgSuccessLoadGrid(msg){
	$("#flexTable").flexReload();
	$.msgbox.show({
        message: msg,
        icon: 'ok',
        timeOut: 1500,
        beforeHide: function(){
        }
    });
}
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
function deleteItem(ID,table){
	if(window.confirm('您确定要删除这条信息吗？')){
		$.ajax({
			type:"post",
			url:getRootPath()+"/CommonAction.do",
			dataType:"json",
			data:'operType=deleteCommon&ID='+ID+'&TABLE='+encodeURIComponent(table),
			success:function(data){
				if(data.SUCCESS == 1){
					$("#flexTable").flexReload();
					msgSuccess('删除成功');
				}else{
					$("#flexTable").flexReload();
					msgError('删除失败');
				}
			}
		});
	}else{
		return;
	}
}
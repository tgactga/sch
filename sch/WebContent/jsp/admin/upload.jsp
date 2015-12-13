<%@ page pageEncoding="utf-8"%>  
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>  

<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<html>  
    <head>  
        <title>上传任意多个文件（总大小不能超过2M)</title>  
        
		<link href="<%=path%>/css/jqueryui/jquery-ui-1.10.3.custom.min.css" rel="stylesheet" type="text/css" />
    	<link href="<%=path%>/js/msgbox/msgbox.css" rel="stylesheet" />
		<script src="<%=path%>/js/jquery/jquery-1.11.1.min.js" type="text/javascript"></script>
    	<script src="<%=path%>/js/jquery/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
		<script src="<%=path%>/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    	<script src="<%=path%>/js/msgbox/msgbox.js" type="text/javascript"></script>
    	<script src="<%=path%>/js/common.js" type="text/javascript"></script>
		<script src="<%=path%>/js/ckeditor/ckeditor.js" type="text/javascript"></script>
    
    
    
        <script language="javascript"> 
        Array.prototype.remove=function(dx) 
        { 
            if(isNaN(dx)||dx>this.length){return false;} 
            for(var i=0,n=0;i<this.length;i++) 
            { 
                if(this[i]!=this[dx]) 
                { 
                    this[n++]=this[i] 
                } 
            } 
            this.length-=1 
        } 
        
        	var uploadFileArr = new Array();
        
              // 在DOM中插入一个上传文件列表项（div元素)和一个<input type="file"/>元素  
              function insertNextFile(obj)   
              {   
            // 获取上传控制个数  
                  var childnum = document.getElementById("files").getElementsByTagName("input").length;         
                  var id = childnum - 1;  
                  var fullName = obj.value;  
                  // 插入<div>元素及其子元素  
                  var fileHtml = '';  
                  fileHtml += '<div  id = "file_preview' + id + '" style ="border-bottom: 1px solid #CCC;">';  
                  fileHtml += '<img  width =30 height = 30 src ="<%=basePath%>/images/file.png" title="' + fullName + '"/>';  
                  fileHtml += '<a href="javascript:;" onclick="removeFile(' + id + ');">删除</a>   ';  
                  fileHtml += fullName.substr(fullName.lastIndexOf('\\')+1) +'  </div>';  
                  //alert(fullName.substr(fullName.lastIndexOf('\\')+1));
                  uploadFileArr.push(fullName.substr(fullName.lastIndexOf('\\')+1));
                  
                  var fileElement = document.getElementById("files_preview");  
                  fileElement.innerHTML = fileElement.innerHTML + fileHtml;      
                  obj.style.display = 'none';   // 隐藏当前的<input type=”file”/>元素  
                  addUploadFile(childnum);  // 插入新的<input type=”file”/>元素  
              }  
              //  插入新的<input type=”file”/>元素，适合于不同的浏览器（包括IE、FireFox等）  
              function addUploadFile(index)  
              {  
                  try  // 用于IE浏览器  
                  {     
                      var uploadHTML = document.createElement( "<input type='file' id='file_" + index +   
                                              "' name='file[" + index + "]' onchange='insertNextFile(this)'/>");  
                      document.getElementById("files").appendChild(uploadHTML);  
                  }  
                  catch(e)  // 用于其他浏览器  
                  {   
                      var uploadObj = document.createElement("input");  
                      uploadObj.setAttribute("name", "file[" + index + "]");  
                      uploadObj.setAttribute("onchange", "insertNextFile(this)");  
                      uploadObj.setAttribute("type", "file");  
                      uploadObj.setAttribute("id", "file_" + index);  
                      document.getElementById("files").appendChild(uploadObj);  
                  }  
              }  
              function removeFile(index)  // 删除当前文件的<div>和<input type=”file”/>元素  
              {  
            	  uploadFileArr.remove(index);
                  document.getElementById("files_preview").removeChild(document.getElementById("file_preview" + index));   
                  document.getElementById("files").removeChild(document.getElementById("file_" + index));      
              }  
              function showStatus(obj)  // 显示“正在上传文件”提示信息  
              {  
                document.getElementById("status").style.visibility="visible";  
                
                var uploadFileNames = uploadFileArr.join("<br/>");
          	  	//alert(uploadFileNames);
          	  
          	  	$('#FILES', window.parent.document).html(uploadFileNames);
          	  
          	  	$("#uploadForm").submit();
          	  
              }
              
        </script>  
    </head>  
    <body>  
        <form id="uploadForm" enctype="multipart/form-data" action="<%=path%>/multiUpload.do"  method="post">
            <span id="files"> <%--  在此处插入用于上传文件的input元素 --%>   
               <input type="file" id="file_0" name="file[0]" onchange="insertNextFile(this)" /> </span>    
               <input type="button" value="上传 " onclick="showStatus(this);" />
        </form>
        <p>  
        <div id="status" style="visibility: hidden; color: Red">  
            	正在上传文件  
        </div>  
        <p>  
            <%--  在此处用DOM技术插入上传文件列表项  --%>  
        <div id="files_preview"  
            style="overflow: auto"></div>  
    </body>  
</html> 
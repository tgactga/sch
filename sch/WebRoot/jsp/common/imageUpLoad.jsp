<%@ page contentType="text/html" language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="com.jspsmart.upload.SmartUpload"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html;charset=utf-8");
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String rootPath = request.getSession().getServletContext().getRealPath("/");
	//先建文件夹
	String folderPath = rootPath + "file/imgfile/";
	String str_Path = folderPath.toString().replace("\\", "/");
	//上传文件
	SmartUpload mySmartUpload=new SmartUpload();
	//设置允许上传的文件类型
	//mySmartUpload.setAllowedFilesList("xls");
	mySmartUpload.initialize(pageContext);
	mySmartUpload.upload();
	
	String CURDATE = mySmartUpload.getRequest().getParameter("CURDATE").toString();//获取提交的表单中的值，根据name获得
	for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
		com.jspsmart.upload.File file = mySmartUpload.getFiles().getFile(i);
		if(!file.getFileName().equals("")){
			String FILE_PATH = str_Path + CURDATE + ".jpg";
			file.saveAs(FILE_PATH);
		}
	}
%>
</body>
</html>
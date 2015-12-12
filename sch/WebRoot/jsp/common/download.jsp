<%@ page contentType="text/html;charset=utf-8" import="com.jspsmart.upload.*" %>
<%
	request.setCharacterEncoding("utf-8");
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	String rootPath = request.getSession().getServletContext().getRealPath("/");
	String url=new String(request.getParameter("url").getBytes("ISO-8859-1"),"utf-8");
	url = url.replaceAll("/", "\\\\");
	String FILE_NAME = new String(request.getParameter("FILE_NAME").getBytes("ISO-8859-1"),"utf-8");
	//System.out.println("url="+url.substring(url.lastIndexOf("/")));
	//使用方法
	//在javaScript中调用
	//window.open("<=basePath>FileUpLoad/download.jsp?url=FileUpLoad/AllUploadFiles/" + encodeURI(相对路径+文件名) ,"_self");
%>
<%! 
   public String toUtf8String(String s)
   {
      StringBuffer sb = new StringBuffer();
      for (int i = 0; i < s.length(); i++)
      {
         char c = s.charAt(i);
         if (c >= 0 && c <= 255)
         {
            sb.append(c);
         }
         else
         {
            byte[] b;
            try
            {
               b = Character.toString(c).getBytes("utf-8");
            }
            catch (Exception ex)
            {
				//System.out.println(ex);
				b = new byte[0];
            }
            for (int j = 0; j < b.length; j++)
            {
               int k = b[j];
               if (k < 0)
                  k += 256;
               sb.append("%" + Integer.toHexString(k).toUpperCase());
            }
         }
      }
      return sb.toString();
   }
%>
<%
 try{ 
	// 新建一个SmartUpload对象
	SmartUpload su = new SmartUpload();
	// 初始化
	su.initialize(pageContext);
	// 设定contentDisposition为null以禁止浏览器自动打开文件，
	//保证点击链接后是下载文件。若不设定，则下载的文件扩展名为
	//doc时，浏览器将自动用word打开它。扩展名为pdf时，
	//浏览器将用acrobat打开。
	su.setContentDisposition(null);
	// 下载文件
	su.downloadFile(rootPath+url,null,toUtf8String(FILE_NAME));
}catch(Exception e){
	e.printStackTrace();
}
out.clear();
out=pageContext.pushBody();
%>
package com.huahong.admin.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.huahong.admin.dao.CommonDAO;
import com.huahong.erp.util.GetParam;
import com.huahong.erp.util.exchange;
import com.huahong.util.CommonFun;

public class DocManagementAction extends Action{
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response){
		try {
			String operType = request.getParameter("operType");
			if(operType.equals("queryDoc")){
				return queryDoc(mapping, form, request, response);
			}
			if(operType.equals("deleteDoc")){
				return deleteDoc(mapping, form, request, response);
			}
			if(operType.equals("dowload")){
				return (ActionForward) download(mapping, form, request, response);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	
	static String fileUploadPath = null;
    static{
    	Properties prop = new Properties();
    	InputStream in = UploadMoreAction.class.getClassLoader().getResourceAsStream("/config/fileupload.properties");
    	try {
			prop.load(in);
			fileUploadPath = prop.getProperty("fileUploadPath");
			File path = new File(fileUploadPath);
			if(!path.exists()){
				path.mkdir();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
    
	private ActionForward queryDoc(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			mapPara.put("rp", Integer.parseInt(mapPara.get("rp").toString()));
			mapPara.put("page",(Integer.parseInt(mapPara.get("page").toString())-1)*Integer.parseInt(mapPara.get("rp").toString()));
			String FILENAME = mapPara.get("FILENAME").toString();
//			CommonDAO dao = new CommonDAO();
//			CommonFun fun = new CommonFun();
//			String condition = "";
//			 
//			if(!FILENAME.equals("")){
////				condition = condition.substring(0,condition.length()-4);
//				condition = "  AND  FILES LIKE '%"+FILENAME+"%' ";
//				mapPara.put("condition", condition);
//			}
//			int total = fun.getTotalItem("SELECT COUNT(*) AS CON FROM new_content N WHERE N.FILES IS NOT NULL"+condition);
//			String json="";
//			int a = Integer.parseInt(mapPara.get("page").toString())+1;
//			int b = Integer.parseInt(mapPara.get("rp").toString());
//			int page = a/b;
//			page = page + 1;
//			List list = dao.getDocList(mapPara);
			List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
			File downloadFilePath = new File(fileUploadPath);
			File[] files = {};
			if(downloadFilePath.isDirectory()){
				files = downloadFilePath.listFiles();
				int count = 0;
				SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd HH:mm:ss");
				for(File file : files){
					Map<String, Object> map = new HashMap<String, Object>();
					map.put("ROWNUM", count++);
					
					String fileCode=(String)System.getProperties().get("file.encoding");

					String fileName = file.getName();

					fileName = new String (fileName.getBytes(fileCode),fileCode);

						
					map.put("FILES", fileName);
					map.put("URL", fileUploadPath + file.getName());
					Calendar cal = Calendar.getInstance();  
			        long time = file.lastModified();  
			        cal.setTimeInMillis(time);    
					map.put("EDIT_TIME", sdf.format(cal.getTime()));
					list.add(map);
				}
			}
			
			int total = files.length;
			String json="";
			int a = Integer.parseInt(mapPara.get("page").toString())+1;
			int b = Integer.parseInt(mapPara.get("rp").toString());
			int page = a/b;
			page = page + 1;
			
			String path = request.getContextPath();
			if(list!=null && list.size()>0){
				json+="{\"page\":"+page+",\"total\":"+total+",\"rows\":[";
			    for(int i=0;i<list.size();i++){
			    	if(i >= (page-1)* b && i < page *b ){
				    	String ID=exchange.toHtml(((HashMap)list.get(i)).get("ROWNUM").toString());
				    	String FILES = exchange.toHtml(((HashMap)list.get(i)).get("FILES").toString());
				    	String URL= exchange.toHtml(((HashMap)list.get(i)).get("URL").toString());
				    	String EDIT_TIME =  exchange.toHtml(((HashMap)list.get(i)).get("EDIT_TIME").toString());
				    	String DEAL = "<a href='#' onclick='dowload(\\\""+URL+"\\\")'>下载</a>&nbsp;|&nbsp;"+
				    				  "<a href='#' onclick='deleteDoc(\\\""+URL+"\\\")'>删除</a>";
				    	json+="{\"id\":\""+ID+"\",";
				    	json+="\"cell\":[\""+(i+a)+"\",\""+FILES+"\",\""+URL+"\",\""+EDIT_TIME+"\",\""+DEAL+"\"]},";
			    	}
			    }
			    json=json.substring(0,json.length()-1);
			    json+="]}";
			}else{
				json="[]";
			}
			//System.out.println(json);
			response.getWriter().write(json);
			response.getWriter().close();
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	private ActionForward deleteDoc(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			String fullPath = request.getParameter("path");
			File file = new File(fullPath);
			file.deleteOnExit();
			response.getWriter().write("{\"SUCCESS\":\"1\"}");
		    response.getWriter().close();
		}catch(Exception e){
			e.printStackTrace();
			response.getWriter().write("{\"SUCCESS\":\"0\"}");
		    response.getWriter().close();
		}
	    return null;
	}

	
	 public HttpServletResponse download(ActionMapping mapping, ActionForm form,
				HttpServletRequest request, HttpServletResponse response) {
	        try {
	        	String path = request.getParameter("path");
	        	path = new String(path.getBytes("iso-8859-1"), "UTF-8");
	            // path是指欲下载的文件的路径。
	            File file = new File(path);
	            if(!file.exists()){
	            	//如果文件不存在，那么加上下载路径再试试
	            	file = new File(fileUploadPath + path);
	            	path = fileUploadPath + path;
	            }
	            // 取得文件名。
	            String filename = file.getName();
	            // 取得文件的后缀名。
	            String ext = filename.substring(filename.lastIndexOf(".") + 1).toUpperCase();

	            // 以流的形式下载文件。
	            InputStream fis = new BufferedInputStream(new FileInputStream(path));
	            byte[] buffer = new byte[fis.available()];
	            fis.read(buffer);
	            fis.close();
	            // 清空response
	            response.reset();
	            // 设置response的Header
	            response.addHeader("Content-Disposition", "attachment;filename=" + new String(new String(filename.getBytes("UTF-8"),"iso-8859-1")));
	            response.addHeader("Content-Length", "" + file.length());
	            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
	            response.setContentType("application/octet-stream");
	            toClient.write(buffer);
	            toClient.flush();
	            toClient.close();
	        } catch (IOException ex) {
	            ex.printStackTrace();
	            try {
					response.getWriter().write("下载文件失败，原因：" + ex.getMessage());
					 response.getWriter().close();
				} catch (IOException e) {
					e.printStackTrace();
				}
	            return null;
	        }
	        return response;
	    }
	 
}

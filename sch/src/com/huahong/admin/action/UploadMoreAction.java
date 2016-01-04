package com.huahong.admin.action;

import java.io.File;
import java.io.FileOutputStream;  
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
  
import org.apache.struts.action.Action;  
import org.apache.struts.action.ActionForm;  
import org.apache.struts.action.ActionForward;  
import org.apache.struts.action.ActionMapping;  
import org.apache.struts.upload.FormFile;  

import com.huahong.erp.util.UploadMoreForm;
  
  
public class UploadMoreAction extends Action {
	static String fileUploadPath = null;
    static{
    	Properties prop = new Properties();
    	InputStream in = UploadMoreAction.class.getClassLoader().getResourceAsStream("/config/fileupload.properties");
    	try {
			prop.load(in);
			fileUploadPath = System.getProperty("user.dir") + prop.getProperty("fileUploadPath");
			File path = new File(fileUploadPath);
			if(!path.exists()){
				path.mkdir();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
    }
    public ActionForward execute(ActionMapping mapping, ActionForm form,  
            HttpServletRequest request, HttpServletResponse response)  
    {  
    	try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e2) {
			e2.printStackTrace();
		}
		
        UploadMoreForm umForm = (UploadMoreForm) form;  
        int count = 0;  
        try {  
            count = umForm.getFileCount();   // 获得上传文件的总数  
            for (int i = 0; i < count; i++)  
            {  
                FormFile file = umForm.getFile(i);   
                
                
                FileOutputStream fos = new FileOutputStream(fileUploadPath + "\\" + file.getFileName()); //创建输出流  
                fos.write(file.getFileData()); //写入  
                fos.flush();//释放  
                fos.close(); //关闭  
            }
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("上传成功");
    	    response.getWriter().close();
        } catch (Exception e) {  
        	try {
        		response.setCharacterEncoding("UTF-8");
				response.getWriter().write("上传失败,请重试！");
				response.getWriter().close();
			} catch (IOException e1) {
				e1.printStackTrace();
			}
    	    
            e.printStackTrace();  
        }
        
        return null;  
    }  
}

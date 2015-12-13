package com.huahong.admin.action;

import java.io.File;
import java.io.FileOutputStream;  
import java.io.IOException;
import java.io.InputStream;
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
    	InputStream in = UploadMoreAction.class.getClassLoader().getResourceAsStream("/config/config.properties");
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
    public ActionForward execute(ActionMapping mapping, ActionForm form,  
            HttpServletRequest request, HttpServletResponse response)  
    {  
        UploadMoreForm umForm = (UploadMoreForm) form;  
        int count = 0;  
        try {  
            count = umForm.getFileCount();   // 获得上传文件的总数  
            for (int i = 0; i < count; i++)  
            {  
                FormFile file = umForm.getFile(i);   
                System.out.println(file.getFileName());
                FileOutputStream fos = new FileOutputStream(fileUploadPath + "\\" + file.getFileName()); //创建输出流  
                fos.write(file.getFileData()); //写入  
                fos.flush();//释放  
                fos.close(); //关闭  
            }
            request.getSession().setAttribute("uploadFileNames", umForm.getFileNames());
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

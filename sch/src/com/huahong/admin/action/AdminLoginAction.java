package com.huahong.admin.action;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.huahong.admin.dao.AdminLoginDAO;
import com.huahong.erp.util.GetParam;
import com.huahong.util.ToLowerAndUpper;
import com.huahong.util.security.MD5;

public class AdminLoginAction extends Action{
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response){
		try {
			String operType = request.getParameter("operType");
			if(operType.equals("adminLogin")){
				return adminLogin(mapping, form, request, response);
			}
			if(operType.equals("updatePsw")){
				return updatePsw(mapping, form, request, response);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	
	private ActionForward updatePsw(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			
			AdminLoginDAO dao = new AdminLoginDAO();
			MD5 md = new MD5();
			String mi = md.getMD5ofStr(mapPara.get("USER_PASSWORD").toString());
			mapPara.put("USER_PASSWORD", mi);
			Boolean updateflag = dao.updateAdminUser(mapPara);
			
				if(updateflag){//=修改成功
					response.getWriter().write("{\"SUCCESS\":\"1\"}");
				    response.getWriter().close();
				}else{// 有误
					response.getWriter().write("{\"SUCCESS\":\"0\"}");
				    response.getWriter().close();
				}
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	private ActionForward adminLogin(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			HttpSession session = request.getSession();
			String WDCOOKKEY = session.getAttribute("WDCOOKKEY").toString();
			String CHECKCODE = mapPara.get("CHECKCODE").toString();
			WDCOOKKEY = ToLowerAndUpper.toLower(WDCOOKKEY);
			CHECKCODE = ToLowerAndUpper.toLower(CHECKCODE);
			AdminLoginDAO dao = new AdminLoginDAO();
			if(WDCOOKKEY.equals(CHECKCODE)){
				MD5 md = new MD5();
				String mi = md.getMD5ofStr(mapPara.get("USER_PASSWORD").toString());
				mapPara.put("USER_PASSWORD_MI", mi);
				List list = dao.getAdminUser(mapPara);
				if(list!=null && list.size()>0){//认证成功
					session.setAttribute("USER_ID", ((HashMap)list.get(0)).get("ID").toString());
					session.setAttribute("USER_CODE", mapPara.get("USER_CODE").toString());
					session.setAttribute("USER_NAME", ((HashMap)list.get(0)).get("USER_NAME").toString());
					session.setAttribute("ROLE_NAME", ((HashMap)list.get(0)).get("ROLE_NAME").toString());
					response.getWriter().write("{\"SUCCESS\":\"1\"}");
				    response.getWriter().close();
				}else{//用户名或密码输入有误
					response.getWriter().write("{\"SUCCESS\":\"0\"}");
				    response.getWriter().close();
				}
			}else{
				response.getWriter().write("{\"SUCCESS\":\"2\"}");
			    response.getWriter().close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
}
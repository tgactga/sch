package com.huahong.admin.action;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.huahong.admin.bo.CommonFun;
import com.huahong.admin.dao.UserManagementDAO;
import com.huahong.erp.util.GetParam;
import com.huahong.erp.util.GetRecentDate;
import com.huahong.erp.util.exchange;
import com.huahong.util.security.MD5;

public class UserManagementAction extends Action{
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response){
		try {
			String operType = request.getParameter("operType");
			if(operType.equals("searchAllUser")){
				return searchAllUser(mapping, form, request, response);//查询所有用户
			}else if(operType.equals("addUser")){
				return addUser(mapping, form, request, response);//添加用户
			}else if(operType.equals("updateUser")){
				return updateUser(mapping, form, request, response);//修改用户
			}else if(operType.equals("disableUser")){
				//return disableUser(mapping, form, request, response);//禁用用户
			}else if(operType.equals("getUnitDep")){
				//return getUnitDep(mapping, form, request, response);//查询科室
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	private ActionForward searchAllUser(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			String path = request.getContextPath();
			HashMap mapPara = GetParam.GetParamValue(request,"ISO-8859-1","utf-8");
			mapPara.put("rp", Integer.parseInt(mapPara.get("rp").toString()));
			mapPara.put("page",(Integer.parseInt(mapPara.get("page").toString())-1)*Integer.parseInt(mapPara.get("rp").toString()));
			UserManagementDAO dao = new UserManagementDAO();
			CommonFun fun = new CommonFun();
			int total = fun.getTotalItem("SELECT COUNT(*) AS CON FROM user");
			String json="";
			int a = Integer.parseInt(mapPara.get("page").toString())+1;
			int b = Integer.parseInt(mapPara.get("rp").toString());
			int page = a/b;
			page = page + 1;
			List list = dao.searchAllUserList(mapPara);
			if(list!=null && list.size()>0){
				json+="{\"page\":"+page+",\"total\":"+total+",\"rows\":[";
			    for(int i=0;i<list.size();i++){
			    	String ID=exchange.toHtml(((HashMap)list.get(i)).get("ID").toString());
			    	String USER_CODE=exchange.toHtml(((HashMap)list.get(i)).get("USER_CODE").toString());
			    	String USER_NAME = exchange.toHtml(((HashMap)list.get(i)).get("USER_NAME").toString());
			    	String ROLE_NAME = exchange.toHtml(((HashMap)list.get(i)).get("ROLE_NAME").toString());
			    	String RID = exchange.toHtml(((HashMap)list.get(i)).get("RID").toString());
			    	String CHU_NAME = exchange.toHtml(((HashMap)list.get(i)).get("CHU_NAME").toString());
			    	String CHU_ID = exchange.toHtml(((HashMap)list.get(i)).get("CHU_ID").toString());
			    	String REGIST_TIME = exchange.toHtml(((HashMap)list.get(i)).get("REGIST_TIME").toString());
			    	String LAST_LOGIN_TIME = exchange.toHtml(((HashMap)list.get(i)).get("LAST_LOGIN_TIME").toString());
			    	String DEAL = "<a onclick='editItem(this)' style='cursor:pointer;'>编辑</a>&nbsp;|&nbsp;<a href='#' onclick='deleteItem(\\\""+ID+"\\\",\\\"user\\\")' style='cursor:pointer;'>删除</a>";
			    	json+="{\"id\":\""+ID+"\",";
			    	json+="\"cell\":[\""+(i+a)+"\",\""+USER_CODE+"\",\""+USER_NAME+"\",\""+CHU_NAME+"\",\""+CHU_ID+"\",\""+ROLE_NAME+"\",\""+RID+"\",\""+REGIST_TIME+"\",\""+LAST_LOGIN_TIME+"\",\""+DEAL+"\"]},";
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
	private ActionForward addUser(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			MD5 md = new MD5();
			String mi = md.getMD5ofStr(mapPara.get("USER_PASSWORD").toString());
			mapPara.put("USER_PASSWORD", mi);
			mapPara.put("REGIST_TIME", GetRecentDate.getRecentDate("yyyy-MM-dd HH:mm:ss"));
			UserManagementDAO dao = new UserManagementDAO();
			boolean tag = dao.insertUser(mapPara);
			if(tag == true){
				response.getWriter().write("{\"SUCCESS\":\"1\"}");
			    response.getWriter().close();
			}else{
				response.getWriter().write("{\"SUCCESS\":\"0\"}");
			    response.getWriter().close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	private ActionForward updateUser(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			UserManagementDAO dao = new UserManagementDAO();
			boolean tag = dao.updateUser(mapPara);
			if(tag == true){
				response.getWriter().write("{\"SUCCESS\":\"1\"}");
			    response.getWriter().close();
			}else{
				response.getWriter().write("{\"SUCCESS\":\"0\"}");
			    response.getWriter().close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
}

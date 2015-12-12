package com.huahong.admin.action;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.huahong.admin.dao.AuditNewsDAO;
import com.huahong.admin.dao.TopTeacherDAO;
import com.huahong.erp.util.GetParam;
import com.huahong.erp.util.exchange;
import com.huahong.util.CommonFun;

public class TopTeacherAction extends Action{
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response){
		try {
			String operType = request.getParameter("operType");
			if(operType.equals("searchTopTeacher")){
				return searchTopTeacher(mapping, form, request, response);
			}else if(operType.equals("addTopTeacher")){
				return addTopTeacher(mapping, form, request, response);
			}else if(operType.equals("updateTopTeacher")){
				return updateTopTeacher(mapping, form, request, response);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	private ActionForward searchTopTeacher(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			mapPara.put("rp", Integer.parseInt(mapPara.get("rp").toString()));
			mapPara.put("page",(Integer.parseInt(mapPara.get("page").toString())-1)*Integer.parseInt(mapPara.get("rp").toString()));
			TopTeacherDAO dao = new TopTeacherDAO();
			CommonFun fun = new CommonFun();
			int total = fun.getTotalItem("SELECT COUNT(*) AS CON FROM god_teacher");
			String json="";
			int a = Integer.parseInt(mapPara.get("page").toString())+1;
			int b = Integer.parseInt(mapPara.get("rp").toString());
			int page = a/b;
			page = page + 1;
			List list = dao.getTeacherList(mapPara);
			String path = request.getContextPath();
			if(list!=null && list.size()>0){
				json+="{\"page\":"+page+",\"total\":"+total+",\"rows\":[";
			    for(int i=0;i<list.size();i++){
			    	String ID=exchange.toHtml(((HashMap)list.get(i)).get("ID").toString());
			    	String TEACH_NAME=exchange.toHtml(((HashMap)list.get(i)).get("TEACH_NAME").toString());
			    	String TEACH_KEMU = exchange.toHtml(((HashMap)list.get(i)).get("TEACH_KEMU").toString());
			    	String TEACH_NIANJI = exchange.toHtml(((HashMap)list.get(i)).get("TEACH_NIANJI").toString());
			    	String TEACH_PHOTO = exchange.toHtml(((HashMap)list.get(i)).get("TEACH_PHOTO").toString());
			    	TEACH_PHOTO = "<img src='"+path+TEACH_PHOTO+"' style='width:50px;height:80px;'/>";
			    	String TEACH_URL = exchange.toHtml(((HashMap)list.get(i)).get("TEACH_URL").toString());
			    	String DEAL = "<a href='#' onclick='updateNew(\\\""+ID+"\\\")'>修改</a>&nbsp;|&nbsp;<a href='#' onclick='deleteItem(\\\""+ID+"\\\",\\\"god_teacher\\\")'>删除</a>";
			    	json+="{\"id\":\""+ID+"\",";
			    	json+="\"cell\":[\""+(i+a)+"\",\""+TEACH_NAME+"\",\""+TEACH_KEMU+"\",\""+TEACH_NIANJI+"\",\""+TEACH_PHOTO+"\",\""+TEACH_URL+"\",\""+DEAL+"\"]},";
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
	private ActionForward addTopTeacher(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			TopTeacherDAO dao = new TopTeacherDAO();
			Boolean tag = dao.insertTeacher(mapPara);
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
	private ActionForward updateTopTeacher(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			TopTeacherDAO dao = new TopTeacherDAO();
			Boolean tag = dao.updateTeacher(mapPara);
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

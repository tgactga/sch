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
import com.huahong.admin.dao.ChuManagementDAO;
import com.huahong.erp.util.GetParam;
import com.huahong.erp.util.exchange;
import com.huahong.score.dao.ClassManagementDAO;

public class ChuManagementManagement extends Action{
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response){
		try {
			String operType = request.getParameter("operType");
			if(operType.equals("searchChu")){
				return searchChu(mapping, form, request, response);
			}else if(operType.equals("addChu")){
				return addChu(mapping, form, request, response);
			}else if(operType.equals("updateChu")){
				return updateChu(mapping, form, request, response);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	private ActionForward searchChu(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"ISO-8859-1","utf-8");
			mapPara.put("rp", Integer.parseInt(mapPara.get("rp").toString()));
			mapPara.put("page",(Integer.parseInt(mapPara.get("page").toString())-1)*Integer.parseInt(mapPara.get("rp").toString()));
			CommonFun fun = new CommonFun();
			ChuManagementDAO dao = new ChuManagementDAO();
			int total = fun.getTotalItem("SELECT COUNT(*) AS CON FROM chu");
			String json="";
			int a = Integer.parseInt(mapPara.get("page").toString())+1;
			int b = Integer.parseInt(mapPara.get("rp").toString());
			int page = a/b;
			page = page + 1;
			List list = dao.searchChuList(mapPara);
			if(list!=null && list.size()>0){
				json+="{\"page\":"+page+",\"total\":"+total+",\"rows\":[";
			    for(int i=0;i<list.size();i++){
			    	String ID=exchange.toHtml(((HashMap)list.get(i)).get("ID").toString());
			    	String CHU_NAME=exchange.toHtml(((HashMap)list.get(i)).get("CHU_NAME").toString());
			    	String DEAL = "<a href='#' onclick='updateData(this)'>编辑</a>&nbsp;|&nbsp;<a href='#' onclick='deleteItem(\\\""+ID+"\\\",\\\"chu\\\")'>删除</a>";
			    	json+="{\"id\":\""+ID+"\",";
			    	json+="\"cell\":[\""+(i+a)+"\",\""+CHU_NAME+"\",\""+DEAL+"\"]},";
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
	private ActionForward addChu(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			ChuManagementDAO dao = new ChuManagementDAO();
			boolean tag = dao.insertChu(mapPara);
			if(tag == true){
				response.getWriter().write("1");
			    response.getWriter().close();
			}else{
				response.getWriter().write("0");
			    response.getWriter().close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	private ActionForward updateChu(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			ChuManagementDAO dao = new ChuManagementDAO();
			boolean tag = dao.updateChu(mapPara);
			if(tag == true){
				response.getWriter().write("1");
			    response.getWriter().close();
			}else{
				response.getWriter().write("0");
			    response.getWriter().close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
}

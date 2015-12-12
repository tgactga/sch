package com.huahong.admin.action;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.huahong.admin.dao.HotNewDAO;
import com.huahong.erp.util.GetParam;
import com.huahong.erp.util.exchange;
import com.huahong.util.CommonFun;

public class HotNewAction extends Action{
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response){
		try {
			String operType = request.getParameter("operType");
			if(operType.equals("searchHotNew")){
				return searchHotNew(mapping, form, request, response);
			}else if(operType.equals("addNew")){
				return addNew(mapping, form, request, response);
			}else if(operType.equals("updateNew")){
				return updateNew(mapping, form, request, response);
			}else if(operType.equals("updateNewText")){
				return updateNewText(mapping, form, request, response);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	private ActionForward searchHotNew(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=gb2312");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			mapPara.put("rp", Integer.parseInt(mapPara.get("rp").toString()));
			mapPara.put("page",(Integer.parseInt(mapPara.get("page").toString())-1)*Integer.parseInt(mapPara.get("rp").toString()));
			String NEW_TYPE = mapPara.get("NEW_TYPE").toString();
			HotNewDAO dao = new HotNewDAO();
			CommonFun fun = new CommonFun();
			int total = fun.getTotalItem("SELECT COUNT(*) AS CON FROM show_img WHERE NEW_TYPE="+NEW_TYPE);
			String json="";
			int a = Integer.parseInt(mapPara.get("page").toString())+1;
			int b = Integer.parseInt(mapPara.get("rp").toString());
			int page = a/b;
			page = page + 1;
			List list = dao.getHotNewList(mapPara);
			String path = request.getContextPath();
			if(list!=null && list.size()>0){
				json+="{\"page\":"+page+",\"total\":"+total+",\"rows\":[";
			    for(int i=0;i<list.size();i++){
			    	String ID=exchange.toHtml(((HashMap)list.get(i)).get("ID").toString());
			    	String NEW_TITLE=exchange.toHtml(((HashMap)list.get(i)).get("NEW_TITLE").toString());
			    	String NEW_ORDER=exchange.toHtml(((HashMap)list.get(i)).get("NEW_ORDER").toString());
			    	String IMG_FILE=exchange.toHtml(((HashMap)list.get(i)).get("IMG_FILE").toString());
			    	IMG_FILE = "<img src='"+path+IMG_FILE+"' style='height:80px;'/>";
			    	String NEW_URL=exchange.toHtml(((HashMap)list.get(i)).get("NEW_URL").toString());
			    	NEW_TITLE = "<a href='"+NEW_URL+"' target='_blank'>"+NEW_TITLE+"</a>";
			    	String DEAL = "<a href='#' onclick='updateNew(\\\""+ID+"\\\")'>修改</a>&nbsp;|&nbsp;<a href='#' onclick='deleteItem(\\\""+ID+"\\\",\\\"show_img\\\")'>删除</a>";
			    	json+="{\"id\":\""+ID+"\",";
			    	json+="\"cell\":[\""+(i+a)+"\",\""+NEW_TITLE+"\",\""+IMG_FILE+"\",\""+NEW_ORDER+"\",\""+NEW_URL+"\",\""+DEAL+"\"]},";
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
	private ActionForward addNew(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=gb2312");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			HotNewDAO dao = new HotNewDAO();
			mapPara.put("NEW_URL", mapPara.get("NEW_URL").toString().replaceAll("☆", "."));
			boolean tag = dao.insertHotNew(mapPara);
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
	private ActionForward updateNew(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=gb2312");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			HotNewDAO dao = new HotNewDAO();
			mapPara.put("NEW_URL", mapPara.get("NEW_URL").toString().replaceAll("☆", "."));
			boolean tag = dao.updateHotNew(mapPara);
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
	private ActionForward updateNewText(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=gb2312");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			HotNewDAO dao = new HotNewDAO();
			boolean tag = dao.updateHotNewText(mapPara);
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
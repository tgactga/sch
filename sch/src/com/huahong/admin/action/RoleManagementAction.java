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
import com.huahong.admin.dao.RoleManagementDAO;
import com.huahong.erp.util.GetParam;
import com.huahong.erp.util.exchange;

public class RoleManagementAction extends Action{
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response){
		try {
			String operType = request.getParameter("operType");
			if(operType.equals("searchRole")){
				return searchRole(mapping, form, request, response);//查询角色列表
			}else if(operType.equals("addRole")){
				return addRole(mapping, form, request, response);//添加角色
			}else if(operType.equals("updateRole")){
				return updateRole(mapping, form, request, response);//修改角色
			}else if(operType.equals("showRoleTree")){
				return showRoleTree(mapping, form, request, response);//显示权限树
			}else if(operType.equals("assignPermissions")){
				return assignPermissions(mapping, form, request, response);//分配权限
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	private ActionForward searchRole(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			String path = request.getContextPath();
			HashMap mapPara = GetParam.GetParamValue(request,"ISO-8859-1","utf-8");
			mapPara.put("rp", Integer.parseInt(mapPara.get("rp").toString()));
			mapPara.put("page",(Integer.parseInt(mapPara.get("page").toString())-1)*Integer.parseInt(mapPara.get("rp").toString()));
			RoleManagementDAO dao = new RoleManagementDAO();
			CommonFun fun = new CommonFun();
			String condition = "";
			String SEARCH_ROLE_NAME = mapPara.get("ROLE_NAME").toString();
			if(!SEARCH_ROLE_NAME.equals("")){
				condition += "ROLE_NAME LIKE '%"+SEARCH_ROLE_NAME+"%' AND ";
			}
			if(!condition.equals("")){
				condition = condition.substring(0,condition.length()-4);
				condition = " WHERE " + condition;
				mapPara.put("condition", condition);
			}
			int total = fun.getTotalItem("SELECT COUNT(*) AS CON FROM role" + condition);
			String json="";
			int a = Integer.parseInt(mapPara.get("page").toString())+1;
			int b = Integer.parseInt(mapPara.get("rp").toString());
			int page = a/b;
			page = page + 1;
			List list = dao.searchRoleList(mapPara);
			if(list!=null && list.size()>0){
				json+="{\"page\":"+page+",\"total\":"+total+",\"rows\":[";
			    for(int i=0;i<list.size();i++){
			    	String ID=exchange.toHtml(((HashMap)list.get(i)).get("ID").toString());
			    	String ROLE_CODE=exchange.toHtml(((HashMap)list.get(i)).get("ROLE_CODE").toString());
			    	String ROLE_NAME = exchange.toHtml(((HashMap)list.get(i)).get("ROLE_NAME").toString());
			    	String ROLE_DESCRIBE = exchange.toHtml(((HashMap)list.get(i)).get("ROLE_DESCRIBE").toString());
			    	String ROLE = "<a onclick='shouquan(this)' style='cursor:pointer;'>权限</a>";
			    	String DEAL = "<a onclick='editItem(this)' style='cursor:pointer;'>编辑</a>&nbsp;|&nbsp;<a href='#' onclick='deleteItem(\\\""+ID+"\\\",\\\"role\\\")' style='cursor:pointer;'>删除</a>";
			    	json+="{\"id\":\""+ID+"\",";
			    	json+="\"cell\":[\""+(i+a)+"\",\""+ROLE_CODE+"\",\""+ROLE_NAME+"\",\""+ROLE_DESCRIBE+"\",\""+ROLE+"\",\""+DEAL+"\"]},";
			    }
			    json=json.substring(0,json.length()-1);
			    json+="]}";
			}else{
				json="[]";
			}
			response.getWriter().write(json);
			response.getWriter().close();
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	private ActionForward addRole(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			RoleManagementDAO dao = new RoleManagementDAO();
			boolean tag = dao.insertRole(mapPara);
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
	private ActionForward updateRole(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			RoleManagementDAO dao = new RoleManagementDAO();
			boolean tag = dao.updateRole(mapPara);
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
	private ActionForward showRoleTree(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			RoleManagementDAO dao = new RoleManagementDAO();
			List roleList = dao.getRoleTreeList();//查询所有树节点
			List roleHaveList = dao.getRoleHaveTreeList(mapPara);//查询授权后的树节点
			String roleId = "☆";
			if(roleHaveList!=null && roleHaveList.size()>0){
				for(int i=0;i<roleHaveList.size();i++){
					roleId += ((HashMap)roleHaveList.get(i)).get("TREE_ID").toString() + "☆";
				}
			}
			String json = "[";
			for(int i=0;i<roleList.size();i++){
				String haveid = "☆" + ((HashMap)roleList.get(i)).get("ID").toString() + "☆";
				if(roleId.indexOf(haveid)>-1){
					json += "{\"id\":\""+((HashMap)roleList.get(i)).get("ID").toString()+"\"," +
					"\"pId\":\""+((HashMap)roleList.get(i)).get("PID").toString()+"\"," +
					"\"name\":\""+((HashMap)roleList.get(i)).get("NAME").toString()+"\",\"checked\":\"true\"},";
				}else{
					json += "{\"id\":\""+((HashMap)roleList.get(i)).get("ID").toString()+"\"," +
							"\"pId\":\""+((HashMap)roleList.get(i)).get("PID").toString()+"\"," +
							"\"name\":\""+((HashMap)roleList.get(i)).get("NAME").toString()+"\"},";
				}
			}
			json = json.substring(0,json.length()-1)+"]";
			//System.out.println(json);
			response.getWriter().write(json);
			response.getWriter().close();
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	private ActionForward assignPermissions(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			String ID = mapPara.get("ID").toString();
			String[] treeId = mapPara.get("NODEID").toString().split("☆");
			RoleManagementDAO dao = new RoleManagementDAO();
			dao.deleteOldRole(ID);//删除旧的权限
			for(int i=0;i<treeId.length;i++){
				HashMap map = new HashMap();
				map.put("ROLE_ID", ID);
				map.put("TREE_ID", treeId[i]);
				dao.insertAssign(map);
			}
			response.getWriter().write("{\"SUCCESS\":\"1\"}");
		    response.getWriter().close();
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
}

package com.huahong.admin.action;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.huahong.admin.dao.CommonDAO;
import com.huahong.erp.util.GetMaxId;
import com.huahong.erp.util.GetParam;
import com.huahong.erp.util.UploadMoreForm;
import com.huahong.erp.util.exchange;
import com.huahong.util.CommonFun;

public class CommonAction extends Action{
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response){
		try {
			String operType = request.getParameter("operType");
			if(operType.equals("searchContract")){
				return searchContract(mapping, form, request, response);
			}else if(operType.equals("addNew")){
				return addNew(mapping, form, request, response);
			}else if(operType.equals("updateNew")){
				return updateNew(mapping, form, request, response);
			}else if(operType.equals("auditNew")){
				return auditNew(mapping, form, request, response);
			}else if(operType.equals("deleteCommon")){//公共删除
				return deleteCommon(mapping, form, request, response);
			}else if(operType.equals("analysNews")){//统计分析
				return analysNews(mapping, form, request, response);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	private ActionForward deleteCommon(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			CommonDAO dao = new CommonDAO();
			boolean tag = dao.deleteCommon(mapPara);
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
	private ActionForward searchContract(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			mapPara.put("rp", Integer.parseInt(mapPara.get("rp").toString()));
			mapPara.put("page",(Integer.parseInt(mapPara.get("page").toString())-1)*Integer.parseInt(mapPara.get("rp").toString()));
			String NEW_TYPE = mapPara.get("NEW_TYPE").toString();
			CommonDAO dao = new CommonDAO();
			CommonFun fun = new CommonFun();
			String condition = "";
			String NEW_TITLE_S = new String(mapPara.get("NEW_TITLE_S").toString().getBytes("ISO-8859-1"),"utf-8");
			String NEW_TIME_START = new String(mapPara.get("NEW_TIME_START").toString().getBytes("ISO-8859-1"),"UTF-8");
			String NEW_TIME_END = new String(mapPara.get("NEW_TIME_END").toString().getBytes("ISO-8859-1"),"UTF-8");
			String ISSUER_PER_S =  new String(mapPara.get("ISSUER_PER_S").toString().getBytes("ISO-8859-1"),"UTF-8");
			
			
			
			if(!NEW_TITLE_S.equals("")){
				condition += "N.NEW_TITLE LIKE '%"+NEW_TITLE_S+"%' AND ";
			}
			if(!NEW_TIME_START.equals("") && !NEW_TIME_END.equals("")){
				condition += "N.NEW_TIME>='"+NEW_TIME_START+"' AND N.NEW_TIME<='"+NEW_TIME_END+"' AND ";
			}else if(NEW_TIME_START.equals("") && !NEW_TIME_END.equals("")){
				condition += "N.NEW_TIME>='1900-01-01 00:00:00' AND N.NEW_TIME<='"+NEW_TIME_END+"' AND ";
			}else if(!NEW_TIME_START.equals("") && NEW_TIME_END.equals("")){
				condition += "N.NEW_TIME>='"+NEW_TIME_START+"' AND N.NEW_TIME<='2100-01-01 00:00:00' AND ";
			}
			if(!ISSUER_PER_S.equals("")){
				condition += "N.ISSUER_PER LIKE '%"+ISSUER_PER_S+"%' AND ";
			}
			String roleId = request.getSession().getAttribute("ROLE_ID") + "";
			if("4".equals(roleId)){
				String chuId = request.getSession().getAttribute("CHU_ID") + "";
				condition += " N.ISSUER_PER IN(select id from user uu where uu.chu_id="+chuId +") AND";
			}
			
			if(!condition.equals("")){
				condition = condition.substring(0,condition.length()-4);
				condition = " AND " + condition;
				mapPara.put("condition", condition);
			}
			int total = fun.getTotalItem("SELECT COUNT(*) AS CON FROM new_content N WHERE N.NEW_TYPE='"+NEW_TYPE+"'" + condition);
			String json="";
			int a = Integer.parseInt(mapPara.get("page").toString())+1;
			int b = Integer.parseInt(mapPara.get("rp").toString());
			int page = a/b;
			page = page + 1;
			List list = dao.getNewList(mapPara);
			String path = request.getContextPath();
			if(list!=null && list.size()>0){
				json+="{\"page\":"+page+",\"total\":"+total+",\"rows\":[";
			    for(int i=0;i<list.size();i++){
			    	String ID=exchange.toHtml(((HashMap)list.get(i)).get("ID").toString());
			    	String NEW_TITLE=exchange.toHtml(((HashMap)list.get(i)).get("NEW_TITLE").toString());
			    	String NEW_TIME = exchange.toHtml(((HashMap)list.get(i)).get("NEW_TIME").toString());
			    	String ISSUER_PER = exchange.toHtml(((HashMap)list.get(i)).get("ISSUER_PER").toString());
			    	String NEW_FEN = exchange.toHtml(((HashMap)list.get(i)).get("NEW_FEN").toString());
			    	String AUDIT_TAG = exchange.toHtml(((HashMap)list.get(i)).get("AUDIT_TAG").toString());
			    	if(AUDIT_TAG.equals("0")) AUDIT_TAG = "草稿";
			    	else if(AUDIT_TAG.equals("1")) AUDIT_TAG = "待审核";
			    	else if(AUDIT_TAG.equals("2")) AUDIT_TAG = "已发布";
			    	String NEW_FENNAME = exchange.toHtml(((HashMap)list.get(i)).get("NEW_FENNAME").toString());
			    	NEW_TITLE = "<a href='"+path+"/jsp/newDetail.jsp?ID="+ID+"' target='_blank' title='点击查看新闻详情'>"+NEW_TITLE+"</a>";
			    	String DEAL = "<a href='#' onclick='updateNew(\\\""+ID+"\\\")'>修改</a>&nbsp;|&nbsp;<a href='#' onclick='deleteItem(\\\""+ID+"\\\",\\\"new_content\\\")'>删除</a>";
			    	json+="{\"id\":\""+ID+"\",";
			    	json+="\"cell\":[\""+(i+a)+"\",\""+NEW_FENNAME+"\",\""+NEW_TITLE+"\",\""+NEW_TIME+"\",\""+ISSUER_PER+"\",\""+AUDIT_TAG+"\",\""+DEAL+"\"]},";
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
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			
			CommonDAO dao = new CommonDAO();
			mapPara.put("ISSUER_PER", request.getSession().getAttribute("USER_ID"));
			boolean tag = dao.insertNew(mapPara);
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
		request.getSession().setAttribute("uploadFileNames", "");
	    return null;
	}
	private ActionForward updateNew(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			CommonDAO dao = new CommonDAO();
			mapPara.put("ISSUER_PER", request.getSession().getAttribute("USER_ID"));
			boolean tag = dao.updateNew(mapPara);
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
	private ActionForward auditNew(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			CommonDAO dao = new CommonDAO();
			mapPara.put("AUDIT_USER", request.getSession().getAttribute("USER_ID"));
			boolean tag = dao.updateAuditNew(mapPara);
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
	
	private ActionForward analysNews(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			mapPara.put("rp", Integer.parseInt(mapPara.get("rp").toString()));
			mapPara.put("page",(Integer.parseInt(mapPara.get("page").toString())-1)*Integer.parseInt(mapPara.get("rp").toString()));
			CommonDAO dao = new CommonDAO();
			CommonFun fun = new CommonFun();
			String condition = "";
			String startTime =  new String(mapPara.get("startTime").toString().getBytes("ISO-8859-1"),"UTF-8");
			String endTime =  new String(mapPara.get("endTime").toString().getBytes("ISO-8859-1"),"UTF-8");
			if("".equals(endTime)){
				Date endTimeDate = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				endTime = sdf.format(endTimeDate);
			}
			if(!startTime.equals("")){
				
				condition += " t.NEW_TIME between  '"+startTime+"' AND '" + endTime+"'";
			}
			if(!condition.equals("")){
				condition = " AND " + condition;
				mapPara.put("condition", condition);
			}
			int total = fun.getTotalItem("SELECT COUNT(*) AS CON FROM(select  issuer_per,chu_id ,chu_name,count  from" +
					" (select issuer_per,count,chu_id from (select t.issuer_per,count(*) count  from new_content t where 1=1 " + condition +
					" group by t.issuer_per) tt  left join user u on tt.issuer_per=u.id)" +
					" mm left join chu c on mm.chu_id=c.id) aaa");
			String json="";
			int a = Integer.parseInt(mapPara.get("page").toString())+1;
			int b = Integer.parseInt(mapPara.get("rp").toString());
			int page = a/b;
			page = page + 1;
			List list = dao.analysNews(mapPara);
			String path = request.getContextPath();
			if(list!=null && list.size()>0){
				json+="{\"page\":"+page+",\"total\":"+total+",\"rows\":[";
			    for(int i=0;i<list.size();i++){
			    	
			    	String ISSUER_PER = exchange.toHtml(((HashMap)list.get(i)).get("ISSUER_PER").toString());
			    	String CHU_ID = exchange.toHtml(((HashMap)list.get(i)).get("CHU_ID").toString());
			    	String CHU_NAME = exchange.toHtml(((HashMap)list.get(i)).get("CHU_NAME").toString());
			    	String COUNT = exchange.toHtml(((HashMap)list.get(i)).get("COUNT").toString());
			    	json+="{\"id\":\""+i+"\",";
			    	json+="\"cell\":[\""+(i+a)+"\",\""+CHU_NAME+"\",\""+COUNT+"\",\""+ISSUER_PER+"\",\""+CHU_ID+"\"]},";
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
}

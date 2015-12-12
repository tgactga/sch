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
import com.huahong.erp.util.GetParam;
import com.huahong.erp.util.exchange;
import com.huahong.util.CommonFun;

public class AuditNewsAction extends Action{
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response){
		try {
			String operType = request.getParameter("operType");
			if(operType.equals("searchAuditNew")){
				return searchAuditNew(mapping, form, request, response);
			}else if(operType.equals("auditNew")){
				return auditNew(mapping, form, request, response);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	private ActionForward searchAuditNew(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			mapPara.put("rp", Integer.parseInt(mapPara.get("rp").toString()));
			mapPara.put("page",(Integer.parseInt(mapPara.get("page").toString())-1)*Integer.parseInt(mapPara.get("rp").toString()));
			AuditNewsDAO dao = new AuditNewsDAO();
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
			if(!condition.equals("")){
				condition = condition.substring(0,condition.length()-4);
				condition = " AND " + condition;
				mapPara.put("condition", condition);
			}
			int total = fun.getTotalItem("SELECT COUNT(*) AS CON FROM new_content N WHERE N.AUDIT_TAG='1'" + condition);
			String json="";
			int a = Integer.parseInt(mapPara.get("page").toString())+1;
			int b = Integer.parseInt(mapPara.get("rp").toString());
			int page = a/b;
			page = page + 1;
			List list = dao.getAuditNewList(mapPara);
			String path = request.getContextPath();
			if(list!=null && list.size()>0){
				json+="{\"page\":"+page+",\"total\":"+total+",\"rows\":[";
			    for(int i=0;i<list.size();i++){
			    	String ID=exchange.toHtml(((HashMap)list.get(i)).get("ID").toString());
			    	String NEW_TITLE=exchange.toHtml(((HashMap)list.get(i)).get("NEW_TITLE").toString());
			    	NEW_TITLE = "<a href='"+path+"/jsp/newDetail.jsp?ID="+ID+"' target='_blank' title='点击查看新闻详情'>"+NEW_TITLE+"</a>";
			    	String NEW_TIME = exchange.toHtml(((HashMap)list.get(i)).get("NEW_TIME").toString());
			    	String ISSUER_PER = exchange.toHtml(((HashMap)list.get(i)).get("ISSUER_PER").toString());
			    	String NEW_TYPE = exchange.toHtml(((HashMap)list.get(i)).get("NEW_TYPE").toString());
			    	String AUDIT_TAG = exchange.toHtml(((HashMap)list.get(i)).get("AUDIT_TAG").toString());
			    	String USER_NAME = exchange.toHtml(((HashMap)list.get(i)).get("USER_NAME").toString());
			    	if(AUDIT_TAG.equals("0")) AUDIT_TAG = "草稿";
			    	else if(AUDIT_TAG.equals("1")) AUDIT_TAG = "待审核";
			    	else if(AUDIT_TAG.equals("2")) AUDIT_TAG = "已发布";
			    	String NEW_FENNAME = exchange.toHtml(((HashMap)list.get(i)).get("NEW_FENNAME").toString());
			    	String DEAL = "<a href='#' onclick='auditNew(\\\""+ID+"\\\", \\\""+NEW_TYPE+"\\\")'>审核</a>&nbsp;|&nbsp;<a href='#' onclick='deleteItem(\\\""+ID+"\\\",\\\"new_content\\\")'>删除</a>";
			    	json+="{\"id\":\""+ID+"\",";
			    	json+="\"cell\":[\""+(i+a)+"\",\""+NEW_FENNAME+"\",\""+NEW_TITLE+"\",\""+NEW_TIME+"\",\""+USER_NAME+"\",\""+AUDIT_TAG+"\",\""+DEAL+"\"]},";
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
	private ActionForward auditNew(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
}

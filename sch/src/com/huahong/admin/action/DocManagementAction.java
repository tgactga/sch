package com.huahong.admin.action;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.huahong.admin.dao.CommonDAO;
import com.huahong.erp.util.GetParam;
import com.huahong.erp.util.exchange;
import com.huahong.util.CommonFun;

public class DocManagementAction extends Action{
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response){
		try {
			String operType = request.getParameter("operType");
			if(operType.equals("queryDoc")){
				return queryDoc(mapping, form, request, response);
			}
			if(operType.equals("deleteDoc")){
				return deleteDoc(mapping, form, request, response);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	
	private ActionForward queryDoc(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			mapPara.put("rp", Integer.parseInt(mapPara.get("rp").toString()));
			mapPara.put("page",(Integer.parseInt(mapPara.get("page").toString())-1)*Integer.parseInt(mapPara.get("rp").toString()));
			String FILENAME = mapPara.get("FILENAME").toString();
			CommonDAO dao = new CommonDAO();
			CommonFun fun = new CommonFun();
			String condition = "";
			 
			if(!FILENAME.equals("")){
//				condition = condition.substring(0,condition.length()-4);
				condition = "  AND  FILES LIKE '%"+FILENAME+"%' ";
				mapPara.put("condition", condition);
			}
			int total = fun.getTotalItem("SELECT COUNT(*) AS CON FROM new_content N WHERE N.FILES IS NOT NULL"+condition);
			String json="";
			int a = Integer.parseInt(mapPara.get("page").toString())+1;
			int b = Integer.parseInt(mapPara.get("rp").toString());
			int page = a/b;
			page = page + 1;
			List list = dao.getDocList(mapPara);
			String path = request.getContextPath();
			if(list!=null && list.size()>0){
				json+="{\"page\":"+page+",\"total\":"+total+",\"rows\":[";
			    for(int i=0;i<list.size();i++){
			    	String ID=exchange.toHtml(((HashMap)list.get(i)).get("ID").toString());
//			    	String NEW_TITLE=exchange.toHtml(((HashMap)list.get(i)).get("NEW_TITLE").toString());
//			    	String NEW_TIME = exchange.toHtml(((HashMap)list.get(i)).get("NEW_TIME").toString());
//			    	String ISSUER_PER = exchange.toHtml(((HashMap)list.get(i)).get("ISSUER_PER").toString());
//			    	String NEW_FEN = exchange.toHtml(((HashMap)list.get(i)).get("NEW_FEN").toString());
//			    	String AUDIT_TAG = exchange.toHtml(((HashMap)list.get(i)).get("AUDIT_TAG").toString());
//			    	if(AUDIT_TAG.equals("0")) AUDIT_TAG = "草稿";
//			    	else if(AUDIT_TAG.equals("1")) AUDIT_TAG = "待审核";
//			    	else if(AUDIT_TAG.equals("2")) AUDIT_TAG = "已发布";
			    	String FILES = exchange.toHtml(((HashMap)list.get(i)).get("FILES").toString());
			    	String URL= exchange.toHtml("@d:sch");
			    	String EDIT_TIME =  exchange.toHtml(((HashMap)list.get(i)).get("EDIT_TIME").toString());
//			    	NEW_TITLE = "<a href='"+path+"/jsp/newDetail.jsp?ID="+ID+"' target='_blank' title='点击查看新闻详情'>"+NEW_TITLE+"</a>";
			    	String DEAL = "<a href='#' onclick='updateNew(\\\""+ID+"\\\")'>下载</a>&nbsp;|&nbsp;<a href='#' onclick='deleteItem(\\\""+ID+"\\\",\\\"new_content\\\")'>删除</a>";
			    	json+="{\"id\":\""+ID+"\",";
			    	json+="\"cell\":[\""+(i+a)+"\",\""+FILES+"\",\""+URL+"\",\""+EDIT_TIME+"\",\""+DEAL+"\"]},";
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
	private ActionForward deleteDoc(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			 
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}

}

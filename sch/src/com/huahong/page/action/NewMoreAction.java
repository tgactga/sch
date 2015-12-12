package com.huahong.page.action;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.huahong.erp.util.GetParam;
import com.huahong.page.dao.NewMoreDAO;
import com.huahong.util.CommonFun;

public class NewMoreAction extends Action{
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response){
		try {
			String operType = request.getParameter("operType");
			if(operType.equals("showMoreNew")){
				return showMoreNew(mapping, form, request, response);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	private ActionForward showMoreNew(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=gb2312");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			String curPage = mapPara.get("curPage").toString();
			String everyEva = mapPara.get("everyEva").toString();
			int curPageInt = Integer.parseInt(curPage);
			int everyEvaInt = Integer.parseInt(everyEva);
			int start = (curPageInt-1)*everyEvaInt;
			mapPara.put("start", start);
			CommonFun fun = new CommonFun();
			String NEW_TYPE = mapPara.get("NEW_TYPE").toString();
			String NEW_FEN = mapPara.get("NEW_FEN").toString();
			String condition = "";
			if(NEW_FEN.equals("")){
				condition = "NEW_TYPE='"+NEW_TYPE+"'";
			}else{
				condition = "NEW_TYPE='"+NEW_TYPE+"' AND NEW_FEN='"+NEW_FEN+"'";
			}
			mapPara.put("condition", condition);
			int total = fun.getTotalItem("SELECT COUNT(*) AS CON FROM new_content WHERE AUDIT_TAG='2' AND " + condition);
			NewMoreDAO dao = new NewMoreDAO();
			List list = dao.getMoreNew(mapPara);
			String json = "";
			if(list!=null && list.size()>0){
				json = "[{\"total\":\""+total+"\"},";
				for(int i=0;i<list.size();i++){
					json += "{\"ID\":\""+((HashMap)list.get(i)).get("ID").toString()+"\",";
					json += "\"NEW_TITLE\":\""+((HashMap)list.get(i)).get("NEW_TITLE").toString()+"\",";
					json += "\"NEW_TIME\":\""+((HashMap)list.get(i)).get("NEW_TIME").toString()+"\",";
					json += "\"NEW_NUM\":\""+((HashMap)list.get(i)).get("NEW_NUM").toString()+"\"},";
				}
				json = json.substring(0,json.length()-1)+"]";
			}else{
				json = "";
			}
			GetParam.outJSON(response, json);
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
}

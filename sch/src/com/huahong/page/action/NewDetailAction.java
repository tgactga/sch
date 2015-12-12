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
import com.huahong.page.dao.NewDetailDAO;

public class NewDetailAction extends Action{
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response){
		try {
			String operType = request.getParameter("operType");
			if(operType.equals("showNew")){
				return showNew(mapping, form, request, response);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	private ActionForward showNew(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=gb2312");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			NewDetailDAO dao = new NewDetailDAO();
			//List list = dao.getNew();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
}

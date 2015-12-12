package com.huahong.score.action;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.huahong.admin.bo.CommonFun;
import com.huahong.erp.util.GetParam;
import com.huahong.erp.util.exchange;
import com.huahong.score.dao.StatManagementDAO;

public class StatManagementAction extends Action{
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response){
		try {
			String operType = request.getParameter("operType");
			if(operType.equals("searchScore")){
				return searchScore(mapping, form, request, response);
			}else if(operType.equals("totalStatScore")){
				return totalStatScore(mapping, form, request, response);
			}else if(operType.equals("totalClassStatScore")){
				return totalClassStatScore(mapping, form, request, response);
			}else if(operType.equals("dankeDis")){
				return dankeDis(mapping, form, request, response);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	private ActionForward searchScore(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=gb2312");
			HashMap mapPara = GetParam.GetParamValue(request,"ISO-8859-1","utf-8");
			mapPara.put("rp", Integer.parseInt(mapPara.get("rp").toString()));
			mapPara.put("page",(Integer.parseInt(mapPara.get("page").toString())-1)*Integer.parseInt(mapPara.get("rp").toString()));
			String condition = "";
			String SCORE_YEAR_S = mapPara.get("SCORE_YEAR_S").toString();
			String SEMESTER_S = mapPara.get("SEMESTER_S").toString();
			String SCORE_CLASS_S = mapPara.get("SCORE_CLASS_S").toString();
			String KEMU_S = mapPara.get("KEMU_S").toString();
			String DANKE_S = mapPara.get("DANKE_S").toString();
			if(DANKE_S.equals("1")){
				mapPara.put("KEMU", "CHINESE");
			}else if(DANKE_S.equals("2")){
				mapPara.put("KEMU", "KEMATCH");
			}else if(DANKE_S.equals("3")){
				mapPara.put("KEMU", "ENGLISH");
			}else if(DANKE_S.equals("4")){
				mapPara.put("KEMU", "PHYSICAL");
			}else if(DANKE_S.equals("5")){
				mapPara.put("KEMU", "CHEMISTRY");
			}else if(DANKE_S.equals("6")){
				mapPara.put("KEMU", "BIOLOGICAL");
			}else if(DANKE_S.equals("7")){
				mapPara.put("KEMU", "HISTORY");
			}else if(DANKE_S.equals("8")){
				mapPara.put("KEMU", "POLITY");
			}else if(DANKE_S.equals("9")){
				mapPara.put("KEMU", "GEOGRAPHY");
			}
			condition += CommonFun.pinCondition("SCORE_YEAR", SCORE_YEAR_S, "", "varchardeng");
			condition += CommonFun.pinCondition("SEMESTER", SEMESTER_S, "", "varchardeng");
			condition += CommonFun.pinCondition("KEMU", KEMU_S, "", "varchardeng");
			condition += CommonFun.pinCondition("SCORE_CLASS", SCORE_CLASS_S, "", "varchardeng");
			if(!condition.equals("")){
				condition = "WHERE "+condition.substring(0, condition.length()-4);
			}
			mapPara.put("condition", condition);
			CommonFun fun = new CommonFun();
			StatManagementDAO dao = new StatManagementDAO();
			int total = fun.getTotalItem("SELECT COUNT(*) AS CON FROM score " + condition);
			String json="";
			int a = Integer.parseInt(mapPara.get("page").toString())+1;
			int b = Integer.parseInt(mapPara.get("rp").toString());
			int page = a/b;
			page = page + 1;
			System.out.println(mapPara);
			List list = dao.searchScoreList(mapPara);
			if(list!=null && list.size()>0){
				json+="{\"page\":"+page+",\"total\":"+total+",\"rows\":[";
			    for(int i=0;i<list.size();i++){
			    	String ID=exchange.toHtml(((HashMap)list.get(i)).get("ID").toString());
			    	String SCORE_YEAR=exchange.toHtml(((HashMap)list.get(i)).get("SCORE_YEAR").toString());
			    	String SEMESTER = exchange.toHtml(((HashMap)list.get(i)).get("SEMESTER").toString());
			    	String SCORE_GRADE = exchange.toHtml(((HashMap)list.get(i)).get("SCORE_GRADE").toString());
			    	String SCORE_CLASS = exchange.toHtml(((HashMap)list.get(i)).get("SCORE_CLASS").toString());
			    	String SCORE_NO = exchange.toHtml(((HashMap)list.get(i)).get("SCORE_NO").toString());
			    	String STU_NAME = exchange.toHtml(((HashMap)list.get(i)).get("STU_NAME").toString());
			    	String STU_SEX = exchange.toHtml(((HashMap)list.get(i)).get("STU_SEX").toString());
			    	String AAS = exchange.toHtml(((HashMap)list.get(i)).get("AAS").toString());
			    	String KEMU = exchange.toHtml(((HashMap)list.get(i)).get("KEMU").toString());
			    	String CHINESE = exchange.toHtml(((HashMap)list.get(i)).get("CHINESE").toString());
			    	String KEMATCH = exchange.toHtml(((HashMap)list.get(i)).get("KEMATCH").toString());
			    	String ENGLISH = exchange.toHtml(((HashMap)list.get(i)).get("ENGLISH").toString());
			    	String PHYSICAL = exchange.toHtml(((HashMap)list.get(i)).get("PHYSICAL").toString());
			    	String CHEMISTRY = exchange.toHtml(((HashMap)list.get(i)).get("CHEMISTRY").toString());
			    	String BIOLOGICAL = exchange.toHtml(((HashMap)list.get(i)).get("BIOLOGICAL").toString());
			    	String HISTORY = exchange.toHtml(((HashMap)list.get(i)).get("HISTORY").toString());
			    	String POLITY = exchange.toHtml(((HashMap)list.get(i)).get("POLITY").toString());
			    	String GEOGRAPHY = exchange.toHtml(((HashMap)list.get(i)).get("GEOGRAPHY").toString());
			    	String TOTAL_SCORE = exchange.toHtml(((HashMap)list.get(i)).get("TOTAL_SCORE").toString());
			    	json+="{\"id\":\""+ID+"\",";
			    	json+="\"cell\":[\""+(i+a)+"\",\""+SCORE_GRADE+"\",\""+SCORE_CLASS+"\",\""+SCORE_NO+"\",\""+STU_NAME+"\",\""+STU_SEX+"\",\""+AAS+"\",\""+KEMU+"\",\""+CHINESE+"\",\""+KEMATCH+"\",\""+ENGLISH+"\",\""+PHYSICAL+"\",\""+CHEMISTRY+"\",\""+BIOLOGICAL+"\",\""+HISTORY+"\",\""+POLITY+"\",\""+GEOGRAPHY+"\",\""+TOTAL_SCORE+"\"]},";
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
	private ActionForward totalStatScore(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=gb2312");
			HashMap mapPara = GetParam.GetParamValue(request,"ISO-8859-1","utf-8");
			mapPara.put("rp", Integer.parseInt(mapPara.get("rp").toString()));
			mapPara.put("page",(Integer.parseInt(mapPara.get("page").toString())-1)*Integer.parseInt(mapPara.get("rp").toString()));
			String condition = "";
			String SCORE_YEAR_S = mapPara.get("SCORE_YEAR_S").toString();
			String SEMESTER_S = mapPara.get("SEMESTER_S").toString();
			String KEMU_S = mapPara.get("KEMU_S").toString();
			String SCORE_CLASS_S = mapPara.get("SCORE_CLASS_S").toString();
			condition += CommonFun.pinCondition("SCORE_YEAR", SCORE_YEAR_S, "", "varchardeng");
			condition += CommonFun.pinCondition("SEMESTER", SEMESTER_S, "", "varchardeng");
			condition += CommonFun.pinCondition("KEMU", KEMU_S, "", "varchardeng");
			condition += CommonFun.pinCondition("SCORE_CLASS", SCORE_CLASS_S, "", "varchardeng");
			if(!condition.equals("")){
				condition = "WHERE "+condition.substring(0, condition.length()-4);
			}
			mapPara.put("condition", condition);
			CommonFun fun = new CommonFun();
			StatManagementDAO dao = new StatManagementDAO();
			int total = fun.getTotalItem("SELECT COUNT(*) AS CON FROM score " + condition);
			String json="";
			int a = Integer.parseInt(mapPara.get("page").toString())+1;
			int b = Integer.parseInt(mapPara.get("rp").toString());
			int page = a/b;
			page = page + 1;
			List list = dao.searchTotalStatList(mapPara);
			if(list!=null && list.size()>0){
				json+="{\"page\":"+page+",\"total\":"+total+",\"rows\":[";
			    for(int i=0;i<list.size();i++){
			    	String ID=exchange.toHtml(((HashMap)list.get(i)).get("ID").toString());
			    	String SCORE_YEAR=exchange.toHtml(((HashMap)list.get(i)).get("SCORE_YEAR").toString());
			    	String SEMESTER = exchange.toHtml(((HashMap)list.get(i)).get("SEMESTER").toString());
			    	String SCORE_GRADE = exchange.toHtml(((HashMap)list.get(i)).get("SCORE_GRADE").toString());
			    	String SCORE_CLASS = exchange.toHtml(((HashMap)list.get(i)).get("SCORE_CLASS").toString());
			    	String SCORE_NO = exchange.toHtml(((HashMap)list.get(i)).get("SCORE_NO").toString());
			    	String STU_NAME = exchange.toHtml(((HashMap)list.get(i)).get("STU_NAME").toString());
			    	String STU_SEX = exchange.toHtml(((HashMap)list.get(i)).get("STU_SEX").toString());
			    	String AAS = exchange.toHtml(((HashMap)list.get(i)).get("AAS").toString());
			    	String KEMU = exchange.toHtml(((HashMap)list.get(i)).get("KEMU").toString());
			    	String CHINESE = exchange.toHtml(((HashMap)list.get(i)).get("CHINESE").toString());
			    	String KEMATCH = exchange.toHtml(((HashMap)list.get(i)).get("KEMATCH").toString());
			    	String ENGLISH = exchange.toHtml(((HashMap)list.get(i)).get("ENGLISH").toString());
			    	String PHYSICAL = exchange.toHtml(((HashMap)list.get(i)).get("PHYSICAL").toString());
			    	String CHEMISTRY = exchange.toHtml(((HashMap)list.get(i)).get("CHEMISTRY").toString());
			    	String BIOLOGICAL = exchange.toHtml(((HashMap)list.get(i)).get("BIOLOGICAL").toString());
			    	String HISTORY = exchange.toHtml(((HashMap)list.get(i)).get("HISTORY").toString());
			    	String POLITY = exchange.toHtml(((HashMap)list.get(i)).get("POLITY").toString());
			    	String GEOGRAPHY = exchange.toHtml(((HashMap)list.get(i)).get("GEOGRAPHY").toString());
			    	String TOTAL_SCORE = exchange.toHtml(((HashMap)list.get(i)).get("TOTAL_SCORE").toString());
			    	json+="{\"id\":\""+ID+"\",";
			    	json+="\"cell\":[\""+(i+a)+"\",\""+SCORE_GRADE+"\",\""+SCORE_CLASS+"\",\""+SCORE_NO+"\",\""+STU_NAME+"\",\""+STU_SEX+"\",\""+AAS+"\",\""+KEMU+"\",\""+CHINESE+"\",\""+KEMATCH+"\",\""+ENGLISH+"\",\""+PHYSICAL+"\",\""+CHEMISTRY+"\",\""+BIOLOGICAL+"\",\""+HISTORY+"\",\""+POLITY+"\",\""+GEOGRAPHY+"\",\""+TOTAL_SCORE+"\"]},";
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
	private ActionForward totalClassStatScore(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=gb2312");
			HashMap mapPara = GetParam.GetParamValue(request,"ISO-8859-1","utf-8");
			mapPara.put("rp", Integer.parseInt(mapPara.get("rp").toString()));
			mapPara.put("page",(Integer.parseInt(mapPara.get("page").toString())-1)*Integer.parseInt(mapPara.get("rp").toString()));
			String condition = "";
			String SCORE_YEAR_S = mapPara.get("SCORE_YEAR_S").toString();
			String SEMESTER_S = mapPara.get("SEMESTER_S").toString();
			String KEMU_S = mapPara.get("KEMU_S").toString();
			condition += CommonFun.pinCondition("SCORE_YEAR", SCORE_YEAR_S, "", "varchardeng");
			condition += CommonFun.pinCondition("SEMESTER", SEMESTER_S, "", "varchardeng");
			condition += CommonFun.pinCondition("KEMU", KEMU_S, "", "varchardeng");
			if(!condition.equals("")){
				condition = "WHERE "+condition.substring(0, condition.length()-4);
			}
			mapPara.put("condition", condition);
			CommonFun fun = new CommonFun();
			StatManagementDAO dao = new StatManagementDAO();
			int total = fun.getTotalItem("SELECT COUNT(*) AS CON FROM stclass");
			String json="";
			int a = Integer.parseInt(mapPara.get("page").toString())+1;
			int b = Integer.parseInt(mapPara.get("rp").toString());
			int page = a/b;
			page = page + 1;
			List list = dao.searchClassTotalStatList(mapPara);
			if(list!=null && list.size()>0){
				json+="{\"page\":"+page+",\"total\":"+total+",\"rows\":[";
			    for(int i=0;i<list.size();i++){
			    	String CLASS_NAME=exchange.toHtml(((HashMap)list.get(i)).get("CLASS_NAME").toString());
			    	String TOTAL_SCORE=exchange.toHtml(((HashMap)list.get(i)).get("TOTAL_SCORE").toString());
			    	if(TOTAL_SCORE.equals("")) TOTAL_SCORE = "0";
			    	json+="{\"id\":\"\",";
			    	json+="\"cell\":[\""+(i+a)+"\",\""+CLASS_NAME+"\",\""+TOTAL_SCORE+"\"]},";
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
	private ActionForward dankeDis(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=gb2312");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			String condition = "";
			String SCORE_YEAR = mapPara.get("SCORE_YEAR").toString();
			String SEMESTER = mapPara.get("SEMESTER").toString();
			String KEMU = mapPara.get("KEMU").toString();
			String DANKE = mapPara.get("DANKE").toString();
			String SCORE_TOTAL = mapPara.get("SCORE_TOTAL").toString();
			if(DANKE.equals("语文")){
				DANKE =  "CHINESE";
			}else if(DANKE.equals("数学")){
				DANKE =  "KEMATCH";
			}else if(DANKE.equals("英语")){
				DANKE =  "ENGLISH";
			}else if(DANKE.equals("物理")){
				DANKE =  "PHYSICAL";
			}else if(DANKE.equals("化学")){
				DANKE =  "CHEMISTRY";
			}else if(DANKE.equals("生物")){
				DANKE =  "BIOLOGICAL";
			}else if(DANKE.equals("历史")){
				DANKE =  "HISTORY";
			}else if(DANKE.equals("政治")){
				DANKE =  "POLITY";
			}else if(DANKE.equals("地理")){
				DANKE =  "GEOGRAPHY";
			}
			int totalFen = Integer.parseInt(SCORE_TOTAL);
			String sql = "";
			for(int i=0;i<Math.ceil(totalFen/10);i++){
				sql += "SELECT COUNT(*) AS CON FROM score WHERE "+DANKE+">="+i*10+" AND "+DANKE+"<"+(i+1)*10+" AND SCORE_YEAR='"+SCORE_YEAR+"' AND SEMESTER='"+SEMESTER+"' AND KEMU='"+KEMU+"' UNION ALL ";
			}
			if(!sql.equals("")) sql = sql.substring(0, sql.length()-10);
			StatManagementDAO dao = new StatManagementDAO();
			List list = dao.searchDanKeFenList(sql);
			String json = "";
			if(list!=null && list.size()>0){
				json += "[";
				for(int i=0;i<list.size();i++){
					json += "{\"CON\":\""+((HashMap)list.get(i)).get("CON").toString()+"\"},";
				}
				json=json.substring(0,json.length()-1);
			    json+="]";
			}else{
				json = "[]";
			}
			response.getWriter().write(json);
			response.getWriter().close();
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
}
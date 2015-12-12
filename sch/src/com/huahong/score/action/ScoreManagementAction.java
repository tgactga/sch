package com.huahong.score.action;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Sheet;
import jxl.Workbook;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.huahong.admin.bo.CommonFun;
import com.huahong.erp.util.GetParam;
import com.huahong.erp.util.GetRecentDate;
import com.huahong.erp.util.exchange;
import com.huahong.score.dao.ScoreManagementDAO;
import com.jspsmart.upload.SmartUpload;

public class ScoreManagementAction extends Action{
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response){
		try {
			String operType = request.getParameter("operType");
			if(operType.equals("searchScore")){
				return searchScore(mapping, form, request, response);
			}else if(operType.equals("impScore")){
				return impScore(mapping, form, request, response);
			}else if(operType.equals("searchSt")){
				return searchSt(mapping, form, request, response);
			}else if(operType.equals("searchStScore")){
				return searchStScore(mapping, form, request, response);
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
			String path = request.getContextPath();
			HashMap mapPara = GetParam.GetParamValue(request,"ISO-8859-1","utf-8");
			//System.out.println(mapPara);
			mapPara.put("rp", Integer.parseInt(mapPara.get("rp").toString()));
			mapPara.put("page",(Integer.parseInt(mapPara.get("page").toString())-1)*Integer.parseInt(mapPara.get("rp").toString()));
			String condition = "";
			String SCORE_YEAR_S = mapPara.get("SCORE_YEAR_S").toString();
			String SEMESTER_S = mapPara.get("SEMESTER_S").toString();
			String KEMU_S = mapPara.get("KEMU_S").toString();
			String SCORE_CLASS_S = mapPara.get("SCORE_CLASS_S").toString();
			String STU_NAME_S = mapPara.get("STU_NAME_S").toString();
			condition += CommonFun.pinCondition("SCORE_YEAR", SCORE_YEAR_S, "", "varchardeng");
			condition += CommonFun.pinCondition("SEMESTER", SEMESTER_S, "", "varchardeng");
			condition += CommonFun.pinCondition("KEMU", KEMU_S, "", "varchardeng");
			condition += CommonFun.pinCondition("SCORE_CLASS", SCORE_CLASS_S, "", "varchardeng");
			condition += CommonFun.pinCondition("STU_NAME", STU_NAME_S, "", "varchar");
			if(!condition.equals("")){
				condition = "WHERE "+condition.substring(0, condition.length()-4);
			}
			mapPara.put("condition", condition);
			CommonFun fun = new CommonFun();
			ScoreManagementDAO dao = new ScoreManagementDAO();
			int total = fun.getTotalItem("SELECT COUNT(*) AS CON FROM score " + condition);
			String json="";
			int a = Integer.parseInt(mapPara.get("page").toString())+1;
			int b = Integer.parseInt(mapPara.get("rp").toString());
			int page = a/b;
			page = page + 1;
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
	private ActionForward impScore(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=gb2312");
			String path = request.getContextPath();
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			//先建文件夹
			String folderPath = rootPath + "export/";
			String str_Path = folderPath.toString().replace("\\", "/");
			//上传文件
			SmartUpload mySmartUpload=new SmartUpload();
			//设置允许上传的文件类型
			//mySmartUpload.setAllowedFilesList("xls");
			ServletConfig config = this.getServlet().getServletConfig();
			mySmartUpload.initialize(config, request, response);
			mySmartUpload.upload();
			
			String CURDATE=GetRecentDate.getRecentDate("yyyyMMddHHmmssS");
			String FILE_PATH = "";
			for(int i=0;i<mySmartUpload.getFiles().getCount();i++){
				com.jspsmart.upload.File file = mySmartUpload.getFiles().getFile(i);
				if(!file.getFileName().equals("")){
					FILE_PATH = str_Path + CURDATE + "_" + i + "." + file.getFileExt();
					file.saveAs(FILE_PATH);
				}
			}
			
			ScoreManagementDAO dao = new ScoreManagementDAO();
			InputStream stream = new FileInputStream(FILE_PATH);
			Workbook rwb = Workbook.getWorkbook(stream);
			Sheet sheet = rwb.getSheet(0);
			for(int i=1; i<sheet.getRows(); i++){
				String SCORE_YEAR = sheet.getCell(0,i).getContents();//年份
				if(SCORE_YEAR.equals("")) break;
				String SEMESTER = sheet.getCell(1,i).getContents();//学期
				String SCORE_GRADE = sheet.getCell(2,i).getContents();//班级
				String SCORE_CLASS = sheet.getCell(3,i).getContents();//班级
				String SCORE_NO = sheet.getCell(4,i).getContents();//学号
				String STU_NAME = sheet.getCell(5,i).getContents();//姓名
				String STU_SEX = sheet.getCell(6,i).getContents();//性别
				String AAS = sheet.getCell(7,i).getContents();//文理科
				String KEMU = sheet.getCell(8,i).getContents();//考试名称
				String CHINESE = sheet.getCell(9,i).getContents();//语文
				if(CHINESE.equals("")) CHINESE = "0";
				String MATCH = sheet.getCell(10,i).getContents();//数学
				if(MATCH.equals("")) MATCH = "0";
				String ENGLISH = sheet.getCell(12,i).getContents();//英语
				if(ENGLISH.equals("")) ENGLISH = "0";
				String PHYSICAL = sheet.getCell(13,i).getContents();//物理
				if(PHYSICAL.equals("")) PHYSICAL = "0";
				String CHEMISTRY = sheet.getCell(14,i).getContents();//化学
				if(CHEMISTRY.equals("")) CHEMISTRY = "0";
				String BIOLOGICAL = sheet.getCell(15,i).getContents();//生物
				if(BIOLOGICAL.equals("")) BIOLOGICAL = "0";
				String HISTORY = sheet.getCell(16,i).getContents();//历史
				if(HISTORY.equals("")) HISTORY = "0";
				String POLITY = sheet.getCell(17,i).getContents();//政治
				if(POLITY.equals("")) POLITY = "0";
				String GEOGRAPHY = sheet.getCell(18,i).getContents();//地理
				if(GEOGRAPHY.equals("")) GEOGRAPHY = "0";
				float total = Float.valueOf(CHINESE)+Float.valueOf(MATCH)+Float.valueOf(ENGLISH)+Float.valueOf(PHYSICAL)+Float.valueOf(CHEMISTRY)+Float.valueOf(BIOLOGICAL)+Float.valueOf(HISTORY)+Float.valueOf(POLITY)+Float.valueOf(GEOGRAPHY);
				
				HashMap map = new HashMap();
				map.put("SCORE_YEAR", SCORE_YEAR);
				map.put("SEMESTER", SEMESTER);
				map.put("SCORE_GRADE", SCORE_GRADE);
				map.put("SCORE_CLASS", SCORE_CLASS);
				map.put("SCORE_NO", SCORE_NO);
				map.put("STU_NAME", STU_NAME);
				map.put("STU_SEX", STU_SEX);
				map.put("AAS", AAS);
				map.put("KEMU", KEMU);
				map.put("CHINESE", CHINESE);
				map.put("MATCH", MATCH);
				map.put("ENGLISH", ENGLISH);
				map.put("PHYSICAL", PHYSICAL);
				map.put("CHEMISTRY", CHEMISTRY);
				map.put("BIOLOGICAL", BIOLOGICAL);
				map.put("HISTORY", HISTORY);
				map.put("POLITY", POLITY);
				map.put("GEOGRAPHY", GEOGRAPHY);
				map.put("TOTAL_SCORE", total);
				dao.insertScore(map);
			}
			rwb.close();
			stream.close();
			response.getWriter().write("1");
		    response.getWriter().close();
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	private ActionForward searchSt(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=gb2312");
			String path = request.getContextPath();
			HashMap mapPara = GetParam.GetParamValue(request,"ISO-8859-1","utf-8");
			String SCORE_GRADE_S = mapPara.get("SCORE_GRADE").toString();
			String SCORE_CLASS_S = mapPara.get("SCORE_CLASS").toString();
			String STU_NAME_S = mapPara.get("STU_NAME").toString();
			String condition = "";
			condition += CommonFun.pinCondition("SCORE_GRADE", SCORE_GRADE_S, "", "varchardeng");
			condition += CommonFun.pinCondition("SCORE_CLASS", SCORE_CLASS_S, "", "varchardeng");
			condition += CommonFun.pinCondition("STU_NAME", STU_NAME_S, "", "varchardeng");
			if(!condition.equals("")){
				condition = "WHERE "+condition.substring(0, condition.length()-4);
			}
			ScoreManagementDAO dao = new ScoreManagementDAO();
			mapPara.put("condition", condition);
			List stList = dao.searchStList(mapPara);
			String json = "";
			if(stList!=null && stList.size()>0){
				json = "[";
				for(int i=0;i<stList.size();i++){
					json += "{\"SCORE_NO\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("SCORE_NO").toString())+"\",";
					json += "\"SCORE_GRADE\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("SCORE_GRADE").toString())+"\",";
					json += "\"SCORE_CLASS\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("SCORE_CLASS").toString())+"\",";
					json += "\"STU_SEX\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("STU_SEX").toString())+"\",";
					json += "\"STU_NAME\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("STU_NAME").toString())+"\"},";
				}
				json = json.substring(0,json.length()-1)+"]";
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
	private ActionForward searchStScore(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=gb2312");
			String path = request.getContextPath();
			HashMap mapPara = GetParam.GetParamValue(request,"ISO-8859-1","utf-8");
			ScoreManagementDAO dao = new ScoreManagementDAO();
			List stList = dao.searchStScoreList(mapPara);
			String json = "";
			if(stList!=null && stList.size()>0){
				json = "[";
				for(int i=0;i<stList.size();i++){
					json += "{\"ID\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("ID").toString())+"\",";
					json += "\"SCORE_YEAR\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("SCORE_YEAR").toString())+"\",";
					json += "\"SEMESTER\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("SEMESTER").toString())+"\",";
					json += "\"SCORE_GRADE\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("SCORE_GRADE").toString())+"\",";
					json += "\"SCORE_CLASS\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("SCORE_CLASS").toString())+"\",";
					json += "\"SCORE_NO\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("SCORE_NO").toString())+"\",";
					json += "\"STU_NAME\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("STU_NAME").toString())+"\",";
					json += "\"STU_SEX\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("STU_SEX").toString())+"\",";
					json += "\"AAS\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("AAS").toString())+"\",";
					json += "\"KEMU\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("KEMU").toString())+"\",";
					json += "\"CHINESE\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("CHINESE").toString())+"\",";
					json += "\"KEMATCH\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("KEMATCH").toString())+"\",";
					json += "\"ENGLISH\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("ENGLISH").toString())+"\",";
					json += "\"PHYSICAL\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("PHYSICAL").toString())+"\",";
					json += "\"CHEMISTRY\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("CHEMISTRY").toString())+"\",";
					json += "\"BIOLOGICAL\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("BIOLOGICAL").toString())+"\",";
					json += "\"HISTORY\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("HISTORY").toString())+"\",";
					json += "\"POLITY\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("POLITY").toString())+"\",";
					json += "\"GEOGRAPHY\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("GEOGRAPHY").toString())+"\",";
					json += "\"TOTAL_SCORE\":\""+exchange.toHtml(((HashMap)stList.get(i)).get("TOTAL_SCORE").toString())+"\"},";
				}
				json = json.substring(0,json.length()-1)+"]";
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
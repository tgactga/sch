package com.huahong.admin.action;

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

import com.huahong.admin.dao.CommonDAO;
import com.huahong.admin.dao.XiaoYouDAO;
import com.huahong.erp.util.GetParam;
import com.huahong.erp.util.GetRecentDate;
import com.huahong.erp.util.exchange;
import com.huahong.page.dao.NewMoreDAO;
import com.huahong.score.dao.ScoreManagementDAO;
import com.huahong.util.CommonFun;
import com.jspsmart.upload.SmartUpload;

public class XiaoYouAction extends Action{
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
			}else if(operType.equals("searchPageContract")){
				return searchPageContract(mapping, form, request, response);
			}else if(operType.equals("searchXiaoYouMing")){
				return searchXiaoYouMing(mapping, form, request, response);
			}else if(operType.equals("addXiaoYouMing")){
				return addXiaoYouMing(mapping, form, request, response);
			}else if(operType.equals("updateXiaoYouMing")){
				return updateXiaoYouMing(mapping, form, request, response);
			}else if(operType.equals("searchXiaoYouMingBi")){
				return searchXiaoYouMingBi(mapping, form, request, response);
			}else if(operType.equals("impXiaoYou")){
				return impXiaoYou(mapping, form, request, response);
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
			XiaoYouDAO dao = new XiaoYouDAO();
			CommonFun fun = new CommonFun();
			
			int total = fun.getTotalItem("SELECT COUNT(*) AS CON FROM xiaoyou ");
			String json="";
			int a = Integer.parseInt(mapPara.get("page").toString())+1;
			int b = Integer.parseInt(mapPara.get("rp").toString());
			int page = a/b;
			page = page + 1;
			List list = dao.getXiaoYouList(mapPara);
			String path = request.getContextPath();
			if(list!=null && list.size()>0){
				json+="{\"page\":"+page+",\"total\":"+total+",\"rows\":[";
			    for(int i=0;i<list.size();i++){
			    	String ID=exchange.toHtml(((HashMap)list.get(i)).get("ID").toString());
			    	String NAME=exchange.toHtml(((HashMap)list.get(i)).get("NAME").toString());
			    	String BIYE = exchange.toHtml(((HashMap)list.get(i)).get("BIYE").toString());
			    	String PHOTO = exchange.toHtml(((HashMap)list.get(i)).get("PHOTO").toString());
			    	PHOTO = "<img src='"+path+PHOTO+"' style='width:50px;height:80px;'/>";
			    	String TOP_SHOW = exchange.toHtml(((HashMap)list.get(i)).get("TOP_SHOW").toString());
			    	if(TOP_SHOW.equals("1")) TOP_SHOW = "是";
			    	else TOP_SHOW = "否";
			    	String DEAL = "<a href='#' onclick='updateNew(\\\""+ID+"\\\")'>修改</a>&nbsp;|&nbsp;<a href='#' onclick='deleteItem(\\\""+ID+"\\\",\\\"xiaoyou\\\")'>删除</a>";
			    	json+="{\"id\":\""+ID+"\",";
			    	json+="\"cell\":[\""+(i+a)+"\",\""+NAME+"\",\""+BIYE+"\",\""+PHOTO+"\",\""+TOP_SHOW+"\",\""+DEAL+"\"]},";
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
			XiaoYouDAO dao = new XiaoYouDAO();
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
	    return null;
	}
	private ActionForward updateNew(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			XiaoYouDAO dao = new XiaoYouDAO();
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
	private ActionForward searchPageContract(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			String curPage = mapPara.get("curPage").toString();
			String everyEva = mapPara.get("everyEva").toString();
			int curPageInt = Integer.parseInt(curPage);
			int everyEvaInt = Integer.parseInt(everyEva);
			int start = (curPageInt-1)*everyEvaInt;
			mapPara.put("start", start);
			CommonFun fun = new CommonFun();
			int total = fun.getTotalItem("SELECT COUNT(*) AS CON FROM xiaoyou ");
			XiaoYouDAO dao = new XiaoYouDAO();
			List list = dao.getMoreXiaoYou(mapPara);
			String json = "";
			if(list!=null && list.size()>0){
				json = "[{\"total\":\""+total+"\"},";
				for(int i=0;i<list.size();i++){
					json += "{\"ID\":\""+((HashMap)list.get(i)).get("ID").toString()+"\",";
					json += "\"NAME\":\""+((HashMap)list.get(i)).get("NAME").toString()+"\",";
					json += "\"BIYE\":\""+((HashMap)list.get(i)).get("BIYE").toString()+"\",";
					json += "\"PHOTO\":\""+((HashMap)list.get(i)).get("PHOTO").toString()+"\",";
					json += "\"TOP_SHOW\":\""+((HashMap)list.get(i)).get("TOP_SHOW").toString()+"\"},";
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
	private ActionForward searchXiaoYouMing(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			mapPara.put("rp", Integer.parseInt(mapPara.get("rp").toString()));
			mapPara.put("page",(Integer.parseInt(mapPara.get("page").toString())-1)*Integer.parseInt(mapPara.get("rp").toString()));
			XiaoYouDAO dao = new XiaoYouDAO();
			CommonFun fun = new CommonFun();
			
			int total = fun.getTotalItem("SELECT COUNT(*) AS CON FROM xiaoyou_ming ");
			String json="";
			int a = Integer.parseInt(mapPara.get("page").toString())+1;
			int b = Integer.parseInt(mapPara.get("rp").toString());
			int page = a/b;
			page = page + 1;
			List list = dao.getXiaoYouMingList(mapPara);
			String path = request.getContextPath();
			if(list!=null && list.size()>0){
				json+="{\"page\":"+page+",\"total\":"+total+",\"rows\":[";
			    for(int i=0;i<list.size();i++){
			    	String ID=exchange.toHtml(((HashMap)list.get(i)).get("ID").toString());
			    	String XIAOYOU_NAME=exchange.toHtml(((HashMap)list.get(i)).get("XIAOYOU_NAME").toString());
			    	String XIAOYOU_CLASS = exchange.toHtml(((HashMap)list.get(i)).get("XIAOYOU_CLASS").toString());
			    	XIAOYOU_CLASS = XIAOYOU_CLASS + "班";
			    	String BIYE = exchange.toHtml(((HashMap)list.get(i)).get("BIYE").toString());
			    	String XIAOYOU_SUO = exchange.toHtml(((HashMap)list.get(i)).get("XIAOYOU_SUO").toString());
			    	String XIAOYOU_SUO_SHOW = "";
			    	if(XIAOYOU_SUO.equals("1")){
			    		XIAOYOU_SUO_SHOW = "历届初中毕业生";
			    	}else{
			    		XIAOYOU_SUO_SHOW = "历届高中毕业生";
			    	}
			    	String DEAL = "<a href='#' onclick='update(this)'>修改</a>&nbsp;|&nbsp;<a href='#' onclick='deleteItem(\\\""+ID+"\\\",\\\"xiaoyou\\\")'>删除</a>";
			    	json+="{\"id\":\""+ID+"\",";
			    	json+="\"cell\":[\""+(i+a)+"\",\""+XIAOYOU_NAME+"\",\""+XIAOYOU_CLASS+"\",\""+BIYE+"\",\""+XIAOYOU_SUO_SHOW+"\",\""+XIAOYOU_SUO+"\",\""+DEAL+"\"]},";
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
	private ActionForward addXiaoYouMing(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			XiaoYouDAO dao = new XiaoYouDAO();
			String XIAOYOU_CLASS = mapPara.get("XIAOYOU_CLASS").toString();
			String XIAOYOU_CLASS_ORD = toVal(XIAOYOU_CLASS);
			mapPara.put("XIAOYOU_CLASS_ORD", XIAOYOU_CLASS_ORD);
			boolean tag = dao.insertXiaoYouMing(mapPara);
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
	private ActionForward updateXiaoYouMing(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			XiaoYouDAO dao = new XiaoYouDAO();
			String XIAOYOU_CLASS = mapPara.get("XIAOYOU_CLASS").toString();
			String XIAOYOU_CLASS_ORD = toVal(XIAOYOU_CLASS);
			mapPara.put("XIAOYOU_CLASS_ORD", XIAOYOU_CLASS_ORD);
			boolean tag = dao.updatetXiaoYouMing(mapPara);
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
	private String toVal(String num){
		if(num.equals("一")){
			return "1";
		}else if(num.equals("二")){
			return "2";
		}else if(num.equals("三")){
			return "3";
		}else if(num.equals("四")){
			return "4";
		}else if(num.equals("五")){
			return "5";
		}else if(num.equals("六")){
			return "6";
		}else if(num.equals("七")){
			return "7";
		}else if(num.equals("八")){
			return "8";
		}else if(num.equals("九")){
			return "9";
		}else if(num.equals("十")){
			return "10";
		}else if(num.equals("十一")){
			return "11";
		}else if(num.equals("十二")){
			return "12";
		}else if(num.equals("十三")){
			return "13";
		}else if(num.equals("十四")){
			return "14";
		}else if(num.equals("十五")){
			return "15";
		}else if(num.equals("十六")){
			return "16";
		}else if(num.equals("十七")){
			return "17";
		}else if(num.equals("十八")){
			return "18";
		}else{
			return "";
		}
		
	}
	private ActionForward searchXiaoYouMingBi(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
			HashMap mapPara = GetParam.GetParamValue(request,"utf-8","utf-8");
			String BIYE = mapPara.get("BIYE").toString();
			XiaoYouDAO dao = new XiaoYouDAO();
			CommonFun fun = new CommonFun();
			
			String json="";
			List list = dao.getXiaoYouMingBiYeList(mapPara);
			if(list!=null && list.size()>0){
				json = "[";
				for(int i=0;i<list.size();i++){
					json += "{\"XIAOYOU_NAME\":\""+((HashMap)list.get(i)).get("XIAOYOU_NAME").toString()+"\",";
					json += "\"XIAOYOU_CLASS\":\""+((HashMap)list.get(i)).get("XIAOYOU_CLASS").toString()+"\"},";
				}
				json = json.substring(0,json.length()-1)+"]";
			}else{
				json = "";
			}
			//System.out.println(json);
			response.getWriter().write(json);
			response.getWriter().close();
		}catch(Exception e){
			e.printStackTrace();
		}
	    return null;
	}
	private ActionForward impXiaoYou(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("utf-8");
			response.setCharacterEncoding("utf-8");
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
			
			XiaoYouDAO dao = new XiaoYouDAO();
			InputStream stream = new FileInputStream(FILE_PATH);
			Workbook rwb = Workbook.getWorkbook(stream);
			Sheet sheet = rwb.getSheet(0);
			for(int i=1; i<sheet.getRows(); i++){
				String XIAOYOU_NAME = sheet.getCell(1,i).getContents();//姓名
				if(XIAOYOU_NAME.equals("")) break;
				String XIAOYOU_CLASS = sheet.getCell(2,i).getContents();//班级
				String XIAOYOU_CLASS_ORD = toVal(XIAOYOU_CLASS);
				String BIYE = sheet.getCell(3,i).getContents();//毕业时间
				
				HashMap map = new HashMap();
				map.put("XIAOYOU_NAME", XIAOYOU_NAME);
				map.put("XIAOYOU_CLASS", XIAOYOU_CLASS);
				map.put("XIAOYOU_CLASS_ORD", XIAOYOU_CLASS_ORD);
				map.put("BIYE", BIYE);
				map.put("XIAOYOU_SUO", "2");
				dao.insertXiaoYouMing(map);
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
}

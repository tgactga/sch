package com.huahong.util;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.huahong.erp.util.GetRecentDate;

public class CommonFun {
	public int getTotalItem(String condition){
		int total = 0;
		CommonFunDAO dao = new CommonFunDAO();
		List list = dao.getTotal(condition);
		total = Integer.parseInt(((HashMap)list.get(0)).get("CON").toString());
		return total;
	}
	public void loginLog(HttpServletRequest request,String url){
		String IP = request.getRemoteAddr();
		HttpSession session = request.getSession();
		String USER_ID = session.getAttribute("USER_ID").toString();
		GetRecentDate date=new GetRecentDate();
		String currentDate=date.getRecentDate("yyyy-MM-dd HH:mm:ss");
		HashMap map = new HashMap();
		map.put("USER_ID", USER_ID);
		map.put("IP", IP);
		map.put("URL", url);
		map.put("DEAL_TIME", currentDate);
		CommonFunDAO dao = new CommonFunDAO();
		dao.insertLog(map);
	}
	public static String addZeroForNum(String str, int strLength) {
	     int strLen = str.length();
	     StringBuffer sb = null;
	     while (strLen < strLength) {
	           sb = new StringBuffer();
	           sb.append("0").append(str);// 左(前)补0
	           //sb.append(str).append("0");//右(后)补0
	           str = sb.toString();
	           strLen = str.length();
	     }
	     return str;
	}
	public static String retTitle(String code){
		String title = "";
		if(code.equals("2")) title = "学校概况";
		else if(code.equals("3")) title = "校园新闻";
		else if(code.equals("4")) title = "考试招生";
		else if(code.equals("5")) title = "名师名生";
		else if(code.equals("6")) title = "课程改革";
		else if(code.equals("7")) title = "德育视窗";
		else if(code.equals("8")) title = "校友联谊";
		else if(code.equals("9")) title = "国际合作";
		else if(code.equals("10")) title = "学校党建";
		else if(code.equals("11")) title = "教学资源";
		else if(code.equals("12")) title = "媒体关注";
		else if(code.equals("13")) title = "特别关注";
		return title;
	}
}

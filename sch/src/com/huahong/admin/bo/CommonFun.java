package com.huahong.admin.bo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.huahong.admin.dao.CommonFunDAO;
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
		url = url.replaceAll("\\?null", "");
		map.put("URL", url);
		map.put("DEAL_TIME", currentDate);
		CommonFunDAO dao = new CommonFunDAO();
		dao.insertLog(map);
	}
	//SEND_ID 发文ID
	public List getRecList(String SEND_ID){
		List list = new ArrayList();
		CommonFunDAO dao = new CommonFunDAO();
		List recList = dao.getSendReceiveList(SEND_ID);
		for(int i=0;i<recList.size();i++){
			String RECEIVE_UNIT = ((HashMap)recList.get(i)).get("RECEIVE_UNIT").toString();
			String RECEIVE_UNIT_ID = ((HashMap)recList.get(i)).get("RECEIVE_UNIT_ID").toString();
			String LEAF = ((HashMap)recList.get(i)).get("LEAF").toString();
			String PID = ((HashMap)recList.get(i)).get("PID").toString();
			String parentName = "";
			if(!PID.equals("")){
				parentName = dao.getParentName(PID);
			}
			HashMap map = new HashMap();
			map.put("RECEIVE_UNIT", RECEIVE_UNIT);
			map.put("RECEIVE_UNIT_ID", RECEIVE_UNIT_ID);
			map.put("LEAF", LEAF);
			map.put("PID", PID);
			map.put("PARENTNAME", parentName);
			list.add(map);
		}
		return list;
	}
	public static String pinCondition(String col, String value1, String value2, String type){
		String condition = "";
		if(type.equals("varchar")){
			if(!value1.equals("")){
				condition = col + " LIKE '%"+value1+"%' AND ";
			}
		}if(type.equals("varchardeng")){
			if(!value1.equals("")){
				condition = col + "='"+value1+"' AND ";
			}
		}else if(type.equals("datatime")){
			if(value1.length() == 10) value1 = value1 + " 00:00:00";
			if(value2.length() == 10) value2 = value2 + " 23:59:59";
			if(!value1.equals("") && !value2.equals("")){
				condition += col+">='"+value1+"' AND "+col+"<='"+value2+"' AND ";
			}else if(value1.equals("") && !value2.equals("")){
				condition += col+">='1900-01-01 00:00:00' AND "+col+"<='"+value2+"' AND ";
			}else if(!value1.equals("") && value2.equals("")){
				condition += col+">='"+value1+"' AND "+col+"<='2100-01-01 00:00:00' AND ";
			}
		}else if(type.equals("data")){
			if(!value1.equals("") && !value2.equals("")){
				condition += col+">='"+value1+"' AND "+col+"<='"+value2+"' AND ";
			}else if(value1.equals("") && !value2.equals("")){
				condition += col+">='1900-01-01' AND "+col+"<='"+value2+"' AND ";
			}else if(!value1.equals("") && value2.equals("")){
				condition += col+">='"+value1+"' AND "+col+"<='2100-01-01' AND ";
			}
		}
		return condition;
	}
}

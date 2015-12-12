package com.huahong.erp.util;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//读值类
public class GetParam {
	
	public static HashMap GetParamValue(HttpServletRequest request) {
		try{
			HashMap map = new HashMap();
			Enumeration keys = request.getParameterNames();
			while(keys.hasMoreElements()){
				String keyTemp = (String)keys.nextElement();
				String temp = (request.getParameter(keyTemp) == null) ? "" : new String(request.getParameter(keyTemp).getBytes("iso-8859-1"),"utf-8");
				map.put(keyTemp, temp);
			}
			return map;
			
		}catch(Exception e){
			System.out.println("Exception in GetParam.GetParam");
			e.printStackTrace();
		}
		return null;
		
	}
	
	public static HashMap GetParamValue(HttpServletRequest request,String oldCode,String newCode) {
		try{
			HashMap map = new HashMap();
			Enumeration keys = request.getParameterNames();
			while(keys.hasMoreElements()){
				String keyTemp = (String)keys.nextElement();
				String temp = (request.getParameter(keyTemp) == null) ? "" : new String(request.getParameter(keyTemp).getBytes(oldCode),newCode);
				map.put(keyTemp, temp);
			}
			return map;
			
		}catch(Exception e){
			System.out.println("Exception in GetParam.GetParam");
			e.printStackTrace();
		}
		return null;
		
	}
	
	public static String createJSON(List list, String strPra, int index,int pageSize){
		try{
			String[] strAray = strPra.split(",");
			
			String strJSON = "{totalProperty:";
			if(list == null || list.isEmpty()){
				strJSON = strJSON + "0,root:[]}";
			}else{
				strJSON = strJSON + list.size() + ",root:[";
				
				for(int i=index; i<list.size()&&i<pageSize+index ;i++){
					
					strJSON = strJSON + "{";
					
					HashMap map = (HashMap)list.get(i);
					
					for(int j = 0; j < strAray.length; j++){
						
						String strTemp = "";
						
						if(map.get(strAray[j]) == null){
		
						}else{
							strTemp = (String)map.get(strAray[j]);
						}				
						strJSON = strJSON + strAray[j].toString() + ":'" + strTemp.replace("'", "\\'") + "'";
						if(j != strAray.length - 1){
							strJSON = strJSON + ",";
						}
					}
					
					strJSON = strJSON + "}";
					
					if(i != pageSize + index - 1 && i != list.size()-1){
						strJSON = strJSON + ",";
					}
				}
				
				strJSON = strJSON + "]}";
			}
			
			return strJSON;
		}catch(Exception e){
			System.out.println("Exception in GetParam.GetParam");
			e.printStackTrace();
		}
		return null;	
	}
	public static String createJSON(List list, String strPra){
		String json = "";
		String[] strArray = strPra.split(",");
		if(list == null || list.isEmpty()){
			json = "[]";
		}else{
			json = "[";
			for(int i=0;i<list.size();i++){
				json += "{";
				for(int j=0;j<strArray.length;j++){
					json += "\""+strArray[j]+"\":\""+exchange.toHtml(((HashMap)list.get(i)).get(strArray[j]).toString())+"\",";
				}
				json = json.substring(0,json.length()-1) + "},";
			}
			json = json.substring(0,json.length()-1) + "]";
		}
		return json;
	}
	public static String outJSON(HttpServletResponse response,String json) {
		try{
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().write(json); 
			response.getWriter().close();
		}catch(Exception e){
			System.out.println("Exception in GetParam.GetParam");
			e.printStackTrace();
		}
		return null;
	}

	public static void main(String[] args) {

	}

}

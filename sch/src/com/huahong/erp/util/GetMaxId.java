package com.huahong.erp.util;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

public class GetMaxId {

	public  int getMaxId(String table,String ID){
		try{
			GetMaxIdDAO dao = new GetMaxIdDAO();
			HashMap map = new HashMap();
			map.put("table",table);
			map.put("ID",ID);
			int maxId = dao.getMaxId(map);
			return maxId;
		}catch (Exception ex){
			ex.printStackTrace();
		}
		return 0;
	}
}

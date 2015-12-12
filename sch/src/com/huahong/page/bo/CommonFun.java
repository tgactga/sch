package com.huahong.page.bo;

import java.util.HashMap;
import java.util.List;

import com.huahong.page.dao.IndexDAO;

public class CommonFun {
	public static List showTopNew(String ID, String TAG, String TIAO){
		String condition = "";
		if(TAG.equals("0")){
			condition = "NEW_TYPE = '"+ID+"'";
			if(ID.equals("3")) condition += " AND NEW_FEN!='7' ";
		}else{
			condition = "NEW_FEN = '"+ID+"'";
		}
		IndexDAO dao = new IndexDAO();
		HashMap map = new HashMap();
		map.put("condition", condition);
		map.put("TIAO", TIAO);
		List list = dao.getTopNewList(map);
		return list;
	}
}

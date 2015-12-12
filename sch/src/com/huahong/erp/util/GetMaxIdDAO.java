package com.huahong.erp.util;

import java.util.HashMap;

import com.huahong.erp.BaseDAO;
import com.huahong.util.Log;

public class GetMaxIdDAO extends BaseDAO{
	public int getMaxId(HashMap map){
		try{
			String id = (String)dao.queryForObject("GetMaxIdDAO.getMaxId",map);
			if(id == null){
				id = "0";
				
			}
			int rowId = Integer.parseInt(id)+1;
			return rowId;
		}catch(Exception e){
			Log.error("GetMaxIdDAO.getMaxId方法出现异常！" + e.getMessage());
		}
		return 0;
	}
}

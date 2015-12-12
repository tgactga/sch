package com.huahong.util;

import java.util.HashMap;
import java.util.List;

import com.huahong.erp.BaseDAO;
import com.huahong.util.Log;

public class CommonFunDAO extends BaseDAO{
	//获取总行数
	public List getTotal(String condition) {
		try {
			return dao.queryForList("CommonFunDAO.getTotal", condition);
		} catch (Exception e) {
			Log.error("CommonFunDAO.getTotal方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public boolean insertLog(HashMap map) {
		try {
			dao.insert("CommonFunDAO.insertLog", map);
			return true;
		} catch (Exception e) {
			Log.error("CommonFunDAO.insertLog方法出现异常 " + e.getMessage());
			return false;
		}
	}
	public List getMainPage(String TYPE) {
		try {
			return dao.queryForList("CommonFunDAO.getMainPage", TYPE);
		} catch (Exception e) {
			Log.error("CommonFunDAO.getMainPage方法出现异常 " + e.getMessage());
			return null;
		}
	}
}

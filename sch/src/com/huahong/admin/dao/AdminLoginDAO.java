package com.huahong.admin.dao;

import java.util.HashMap;
import java.util.List;

import com.huahong.erp.BaseDAO;
import com.huahong.util.Log;

public class AdminLoginDAO extends BaseDAO{
	public List getAdminUser(HashMap map) {
		try {
			 return dao.queryForList("AdminLoginDAO.getAdminUser", map);
		} catch (Exception e) {
			Log.error("AdminLoginDAO.getAdminUser方法出现异常 " + e.getMessage());
			return null;
		}
	}
	
	public boolean updateAdminUser(HashMap map) {
		try {
			 dao.insert("AdminLoginDAO.updateAdminUser", map);
			  return true;
		} catch (Exception e) {
			Log.error("AdminLoginDAO.updateAdminUser方法出现异常 " + e.getMessage());
			return false;
		}
	}

}
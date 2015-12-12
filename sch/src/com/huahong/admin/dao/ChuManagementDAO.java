package com.huahong.admin.dao;

import java.util.HashMap;
import java.util.List;

import com.huahong.erp.BaseDAO;
import com.huahong.util.Log;

public class ChuManagementDAO extends BaseDAO{
	public List searchChuList(HashMap map) {
		try {
			 return dao.queryForList("ChuManagementDAO.searchClassList", map);
		} catch (Exception e) {
			Log.error("ClassManagementDAO.searchClassList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public List searchAllChu() {
		try {
			 return dao.queryForList("ChuManagementDAO.searchAllChu", null);
		} catch (Exception e) {
			Log.error("ClassManagementDAO.searchAllChu方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public boolean insertChu(HashMap map) {
		try {
			dao.insert("ChuManagementDAO.insertChu", map);
			return true;
		} catch (Exception e) {
			Log.error("ChuManagementDAO.insertChu方法出现异常 " + e.getMessage());
			return false;
		}
	}
	public boolean updateChu(HashMap map) {
		try {
			dao.update("ChuManagementDAO.updateChu", map);
			return true;
		} catch (Exception e) {
			Log.error("ChuManagementDAO.updateChu方法出现异常 " + e.getMessage());
			return false;
		}
	}
}

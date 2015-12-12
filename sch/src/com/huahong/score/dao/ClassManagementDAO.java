package com.huahong.score.dao;

import java.util.HashMap;
import java.util.List;

import com.huahong.erp.BaseDAO;
import com.huahong.util.Log;

public class ClassManagementDAO extends BaseDAO{
	public List searchClassList(HashMap map) {
		try {
			 return dao.queryForList("ClassManagementDAO.searchClassList", map);
		} catch (Exception e) {
			Log.error("ClassManagementDAO.searchClassList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public boolean insertClass(HashMap map) {
		try {
			dao.insert("ClassManagementDAO.insertClass", map);
			return true;
		} catch (Exception e) {
			Log.error("ClassManagementDAO.insertClass方法出现异常 " + e.getMessage());
			return false;
		}
	}
	public boolean updateClass(HashMap map) {
		try {
			dao.update("ClassManagementDAO.updateClass", map);
			return true;
		} catch (Exception e) {
			Log.error("ClassManagementDAO.updateClass方法出现异常 " + e.getMessage());
			return false;
		}
	}
}
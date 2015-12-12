package com.huahong.score.dao;

import java.util.HashMap;
import java.util.List;

import com.huahong.erp.BaseDAO;
import com.huahong.util.Log;

public class StatManagementDAO extends BaseDAO{
	public List searchScoreList(HashMap map) {
		try {
			 return dao.queryForList("StatManagementDAO.searchScoreList", map);
		} catch (Exception e) {
			Log.error("StatManagementDAO.searchScoreList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public List searchTotalStatList(HashMap map) {
		try {
			 return dao.queryForList("StatManagementDAO.searchTotalStatList", map);
		} catch (Exception e) {
			Log.error("StatManagementDAO.searchTotalStatList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public List searchClassTotalStatList(HashMap map) {
		try {
			 return dao.queryForList("StatManagementDAO.searchClassTotalStatList", map);
		} catch (Exception e) {
			Log.error("StatManagementDAO.searchClassTotalStatList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public List searchDanKeFenList(String sql) {
		try {
			 return dao.queryForList("StatManagementDAO.searchDanKeFenList", sql);
		} catch (Exception e) {
			Log.error("StatManagementDAO.searchDanKeFenList方法出现异常 " + e.getMessage());
			return null;
		}
	}
}
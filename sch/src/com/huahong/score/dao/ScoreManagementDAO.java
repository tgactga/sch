package com.huahong.score.dao;

import java.util.HashMap;
import java.util.List;

import com.huahong.erp.BaseDAO;
import com.huahong.util.Log;

public class ScoreManagementDAO extends BaseDAO{
	public List searchScoreList(HashMap map) {
		try {
			 return dao.queryForList("ScoreManagementDAO.searchScoreList", map);
		} catch (Exception e) {
			Log.error("ScoreManagementDAO.searchScoreList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public boolean insertScore(HashMap map) {
		try {
			dao.insert("ScoreManagementDAO.insertScore", map);
			return true;
		} catch (Exception e) {
			Log.error("ScoreManagementDAO.insertScore方法出现异常 " + e.getMessage());
			return false;
		}
	}
	public List searchStList(HashMap map) {
		try {
			 return dao.queryForList("ScoreManagementDAO.searchStList", map);
		} catch (Exception e) {
			Log.error("ScoreManagementDAO.searchStList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public List searchStScoreList(HashMap map) {
		try {
			 return dao.queryForList("ScoreManagementDAO.searchStScoreList", map);
		} catch (Exception e) {
			Log.error("ScoreManagementDAO.searchStScoreList方法出现异常 " + e.getMessage());
			return null;
		}
	}
}
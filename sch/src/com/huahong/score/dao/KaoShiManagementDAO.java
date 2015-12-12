package com.huahong.score.dao;

import java.util.HashMap;
import java.util.List;

import com.huahong.erp.BaseDAO;
import com.huahong.util.Log;

public class KaoShiManagementDAO extends BaseDAO{
	public List searchKaoShiList(HashMap map) {
		try {
			 return dao.queryForList("KaoShiManagementDAO.searchKaoShiList", map);
		} catch (Exception e) {
			Log.error("KaoShiManagementDAO.searchKaoShiList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public boolean insertKaoShi(HashMap map) {
		try {
			dao.insert("KaoShiManagementDAO.insertKaoShi", map);
			return true;
		} catch (Exception e) {
			Log.error("KaoShiManagementDAO.insertKaoShi方法出现异常 " + e.getMessage());
			return false;
		}
	}
	public boolean updateKaoShi(HashMap map) {
		try {
			dao.update("KaoShiManagementDAO.updateKaoShi", map);
			return true;
		} catch (Exception e) {
			Log.error("KaoShiManagementDAO.updateKaoShi方法出现异常 " + e.getMessage());
			return false;
		}
	}
}
package com.huahong.admin.dao;

import java.util.HashMap;
import java.util.List;

import com.huahong.erp.BaseDAO;
import com.huahong.util.Log;

public class LeftTreeDAO extends BaseDAO{
	public List searchLeftUserList(String ID) {
		try {
			return dao.queryForList("LeftTreeDAO.searchLeftUserList", ID);
		} catch (Exception e) {
			Log.error("LeftTreeDAO.searchLeftUserList方法出现异常 " + e.getMessage());
			return null;
		}
	}
}

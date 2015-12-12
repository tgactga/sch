package com.huahong.page.dao;

import java.util.HashMap;
import java.util.List;

import com.huahong.erp.BaseDAO;
import com.huahong.util.Log;

public class IndexDAO extends BaseDAO{
	//首页查询热点新闻
	public List getHotNewList(String NEW_TYPE) {
		try {
			return dao.queryForList("IndexDAO.getHotNewList", NEW_TYPE);
		} catch (Exception e) {
			Log.error("IndexDAO.getHotNewList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	//首页查询新闻详情
	public List getTopNewList(HashMap map) {
		try {
			return dao.queryForList("IndexDAO.getTopNewList", map);
		} catch (Exception e) {
			Log.error("IndexDAO.getTopNewList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public List getListUser(HashMap map) {
		try {
			return dao.queryForList("IndexDAO.getListUser", map);
		} catch (Exception e) {
			Log.error("IndexDAO.getListUser方法出现异常 " + e.getMessage());
			return null;
		}
	}
}

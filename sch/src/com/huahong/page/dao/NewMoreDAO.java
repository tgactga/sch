package com.huahong.page.dao;

import java.util.HashMap;
import java.util.List;

import com.huahong.erp.BaseDAO;
import com.huahong.util.Log;

public class NewMoreDAO extends BaseDAO{
	public List getMoreNew(HashMap map){
		try {
			return dao.queryForList("NewMoreDAO.getMoreNew", map);
		} catch (Exception e) {
			Log.error("NewMoreDAO.getNew方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public List getFen(String ID){
		try {
			return dao.queryForList("NewMoreDAO.getFen", ID);
		} catch (Exception e) {
			Log.error("NewMoreDAO.getFen方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public String getFenTitle(String ID){
		try {
			String title = (String)dao.queryForObject("NewMoreDAO.getFenTitle", ID);
			return title;
		} catch (Exception e) {
			Log.error("NewMoreDAO.getFenTitle方法出现异常 " + e.getMessage());
			return "";
		}
	}
}

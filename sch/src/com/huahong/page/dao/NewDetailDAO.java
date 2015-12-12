package com.huahong.page.dao;

import java.util.HashMap;
import java.util.List;

import com.huahong.erp.BaseDAO;
import com.huahong.util.Log;

public class NewDetailDAO extends BaseDAO{
	public List getNew(String ID){
		try {
			return dao.queryForList("NewDetailDAO.getNew", ID);
		} catch (Exception e) {
			Log.error("NewDetailDAO.getNew方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public boolean addNum(String ID){
		try{
			dao.update("NewDetailDAO.addNum", ID);
			return true;
		}catch(Exception e){
			Log.error("NewDetailDAO.addNum方法出现异常 " + e.getMessage());
			return false;
		}
	}
}

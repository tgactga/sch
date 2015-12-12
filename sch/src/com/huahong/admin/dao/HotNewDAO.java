package com.huahong.admin.dao;

import java.util.HashMap;
import java.util.List;

import com.huahong.erp.BaseDAO;
import com.huahong.util.Log;

public class HotNewDAO extends BaseDAO{
	//查询热点新闻
	public List getHotNewList(HashMap map) {
		try {
			 return dao.queryForList("HotNewDAO.getHotNewList", map);
		} catch (Exception e) {
			Log.error("HotNewDAO.getHotNewList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	//查询热点新闻根据类型查询
	public List getHotNewListType(String ID) {
		try {
			 return dao.queryForList("HotNewDAO.getHotNewListType", ID);
		} catch (Exception e) {
			Log.error("HotNewDAO.getHotNewListType方法出现异常" + e.getMessage());
			return null;
		}
	}
	//添加热点新闻
	public boolean insertHotNew(HashMap map){
		try{
			dao.insert("HotNewDAO.insertHotNew", map);
			return true;
		}catch(Exception e){
			Log.error("HotNewDAO.insertHotNew方法出现异常" + e.getMessage());
			return false;
		}
	}
	//查询热点新闻详情
	public List getHotNewDet(String ID) {
		try {
			 return dao.queryForList("HotNewDAO.getHotNewDet", ID);
		} catch (Exception e) {
			Log.error("HotNewDAO.getHotNewDet方法出现异常" + e.getMessage());
			return null;
		}
	}
	public boolean updateHotNew(HashMap map){
		try{
			dao.update("HotNewDAO.updateHotNew", map);
			return true;
		}catch(Exception e){
			Log.error("HotNewDAO.updateHotNew方法出现异常" + e.getMessage());
			return false;
		}
	}
	public boolean updateHotNewText(HashMap map){
		try{
			dao.update("HotNewDAO.updateHotNewText", map);
			return true;
		}catch(Exception e){
			Log.error("HotNewDAO.updateHotNewText方法出现异常" + e.getMessage());
			return false;
		}
	}
}

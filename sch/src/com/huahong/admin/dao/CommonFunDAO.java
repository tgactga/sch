package com.huahong.admin.dao;

import java.util.HashMap;
import java.util.List;

import com.huahong.erp.BaseDAO;
import com.huahong.util.Log;

public class CommonFunDAO extends BaseDAO{
	//获取总行数
	public List getTotal(String condition) {
		try {
			return dao.queryForList("CommonFunDAO.getTotal", condition);
		} catch (Exception e) {
			Log.error("CommonFunDAO.getTotal方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public boolean insertLog(HashMap map) {
		try {
			dao.insert("CommonFunDAO.insertLog", map);
			return true;
		} catch (Exception e) {
			Log.error("CommonFunDAO.insertLog方法出现异常 " + e.getMessage());
			return false;
		}
	}
	//根据发文ID查询发文信息
	public List getSendDetList(String ID) {
		try {
			return dao.queryForList("CommonFunDAO.getSendDetList", ID);
		} catch (Exception e) {
			Log.error("CommonFunDAO.getSendDetList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	//根据发文ID查询接收单位信息
	public List getSendReceiveList(String ID) {
		try {
			return dao.queryForList("CommonFunDAO.getSendReceiveList", ID);
		} catch (Exception e) {
			Log.error("CommonFunDAO.getSendReceiveList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	//根据发文ID查询发送文件信息
	public List getSendFileList(String ID) {
		try {
			return dao.queryForList("CommonFunDAO.getSendFileList", ID);
		} catch (Exception e) {
			Log.error("CommonFunDAO.getSendFileList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public List getSendRecFileList(HashMap map) {
		try {
			return dao.queryForList("CommonFunDAO.getSendRecFileList", map);
		} catch (Exception e) {
			Log.error("CommonFunDAO.getSendRecFileList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public String getParentName(String ID) {
		try {
			String name = (String)dao.queryForObject("CommonFunDAO.getParentName", ID);
			return name;
		} catch (Exception e) {
			Log.error("CommonFunDAO.getParentName方法出现异常 " + e.getMessage());
			return "";
		}
	}
}

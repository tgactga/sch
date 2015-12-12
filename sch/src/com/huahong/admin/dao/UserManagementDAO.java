package com.huahong.admin.dao;

import java.util.HashMap;
import java.util.List;

import com.huahong.erp.BaseDAO;
import com.huahong.util.Log;

public class UserManagementDAO extends BaseDAO{
	//查询所有用户
	public List searchAllUserList(HashMap map) {
		try {
			return dao.queryForList("UserManagementDAO.searchAllUserList", map);
		} catch (Exception e) {
			Log.error("UserManagementDAO.searchAllUserList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	//添加用户
	public boolean insertUser(HashMap map){
		try{
			dao.insert("UserManagementDAO.insertUser", map);
			return true;
		}catch(Exception e){
			Log.error("UserManagementDAO.insertUser方法出现异常 " + e.getMessage());
			return false;
		}
	}
	//查询所有角色
	public List getAllRole() {
		try {
			return dao.queryForList("UserManagementDAO.getAllRole", null);
		} catch (Exception e) {
			Log.error("UserManagementDAO.getAllRole方法出现异常 " + e.getMessage());
			return null;
		}
	}
	//修改用户
	public boolean updateUser(HashMap map){
		try{
			dao.insert("UserManagementDAO.updateUser", map);
			return true;
		}catch(Exception e){
			Log.error("UserManagementDAO.updateUser方法出现异常 " + e.getMessage());
			return false;
		}
	}
}

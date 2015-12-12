package com.huahong.admin.dao;

import java.util.HashMap;
import java.util.List;

import com.huahong.erp.BaseDAO;
import com.huahong.util.Log;

public class RoleManagementDAO extends BaseDAO{
	//查询角色列表
	public List searchRoleList(HashMap map) {
		try {
			return dao.queryForList("RoleManagementDAO.searchRoleList", map);
		} catch (Exception e) {
			Log.error("RoleManagementDAO.searchRoleList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	//添加角色
	public boolean insertRole(HashMap map){
		try{
			dao.insert("RoleManagementDAO.insertRole", map);
			return true;
		}catch(Exception e){
			Log.error("RoleManagementDAO.insertRole方法出现异常 " + e.getMessage());
			return false;
		}
	}
	//修改角色
	public boolean updateRole(HashMap map){
		try{
			dao.insert("RoleManagementDAO.updateRole", map);
			return true;
		}catch(Exception e){
			Log.error("RoleManagementDAO.updateRole方法出现异常 " + e.getMessage());
			return false;
		}
	}
	//获取权限树
	public List getRoleTreeList() {
		try {
			return dao.queryForList("RoleManagementDAO.getRoleTreeList", null);
		} catch (Exception e) {
			Log.error("RoleManagementDAO.getRoleTreeList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	//获取该角色有的权限
	public List getRoleHaveTreeList(HashMap map) {
		try {
			return dao.queryForList("RoleManagementDAO.getRoleHaveTreeList", map);
		} catch (Exception e) {
			Log.error("RoleManagementDAO.getRoleHaveTreeList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	//删除旧的权限
	public boolean deleteOldRole(String ID){
		try{
			dao.insert("RoleManagementDAO.deleteOldRole", ID);
			return true;
		}catch(Exception e){
			Log.error("RoleManagementDAO.deleteOldRole方法出现异常 " + e.getMessage());
			return false;
		}
	}
	//添加权限
	public boolean insertAssign(HashMap map){
		try{
			dao.insert("RoleManagementDAO.insertAssign", map);
			return true;
		}catch(Exception e){
			Log.error("RoleManagementDAO.insertAssign方法出现异常 " + e.getMessage());
			return false;
		}
	}
}

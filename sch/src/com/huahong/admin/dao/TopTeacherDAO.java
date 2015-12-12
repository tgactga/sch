package com.huahong.admin.dao;

import java.util.HashMap;
import java.util.List;

import com.huahong.erp.BaseDAO;
import com.huahong.util.Log;

public class TopTeacherDAO extends BaseDAO{
	public List getTeacherList(HashMap map) {
		try {
			return dao.queryForList("TopTeacherDAO.getTeacherList", map);
		} catch (Exception e) {
			Log.error("TopTeacherDAO.getTeacherList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public List getTopTeacherDet(String ID) {
		try {
			return dao.queryForList("TopTeacherDAO.getTopTeacherDet", ID);
		} catch (Exception e) {
			Log.error("TopTeacherDAO.getTopTeacherDet方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public boolean insertTeacher(HashMap map){
		try{
			dao.insert("TopTeacherDAO.insertTeacher", map);
			return true;
		}catch(Exception e){
			Log.error("TopTeacherDAO.insertTeacher方法出现异常" + e.getMessage());
			return false;
		}
	}
	public boolean updateTeacher(HashMap map){
		try{
			dao.insert("TopTeacherDAO.updateTeacher", map);
			return true;
		}catch(Exception e){
			Log.error("TopTeacherDAO.updateTeacher方法出现异常" + e.getMessage());
			return false;
		}
	}
	public List getAllTeacherList(String TYPE) {
		try {
			return dao.queryForList("TopTeacherDAO.getAllTeacherList", TYPE);
		} catch (Exception e) {
			Log.error("TopTeacherDAO.getAllTeacherList方法出现异常 " + e.getMessage());
			return null;
		}
	}
}

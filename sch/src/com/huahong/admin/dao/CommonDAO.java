package com.huahong.admin.dao;

import java.util.HashMap;
import java.util.List;

import com.huahong.erp.BaseDAO;
import com.huahong.util.Log;

public class CommonDAO extends BaseDAO{
	//查询新闻
	public List getNewList(HashMap map) {
		try {
			return dao.queryForList("CommonDAO.getNewList", map);
		} catch (Exception e) {
			Log.error("CommonDAO.getNewList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	//查询文件列表
	public List getDocList(HashMap map) {
		try {
			return dao.queryForList("CommonDAO.getDocList", map);
		} catch (Exception e) {
			Log.error("CommonDAO.getDocList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	//添加新闻
	public boolean insertNew(HashMap map){
		try{
			dao.insert("CommonDAO.insertNew", map);
			return true;
		}catch(Exception e){
			Log.error("CommonDAO.insertNew方法出现异常 " + e.getMessage());
			return false;
		}
	}
	//添加新闻文件附件
	public boolean insertFile(HashMap map){
		try{
			dao.insert("CommonDAO.insertFile", map);
			return true;
		}catch(Exception e){
			Log.error("CommonDAO.insertFile方法出现异常 " + e.getMessage());
			return false;
		}
	}
	//查询新闻栏目
	public List getNewLan(String ID) {
		try {
			return dao.queryForList("CommonDAO.getNewLan", ID);
		} catch (Exception e) {
			Log.error("CommonDAO.getNewLan方法出现异常 " + e.getMessage());
			return null;
		}
	}
	//查询新闻详细
	@SuppressWarnings("rawtypes")
	public List getNewDetail(String ID){
		try{
			List list = dao.queryForList("CommonDAO.getNewDetail", ID);
			return list;
		}catch(Exception e){
			Log.error("CommonDAO.getNewDetail方法出现异常 " + e.getMessage());
			return null;
		}
	}
	//获取新闻文件
	public List getNewFileDetail(String ID){
		try{
			return dao.queryForList("CommonDAO.getNewFileDetail", ID);
		}catch(Exception e){
			Log.error("CommonDAO.getNewFileDetail方法出现异常 " + e.getMessage());
			return null;
		}
	}
	//添加新闻
	public boolean updateNew(HashMap map){
		try{
			dao.insert("CommonDAO.updateNew", map);
			return true;
		}catch(Exception e){
			Log.error("CommonDAO.updateNew方法出现异常 " + e.getMessage());
			return false;
		}
	}
	//添加新闻
	public boolean updateAuditNew(HashMap map){
		try{
			dao.insert("CommonDAO.updateAuditNew", map);
			return true;
		}catch(Exception e){
			Log.error("CommonDAO.updateAuditNew方法出现异常 " + e.getMessage());
			return false;
		}
	}
	//公共删除
	public boolean deleteCommon(HashMap map){
		try{
			dao.insert("CommonDAO.deleteCommon", map);
			return true;
		}catch(Exception e){
			Log.error("CommonDAO.deleteCommon方法出现异常 " + e.getMessage());
			return false;
		}
	}//查询分类
	public List getFenList(String ID) {
		try {
			return dao.queryForList("CommonDAO.getFenList", ID);
		} catch (Exception e) {
			Log.error("CommonDAO.getFenList方法出现异常 " + e.getMessage());
			return null;
		}
	}
}
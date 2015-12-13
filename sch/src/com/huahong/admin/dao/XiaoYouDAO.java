package com.huahong.admin.dao;

import java.util.HashMap;
import java.util.List;

import com.huahong.erp.BaseDAO;
import com.huahong.util.Log;

public class XiaoYouDAO extends BaseDAO{
	public List getXiaoYouList(HashMap map) {
		try {
			return dao.queryForList("XiaoYouDAO.getXiaoYouList", map);
		} catch (Exception e) {
			Log.error("XiaoYouDAO.getXiaoYouList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public List getXiaoYouTopList() {
		try {
			return dao.queryForList("XiaoYouDAO.getXiaoYouTopList", null);
		} catch (Exception e) {
			Log.error("XiaoYouDAO.getXiaoYouTopList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	//添加新闻
	public boolean insertNew(HashMap map){
		try{
			dao.insert("XiaoYouDAO.insertNew", map);
			return true;
		}catch(Exception e){
			Log.error("XiaoYouDAO.insertNew方法出现异常 " + e.getMessage());
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
			return dao.queryForList("XiaoYouDAO.getNewFileDetail", ID);
		}catch(Exception e){
			Log.error("XiaoYouDAO.getNewFileDetail方法出现异常 " + e.getMessage());
			return null;
		}
	}
	//添加新闻
	public boolean updateNew(HashMap map){
		try{
			dao.insert("XiaoYouDAO.updateNew", map);
			return true;
		}catch(Exception e){
			Log.error("XiaoYouDAO.updateNew方法出现异常 " + e.getMessage());
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
	}
	public List getMoreXiaoYou(HashMap map) {
		try {
			return dao.queryForList("XiaoYouDAO.getMoreXiaoYou", map);
		} catch (Exception e) {
			Log.error("XiaoYouDAO.getMoreXiaoYou方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public List getXiaoYouMingList(HashMap map) {
		try {
			return dao.queryForList("XiaoYouDAO.getXiaoYouMingList", map);
		} catch (Exception e) {
			Log.error("XiaoYouDAO.getXiaoYouMingList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public boolean insertXiaoYouMing(HashMap map){
		try{
			dao.insert("XiaoYouDAO.insertXiaoYouMing", map);
			return true;
		}catch(Exception e){
			Log.error("XiaoYouDAO.insertXiaoYouMing方法出现异常 " + e.getMessage());
			return false;
		}
	}
	public boolean updatetXiaoYouMing(HashMap map){
		try{
			dao.update("XiaoYouDAO.updatetXiaoYouMing", map);
			return true;
		}catch(Exception e){
			Log.error("XiaoYouDAO.updatetXiaoYouMing方法出现异常 " + e.getMessage());
			return false;
		}
	}
	public List getBiYeList(String XIAOYOU_SUO) {
		try {
			return dao.queryForList("XiaoYouDAO.getBiYeList", XIAOYOU_SUO);
		} catch (Exception e) {
			Log.error("XiaoYouDAO.getBiYeList方法出现异常 " + e.getMessage());
			return null;
		}
	}
	public List getXiaoYouMingBiYeList(HashMap map) {
		try {
			return dao.queryForList("XiaoYouDAO.getXiaoYouMingBiYeList", map);
		} catch (Exception e) {
			Log.error("XiaoYouDAO.getXiaoYouMingBiYeList方法出现异常 " + e.getMessage());
			return null;
		}
	}
}
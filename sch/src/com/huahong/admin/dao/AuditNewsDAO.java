package com.huahong.admin.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.huahong.erp.BaseDAO;
import com.huahong.erp.util.GetParam;
import com.huahong.erp.util.exchange;
import com.huahong.util.CommonFun;
import com.huahong.util.Log;

public class AuditNewsDAO extends BaseDAO{
	public List getAuditNewList(HashMap map) {
		try {
			return dao.queryForList("CommonDAO.getAuditNewList", map);
		} catch (Exception e) {
			Log.error("CommonDAO.getAuditNewList方法出现异常 " + e.getMessage());
			return null;
		}
	}
}

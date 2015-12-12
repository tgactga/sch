package com.huahong.erp;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.huahong.util.db.DBManager;
import com.huahong.util.db.IDBManager;

public class BaseDAO {
	
	public IDBManager dbm = null;

	public SqlMapClient dao = null;

	public BaseDAO(){
		dbm = DBManager.getDBManager();
		dao = dbm.getMapClient();
	}

}

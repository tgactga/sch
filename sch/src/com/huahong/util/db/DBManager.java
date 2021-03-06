package com.huahong.util.db;

import java.util.Properties;

import com.huahong.util.ResourceReader;
import com.huahong.util.db.DBManager;
import com.huahong.util.Log;
import com.huahong.util.db.IDBManager;

public class DBManager {
	
public static IDBManager idb = null;
	
	private static String implClass = "com.huahong.util.db.DBManagerIBATISImpl";
	
	public static Properties props = ResourceReader.getResourcesFromPackage(
			"/com/huahong/util/db/config.properties",
			DBManager.class);
	
	/**
	 * 获得数据库连接管理类
	 * 
	 * @return IDBManager
	 */
	public static IDBManager getDBManager(){
		
		if(props != null && props.get("implClass") != null){
			implClass = (String)props.getProperty("implClass");
		}
		if(idb == null){
			try{
				idb = (IDBManager)Class.forName(implClass).newInstance();
			} catch(InstantiationException ie){
				Log.error("配置的数据库管理类不能被实例化，请确认配置是否正确！" + ie.getMessage());
			} catch(IllegalAccessException iae){
				Log.error("配置的数据库管理类无法访问，请确认配置是否正确！" + iae.getMessage());
			} catch(ClassNotFoundException ce){
				Log.error("配置的数据库管理类未找到，请确认配置是否正确！" + ce.getMessage());
			}
		}
		return idb;
	}

}

package com.huahong.erp.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Properties;
import java.util.Date;

import com.huahong.util.CommonException;
import com.huahong.util.FileUtil;
import com.huahong.util.DateUtils;
import com.huahong.util.Log;
import com.huahong.util.ResourceReader;
import com.huahong.util.security.Security;

public class AdminUtil {
	
	public static final String FILENAME = "admin.properties";
	public static final String DATABASE_FILENAME = "config/config.properties";
	public static final String KEY = "status";
	public static String path = null;
	public static final String sep = System.getProperty("file.separator");
	
	public static void getConfigurePath() {
		if (path == null) {
			path = FileUtil.getClassPath();		// 寻找到classes路径
			Log.info("获取的路径为：" + path);	
		}
	}
	
	/**
	 * 判断WEB环境是否被正确的配置了。<br>
	 * 方法：查找WEB-INF/classes目录下的admin.properties文件是否存在，以及文件内容配置是否正确。 <br>
	 * 
	 * @return
	 */
	public static boolean ifConfigured()  throws CommonException{
		InputStream in = null;
		try {
		
			getConfigurePath();
			if (path == null) {
				return false;
			}
			// 加载配置文件
			Properties props = new Properties();
			File file = new File(path + sep + FILENAME);
			if(!file.exists())
				return false;
			in = new FileInputStream(file);
			props.load(in);
			props = ResourceReader.getDecodedResources(props);
			if (props.get(KEY) == null
					|| !props.get(KEY).toString().equals("ok")) {
				return false;
			} else {
				return true;
			}
		} catch (Exception e) {
			Log.error("获取管理员配置文件路径错误！" + e.getMessage());
			e.printStackTrace();
			throw new CommonException("获取管理员配置信息错误！" + e.getMessage());
		} finally {
			try {
				if (in != null)
					in.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 获得数据库配置的相关信息
	 * 
	 * @return
	 */
	public static Properties getDatabaseConfigure() throws CommonException{
		return getProperties(path  + DATABASE_FILENAME);//path + sep + DATABASE_FILENAME
		
	}
	
	/**
	 * 设置数据库配置 <br>
	 * 
	 * @param props
	 * @return
	 */
	public static boolean setDatabaseConfigure(Properties props) {
		return setProperties(props, path + sep + DATABASE_FILENAME);
	}
	
	/**
	 * 获得指定配置文件
	 * 
	 * @param filename
	 * @return
	 */
	protected static Properties getProperties(String filename) throws CommonException{
		InputStream in = null;
		Log.info("管理员配置文件：" + filename);
		try {
			getConfigurePath();
			if (path == null) {
				return null;
			}
			// 加载配置文件
			Properties props = new Properties();
			File file = new File(filename);
			if(!file.exists())
				return null;
			in = new FileInputStream(file);
			props.load(in);
			props = ResourceReader.getDecodedResources(props);
			
			if (props == null) {
				return null;
			} else {
				return props;
			}
		} catch (Exception e) {
			Log.error("获取配置文件" + filename + "错误！" + e.getMessage());
			e.printStackTrace();
			throw new CommonException("管理员设置配置信息错误：" + e.getMessage());
		} finally {
			try {
				if (in != null)
					in.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 保存Properties文件
	 * @param props
	 */
	protected static boolean setProperties(Properties props, String filename){
		FileOutputStream out = null;
		File file = null;
		try {
			getConfigurePath();
			if (path == null) {
				return false;
			}
			file = new File(filename);
			if (!file.exists()) {
				file.createNewFile();
			}
			out = new FileOutputStream(file);
			props.store(out, "admin set already at " + DateUtils.dateToString(new Date(), "yyyy-MM-dd HH:mm:ss"));
			out.flush();

			Log.info("管理员配置：" + filename + " 配置成功！");
			return true;
		} catch (Exception e) {
			Log.error("获取管理员配置文件路径错误！" + e.getMessage());
			e.printStackTrace();
			return false;
		} finally {
			try {
				if (out != null)
					out.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public static boolean setConfigured() throws CommonException{
		String filename = path + sep + FILENAME;
		Properties props = new Properties();
		Security sec = Security.getInstance();
		props.put(KEY, sec.encodeString("ok"));
		return setProperties(props, filename);
	}
}

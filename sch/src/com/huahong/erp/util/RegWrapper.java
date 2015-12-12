package com.huahong.erp.util;

import com.huahong.erp.util.RegWrapper;
import com.huahong.erp.util.RegWrapperImplJava;
import com.huahong.erp.util.RegWrapperImplORO;

public abstract class RegWrapper {
	
	public static RegWrapper wrapper = null;
	
	/**
	 * Java模式
	 */
	public static final String BY_JAVA = "java";

	/**
	 * ORO中的Perl模式
	 */
	public static final String BY_ORO = "oro";

	/**
	 * 单例模式，默认使用Java方式
	 * 
	 * @return
	 */
	public static RegWrapper getInstance() {
		return getInstance(BY_ORO);
	}
	
	/**
	 * 可以使用Java或者ORO
	 * 
	 * @param by
	 * @return
	 */
	public static RegWrapper getInstance(String by) {
//		if (wrapper == null) {
			if (by.equalsIgnoreCase(BY_JAVA)) {
				wrapper = new RegWrapperImplJava();
			} else {
				wrapper = new RegWrapperImplORO();
			}
//		}
		return wrapper;
	}
	
	/**
	 * 判断给定的字符串value中，是否包含pat所表示的字符串
	 * 
	 * @param value
	 * @param pat
	 * @return boolean
	 */
	public abstract boolean ifFind(String value, String pat);
	
	/**
	 * 检查输入条件是否合法
	 * 
	 * @param value
	 * @param patt
	 * @return
	 */
	public boolean checkCondition(String value, String patt){
		if(value == null || value.length() < 1 || patt == null || patt.length() < 1)
			return false;
		return true;
	}
	
	/**
	 * 根据给定的模式pat从字符串value中找到满足条件的字符串，通常返回一条记录。如果返回多条记录，不能使用此方法；<br>
	 * 调用重载函数，index这里等于1；
	 * 
	 * @param value
	 * @param pat
	 * @return
	 */
	public String getRegsValue(String value, String pat){
		return getRegsValue(value, pat, 1);
	}
	
	/**
	 * 根据给定的模式pat从字符串value中找到满足条件的字符串，通常返回一条记录。如果返回多条记录，不能使用此方法；<br>
	 * index表示获取哪个分组的数据
	 * 
	 * @param value
	 * @param pat
	 * @param index
	 * @return
	 */
	public abstract String getRegsValue(String value, String pat, int index);

}

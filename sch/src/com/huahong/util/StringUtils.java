package com.huahong.util;

import java.security.MessageDigest;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.huahong.erp.util.RegWrapper;

public class StringUtils {
	
	private static final char[] QUOTE_ENCODE = "&quot;".toCharArray();
	private static final char[] AMP_ENCODE = "&amp;".toCharArray();
	private static final char[] LT_ENCODE = "&lt;".toCharArray();
	private static final char[] GT_ENCODE = "&gt;".toCharArray();
	private static MessageDigest digest = null;
	private  static final String  _ERROR_REGX = "(java.[a-zA-Z]*.[a-zA-Z]*)"; 
	public static final RegWrapper regx = RegWrapper.getInstance();
	
	/**
	 * 去除空格的方法
	 * @param source
	 * @return
	 */
	public static String trimString(String source){
		if(source == null)
			return "";
		else if(source.indexOf("　") > -1){
			return source.replaceAll("　", "").trim();
		}else {
			return source.trim();
		}
	}
	
	/**
	 * 数据库异常信息截取函数，返回java.***.***:原因  样例的错误信息 错误表达式:(java.[a-zA-Z]*.[a-zA-Z]*)
	 * @param error 原始错误消息
	 * @param otherinfo 当没有找到指定错误消息时候需要返回的信息
	 * @return 处理后的错误消息
	 */
	public static String splitDBException(String error,String otherInfo){
		if(error == null){
			return otherInfo;
		}
		String error_detals  = "";
		if(regx.ifFind(error, _ERROR_REGX)){
			error_detals = regx.getRegsValue(error, _ERROR_REGX);
			if(!error_detals.equalsIgnoreCase("")){
				int index = error.indexOf(error_detals);
				int end_index = error.length();
				String splitString = error.substring(index, end_index).replace('\n', ' ').trim();
				return splitString != null ? splitString:otherInfo;
			}
			else{
				return otherInfo;
			}
		}else{
			return otherInfo;
		}
	}
	public static String replaceBlank(String str) {
		String dest = "";
		if (str!=null) {
			//Pattern p = Pattern.compile("\\s*|\t|\r|\n");
			Pattern p = Pattern.compile("\t|\r|\n");
			Matcher m = p.matcher(str);
			dest = m.replaceAll("");
		}
		return dest;
	}
}

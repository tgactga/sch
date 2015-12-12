package com.huahong.erp.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;

import com.huahong.erp.util.RegWrapper;
import com.huahong.util.StringUtils;

public class RegWrapperImplJava extends RegWrapper{
	
	 private static final Logger logger = Logger.getLogger(RegWrapper.class);
	 
	 /**
		 * 判断给定的字符串value中，是否包含pat所表达的字符串
		 * 
		 * @param value
		 * @param pat
		 * @return boolean
		 */
		public boolean ifFind(String value, String pat) {
			if (!checkCondition(value, pat))
				return true;
			Pattern pattern = Pattern.compile(pat);
			Matcher matcher = pattern.matcher(value);
			if (matcher.find())
				return true;
			return false;
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
		public String getRegsValue(String value, String pat, int index) {
			if (!checkCondition(value, pat))
				return null;
			Pattern pattern = Pattern.compile(pat);
			Matcher matcher = pattern.matcher(value);
			int end = 0;
			while (matcher.find(end)) {
				if (matcher != null && matcher.groupCount() > 0) {
					return StringUtils.trimString(matcher.group(index));
				}
				end = matcher.end();
			}
			return null;
		}

//		/**
//		 * 返回满足条件的多个分组，List中存放List，外层存放根据全表达式解析出来的，内存存放具体的各个数据。
//		 * 
//		 * @param value
//		 * @param pat
//		 * @return
//		 */
//		public ArrayList getRegsValues(String value, String pat) {
//			if (!checkCondition(value, pat))
//				return null;
//			ArrayList list = new ArrayList();
//			Pattern pattern = null;
//			Matcher matcher = null;
//			try {
//				pattern = Pattern.compile(pat);
//				matcher = pattern.matcher(value);
//				int end = 0;
//				while (matcher.find(end)) {
//					ArrayList one = new ArrayList();
//					for (int i = 1; i <= matcher.groupCount(); i++) {
//						String re = StringUtils.trimString(matcher.group(i));
//						one.add(re);
//					}
//					list.add(one);
//					end = matcher.end();
//				}
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//			matcher = null;
//			pattern = null;
//			return list;
//		}
//
//		/**
//		 * 返回满足条件的多个分组，ArrayList中存放ArrayList，外层存放根据全表达式解析出来的，内存存放具体的各个数据。<br>
//		 * 指定替换位置和替换长度，将null值替换为有数据的值
//		 * 
//		 * @param value
//		 * @param pat
//		 * @param pos
//		 * @param length
//		 * @return
//		 */
//		public ArrayList getRegsValuesComp(String value, String pat, int pos, int length){
//			if (!checkCondition(value, pat))
//				return null;
//			ArrayList list = new ArrayList();
//			Pattern pattern = null;
//			Matcher matcher = null;
//			try {
//				pattern = Pattern.compile(pat);
//				matcher = pattern.matcher(value);
//				int count = 0;
//				while (matcher.find()) {
//					ArrayList one = new ArrayList();
//					for (int i = 1; i < matcher.groupCount(); i++) {
//						String result = StringUtils.trimString(matcher.group(i));
//						one.add(result);
//					}
//					ArrayList ora = (ArrayList)list.get(count);
//					if(ora != null){
//						if(ora.size() != one.size()){
//							logger.error("解析模板正则式错误！");
//						}
//						if(isListNull(one)){	// 监测是否包含空值
//							int iLength = 0;
//							if(length == -1){
//								iLength = one.size();
//							}else{
//								iLength = pos + length;
//								if(iLength > one.size())
//									iLength = one.size();
//							}
//							for(int i=pos;i<iLength;i++){
//								if(one.get(i) == null)
//									one.set(i, ora.get(i));
//							}
//						}
//					}
//					list.add(one);
//					count++;
//				}
//			} catch (Exception mpe) {
//				mpe.printStackTrace();
//			} 
//			matcher = null;
//			pattern = null;
//			return list;
//		}
//		
//		/**
//		 * 将给定的字符串，按照给定的正则式，替换成指定的字符，全部替换
//		 * 
//		 * @param source
//		 * @param pat
//		 * @param dest
//		 * @return
//		 */
//		public String replaceRegValue(String source, String pat, String dest) {
//
//			return replaceRegValue(source, pat, dest, -1);
//		}
//
//		/**
//		 * 将给定的字符串，按照给定的正则式，替换成指定的字符，表明替换多少个
//		 * 
//		 * @param source
//		 * @param pat
//		 * @param dest
//		 * @param index
//		 * @return
//		 */
//		public String replaceRegValue(String value, String pat, String dest,
//				int index) {
//			if (!checkCondition(value, pat))
//				return null;
//
//			Pattern pattern = Pattern.compile(pat);
//			Matcher matcher = pattern.matcher(value);
//
//			if (index == -1)
//				return matcher.replaceAll(dest);
//			else
//				return matcher.replaceFirst(dest);
//
//		}
//
//		/**
//		 * 使用pat做为正则表达式，来获得一条记录，并使用特定的分割符来分割记录，用于分组数目不确定的方式。
//		 * 
//		 * @param value
//		 * @param pat
//		 * @param separateRegex
//		 * @return
//		 */
//		public HashMap getValuesBySeparateRegex(String record, String[] reg,
//				String separateRegex) {
//
//			HashMap map = new HashMap(); // 存储解析的第一次结果
//
//			Pattern p = null;
//			Matcher m = null;
//
//			for (int i = 0; i < reg.length; i++) {
//				p = Pattern.compile(reg[i]);
//				m = p.matcher(record);
//				while (m.find()) {
//					String field = StringUtils.trimString(m.group());
//					String[] result = field.split(separateRegex);
//					String key = StringUtils.replaceSpaces(result[0], "_");
//					ArrayList list = (ArrayList) map.get(key);
//					if (list == null)
//						list = new ArrayList();
//					for (int n = 1; n < result.length; n++) {
//						if (result[n] != null && (result[n].trim()).length() > 0) {
//							list.add(StringUtils.trimString(result[n].trim()));
//						}
//					}
//					map.put(key, list);
//				}
//			}
//			m = null;
//			p = null;
//			return map;
//
//		}
//
//		/**
//		 * 根据正则表达式的分组函数来获取解析的数据
//		 * 
//		 * @param value
//		 * @param pat
//		 * @return
//		 */
//		public HashMap getValueByGroupRegex(String record, String[] reg){
//			HashMap map = new HashMap(); // 存储解析的第一次结果
//
//			Pattern p = null;
//			Matcher m = null;
//			
//			for (int i = 0; i < reg.length; i++) {
//				p = Pattern.compile(reg[i]);
//				m = p.matcher(record);
//				while (m.find()) {
//					if(m.groupCount() < 1)
//						continue;
//					String key = StringUtils.replaceSpaces(m.group(1), "_");
//					ArrayList list = (ArrayList) map.get(StringUtils.trimString(key));
//					if (list == null)
//						list = new ArrayList();
//					for (int n = 2; n <= m.groupCount(); n++) {
//						if (m.group(n) != null && (m.group(n).trim()).length() > 0) {
//							list.add(StringUtils.trimString(m.group(n)));
//						}
//					}
//					map.put(key, list);
//				}
//			}
//			m = null;
//			p = null;
//			return map;
//		}

}

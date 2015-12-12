package com.huahong.erp.util;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;
import org.apache.oro.text.regex.MalformedPatternException;
import org.apache.oro.text.regex.MatchResult;
import org.apache.oro.text.regex.Pattern;
import org.apache.oro.text.regex.PatternCompiler;
import org.apache.oro.text.regex.PatternMatcher;
import org.apache.oro.text.regex.PatternMatcherInput;
import org.apache.oro.text.regex.Perl5Compiler;
import org.apache.oro.text.regex.Perl5Matcher;
import org.apache.oro.text.regex.Perl5Substitution;
import org.apache.oro.text.regex.Util;

import com.huahong.erp.util.RegWrapper;
import com.huahong.util.StringUtils;

public class RegWrapperImplORO extends RegWrapper{
	private PatternCompiler compiler = null;

	private PatternMatcher matcher = null;

	private static final Logger logger = Logger.getLogger(RegWrapper.class);

	/**
	 * 构造函数，实例化Compiler和Matcher对象
	 * 
	 */
	public RegWrapperImplORO() {
		compiler = new Perl5Compiler();
		matcher = new Perl5Matcher();
	}

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
		try {
			Pattern pattern = compiler.compile(pat);
			PatternMatcherInput input = new PatternMatcherInput(value);
			if (matcher.contains(input, pattern)) {
				return true;
			}
		} catch (MalformedPatternException mpe) {
			mpe.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * 根据给定的模式pat从字符串value中找到满足条件的字符串，通常返回一条记录。如果返回多条记录，不能使用此方法；
	 * 
	 * @param value
	 * @param pat
	 * @param index
	 * @return
	 */
	public String getRegsValue(String value, String pat, int index) {
		if (!checkCondition(value, pat))
			return null;
		String result = null;
		Pattern pattern = null;
		PatternMatcherInput input = null;
		try {
			pattern = compiler.compile(pat);
			input = new PatternMatcherInput(value);
			int i = 0;
			while (matcher.contains(input, pattern)) {
				MatchResult results = matcher.getMatch();
				String temp = StringUtils.trimString(results.group(index));
				if (i == 0) {
					result = temp;
				}
				i++;
				if (!temp.equals(result)) {
					logger.error("要获取的字段在原始报告中是多值的，并且这些值不相同！原始值：" + result
							+ "\t最新值：" + temp);
				} else {
					result = temp;
				}
			}
		} catch (MalformedPatternException mpe) {
			mpe.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		input = null;
		pattern = null;
		return result;
	}

//	/**
//	 * 将给定的字符串，按照给定的正则式，替换成指定的字符，全部替换
//	 * 
//	 * @param source
//	 * @param pat
//	 * @param dest
//	 * @return
//	 */
//	public String replaceRegValue(String source, String pat, String dest) {
//		return replaceRegValue(source, pat, dest, Util.SUBSTITUTE_ALL);
//	}
//
//	/**
//	 * 将给定的字符串，按照给定的正则式，替换成指定的字符，表明替换多少个
//	 * 
//	 * @param source
//	 * @param pat
//	 * @param dest
//	 * @param index
//	 * @return
//	 */
//	public String replaceRegValue(String source, String pat, String dest,
//			int index) {
//		if (!checkCondition(source, pat))
//			return null;
//		String result = null;
//		Pattern pattern = null;
//		try {
//			pattern = compiler.compile(pat);
//
//			result = Util.substitute(matcher, pattern, new Perl5Substitution(
//					dest), source, index);
//
//		} catch (MalformedPatternException mpe) {
//			mpe.printStackTrace();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		pattern = null;
//		return result;
//	}
//
//	/**
//	 * 返回满足条件的多个分组，List中存放List，外层存放根据全表达式解析出来的，内存存放具体的各个数据。
//	 * 
//	 * @param value
//	 * @param pat
//	 * @return
//	 */
//	public ArrayList getRegsValues(String value, String pat) {
//		if (!checkCondition(value, pat))
//			return null;
//		ArrayList list = new ArrayList();
//		Pattern pattern = null;
//		PatternMatcherInput input = null;
//		try {
//			pattern = compiler.compile(pat);
//			input = new PatternMatcherInput(value);
//			while (matcher.contains(input, pattern)) {
//				MatchResult results = matcher.getMatch();
//				ArrayList one = new ArrayList();
//				for (int i = 1; i < results.groups(); i++) {
//					String result = StringUtils.trimString(results.group(i));
//					one.add(result);
//				}
//				list.add(one);
//			}
//		} catch (MalformedPatternException mpe) {
//			mpe.printStackTrace();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		input = null;
//		pattern = null;
//		return list;
//	}
//
//	/**
//	 * 返回满足条件的多个分组，ArrayList中存放ArrayList，外层存放根据全表达式解析出来的，内存存放具体的各个数据。<br>
//	 * 指定替换位置和替换长度，将null值替换为有数据的值
//	 * 
//	 * @param value
//	 * @param pat
//	 * @param pos
//	 * @param length
//	 * @return
//	 */
//	public ArrayList getRegsValuesComp(String value, String pat, int pos, int length){
//		if (!checkCondition(value, pat))
//			return null;
//		ArrayList list = new ArrayList();
//		Pattern pattern = null;
//		PatternMatcherInput input = null;
//		try {
//			pattern = compiler.compile(pat);
//			input = new PatternMatcherInput(value);
//			int count = -1;
//			while (matcher.contains(input, pattern)) {
//				MatchResult results = matcher.getMatch();
//				ArrayList one = new ArrayList();
//				for (int i = 1; i < results.groups(); i++) {
//					String result = StringUtils.trimString(results.group(i));
//					one.add(result);
//				}
//				ArrayList ora = null;
//				if(list.size() > 0 && list.get(count) != null){
//					ora = (ArrayList)list.get(count);
//				}
//				if(ora != null){
//					if(ora.size() != one.size()){
//						logger.error("解析模板正则式错误！");
//					}
//					if(isListNull(one)){	// 监测是否包含空值
//						int iLength = 0;
//						if(length == -1){
//							iLength = one.size();
//						}else{
//							iLength = pos + length;
//							if(iLength > one.size())
//								iLength = one.size();
//						}
//						for(int i=pos;i<iLength;i++){
//							if(one.get(i) == null || ((String)one.get(i)).length() < 1)
//								one.set(i, ora.get(i));
//						}
//					}
//				}
//				list.add(one);
//				count++;
//			}
//		} catch (MalformedPatternException mpe) {
//			mpe.printStackTrace();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		input = null;
//		pattern = null;
//		return list;
//	}
//	
//	/**
//	 * 使用pat做为正则表达式，来获得一条记录，并使用特定的分割符来分割记录，用于分组数目不确定的方式。
//	 * 
//	 * @param value
//	 * @param pat
//	 * @param separateRegex
//	 * @return
//	 */
//	public HashMap getValuesBySeparateRegex(String record, String[] reg,
//			String separateRegex) {
//		HashMap map = new HashMap(); // 存储解析的第一次结果
//		Pattern pattern = null;
//		PatternMatcherInput input = null;
//		try {
//			for (int i = 0; i < reg.length; i++) {
//				pattern = compiler.compile(reg[i]);
//				input = new PatternMatcherInput(record);
//				while (matcher.contains(input, pattern)) {
//					MatchResult results = matcher.getMatch();
//					String field = StringUtils.trimString(results.group(0));
//					String[] result = field.split(separateRegex);
//					String key = StringUtils.replaceSpaces(result[0], "_");
//					ArrayList list = (ArrayList) map.get(key);
//					if (list == null)
//						list = new ArrayList();
//					for (int n = 1; n < result.length; n++) {
//						if (result[n] != null
//								&& (result[n].trim()).length() > 0) {
//							list.add(result[n].trim());
//						}
//					}
//					map.put(key, list);
//				}
//			}
//		} catch (MalformedPatternException me) {
//			logger.error("解析出现错误：",me);
//		}
//		input = null;
//		pattern = null;
//		return map;
//	}
//
//	/**
//	 * 根据正则表达式的分组函数来获取解析的数据
//	 * 
//	 * @param value
//	 * @param pat
//	 * @return
//	 */
//	public HashMap getValueByGroupRegex(String record, String[] reg){
//		HashMap map = new HashMap(); // 存储解析的第一次结果
//		Pattern pattern = null;
//		PatternMatcherInput input = null;
//		try {
//			for (int i = 0; i < reg.length; i++) {
//				pattern = compiler.compile(reg[i]);
//				input = new PatternMatcherInput(record);
//				
//				while (matcher.contains(input, pattern)) {
//					MatchResult results = matcher.getMatch();
//					if(results == null || results.groups() < 2)
//						continue;
//					String key = StringUtils.replaceSpaces(results.group(1), "_");
//					ArrayList list = (ArrayList) map.get(key);
//					if (list == null)
//						list = new ArrayList();
//					for (int n = 2; n < results.groups(); n++) {
//						if (results.group(n) != null
//								&& (StringUtils.trimString(results.group(n))).length() > 0) {
//							list.add(StringUtils.trimString(results.group(n)));
//						}
//					}
//					map.put(key, list);
//				}
//			}
//		} catch (MalformedPatternException me) {
//			logger.error("解析出现错误：",me);
//		}
//		input = null;
//		pattern = null;
//		return map;
//	}
}

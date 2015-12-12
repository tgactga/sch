package com.huahong.util;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {
	/**
	 * 将util时间转换为字符串，一个例子："yyyy-MM-dd HH:mm:ss"
	 * 
	 * @param inDate
	 * @param pattern
	 * @return String
	 */
	public static String dateToString(Date inDate, String pattern) {
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		String sDate = sdf.format(inDate);
		return sDate;
	}
}

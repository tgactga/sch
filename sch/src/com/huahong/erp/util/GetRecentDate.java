package com.huahong.erp.util;
import java.text.*;
import java.util.Calendar;
public class GetRecentDate {
	//日期格式：yyyy-MM-dd HH:mm:ss
	public static String getRecentDate(String format){
		try{
			String time = "";
			java.util.Date now = new java.util.Date();
			SimpleDateFormat formatter = new SimpleDateFormat(format);
			time=formatter.format(now);
			return time;
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	/*
	 * 把String times = "2010-02-05 02:54"类型的字符串转换为"201002050254"
	 */
	
	public static String TimeToNum(String times){
		//public String TimeToDate() {
			//String times = "2010-02-05 02:54:20";
		String result="";
		if(times!=null&&!times.equals("")){
			String temp = times.replaceAll("-",""); 
			temp = temp.replaceAll(":", ""); 
			result = temp.replaceAll(" ", ""); 
		}
//			result = result.substring(0, result.length() - 2);
//			System.out.println("result===="+result);
		return result;
		}
	/*
	 * 把字符串"201002050254"转换为时间字符串"2010-02-05 02:54"
	 */
	public static String NumToTime(String num){
		String result="";
//		java.text.SimpleDateFormat formatter=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
		if(num!=null&&!num.equals("")){
			StringBuffer sb=new StringBuffer("");
			sb.append(num.subSequence(0, 4));
			sb.append("-");
			sb.append(num.subSequence(4, 6));
			sb.append("-");
			sb.append(num.subSequence(6, 8));
			sb.append(" ");
			sb.append(num.substring(8, 10));
			sb.append(":");
			sb.append(num.substring(10));
			/*java.util.Date date=new java.util.Date();
			try {
				date=formatter.parse(num);
			} catch (ParseException e) {
				e.printStackTrace();
			}*/
			result=String.valueOf(sb);
		}
		return result;
	}
	
    // 上月第一天   
    public static String getPreviousMonthFirst(){     
        String str = "";   
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");       
   
        Calendar lastDate = Calendar.getInstance();   
        lastDate.set(Calendar.DATE,1);//设为当前月的1号   
        lastDate.add(Calendar.MONTH,-1);//减一个月，变为下月的1号   
          
        str=sdf.format(lastDate.getTime());   
       return str;     
     } 
}

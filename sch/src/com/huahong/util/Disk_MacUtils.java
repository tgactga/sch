package com.huahong.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.Date;

import sun.java2d.pipe.SpanShapeRenderer.Simple;

public class Disk_MacUtils {
	
	private static String getRegister(String s) {
		String s1="",s2="";
		SimpleDateFormat sd=new SimpleDateFormat("yyyy");
		Date d=new Date();
		s+=sd.format(d);
		for(int i=0;i<s.length();i++){
				s1+=(int)s.charAt(i)*(i+1);
		}
		for(int i=0;i<s1.length()/5;i++){
			
			if(i==s1.length()/5-1)
				s2+=s1.substring(i*5,(i+1)*5);
			else 
				s2+=s1.substring(i*5, (i+1)*5)+"-";
		}
		return s2;
	}

	public static String getMAC() {
		String macResult = null;
		String osName = System.getProperty("os.name");
		StringBuffer systemPathBuff = new StringBuffer("");
		
		if (osName.indexOf("Windows") > -1) {
			systemPathBuff.append("c:\\WINDOWS\\system32\\cmd.exe");
		}
		if (osName.indexOf("NT") > -1) {
			systemPathBuff.append("c:\\WINDOWS\\command.com");
		}
			 
		Process pro = null;
		try {
			pro = Runtime.getRuntime().exec(systemPathBuff.toString() + " /c dir");
			InputStream is = pro.getInputStream();
			BufferedReader br = new BufferedReader(new InputStreamReader(is));
			String message = br.readLine();
			String serNuResult = null;
			int index = -1;
			message = br.readLine();
			pro = Runtime.getRuntime().exec(systemPathBuff.toString() + " /c ipconfig/all");
			is = pro.getInputStream();
			br = new BufferedReader(new InputStreamReader(is));
			message = br.readLine();
			while (message != null) {
				if ((index = message.indexOf("Physical Address")) > 0) {
					macResult = message.substring(index + 36).trim();
					break;
				}
				message = br.readLine();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return macResult;
	}
	
	public static String getDisk(){
		String diskResult = null;
		String osName = System.getProperty("os.name");
		StringBuffer systemPathBuff = new StringBuffer("");
		
		if (osName.indexOf("Windows") > -1) {
			systemPathBuff.append("c:\\WINDOWS\\system32\\cmd.exe");
		}
		if (osName.indexOf("NT") > -1) {
			systemPathBuff.append("c:\\WINDOWS\\command.com");
		}
			 
		Process pro = null;
		try {
			pro = Runtime.getRuntime().exec(systemPathBuff.toString() + " /c dir c:");
			InputStream is = pro.getInputStream();
			BufferedReader br = new BufferedReader(new InputStreamReader(is));
			int index = -1;
			String message = br.readLine();
			message = br.readLine();
			diskResult = message.substring(message.length() - 9).trim();			
		}catch(Exception e){
			e.printStackTrace();
		}
		return diskResult;
	}
	
	public static String getConnect(){
		String result = "";
		String strMAC = getMAC().replace("-", "");
		String strDisk = getDisk().replace("-", "");
		char[] ch = strMAC.concat(strDisk).toCharArray();
		int i=0, j=ch.length -1;
		for(i=0;i<j;i++,j--){
			Character ch1 = new Character(ch[i]);
			Character ch2 = new Character(ch[j]);
			if(ch1.compareTo(ch2)>0)
				result += ch1;
			else result += ch2;
		}
		return result;
	}
	
	public static void main(String[] args) {		
		String result = getConnect();
		System.out.println(result);
		
	}
}



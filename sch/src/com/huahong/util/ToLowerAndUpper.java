package com.huahong.util;

public class ToLowerAndUpper {
	private static String S = "ABCDEFG";
	private static String s = "abcdefg";
	public static String toLower(String S){
		String str = "";
		for(int i = 0; i < S.length(); i++){
			char ch = S.charAt(i);
			if(ch <= 'Z' && ch >= 'A'){
				str += (char)(ch-'A'+'a');
			}else{
				str += (char)ch;
			}
		}
		return str;
	}
	public static String toUpper(String S){
		String str = "";
		for(int i = 0; i < S.length(); i++){
			char ch = S.charAt(i);
			if(ch <= 'z' && ch >= 'a'){
				str += (char)(ch-32);
			}else{
				str += (char)ch;
			}
		}
		return str;
	}
	public static void main(String args[]){
		System.out.println(toLower(S));
		System.out.println(toUpper(s));
	}
}

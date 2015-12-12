package com.huahong.util;

import java.io.PrintWriter;
import java.io.StringWriter;

public class CommonException extends Exception {
	
public static final long serialVersionUID = 1;
	
	/**
	 * 
	 */
	public CommonException() {
		super();
	}

	/**
	 * @param sArg0
	 */
	public CommonException(String sArg0) {
		super(sArg0);
	}

	/**
	 * @param sArg0
	 */
	public CommonException(Throwable sArg0) {
		super(sArg0);
	}

	/**
	 * @param sArg0
	 * @param sArg1
	 */
	public CommonException(String sArg0, Throwable sArg1) {
		super(sArg0, sArg1);
	}

	/**
	 * 重载方法。
	 */
	public String toString(){
		return "异常信息：" + this.getMessage();
	}
	
	/**
	 * 将堆栈信息形成字符串保存；
	 * @return String
	 */
	public String getStackTraceString() {
		StringWriter sw = new StringWriter();
		PrintWriter pw = new PrintWriter(sw);
		this.printStackTrace(pw);
		return sw.toString();
	}

}

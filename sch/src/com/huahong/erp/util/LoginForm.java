package com.huahong.erp.util;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

public class LoginForm extends ActionForm{
	
	private String user_name = null;
	
	private String user_password = null;
	
	private String saveCookie = null;
	
	private String ip = null;
	
	public void setUserName(String name){
		
		this.user_name = name;
		
	}
	
	public String getUserName(){
		
		return this.user_name;
		
	}
	public void setUserPassword(String password){
	  
		this.user_password = password;
		
	}
	public String getUserPassword(){
		
		return this.user_password;
		
	}
	public void setSaveCookie(String cookie){
		
		this.saveCookie = cookie;
		
	}
	public String getSavaCookie(){
		
		return this.saveCookie;
		
	}
	public void setIp(String ip){
		
		this.ip = ip;
		
	}
	public String getIp(){
		
		return this.ip;
		
	}
	public void reset(ActionMapping mapping,HttpServletRequest req){
		
		this.ip = null;
		
		this.saveCookie = null;
		
		this.user_name = null;
		
		this.user_password = null;
		
	}
}
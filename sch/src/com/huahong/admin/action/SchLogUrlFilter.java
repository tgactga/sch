package com.huahong.admin.action;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SchLogUrlFilter implements Filter{
	
	public void destroy() {
		
	}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
			FilterChain filterChain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)servletRequest;
		HttpServletResponse response = (HttpServletResponse)servletResponse;
		HttpSession session = request.getSession();
		
		String requestUrl = request.getServletPath() + (request.getPathInfo() == null ? "" : request.getPathInfo());
		
		System.out.println(requestUrl);
		System.out.println(request.getRemoteAddr());
		if(requestUrl.endsWith(".do") || requestUrl.endsWith(".jsp")){
			
		}else{
			
		}
		filterChain.doFilter(servletRequest, servletResponse);
	}

	public void init(FilterConfig arg0) throws ServletException {
		
	}
	
}

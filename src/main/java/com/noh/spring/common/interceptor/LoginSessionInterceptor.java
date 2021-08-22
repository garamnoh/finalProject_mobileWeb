package com.noh.spring.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import com.noh.spring.business.model.vo.BusinessMember;
import com.noh.spring.member.model.vo.Member;

public class LoginSessionInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// 현재 로그인된 사용자 정보
		Member loginMember = (Member)request.getSession().getAttribute("loginMember");
		BusinessMember businessLoginMember = (BusinessMember)request.getSession().getAttribute("businessLoginMember");
		
		// 로그인된 사용자가 있으면 계속, 없으면 로그인 화면으로 이동
		if(loginMember != null || businessLoginMember != null) return HandlerInterceptor.super.preHandle(request, response, handler);
		else {
			// 세션에 저장된 데이터 모두 삭제
			request.getSession().invalidate();
			
			// 로그인 페이지로 이동
			request.getRequestDispatcher("/").forward(request, response);
			return false;
		}
	}
}

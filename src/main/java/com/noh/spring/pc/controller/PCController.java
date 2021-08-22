package com.noh.spring.pc.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.noh.spring.business.model.service.BusinessService;
import com.noh.spring.business.model.vo.BusinessMember;
import com.noh.spring.business.model.vo.BusinessOrder;
import com.noh.spring.member.model.service.MemberService;
import com.noh.spring.member.model.vo.Member;

@SessionAttributes({"loginMember", "businessLoginMember"})
@Controller
public class PCController {

	@Autowired
	private MemberService mService;
	
	@Autowired
	private BusinessService service;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	// 로그인 페이지 이동
	@RequestMapping("/pc/member/loginPage.do")
	public String loginPage() {
		return "pc/login";
	}
	
	// 로그인
	@RequestMapping("/pc/member/login.do")
	@ResponseBody
	public boolean login(Member member, Model model, SessionStatus sessionStatus) {
		// 회원정보 확인
		Member loginMember = mService.login(member);
		// 비밀번호 일치여부 확인
		if(loginMember != null) {
			if(passwordEncoder.matches(member.getPassword(), loginMember.getPassword())) {
				model.addAttribute("loginMember", loginMember);
				return true;
			} else {
				sessionStatus.setComplete();
				return false;
			}
		} else {
			sessionStatus.setComplete();
			return false;
		}
	}
	
	// 로그아웃
	@RequestMapping("/pc/member/logout.do")
	public String logout(SessionStatus sessionStatus, HttpSession session, Model model) {
		if(!sessionStatus.isComplete()) {
			sessionStatus.setComplete();
			session.invalidate();
		}
		model.addAttribute("msg", "none");
		model.addAttribute("loc", "/");
		return "common/msg";
	}
	
	// 사업자 회원 로그인
	@RequestMapping("/pc/member/businessMemberLogin.do")
	@ResponseBody
	public boolean businessMemberLogin(
			BusinessMember businessMember,
			Model model
			) {
		boolean isExist = false;
		BusinessMember businessLoginMember = mService.businessMemberLogin(businessMember);
		if(businessLoginMember != null) {
			isExist = true;
			model.addAttribute("businessLoginMember", businessLoginMember);
		}
		return isExist;
	}
	
	@RequestMapping("/pc/business/getOrderList.do")
	@ResponseBody
	public ModelAndView getOrderList(
			ModelAndView mv,
			HttpSession session
			) {
		// 가게 정보
		String storeId = ((BusinessMember)session.getAttribute("businessLoginMember")).getStoreId();
		List<BusinessOrder> businessOrderList = service.getOrderList(storeId);
		
		mv.addObject("businessOrderList", businessOrderList);
		mv.setViewName("pc/sub/orderListPage");
		
		return mv;
	}
	
	@RequestMapping("/pc/business/getOrderDetail.do")
	@ResponseBody
	public ModelAndView getOrderDetail(
			ModelAndView mv,
			HttpSession session,
			@RequestParam("orderNo") String orderNo
			) {
		HashMap<String, Object> info = new HashMap<String, Object>();
		// 가게 정보
		info.put("storeId", ((BusinessMember)session.getAttribute("businessLoginMember")).getStoreId());
		info.put("orderNo", orderNo);
		
		List<BusinessOrder> businessOrderDetail = service.getOrderDetail(info);
		
		mv.addObject("businessOrderDetail", businessOrderDetail);
		mv.setViewName("pc/sub/orderListDetailPage");
		
		return mv;
	}
}

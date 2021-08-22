package com.noh.spring;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.noh.spring.member.model.vo.Member;
import com.noh.spring.pay.model.service.PayService;

@Controller
public class HomeController {
	
	@Autowired
	private PayService pService;
	
	@RequestMapping("/")
	public String device() {
		return "common/device";
	}
	
	@RequestMapping("/home.do")
	public String home(
			@RequestParam("device") String device,
			HttpServletRequest request,
			Model model
			) {
		Member loginMember = (Member)request.getSession().getAttribute("loginMember");
		if(device.equals("mobile")) {
			// 로그인된 상태면 바로 메인 화면으로 이동
			model.addAttribute("button", "home");
			if(loginMember != null) return "home/home";
			else return "index";			
		} else {
			if(loginMember != null) {
				model.addAttribute("cardInfo", pService.getMyCardInfo(loginMember.getCardSeq()));
			}
			return "pc/index";
		}
	}
	
//	@RequestMapping("/")
//	public String home(HttpServletRequest request, Model model) {
//		Member loginMember = (Member)request.getSession().getAttribute("loginMember");
//		model.addAttribute("button", "home");
//		if(loginMember != null) return "home/home";
//		else return "index";			
//	}
}

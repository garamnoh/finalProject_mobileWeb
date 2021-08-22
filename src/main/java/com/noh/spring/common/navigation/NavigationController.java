package com.noh.spring.common.navigation;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.noh.spring.member.model.vo.Member;
import com.noh.spring.pay.model.service.PayService;

@Controller
public class NavigationController {
	
	@Autowired
	private PayService payService;
	
	// 네비게이션 - 페이지 이동
	@RequestMapping("/navigation/{button}.do")
	public String navigationButton(@PathVariable("button") String button, Model model, HttpSession session) {
		model.addAttribute("button", button);
		
		// 내 카드 정보
		if(button.equals("pay")) model.addAttribute("myCardInfo", payService.getMyCardInfo(((Member)session.getAttribute("loginMember")).getCardSeq()));
		
		return button+"/"+button;
	}
}

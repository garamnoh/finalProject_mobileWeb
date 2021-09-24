package com.noh.spring.other.controller; 

import java.sql.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.noh.spring.member.model.service.MemberService;
import com.noh.spring.member.model.vo.Member;
import com.noh.spring.order.model.vo.Order;
import com.noh.spring.order.service.OrderService;

@Controller
public class OtherController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private HashMap<String, Object> info;
	
	@RequestMapping("/other/moveToHistoryPage.do")
	public String moveToHistoryPage(
			Model model,
			HttpSession session
			) {
		model.addAttribute("button", "other");
		return "other/history";
	}
	
	// 구매 히스토리
	@RequestMapping("/other/getOrderList.do")
	@ResponseBody
	public ModelAndView getOrderList(
			ModelAndView mv,
			HttpSession session,
			@RequestParam(value="startDate") Date startDate,
			@RequestParam(value="endDate") Date endDate
			) {
		// 회원정보
		Member loginMember = (Member)session.getAttribute("loginMember");
		
		info.put("id", loginMember.getId());
		info.put("startDate", startDate);
		info.put("endDate", endDate);
		
		List<Order> orderList = orderService.getOrderList(info);
		
		mv.addObject("orderList", orderList);
		mv.setViewName("other/sub/historyResult");
		return mv;
	}
	
	// 영수증 상세 정보
	@RequestMapping("/other/getBillInfo.do")
	@ResponseBody
	public ModelAndView getBillInfo(
			@RequestParam("orderNumber") String orderNumber,
			ModelAndView mv
			) {
		info.put("orderNo", orderNumber);
		List<Order> order = orderService.getBillInfo(info);
		
		mv.addObject("order", order);
		mv.setViewName("other/sub/billInfo");
		return mv;
	}
	
	// 별명 확인(별명 수정시 중복 확인)
	@RequestMapping("/other/checkNickname.do")
	@ResponseBody
	public boolean checkNickname(
			@RequestParam("nickname") String nickname
			) {
		return memberService.checkNickname(nickname);
	}

	// 별명 수정 db 반영
	@RequestMapping("/other/editNickname.do")
	@ResponseBody
	public boolean editNickname(
			@RequestParam("nickname") String nickname,
			HttpSession session
			) {
		info.put("id", ((Member)session.getAttribute("loginMember")).getId());
		info.put("nickname", nickname);
		return memberService.editNickname(info);
	}
}

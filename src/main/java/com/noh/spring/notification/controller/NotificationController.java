package com.noh.spring.notification.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.noh.spring.member.model.vo.Member;
import com.noh.spring.notification.model.service.NotificationService;
import com.noh.spring.notification.model.vo.Notification;

@Controller
public class NotificationController {

	@Autowired
	private NotificationService service;
	
	// 알림 테이블에 내역 추가
	@RequestMapping("/notification/addNotification.do")
	@ResponseBody
	public boolean addNotification(
			Notification notification
			) {
		System.out.println("notification");
		try {
			service.addNotification(notification);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return true;
	}
	
	// 알림 확인 여부 체크
	@RequestMapping("/notification/checkNotification.do")
	@ResponseBody
	public int checkNotification(
			HttpSession session
			) {
		// 회원 정보
		String id = ((Member)session.getAttribute("loginMember")).getId();
		return service.checkNotification(id);
	}
	
	// 알림 리스트
	@RequestMapping("/notification/getNotificationList.do")
	@ResponseBody
	public ModelAndView getNotificationList(
			ModelAndView mv,
			HttpSession session
			) {
		List<Notification> notificationList = service.getNotification(((Member)session.getAttribute("loginMember")).getId());

		mv.addObject("notificationList", notificationList);
		mv.setViewName("common/sub/notificationList");
		
		return mv;
	}
	
	// 알림 확인 상태 변경
	@RequestMapping("/notification/changeConfirmationStatus.do")
	@ResponseBody
	public boolean changeConfirmationStatus(
			@RequestParam(value="orderNo", required=false, defaultValue="none") String orderNo,
			HttpSession session
			) {
		HashMap<String, String> info = new HashMap<String, String>();
		info.put("orderNo", orderNo);
		info.put("id", ((Member)session.getAttribute("loginMember")).getId());
		
		return service.changeConfirmationStatus(info);
	}
}

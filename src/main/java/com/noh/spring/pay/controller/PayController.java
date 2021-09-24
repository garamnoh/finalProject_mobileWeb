package com.noh.spring.pay.controller; 

import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.noh.spring.common.GenerateBarcode;
import com.noh.spring.common.IamportService;
import com.noh.spring.member.model.service.MemberService;
import com.noh.spring.member.model.vo.Member;
import com.noh.spring.pay.model.service.PayService;
import com.noh.spring.pay.model.vo.Card;
import com.noh.spring.pay.model.vo.Charging;

@Controller
@SessionAttributes({"loginMember"})
public class PayController {

	@Autowired
	private PayService service;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private HashMap<String, String> info;
	
	@Autowired
	private GenerateBarcode barcode;
	
	@Autowired
	private IamportService iamport;
	
	// 카드 등록 페이지로 이동
	@RequestMapping("/pay/moveToRegistCardPage.do")
	public String moveToRegistCardPage(
			Model model,
			HttpSession session
			) {
		List<Card> cardList = service.getCardList();
		List<Card> myCardList = service.getMyCardList(((Member)session.getAttribute("loginMember")).getId());
		String myCards = "";
		for(Card c: myCardList) {
			myCards += c.getCardId() + " ";
		}
		System.out.println(myCards);
		
		model.addAttribute("button", "pay");
		model.addAttribute("cardList", cardList);
		model.addAttribute("myCards", myCards);
		
		return "pay/payRegistCard";
	}
	
	// 카드 선택 페이지로 이동
	@RequestMapping("/pay/moveToSelectCardPage.do")
	public String moveToSelectCardPage(
			Model model,
			HttpSession session
			) {
		// 회원 아이디
		String id = ((Member)session.getAttribute("loginMember")).getId();
		// 보유한 카드 리스트
		List<Card> myCardList = service.getMyCardList(id);

		model.addAttribute("myCardList", myCardList);
		model.addAttribute("button", "pay");
		
		return "pay/paySelectCard";
	}
	
	// 충전 페이지로 이동
	@RequestMapping("/pay/moveToChargingPage.do")
	public String moveToChargingPage(
			Model model,
			HttpSession session
			) {
		iamport.getAccessToken();
		
		model.addAttribute("myCardInfo", service.getMyCardInfo(((Member)session.getAttribute("loginMember")).getCardSeq()));
		model.addAttribute("button", "pay");
		return "pay/payCharging";
	}
	
	// 카드 등록
	@RequestMapping("/pay/registCard.do")
	public String registCard(
			@RequestParam("cardId") String cardId,
			Model model,
			HttpSession session
			) {
		// DB에 전달할 변수
		info.put("id", ((Member)session.getAttribute("loginMember")).getId());
		info.put("cardId", cardId);
		
		// 카드번호 생성
		String cardNo = "";
		for(int i = 0; i < 4; i++) {
			cardNo += String.format("%04d", new Random().nextInt(9999));
			if(i != 3) cardNo += "-";
		}
		info.put("cardNo", cardNo);
		
		// 입력 결과 리턴
		int result = service.registCard(info);
		
		if(result > 0) {
			// cardSeq 값 리턴
			int cardSeq = service.getCardSeq(info);
			info.put("cardSeq", Integer.toString(cardSeq));
			// 내 카드 등록
			service.setMyCard(info);
			model.addAttribute("loginMember", memberService.confirmIdDuplication(info.get("id")));
			
			String button = "pay";
			model.addAttribute("msg", "none");
			model.addAttribute("loc", "/navigation/" + button + ".do");
		} else {
			model.addAttribute("msg", "등록 실패");
			model.addAttribute("loc", "/pay/moveToRegistCardPage.do");
		}

		return "common/msg";
	}
	
	// 카드 선택
	@RequestMapping("/pay/selectCard.do")
	public String selectCard(
			@RequestParam("cardSeq") String cardSeq,
			HttpSession session,
			Model model
			) {
		// 회원 아이디
		String id = ((Member)session.getAttribute("loginMember")).getId();
		// info map
		info.put("id", id);
		info.put("cardSeq", cardSeq);
		
		service.setMyCard(info);
		model.addAttribute("loginMember", memberService.confirmIdDuplication(id));
		
		String button = "pay";
		model.addAttribute("msg", "none");
		model.addAttribute("loc", "/navigation/" + button + ".do");
		
		return "common/msg";
	}
	
	// 바코드 생성
	@RequestMapping("/pay/gerateBarcode.do")
	@ResponseBody
	public boolean generateBarcode(
			@RequestParam("cardNo") String cardNo,
			@RequestParam("fileName") String fileName,
			HttpServletRequest request,
			HttpServletResponse response
			) {
		boolean isSuccess = true;
		try {
			barcode.getBarcode(cardNo, fileName, request, response);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return isSuccess;
	}
	
	// 카드 충전 - 신용카드
	@RequestMapping("/pay/chargingByCredit.do")
	@ResponseBody
	public boolean chargingByCredit(
			HttpSession session,
			@RequestParam("imp_uid") String impUid,
			@RequestParam("merchant_uid") String merchantUid,
			@RequestParam("price") String price
			) {
		Member loginMember = (Member)session.getAttribute("loginMember");
		info.put("id", loginMember.getId());
		info.put("cardSeq", String.valueOf(loginMember.getCardSeq()));
		info.put("impUid", impUid);
		info.put("merchantUid", merchantUid);
		info.put("price", price);
		
		try { 
			service.chargingMyCard(info);
		
		} catch(Exception e) { 
			// accessToken 발급
			//String accessToken = iamport.getAccessToken();
			return false;
		
		} return true;
	}
	
	@RequestMapping("/pay/chargingByCreditFromMobile.do")
	public String chargingByCreditFromMobile(
			HttpSession session,
			@RequestParam("imp_uid") String impUid,
			@RequestParam("merchant_uid") String merchantUid,
			@RequestParam("price") String price,
			Model model
			) {
		System.out.println("payController mobile");
		
		Member loginMember = (Member)session.getAttribute("loginMember");
		info.put("id", loginMember.getId());
		info.put("cardSeq", String.valueOf(loginMember.getCardSeq()));
		info.put("impUid", impUid);
		info.put("merchantUid", merchantUid);
		info.put("price", price);
		
		try { 
			service.chargingMyCard(info);
			
			String button = "pay";
			model.addAttribute("msg", "none");
			model.addAttribute("loc", "/navigation/" + button + ".do");
			
		} catch(Exception e) { 
			// accessToken 발급
			//String accessToken = iamport.getAccessToken();
			
			model.addAttribute("msg", "결제 실패");
			model.addAttribute("loc", "/pay/moveToChargingPage.do");

			return "common/msg";
		
		} return "common/msg";
	}
	
	@RequestMapping("/pay/chargingHistory.do")
	public String chargingHistory(
			@RequestParam("cardSeq") int cardSeq,
			Model model
			) {
		model.addAttribute("cardInfo", service.getMyCardInfo(cardSeq));
		model.addAttribute("chargingHistory", service.getChargingHistory(cardSeq));
		return "pay/payChargingHistory";
	}
	
}

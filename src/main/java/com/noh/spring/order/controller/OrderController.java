package com.noh.spring.order.controller; 

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.noh.spring.business.model.service.BusinessService;
import com.noh.spring.common.KakaoPayService;
import com.noh.spring.common.model.vo.KakaoPayApproval;
import com.noh.spring.member.model.service.MemberService;
import com.noh.spring.member.model.vo.Favorite;
import com.noh.spring.member.model.vo.Member;
import com.noh.spring.order.model.vo.Cart;
import com.noh.spring.order.model.vo.Product;
import com.noh.spring.order.service.OrderService;
import com.noh.spring.pay.model.service.PayService;
import com.noh.spring.store.model.vo.Store;

@Controller
@SessionAttributes({"loginMember"})
public class OrderController {

	@Autowired
	private OrderService service;
	
	@Autowired
	private MemberService mService;
	
	@Autowired
	private PayService pService;
	
	@Autowired
	private BusinessService bService;
	
	@Autowired
	private HashMap<String, Object> info;
	
	@Autowired
	private KakaoPayService kakaoPayService;
	
	// 음료, 푸드, 상품 메뉴 변경
	@RequestMapping("/order/orderMenu.do")
	@ResponseBody
	public ModelAndView orderMenu(
			@RequestParam("menuButton") String menuButton,
			@RequestParam(value="menu", required=false) String menu,
			ModelAndView mv
			) {
		// DB에 넘겨줄 parameter를 담을 map
		HashMap<String, String> info = new HashMap<String, String>();
		info.put("menuButton", menuButton);
		
		// food, md 종류에 따라 다른 페이지로
		switch(menuButton) {
			case "food" : 
				mv.addObject("menuList", service.getMenuList(info));
				mv.setViewName("order/orderOptionFood");
				return mv;
			case "md" : 
				mv.addObject("menuList", service.getMenuList(info));
				mv.setViewName("order/orderOptionMd");
				return mv;
			default: 
				mv.setViewName("order/orderOptionDrink");
				return mv;
		}
	}
	
	// 음료 카테고리 새창(뒤로가기) 사용때문에 method 분리
	@RequestMapping("/order/orderMenuDrink.do")
	public String orderMenuDrink(
			@RequestParam("menuButton") String menuButton,
			@RequestParam("menu") String menu,
			Model model
			) {
		HashMap<String, String> info = new HashMap<String, String>();
		info.put("menuButton", menuButton);
		info.put("menu", menu);
		
		model.addAttribute("menu", menu);
		model.addAttribute("button", "order");
		model.addAttribute("menuList", service.getMenuList(info));
		
		return "order/orderOptionDrink_" + menu;
	}
	
	// 상품 상세정보
	@RequestMapping("/order/orderDetail.do")
	public String orderDetail(
			@RequestParam(value="productId", defaultValue="") String productId,
			HttpSession session,
			Model model
			) {
		// 회원 아이디
		String id = ((Member)session.getAttribute("loginMember")).getId();
		
		// DB에 보낼 데이터용 Map
		HashMap<String, String> info = new HashMap<String, String>();
		info.put("id", id);
		info.put("productId", productId);
		
		// 목록에 있는지 확인
		Favorite favorite = mService.isFavorite(info);
		
		// 목록에 있으면 favorite true 없으면 false
		model.addAttribute("favorite", favorite!=null?true:false);
		
		////////////////////////////////////////////////////////////////////////
		// 상품 정보
		Product productInfo = service.getProductInfo(productId);
		model.addAttribute("button", "order");
		model.addAttribute("productInfo", productInfo);
		return "order/orderOptionDetail";
	}
	
	// 장바구니 확인
	@RequestMapping("/order/checkShoppingCart.do")
	@ResponseBody
	public int checkShoppingCart(HttpSession session, Model model) {
		String id = ((Member)session.getAttribute("loginMember")).getId();
		int listCount = service.checkShoppingCart(id);
		
		return listCount;
	}
	
	// 장바구니에 등록
	@RequestMapping("/order/addToShoppingCart.do")
	@ResponseBody
	public int addToShoppingCart(
			Cart cart,
			HttpSession session,
			Model model
			) {
		// 로그인 회원 정보, 선택된 매장 정보
		// cart객체에 값 입력
		cart.setId(((Member)session.getAttribute("loginMember")).getId());
		
		int result = service.addToShoppingCart(cart);
		return result;
	}
	
	// 장바구니 페이지로 이동
	@RequestMapping("/order/cart/moveToShoppingCart.do")
	public String moveToShoppingCart(Model model, HttpSession session) {
		// 로그인 회원 정보
		String id = ((Member)session.getAttribute("loginMember")).getId();
		// 쇼핑카트 리스트
		model.addAttribute("cartList", service.getShoppingCartList(id));
		model.addAttribute("button", "order");
		return "order/cart/cart";
	}
	
	// 장바구니 목록 삭제
	@RequestMapping("/order/cart/deleteCartList.do")
	public String deleteCartList(
			@RequestParam("cartSeq") int cartSeq,
			Model model
			) {
		int result = service.deleteCartList(cartSeq);
		
		if(result > 0) model.addAttribute("msg", "none");
		else model.addAttribute("msg", "삭제 실패");

		model.addAttribute("loc", "/order/cart/moveToShoppingCart.do");

		return "common/msg";
	}
	
	// 장바구니 제품 수량 변경
	@RequestMapping("/order/cart/changeQuantity.do")
	public String chageQuantity(
			Cart cart,
			Model model
			) {
		int result = service.changeQuantity(cart);
		if(result > 0) model.addAttribute("msg", "none");
		else model.addAttribute("msg", "변경 실패");
		
		model.addAttribute("loc", "/order/cart/moveToShoppingCart.do");
		
		return "common/msg";
	}
	
	// 결제 창으로 이동
	@RequestMapping("/order/cart/moveToPaymentPage.do")
	public String moveToPaymentPage(
			@RequestParam("totalPrice") String totalPrice,
			@RequestParam("totalQuantity") String totalQuantity,
			HttpSession session,
			Model model
			) {
		String id = ((Member)session.getAttribute("loginMember")).getId();
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("totalQuantity", totalQuantity);
		model.addAttribute("cartList", service.getShoppingCartList(id));
		model.addAttribute("button", "order");
		return "order/cart/payment";
	}
	
	// 결제 수단 - 스타벅스 카드
	@RequestMapping("/order/cart/paymentTypeStarbucks.do")
	@ResponseBody
	public ModelAndView paymentTypeStarbucks(
			ModelAndView mv,
			HttpSession session
			) {
		mv.addObject("myCardInfo", pService.getMyCardInfo(((Member)session.getAttribute("loginMember")).getCardSeq()));
		mv.setViewName("order/cart/paymentType/starbucks");
		return mv;
	}
	
	// 결제 수단 - 간편결제
	@RequestMapping("/order/cart/simplePaymentExcution.do")
	@ResponseBody
	public String simplePaymentExcution(
			@RequestParam("totalPrice") String totalPrice,
			@RequestParam("totalQuantity") String totalQuantity,
			@RequestParam("productName") String productName,
			@RequestParam("userId") String userId
			) {
		info.put("totalPrice", totalPrice);
		info.put("totalQuantity", totalQuantity);
		info.put("productName", productName);
		info.put("userId", userId);
		
		return kakaoPayService.getRedirectURL(info);
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////
	// 카카오 결제 성공
	@RequestMapping("/order/cart/simplePaymentSuccess.do")
	public String simplePaymentSuccess(
			@RequestParam("pg_token") String pg_token,
			HttpSession session,
			Model model
			) {
		// 카카오 승인 정보
		KakaoPayApproval kakaoPayApproval = kakaoPayService.getApprovalInfo(pg_token);
		int totalPrice = kakaoPayApproval.getAmount().getTotal();
		
		// 회원 정보
		Member loginMember = (Member)session.getAttribute("loginMember");
		String storeId = ((Store)session.getAttribute("selectedStore")).getStoreId();
		
		/////////////////////////////////////////////////////////////////////////////
		// 주문번호 생성
		/////////////////////////////////////////////////////////////////////////////
		String orderNo = createOrderNumber(loginMember, storeId);
		/////////////////////////////////////////////////////////////////////////////
		
		// db에 넘겨줄 info 
		info.put("paymentType", "Kakao Pay");
		info.put("orderNo", orderNo);
		info.put("cashReceipt", "-");
		info.put("id", loginMember.getId());
		info.put("storeId", storeId);
		info.put("totalPrice", totalPrice);
		info.put("tid", kakaoPayApproval.getTid());
		
		try {
			model.addAttribute("loginMember", service.kakaoTransactional(info));
		} catch(Exception e) {
			e.getMessage();
		}
		
		model.addAttribute("msg", "주문 완료");
		model.addAttribute("loc", "/");
		return "common/msg";
	}
	
	// 카카오 결제 취소
	@RequestMapping("/order/cart/simplePaymentCancel.do")
	public String simplePaymentCancel(Model model) {
		model.addAttribute("msg", "결제 취소");
		model.addAttribute("loc", "/order/cart/moveToShoppingCart.do");
		return "common/msg";
	}
	
	// 카카오 결제 실패
	@RequestMapping("/order/cart/simplePaymentFail.do")
	public String simplePaymentFail(Model model) {
		model.addAttribute("msg", "결제 실패");
		model.addAttribute("loc", "/order/cart/moveToShoppingCart.do");
		return "common/msg";
	}
	//////////////////////////////////////////////////////////////////////////////////////////
	
	// 스타벅스 카드 결제
	@RequestMapping("/order/cart/starbucksPaymentExcution.do")
	@ResponseBody
	public boolean starbucksPaymentExcution(
			@RequestParam("balance") int balance,
			@RequestParam("totalPrice") int totalPrice,
			@RequestParam(value="cashReceipt", required=false) String cashReceipt,
			@RequestParam("cardSeq") int cardSeq,
			HttpSession session,
			Model model
			) {
		// isComplete?
		boolean isComplete = false;
		
		// 회원 정보
		Member loginMember = (Member)session.getAttribute("loginMember");
		String storeId = ((Store)session.getAttribute("selectedStore")).getStoreId();

		// 카드 금액 수정
		int finalBalance = balance - totalPrice;
		
		info.put("cardSeq", loginMember.getCardSeq());
		info.put("finalBalance", finalBalance);
		
		/////////////////////////////////////////////////////////////////////////////
		// 주문번호 생성
		/////////////////////////////////////////////////////////////////////////////
		String orderNo = createOrderNumber(loginMember, storeId);
		/////////////////////////////////////////////////////////////////////////////
		
		// db에 넘겨줄 info 
		info.put("paymentType", "starbucks");
		info.put("cashReceipt", cashReceipt);
		info.put("orderNo", orderNo);
		info.put("id", loginMember.getId());
		info.put("storeId", storeId);
		info.put("totalPrice", totalPrice);
		info.put("cardSeq", cardSeq);
		
		try {
			model.addAttribute("loginMember", service.starbucksTransactional(info));
			isComplete = true;
		} catch(Exception e) {
			e.getMessage();
		}
		return isComplete;
	}
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/////////////////////////////////////////////////////////////////////////////
	// 주문번호 생성
	/////////////////////////////////////////////////////////////////////////////
	public String createOrderNumber(Member loginMember, String storeId) {
		String orderNo = "";
		
		Date today = new Date();
		SimpleDateFormat yearFormat = new SimpleDateFormat("yyyy");
		SimpleDateFormat dateFormat = new SimpleDateFormat("MMdd");
		SimpleDateFormat timeFormat = new SimpleDateFormat("HHmm");
		
		// 스토어 아이디
		// 날짜
		String year = yearFormat.format(today);
		String date = dateFormat.format(today);
		// 시간
		String time = timeFormat.format(today);
		// 핸드폰번호 끝 4자리
		String phone = loginMember.getPhone();
		String no = phone.substring(phone.length()-4, phone.length());
		// 주문번호
		orderNo = storeId + "-" + year + "-" + date + "-" + time + "-" + no;
		
		return orderNo;
	}
}
package com.noh.spring.order.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.noh.spring.business.model.dao.BusinessDao;
import com.noh.spring.common.KakaoPayService;
import com.noh.spring.common.model.vo.KakaoPayCancel;
import com.noh.spring.member.model.dao.MemberDao;
import com.noh.spring.member.model.vo.Member;
import com.noh.spring.order.model.dao.OrderDao;
import com.noh.spring.order.model.vo.Cart;
import com.noh.spring.order.model.vo.Order;
import com.noh.spring.order.model.vo.Product;
import com.noh.spring.pay.model.dao.PayDao;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDao dao;
	
	@Autowired
	private MemberDao mDao;
	
	@Autowired
	private PayDao pDao;
	
	@Autowired
	private BusinessDao bDao;

	@Autowired
	private SqlSession session;
	
	@Autowired
	private KakaoPayService kakaoPayService;
	
	
	@Override
	public Product getProductInfo(String productId) {
		return dao.getProductInfo(session, productId);
	}
	
	@Override
	public List<Product> getMenuList(HashMap<String, String> info) {
		return dao.getMenuList(session, info);
	}

	@Override
	public int addToShoppingCart(Cart cart) {
		return dao.addToShoppingCart(session, cart);
	}
	
	@Override
	public int checkShoppingCart(String id) {
		return dao.checkShoppingCart(session, id);
	}
	
	@Override
	public List<Cart> getShoppingCartList(String id) {
		return dao.getShoppingCartList(session, id);
	}

	@Override
	public int deleteCartList(int cartSeq) {
		return dao.deleteCartList(session, cartSeq);
	}

	@Override
	public int changeQuantity(Cart cart) {
		return dao.changeQuantity(session, cart);
	}

	@Override
	public int starbucksPaymentExcution(HashMap<String, Object> info) {
		return dao.starbucksPaymentExcution(session, info);
	}

	@Override
	public int addOrderInfo(HashMap<String, Object> info) {
		return dao.addOrderInfo(session, info);
	}

	@Override
	public int removeCartList(String id) {
		return dao.removeCartList(session, id);
	}

	@Override
	public List<Order> getOrderList(HashMap<String, Object> info) {
		return dao.getOrderList(session, info);
	}

	@Override
	public List<Order> getBillInfo(HashMap<String, Object> info) {
		return dao.getBillInfo(session, info);
	}

	@Override
	@Transactional
	public Member kakaoTransactional(HashMap<String, Object> info) throws Exception {
		
		Member loginMember = null;
		
		try {
			boolean isAdded = false;
			int result = 0;
			
			List<Cart> cartList = dao.getShoppingCartList(session, (String)info.get("id"));
			for(Cart cart: cartList) {
				info.put("productName", cart.getProductName());
				info.put("productPrice", cart.getProductPrice());
				
				String selectedOption = "";
				// 옵션
				if(!cart.getProductOption().equals("none")) selectedOption += cart.getProductOption().toUpperCase() + " ";
				// 사이즈
				if(!cart.getProductSize().equals("none")) {
					selectedOption += cart.getProductSize().toUpperCase();
					if(cart.getProductSize().equals("tall")) info.put("addedPrice", 0);
					else if(cart.getProductSize().equals("grande")) info.put("addedPrice", 500);
					else info.put("addedPrice", 1000);
				} else {
					info.put("addedPrice",  0);
				}
				
				info.put("selectedOption", selectedOption);
				info.put("quantity", cart.getProductQuantity());
				info.put("extraShot", cart.getExtraShot());
				
				// 주문 내역에 추가
				result += dao.addOrderInfo(session, info);
				
				// 매장 DB에 저장
				bDao.addBusinessOrderInfo(session, info);
			}
			if(result == cartList.size()) isAdded = true;
			
			// 주문 내역에 추가 완료되면
			if(isAdded) {
				// 장바구니 내역 삭제
				dao.removeCartList(session, (String)info.get("id"));
				
				// 1만원 단위로 별 적립
				HashMap<String, Object> rewardsInfo = new HashMap<String, Object>();
				rewardsInfo.put("id", (String)info.get("id"));
				rewardsInfo.put("stars", (int)((int)info.get("totalPrice") / 10000) + 1);
				// 별 적립
				int addRewards = mDao.addRewardsInfo(session, rewardsInfo);
				// 누적 별 합계
				int stars = mDao.getRewardsInfo(session, (String)info.get("id"));
				if(addRewards > 0) rewardsInfo.put("stars", stars);
				// 회원 정보에 반영
				if(stars < 5) rewardsInfo.put("membership", "welcome");
				else if(stars < 30) rewardsInfo.put("membership", "green");
				else rewardsInfo.put("membership", "gold");
				
				mDao.setRewardsInfoToMember(session, rewardsInfo);
				loginMember = mDao.getMemberInfo(session, (String)info.get("id"));
			}
		} catch(RuntimeException e) {
			KakaoPayCancel kakaoPayCancel = kakaoPayService.getCancelInfo((String)info.get("tid"));
			System.out.println(kakaoPayCancel.getApproved_cancel_amount().getTotal() + " : " + kakaoPayCancel.getCanceled_at());
			throw new Exception("실패");
		}
		return loginMember;
	}

	@Override
	@Transactional
	public Member starbucksTransactional(HashMap<String, Object> info) throws Exception {
		
		Member loginMember = null;
		
		try {
			boolean isPaid = dao.starbucksPaymentExcution(session, info)>0?true:false;
			boolean isAdded = false;
			
			// 결제 성공하면 
			if(isPaid) {
				int result = 0;
				// 주문 정보(장바구니)
				List<Cart> cartList = dao.getShoppingCartList(session, (String)info.get("id"));
				for(Cart cart: cartList) {
					info.put("productName", cart.getProductName());
					info.put("productPrice", cart.getProductPrice());
					
					String selectedOption = "";
					// 옵션
					if(!cart.getProductOption().equals("none")) selectedOption += cart.getProductOption().toUpperCase() + " ";
					// 사이즈
					if(!cart.getProductSize().equals("none")) {
						selectedOption += cart.getProductSize().toUpperCase();
						if(cart.getProductSize().equals("tall")) info.put("addedPrice", 0);
						else if(cart.getProductSize().equals("grande")) info.put("addedPrice", 500);
						else info.put("addedPrice", 1000);
					} else {
						info.put("addedPrice",  0);
					}
					
					
					info.put("selectedOption", selectedOption);
					info.put("quantity", cart.getProductQuantity());
					info.put("extraShot", cart.getExtraShot());
					
					// 주문 내역에 추가
					result += dao.addOrderInfo(session, info);
					
					// 매장 DB에 저장
					bDao.addBusinessOrderInfo(session, info);
				}
				if(result == cartList.size()) isAdded = true;
				
				// 주문 내역에 추가 완료되면
				if(isAdded) {
					// 장바구니 내역 삭제
					dao.removeCartList(session, (String)info.get("id"));
					
					// 카드 사용 내역 추가(충전 히스토리 같이 사용)
					pDao.addPaymentHistoryIntoChargingHistory(session, info);
					
					// 1만원 단위로 별 적립
					HashMap<String, Object> rewardsInfo = new HashMap<String, Object>();
					rewardsInfo.put("id", (String)info.get("id"));
					rewardsInfo.put("stars", (int)((int)info.get("totalPrice") / 10000) + 1);
					// 별 적립
					int addRewards = mDao.addRewardsInfo(session, rewardsInfo);
					// 누적 별 합계
					int stars = mDao.getRewardsInfo(session, (String)info.get("id"));
					if(addRewards > 0) rewardsInfo.put("stars", stars);
					// 회원 정보에 반영
					if(stars < 5) rewardsInfo.put("membership", "welcome");
					else if(stars < 30) rewardsInfo.put("membership", "green");
					else rewardsInfo.put("membership", "gold");
					
					mDao.setRewardsInfoToMember(session, rewardsInfo);
					loginMember = mDao.getMemberInfo(session, (String)info.get("id"));
				}
			}
		} catch(RuntimeException e) {
			throw new Exception("실패");
		}
		return loginMember;
	}
}

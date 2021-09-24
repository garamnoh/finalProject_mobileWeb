package com.noh.spring.order.service; 

import java.util.HashMap;
import java.util.List;

import com.noh.spring.member.model.vo.Member;
import com.noh.spring.order.model.vo.Cart;
import com.noh.spring.order.model.vo.Order;
import com.noh.spring.order.model.vo.Product;

public interface OrderService {

	Product getProductInfo(String productId);
	List<Product> getMenuList(HashMap<String, String> info);
	int addToShoppingCart(Cart cart);
	int checkShoppingCart(String id);
	List<Cart> getShoppingCartList(String id);
	int deleteCartList(int cartSeq);
	int changeQuantity(Cart cart);
	int starbucksPaymentExcution(HashMap<String, Object> info);
	int addOrderInfo(HashMap<String, Object> info);
	int removeCartList(String id);
	List<Order> getOrderList(HashMap<String, Object> info);
	List<Order> getBillInfo(HashMap<String, Object> info);
	Member kakaoTransactional(HashMap<String, Object> info) throws Exception;
	Member starbucksTransactional(HashMap<String, Object> info) throws Exception;
}

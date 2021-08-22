package com.noh.spring.order.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.noh.spring.order.model.vo.Cart;
import com.noh.spring.order.model.vo.Order;
import com.noh.spring.order.model.vo.Product;

public interface OrderDao {

	Product getProductInfo(SqlSession session, String productId);
	List<Product> getMenuList(SqlSession session, HashMap<String, String> info);
	int addToShoppingCart(SqlSession session, Cart cart);
	int checkShoppingCart(SqlSession session, String id);
	List<Cart> getShoppingCartList(SqlSession session, String id);
	int deleteCartList(SqlSession session, int cartSeq);
	int changeQuantity(SqlSession session, Cart cart);
	int starbucksPaymentExcution(SqlSession session, HashMap<String, Object> info);
	int addOrderInfo(SqlSession session, HashMap<String, Object> info);
	int removeCartList(SqlSession session, String id);
	List<Order> getOrderList(SqlSession session, HashMap<String, Object> info);
	List<Order> getBillInfo(SqlSession session, HashMap<String, Object> info);
}

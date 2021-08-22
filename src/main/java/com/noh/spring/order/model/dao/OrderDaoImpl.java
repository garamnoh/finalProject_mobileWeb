package com.noh.spring.order.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.noh.spring.order.model.vo.Cart;
import com.noh.spring.order.model.vo.Order;
import com.noh.spring.order.model.vo.Product;

@Repository
public class OrderDaoImpl implements OrderDao {

	@Override
	public Product getProductInfo(SqlSession session, String productId) {
		return session.selectOne("order.getProductInfo", productId);
	}
	
	@Override
	public List<Product> getMenuList(SqlSession session, HashMap<String, String> info) {
		return session.selectList("order.getMenuList", info);
	}
	
	@Override
	public int addToShoppingCart(SqlSession session, Cart cart) {
		return session.insert("order.addToShoppingCart", cart);
	}
	
	@Override
	public int checkShoppingCart(SqlSession session, String id) {
		return session.selectOne("order.checkShoppingCart", id);
	}
	
	@Override
	public List<Cart> getShoppingCartList(SqlSession session, String id) {
		return session.selectList("order.getShoppingCartList", id);
	}

	@Override
	public int deleteCartList(SqlSession session, int cartSeq) {
		return session.delete("order.deleteCartList", cartSeq);
	}

	@Override
	public int changeQuantity(SqlSession session, Cart cart) {
		return session.update("order.changeQuantity", cart);
	}

	@Override
	public int starbucksPaymentExcution(SqlSession session, HashMap<String, Object> info) {
		return session.update("pay.starbucksPaymentExcution", info);
	}

	@Override
	public int addOrderInfo(SqlSession session, HashMap<String, Object> info) {
		return session.insert("order.addOrderInfo", info);
	}

	@Override
	public int removeCartList(SqlSession session, String id) {
		return session.delete("order.removeCartList", id);
	}

	@Override
	public List<Order> getOrderList(SqlSession session, HashMap<String, Object> info) {
		return session.selectList("order.getOrderList", info);
	}

	@Override
	public List<Order> getBillInfo(SqlSession session, HashMap<String, Object> info) {
		return session.selectList("order.getBillInfo", info);
	}
}

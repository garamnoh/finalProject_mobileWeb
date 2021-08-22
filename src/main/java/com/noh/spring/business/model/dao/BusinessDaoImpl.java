package com.noh.spring.business.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.noh.spring.business.model.vo.BusinessOrder;

@Repository
public class BusinessDaoImpl implements BusinessDao {

	@Override
	public int addBusinessOrderInfo(SqlSession session, HashMap<String, Object> info) {
		return session.insert("business.addBusinessOrderInfo", info);
	}

	@Override
	public List<BusinessOrder> getOrderList(SqlSession session, String storeId) {
		return session.selectList("business.getOrderList", storeId);
	}

	@Override
	public List<BusinessOrder> getOrderDetail(SqlSession session, HashMap<String, Object> info) {
		return session.selectList("business.getOrderDetail", info);
	}

	@Override
	public int changeBusinessOrderStatus(SqlSession session, String orderNo) {
		return session.update("business.changeBusinessOrderStatus", orderNo);
	}
}

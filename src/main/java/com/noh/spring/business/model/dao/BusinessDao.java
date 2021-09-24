package com.noh.spring.business.model.dao; 

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.noh.spring.business.model.vo.BusinessOrder;

public interface BusinessDao {

	int addBusinessOrderInfo(SqlSession session, HashMap<String, Object> info);
	List<BusinessOrder> getOrderList(SqlSession session, String storeId);
	List<BusinessOrder> getOrderDetail(SqlSession session, HashMap<String, Object> info);
	int changeBusinessOrderStatus(SqlSession session, String orderNo);
}

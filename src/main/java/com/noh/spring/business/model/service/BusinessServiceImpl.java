package com.noh.spring.business.model.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.noh.spring.business.model.dao.BusinessDao;
import com.noh.spring.business.model.vo.BusinessOrder;

@Service
public class BusinessServiceImpl implements BusinessService {

	@Autowired
	private BusinessDao dao;
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<BusinessOrder> getOrderList(String storeId) {
		return dao.getOrderList(session, storeId);
	}

	@Override
	public List<BusinessOrder> getOrderDetail(HashMap<String, Object> info) {
		return dao.getOrderDetail(session, info);
	}
}

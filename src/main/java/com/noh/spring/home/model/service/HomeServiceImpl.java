package com.noh.spring.home.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.noh.spring.home.model.dao.HomeDao;
import com.noh.spring.order.model.vo.Product;

@Service
public class HomeServiceImpl implements HomeService {

	@Autowired
	private HomeDao dao;
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<Product> newProductList() {
		List<Product> newProductList = dao.newProductList(session);
		return newProductList;
	}

}

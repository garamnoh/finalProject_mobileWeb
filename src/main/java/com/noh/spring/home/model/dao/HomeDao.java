package com.noh.spring.home.model.dao; 

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.noh.spring.order.model.vo.Product;

public interface HomeDao {

	List<Product> newProductList(SqlSession session);
}

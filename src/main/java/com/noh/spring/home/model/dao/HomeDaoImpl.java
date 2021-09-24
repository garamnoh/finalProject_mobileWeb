package com.noh.spring.home.model.dao; 

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.noh.spring.order.model.vo.Product;

@Repository
public class HomeDaoImpl implements HomeDao {

	@Override
	public List<Product> newProductList(SqlSession session) {
		return session.selectList("home.newProductList");
	}

}

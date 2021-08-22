package com.noh.spring.store.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.noh.spring.store.model.vo.Store;

@Repository
public class StoreDaoImpl implements StoreDao {

	@Override
	public List<Store> getStoreList(SqlSession session, int page, int linePerPage, HashMap<String, String> storeInfo) {
		RowBounds row = new RowBounds((page - 1) * linePerPage, linePerPage);
		return session.selectList("store.storeList", storeInfo, row);
	}

	@Override
	public Store getStoreInfo(SqlSession session, String store) {
		return session.selectOne("store.storeInfo", store);
	}
}

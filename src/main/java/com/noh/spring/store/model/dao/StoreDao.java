package com.noh.spring.store.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.noh.spring.store.model.vo.Store;

public interface StoreDao {

	List<Store> getStoreList(SqlSession session, int page, int linePerPage, HashMap<String, String> storeInfo);
	Store getStoreInfo(SqlSession session, String store);
}

package com.noh.spring.store.model.service; 

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.noh.spring.store.model.dao.StoreDao;
import com.noh.spring.store.model.vo.Store;

@Service
public class StoreServiceImpl implements StoreService {

	@Autowired
	private StoreDao dao;
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<Store> getStoreList(int page, int linePerPage, HashMap<String, String> storeInfo) {
		return dao.getStoreList(session, page, linePerPage, storeInfo);
	}
	
	@Override
	public Store getStoreInfo(String store) {
		return dao.getStoreInfo(session, store);
	}
}

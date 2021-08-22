package com.noh.spring.store.model.service;

import java.util.HashMap;
import java.util.List;

import com.noh.spring.store.model.vo.Store;

public interface StoreService {

	List<Store> getStoreList(int page, int linePerPage, HashMap<String, String> storeInfo);
	Store getStoreInfo(String stroe);
}

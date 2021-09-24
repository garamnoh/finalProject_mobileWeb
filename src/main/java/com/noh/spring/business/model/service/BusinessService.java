package com.noh.spring.business.model.service; 

import java.util.HashMap;
import java.util.List;

import com.noh.spring.business.model.vo.BusinessOrder;

public interface BusinessService {

	List<BusinessOrder> getOrderList(String storeId);
	List<BusinessOrder> getOrderDetail(HashMap<String, Object> info);
}

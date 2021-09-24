package com.noh.spring.store.model.vo; 

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Store {

	private String storeId;
	private String storeName;
	private String storeTel;
	private String storeAddress;
	private String storeImg;
	private String locationLat;
	private String locationLng;
	private String type;
	private String distance;
}

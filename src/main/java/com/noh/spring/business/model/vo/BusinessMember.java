package com.noh.spring.business.model.vo; 

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class BusinessMember {

	private int businessMemberNo;
	private String storeId;
	private String password;
	private String storeName;
}

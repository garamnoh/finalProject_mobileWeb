package com.noh.spring.order.model.vo; 

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Cart {

	private int cartSeq;
	private String id;
	private String productName;
	private String productImg;
	private String category;
	private String productOption;
	private String productSize;
	private int productQuantity;
	private int productPrice;
	private int extraShot;
}

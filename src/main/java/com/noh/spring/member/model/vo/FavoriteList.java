package com.noh.spring.member.model.vo; 

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class FavoriteList {

	private int favoriteSeq;
	private String id;
	private String productId;
	private String optionId;
	private String productName;
	private String productNameEn;
	private int productPrice;
	private String category;
	private String type;
	private String productImg;
}

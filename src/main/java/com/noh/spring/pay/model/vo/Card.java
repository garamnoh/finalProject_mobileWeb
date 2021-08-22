package com.noh.spring.pay.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Card {
	
	private int cardSeq;
	private String id;
	private String cardId;
	private String cardNo;
	private String balance;
	private String cardName;
	private String cardImg;
}

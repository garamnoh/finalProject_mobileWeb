package com.noh.spring.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CardInfo {

	private String purchase_corp;
	private String purchase_corp_code;
	private String issuer_corp;
	private String kakaopay_purchase_corp;
	private String kakaopay_issuer_corp;
	private String bin;
	private String card_type;
	private String install_month;
	private String approved_id;
	private String card_mid;
	private String interest_free_install;
	private String card_item_code;
}

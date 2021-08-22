package com.noh.spring.order.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Order {

	private int orderSeq;
	private String orderNo;
	private String id;
	private String storeId;
	private String productName;
	private int productPrice;
	private String selecetedOption;
	private int addedPrice;
	private int quantity;
	private int extraShot;
	private Date paymentDate;
	private String paymentType;
	private String cashReceipt;
	private int approvalNo;
}

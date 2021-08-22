package com.noh.spring.business.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class BusinessOrder {

	private int businessOrderSeq;
	private String storeId;
	private String id;
	private String orderNo;
	private String productName;
	private String selectedOption;
	private int quantity;
	private int extraShot;
	private Date acceptedDate;
	private String status;
	private Date completedDate;
}

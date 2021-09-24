package com.noh.spring.pay.model.vo; 

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Charging {

	private int chargingSeq;
	private int cardSeq;
	private String id;
	private String impUid;
	private String merchantUid;
	private int price;
	private Date chargingDate;
	private String payment;
}

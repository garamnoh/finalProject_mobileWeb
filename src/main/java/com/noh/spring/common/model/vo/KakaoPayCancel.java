package com.noh.spring.common.model.vo; 

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class KakaoPayCancel {

	private ApprovedCancelAmount approved_cancel_amount;
	private Date approved_at;
	private Date canceled_at;
}

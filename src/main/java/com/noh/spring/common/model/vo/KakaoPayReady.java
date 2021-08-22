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
public class KakaoPayReady {

	private String tid;
	private String next_redirect_mobile_url;
	private String next_redirect_pc_url;
	private Date created_at;
}
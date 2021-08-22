package com.noh.spring.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MyInfo {

	private String infoId;
	private String id;
	private int cardSeq;
	private int stars;
	private String membership;
}

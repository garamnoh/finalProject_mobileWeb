package com.noh.spring.member.model.vo; 

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Member {

	private String id;
	private String password;
	private String idNo;
	private String name;
	private String email;
	private String gender;
	private String address;
	private String phone;
	private String nickname;
	private Date enrollDate;
	private String kakaoId;
	private int cardSeq;
	private int stars;
	private String membership;
	private String locationLat;
	private String locationLng;
}

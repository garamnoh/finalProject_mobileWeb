package com.noh.spring.common;

import java.net.URI;
import java.net.URISyntaxException;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.noh.spring.common.model.vo.AccessToken;

@Service
public class IamportService {
	
	private AccessToken accessToken;

	public void getAccessToken() {
		RestTemplate restTemplate = new RestTemplate();
		
		String requestURL = "https://api.iamport.kr/users/getToken";
		
		// 헤더
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
		
		// 바디
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		parameters.add("imp_key", "8592584529414390");
		parameters.add("imp_secret", "226b2c03d6539d0858a05577a0799cfc2188c39440bc9bf7fbca657d69bd5927434685045fd80f8c");
		
		HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(parameters, headers);
		
		try { accessToken = restTemplate.postForObject(new URI(requestURL), body, AccessToken.class); }
		catch(RestClientException e) { e.printStackTrace(); }
		catch(URISyntaxException e) { e.printStackTrace(); }
		
		System.out.println(accessToken.getResponse().getAccess_token());
	} 
}

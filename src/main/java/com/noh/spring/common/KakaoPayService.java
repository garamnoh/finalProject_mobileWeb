package com.noh.spring.common;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.HashMap;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import com.noh.spring.common.model.vo.KakaoPayApproval;
import com.noh.spring.common.model.vo.KakaoPayCancel;
import com.noh.spring.common.model.vo.KakaoPayReady;

@Service
public class KakaoPayService {
	
	private KakaoPayReady kakaoPayReady;
	private KakaoPayApproval kakaoPayApproval;
	private KakaoPayCancel kakaoPayCancel;
	
	private HashMap<String, Object> infoReady;
	
	// 카카오페이 준비
	public String getRedirectURL(HashMap<String, Object> info) {
		// kakaoReady와 kakaoApprove에서 동일하게 사용할 HashMap
		infoReady = info;
		
		RestTemplate restTemplate = new RestTemplate();
		
		String requestURL = "https://kapi.kakao.com/v1/payment/ready";
		String authorization = "KakaoAK 18b59cb48b76317596241a32038a9742";
		
		// 요청할 헤더
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", authorization);
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		// 요청할 바디
		MultiValueMap<String, Object> parameters = new LinkedMultiValueMap<String, Object>();
		parameters.add("cid", "TC0ONETIME");
		parameters.add("partner_order_id", "starbucks");
		parameters.add("partner_user_id", info.get("userId"));
		parameters.add("item_name", info.get("productName"));
		parameters.add("quantity", info.get("totalQuantity"));
		parameters.add("total_amount", info.get("totalPrice"));
		parameters.add("tax_free_amount", 0);
//		parameters.add("approval_url", "http://192.168.0.15:9090/spring/order/cart/simplePaymentSuccess.do");
//		parameters.add("cancel_url", "http://192.168.0.15:9090/spring/order/cart/simplePaymentCancel.do");
//		parameters.add("fail_url", "http://192.168.0.15:9090/spring/order/cart/simplePaymentFail.do");
		parameters.add("approval_url", "http://rclass.iptime.org:9999/21PM_STARBUCKS_final/order/cart/simplePaymentSuccess.do");
		parameters.add("cancel_url", "http://rclass.iptime.org:9999/21PM_STARBUCKS_final/order/cart/simplePaymentCancel.do");
		parameters.add("fail_url", "http://rclass.iptime.org:9999/21PM_STARBUCKS_final/order/cart/simplePaymentFail.do");
		
		HttpEntity<MultiValueMap<String, Object>> body = new HttpEntity<MultiValueMap<String, Object>>(parameters, headers);
		
		try {kakaoPayReady = restTemplate.postForObject(new URI(requestURL), body, KakaoPayReady.class);} 
		catch(RestClientException e) {e.printStackTrace();}
		catch(URISyntaxException e) {e.printStackTrace();}
		
//		return kakaoPayReady.getNext_redirect_pc_url();
		return kakaoPayReady.getNext_redirect_mobile_url();
	}
	
	// 카카오페이 승인
	public KakaoPayApproval getApprovalInfo(String pg_token) {
		
		RestTemplate restTemplate = new RestTemplate();
		
		String requestURL = "https://kapi.kakao.com/v1/payment/approve";
		String authorization = "KakaoAK 18b59cb48b76317596241a32038a9742";
		
		// 요청할 헤더
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", authorization);
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		// 요청할 바디
		MultiValueMap<String, Object> parameters = new LinkedMultiValueMap<String, Object>();
		parameters.add("cid", "TC0ONETIME");
		parameters.add("tid", kakaoPayReady.getTid());
		parameters.add("partner_order_id", "starbucks");
		parameters.add("partner_user_id", infoReady.get("userId"));
		parameters.add("pg_token", pg_token);
		parameters.add("total_amount", infoReady.get("totalPrice"));
		
		HttpEntity<MultiValueMap<String, Object>> body = new HttpEntity<MultiValueMap<String, Object>>(parameters, headers);
		
		try {kakaoPayApproval = restTemplate.postForObject(new URI(requestURL), body, KakaoPayApproval.class);}
		catch(RestClientException e) {e.printStackTrace();}
		catch(URISyntaxException e) {e.printStackTrace();}
		
		return kakaoPayApproval;
	}
	
	// 카카오페이 결제 취소
	public KakaoPayCancel getCancelInfo(String tid) {
		
		RestTemplate restTemplate = new RestTemplate();
		
		String requestURL = "https://kapi.kakao.com/v1/payment/cancel";
		String authorization = "KakaoAK 18b59cb48b76317596241a32038a9742";
		
		// 요청 헤더
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", authorization);
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		
		// 요청 바디
		MultiValueMap<String, Object> parameters = new LinkedMultiValueMap<String, Object>();
		parameters.add("cid", "TC0ONETIME");
		parameters.add("tid", tid);
		parameters.add("cancel_amount", infoReady.get("totalPrice"));
		parameters.add("cancel_tax_free_amount", 0);
		
		HttpEntity<MultiValueMap<String, Object>> body = new HttpEntity<MultiValueMap<String, Object>>(parameters, headers);
		
		try {kakaoPayCancel = restTemplate.postForObject(new URI(requestURL), body, KakaoPayCancel.class);}
		catch(RestClientException e) {e.printStackTrace();}
		catch(URISyntaxException e) {e.printStackTrace();}
		
		return kakaoPayCancel;
	}
}

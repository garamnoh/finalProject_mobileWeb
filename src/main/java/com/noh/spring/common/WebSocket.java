package com.noh.spring.common;

import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.noh.spring.business.model.vo.BusinessMember;
import com.noh.spring.member.model.vo.Member;

public class WebSocket extends TextWebSocketHandler {
	
	// users
	private Map<String, WebSocketSession> users = new HashMap<String, WebSocketSession>();
	
	// businessUsers
	private Map<String, WebSocketSession> businessUsers = new HashMap<String, WebSocketSession>();

	// onopen
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 로그인한 유저의 HttpSession에서 id 조회 및 저장
		String user = "";
		// 개인 회원
		if(((Member)session.getAttributes().get("loginMember") != null)) {
			user = ((Member)session.getAttributes().get("loginMember")).getId();
			users.put(user, session);
		} else if((BusinessMember)session.getAttributes().get("businessLoginMember")!=null) { // 사업자 회원
			user = ((BusinessMember)session.getAttributes().get("businessLoginMember")).getStoreId();
			businessUsers.put(user, session);
		}
		System.out.println(user);
	}

	// onmessage
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 보내는 사람
		String sender;
		if(((Member)session.getAttributes().get("loginMember") != null)) {
			sender = ((Member)session.getAttributes().get("loginMember")).getId();
		} else {
			sender = ((BusinessMember)session.getAttributes().get("businessLoginMember")).getStoreId();
		}
		// message
		String messageData = message.getPayload();
		if(messageData != null) {
			String recipient = messageData.split(",")[0];
			String title = messageData.split(",")[1];
			String content = messageData.split(",")[2];
			String date = messageData.split(",")[3];
			String productName = messageData.split(",")[4];
			String orderNo = messageData.split(",")[5];
			
			if(businessUsers.containsKey(sender)) {
				WebSocketSession recipientSession = users.get(recipient);
				
				if(recipientSession != null) {
					TextMessage textMessage = new TextMessage(recipient + "," + title + "," + content + "," + date + "," + productName + "," + orderNo);
					recipientSession.sendMessage(textMessage);
				}
			} else if(users.containsKey(sender)) {
				WebSocketSession recipientSession = businessUsers.get(recipient);
				
				if(recipientSession != null) {
					TextMessage textMessage = new TextMessage(recipient + "," + content + "," + date);
					recipientSession.sendMessage(textMessage);
				}
			}
		}
	}

	// onclose
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String user;
		if(((Member)session.getAttributes().get("loginMember") != null)) {
			user = ((Member)session.getAttributes().get("loginMember")).getId();
			users.remove(user, session);
		} else if((BusinessMember)session.getAttributes().get("businessLoginMember") != null) {
			user = ((BusinessMember)session.getAttributes().get("businessLoginMember")).getStoreId();
			businessUsers.remove(user, session);
		}
	}
}

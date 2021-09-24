package com.noh.spring.common; 

import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

@Component
public class SendEmail {
	
	@Autowired
	private JavaMailSender mailSender;

	public String getVerificationCode(String name, String email) {
		
		// 6자리 코드 생성
		Random random = new Random();
		String verificationCode = String.format("%06d", random.nextInt(999999));
		
		try {
			// email 객체 생성
			MimeMessage message = mailSender.createMimeMessage();
			// Helper 객체 생성
			MimeMessageHelper helper = new MimeMessageHelper(message, "UTF-8");

			// email setting
			helper.setFrom("garam_noh@naver.com");
			helper.setTo(email);
			helper.setSubject("Verification Code from STARBUCKS");
			helper.setText(name + " 님, 안녕하세요." + "\n스타벅스입니다. \n아래 전송된 인증 코드로 인증해주세요. \n인증 코드 : " + verificationCode);

			// 메일 전송
			mailSender.send(message);
			
		} catch(MessagingException e) {
			
			e.printStackTrace();
			
		} return verificationCode;
	}
}

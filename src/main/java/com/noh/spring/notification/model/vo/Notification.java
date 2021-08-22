package com.noh.spring.notification.model.vo;

import lombok.Data;

@Data
public class Notification {

	private String id;
	private String orderNo;
	private String notificationTitle;
	private String notificationContent;
	private String notificationDate;
	private String confirmationStatus;
	private String productName;
}

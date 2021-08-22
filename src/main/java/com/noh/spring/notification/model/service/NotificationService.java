package com.noh.spring.notification.model.service;

import java.util.HashMap;
import java.util.List;

import com.noh.spring.notification.model.vo.Notification;

public interface NotificationService {

	boolean addNotification(Notification notification) throws Exception;
	int checkNotification(String id);
	boolean changeConfirmationStatus(HashMap<String, String> info);
	List<Notification> getNotification(String id);
}

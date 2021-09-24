package com.noh.spring.notification.model.dao; 

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.noh.spring.notification.model.vo.Notification;

public interface NotificationDao {

	boolean addNotification(SqlSession session, Notification notification);
	int checkNotification(SqlSession session, String id);
	boolean changeConfirmationStatus(SqlSession session, HashMap<String, String> info);
	List<Notification> getNotification(SqlSession session, String id);
}

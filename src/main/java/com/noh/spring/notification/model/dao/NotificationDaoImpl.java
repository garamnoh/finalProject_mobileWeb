package com.noh.spring.notification.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.noh.spring.notification.model.vo.Notification;

@Repository
public class NotificationDaoImpl implements NotificationDao {

	@Override
	public boolean addNotification(SqlSession session, Notification notification) {
		return session.insert("notification.addNotification", notification)>0?true:false;
	}

	@Override
	public int checkNotification(SqlSession session, String id) {
		return session.selectOne("notification.checkNotification", id);
	}

	@Override
	public boolean changeConfirmationStatus(SqlSession session, HashMap<String, String> info) {
		return session.update("notification.changeConfirmationStatus", info)>0?true:false;
	}
	
	@Override
	public List<Notification> getNotification(SqlSession session, String id){
		return session.selectList("notification.getNotification", id);
	}
}

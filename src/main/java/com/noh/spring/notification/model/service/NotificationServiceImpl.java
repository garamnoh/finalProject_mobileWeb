package com.noh.spring.notification.model.service; 

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.noh.spring.business.model.dao.BusinessDao;
import com.noh.spring.notification.model.dao.NotificationDao;
import com.noh.spring.notification.model.vo.Notification;

@Service
public class NotificationServiceImpl implements NotificationService {

	@Autowired
	private NotificationDao dao;
	
	@Autowired
	private BusinessDao bDao;
	
	@Autowired
	private SqlSession session;

	@Override
	@Transactional
	public boolean addNotification(Notification notification) throws Exception {
		boolean flag = false;
		try {
			boolean done = bDao.changeBusinessOrderStatus(session, notification.getOrderNo())>0?true:false;
			if(done) dao.addNotification(session, notification);
			flag = true;
			
		} catch(Exception e) {
			throw new Exception(e);
		
		} return flag;
	}

	@Override
	public int checkNotification(String id) {
		return dao.checkNotification(session, id);
	}

	@Override
	public boolean changeConfirmationStatus(HashMap<String, String> info) {
		return dao.changeConfirmationStatus(session, info);
	}

	@Override
	public List<Notification> getNotification(String id) {
		return dao.getNotification(session, id);
	}
}

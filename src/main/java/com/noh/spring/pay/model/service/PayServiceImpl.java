package com.noh.spring.pay.model.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.noh.spring.pay.model.dao.PayDao;
import com.noh.spring.pay.model.vo.Card;
import com.noh.spring.pay.model.vo.Charging;

@Service
public class PayServiceImpl implements PayService {
	
	@Autowired
	private PayDao dao;
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<Card> getCardList(){
		return dao.getCardList(session);
	}
	
	@Override
	public List<Card> getMyCardList(String id) {
		return dao.getMyCardList(session, id);
	}

	@Override
	public int registCard(HashMap<String, String> info) {
		return dao.registCard(session, info);
	}

	@Override
	public int getCardSeq(HashMap<String, String> info) {
		return dao.getCardSeq(session, info);
	}

	@Override
	public int setMyCard(HashMap<String, String> info) {
		return dao.setMyCard(session, info);
	}

	@Override
	public Card getMyCardInfo(int cardSeq) {
		return dao.getMyCardInfo(session, cardSeq);
	}

	@Override
	@Transactional
	public boolean chargingMyCard(HashMap<String, String> info) throws Exception {
		try {
			dao.chargingMyCard(session, info);
			dao.updateMyCardInfo(session, info);
		
		} catch(RuntimeException e) {
			throw new Exception("등록 실패");
		
		} return true;
	}

	@Override
	public List<Charging> getChargingHistory(int cardSeq) {
		return dao.getChargingHistory(session, cardSeq);
	}
}

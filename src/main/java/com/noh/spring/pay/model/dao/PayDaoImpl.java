package com.noh.spring.pay.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.noh.spring.pay.model.vo.Card;
import com.noh.spring.pay.model.vo.Charging;

@Repository
public class PayDaoImpl implements PayDao {
	
	@Override
	public List<Card> getCardList(SqlSession session) {
		return session.selectList("pay.getCardList");
	}
	
	@Override
	public List<Card> getMyCardList(SqlSession session, String id) {
		return session.selectList("pay.getMyCardList", id);
	}

	@Override
	public int registCard(SqlSession session, HashMap<String, String> info) {
		return session.insert("pay.registCard", info);
	}

	@Override
	public int getCardSeq(SqlSession session, HashMap<String, String> info) {
		return session.selectOne("pay.getCardSeq", info);
	}

	@Override
	public int setMyCard(SqlSession session, HashMap<String, String> info) {
		return session.update("pay.setMyCard", info);
	}

	@Override
	public Card getMyCardInfo(SqlSession session, int cardSeq) {
		return session.selectOne("pay.getMyCardInfo", cardSeq);
	}

	@Override
	public int chargingMyCard(SqlSession session, HashMap<String, String> info) {
		return session.insert("pay.chargingMyCard", info);
	}

	@Override
	public int updateMyCardInfo(SqlSession session, HashMap<String, String> info) {
		return session.update("pay.updateMyCardInfo", info);
	}

	@Override
	public List<Charging> getChargingHistory(SqlSession session, int cardSeq) {
		return session.selectList("pay.getChargingHistory", cardSeq);
	}

	@Override
	public int addPaymentHistoryIntoChargingHistory(SqlSession session, HashMap<String, Object> info) {
		return session.insert("pay.addPaymentHistoryIntoChargingHistory", info);
	}
}

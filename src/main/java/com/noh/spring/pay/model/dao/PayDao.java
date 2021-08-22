package com.noh.spring.pay.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.noh.spring.pay.model.vo.Card;
import com.noh.spring.pay.model.vo.Charging;

public interface PayDao {

	List<Card> getCardList(SqlSession session);
	List<Card> getMyCardList(SqlSession session, String id);
	int registCard(SqlSession session, HashMap<String, String> info);
	int getCardSeq(SqlSession session, HashMap<String, String> info);
	int setMyCard(SqlSession session, HashMap<String, String> info);
	Card getMyCardInfo(SqlSession session, int cardSeq);
	int chargingMyCard(SqlSession session, HashMap<String, String> info);
	int updateMyCardInfo(SqlSession session, HashMap<String, String> info);
	List<Charging> getChargingHistory(SqlSession session, int cardSeq);
	int addPaymentHistoryIntoChargingHistory(SqlSession session, HashMap<String, Object> info);
}

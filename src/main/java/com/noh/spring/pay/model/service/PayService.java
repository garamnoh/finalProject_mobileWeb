package com.noh.spring.pay.model.service; 

import java.util.HashMap;
import java.util.List;

import com.noh.spring.pay.model.vo.Card;
import com.noh.spring.pay.model.vo.Charging;

public interface PayService {

	List<Card> getCardList();
	List<Card> getMyCardList(String id);
	int registCard(HashMap<String, String> info);
	int getCardSeq(HashMap<String, String> info);
	int setMyCard(HashMap<String, String> info);
	Card getMyCardInfo(int cardSeq);
	boolean chargingMyCard(HashMap<String, String> info) throws Exception;
	List<Charging> getChargingHistory(int cardSeq);
}

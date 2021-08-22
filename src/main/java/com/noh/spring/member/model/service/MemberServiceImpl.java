package com.noh.spring.member.model.service;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.noh.spring.business.model.vo.BusinessMember;
import com.noh.spring.member.model.dao.MemberDao;
import com.noh.spring.member.model.vo.Favorite;
import com.noh.spring.member.model.vo.FavoriteList;
import com.noh.spring.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDao dao;

	@Autowired
	private SqlSession session;
	
	@Override
	public int enrollMember(Member member) {
		return dao.enrollMember(session, member);
	}

	@Override
	public int addRewardsInfo(HashMap<String, Object> info) {
		return dao.addRewardsInfo(session, info);
	}
	
	@Override
	public Member confirmIdDuplication(String id) {
		return dao.confirmIdDuplication(session, id);
	}
	
	@Override
	public Member confirmPhoneDuplication(String phone) {
		return dao.confirmPhoneDuplication(session, phone);
	}
	
	@Override
	public Member confirmEmailDuplication(String email) {
		return dao.confirmEmailDuplication(session, email);
	}
	
	@Override
	public String searchId(Member member) {
		return dao.searchId(session, member);
	}
	
	@Override
	public Member checkInfo(Member member) {
		return dao.checkInfo(session, member);
	}
	
	@Override
	public int changePassword(Member member) {
		return dao.changePassword(session, member);
	}
	
	@Override
	public Member login(Member member) {
		return dao.login(session, member);
	}
	
	@Override
	public int getRewardsInfo(String id) {
		return dao.getRewardsInfo(session, id);
	}

	@Override
	public int setRewardsInfoToMember(HashMap<String, Object> info) {
		return dao.setRewardsInfoToMember(session, info);
	}

	@Override
	public Member checkKakaoId(String email) {
		return dao.checkKakaoId(session, email);
	}
	
	@Override
	public int deleteMember(Member member) {
		return dao.deleteMember(session, member);
	}
	
	@Override
	public List<FavoriteList> getFavoriteList(String id){
		return dao.getFavoriteList(session, id);
	}
	
	@Override
	public Favorite isFavorite(HashMap<String, String> info) {
		return dao.isFavorite(session, info);
	}
	
	@Override
	public int addToFavoriteList(HashMap<String, String> info) {
		return dao.addToFavoriteList(session, info);
	}
	
	@Override
	public int removeFromFavoriteList(HashMap<String, String> info) {
		return dao.removeFromFavoriteList(session, info);
	}

	@Override
	public Member getMemberInfo(String id) {
		return dao.getMemberInfo(session, id);
	}

	@Override
	public boolean checkNickname(String nickname) {
		return dao.checkNickname(session, nickname);
	}

	@Override
	public boolean editNickname(HashMap<String, Object> info) {
		return dao.editNickname(session, info);
	}

	@Override
	public BusinessMember businessMemberLogin(BusinessMember businessMember) {
		return dao.businessMemberLogin(session, businessMember);
	}
}

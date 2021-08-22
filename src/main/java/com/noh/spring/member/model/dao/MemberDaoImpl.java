package com.noh.spring.member.model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.noh.spring.business.model.vo.BusinessMember;
import com.noh.spring.member.model.vo.Favorite;
import com.noh.spring.member.model.vo.FavoriteList;
import com.noh.spring.member.model.vo.Member;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Override
	public int enrollMember(SqlSession session, Member member) {
		return session.insert("member.enrollMember", member);
	}
	
	@Override
	public int addRewardsInfo(SqlSession session, HashMap<String, Object> info) {
		return session.insert("member.addRewardsInfo", info);
	}

	@Override
	public Member confirmIdDuplication(SqlSession session, String id) {
		return session.selectOne("member.confirmIdDuplication", id);
	}

	@Override
	public Member confirmPhoneDuplication(SqlSession session, String phone) {
		return session.selectOne("member.confirmPhoneDuplication", phone);
	}

	@Override
	public Member confirmEmailDuplication(SqlSession session, String email) {
		return session.selectOne("member.confirmEmailDuplication", email);
	}

	@Override
	public String searchId(SqlSession session, Member member) {
		return session.selectOne("member.searchId", member);
	}
	
	@Override
	public Member checkInfo(SqlSession session, Member member) {
		return session.selectOne("member.checkInfo", member);
	}
	
	@Override
	public int changePassword(SqlSession session, Member member) {
		return session.update("member.changePassword", member);
	}
	
	@Override
	public Member login(SqlSession session, Member member) {
		return session.selectOne("member.login", member);
	}

	@Override
	public int getRewardsInfo(SqlSession session, String id) {
		return session.selectOne("member.getRewardsInfo", id);
	}

	@Override
	public int setRewardsInfoToMember(SqlSession session, HashMap<String, Object> info) {
		return session.update("member.setRewardsInfoToMember", info);
	}

	@Override
	public Member checkKakaoId(SqlSession session, String email) {
		return session.selectOne("member.checkKakaoId", email);
	}
	
	@Override
	public int deleteMember(SqlSession session, Member member) {
		return session.delete("member.deleteMember", member);
	}
	
	@Override
	public List<FavoriteList> getFavoriteList(SqlSession session, String id) {
		return session.selectList("member.getFavoriteList", id);
	}
	
	@Override
	public Favorite isFavorite(SqlSession session, HashMap<String, String> info) {
		return session.selectOne("member.isFavorite", info);
	}
	
	@Override
	public int addToFavoriteList(SqlSession session, HashMap<String, String> info) {
		return session.insert("member.addToFavoriteList", info);
	}
	
	@Override
	public int removeFromFavoriteList(SqlSession session, HashMap<String, String> info) {
		return session.delete("member.removeFromFavoriteList", info);
	}

	@Override
	public Member getMemberInfo(SqlSession session, String id) {
		return session.selectOne("member.getMemberInfo", id);
	}

	@Override
	public boolean checkNickname(SqlSession session, String nickname) {
		return session.selectOne("member.checkNickname", nickname)==null?true:false;
	}

	@Override
	public boolean editNickname(SqlSession session, HashMap<String, Object> info) {
		return session.update("member.editNickname", info)==1?true:false;
	}

	@Override
	public BusinessMember businessMemberLogin(SqlSession session, BusinessMember businessMember) {
		return session.selectOne("member.businessMemberLogin", businessMember);
	}
}

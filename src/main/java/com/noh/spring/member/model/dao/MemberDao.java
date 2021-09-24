package com.noh.spring.member.model.dao; 

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.noh.spring.business.model.vo.BusinessMember;
import com.noh.spring.member.model.vo.Favorite;
import com.noh.spring.member.model.vo.FavoriteList;
import com.noh.spring.member.model.vo.Member;

public interface MemberDao {

	int enrollMember(SqlSession session, Member member);
	int addRewardsInfo(SqlSession session, HashMap<String, Object> info);
	String searchId(SqlSession session, Member member);
	Member checkInfo(SqlSession session, Member member);
	int changePassword(SqlSession session, Member member);
	Member login(SqlSession session, Member member);
	int getRewardsInfo(SqlSession session, String id);
	int setRewardsInfoToMember(SqlSession session, HashMap<String, Object> info);
	Member checkKakaoId(SqlSession session, String email);
	Member confirmIdDuplication(SqlSession session, String id);
	Member confirmPhoneDuplication(SqlSession session, String phone);
	Member confirmEmailDuplication(SqlSession session, String email);
	int deleteMember(SqlSession session, Member member);
	List<FavoriteList> getFavoriteList(SqlSession session, String id);
	Favorite isFavorite(SqlSession session, HashMap<String, String> info);
	int addToFavoriteList(SqlSession session, HashMap<String, String> info);
	int removeFromFavoriteList(SqlSession session, HashMap<String, String> info);
	Member getMemberInfo(SqlSession session, String id);
	boolean checkNickname(SqlSession session, String nickname);
	boolean editNickname(SqlSession session, HashMap<String, Object> info);
	BusinessMember businessMemberLogin(SqlSession session, BusinessMember businessMember);
}

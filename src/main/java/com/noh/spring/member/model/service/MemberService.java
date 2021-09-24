package com.noh.spring.member.model.service; 

import java.util.HashMap;
import java.util.List;

import com.noh.spring.business.model.vo.BusinessMember;
import com.noh.spring.member.model.vo.Favorite;
import com.noh.spring.member.model.vo.FavoriteList;
import com.noh.spring.member.model.vo.Member;

public interface MemberService {

	int enrollMember(Member member);
	int addRewardsInfo(HashMap<String, Object> info);
	String searchId(Member member);
	Member checkInfo(Member member);
	int changePassword(Member member);
	Member login(Member member);
	int getRewardsInfo(String id);
	int setRewardsInfoToMember(HashMap<String, Object> info);
	Member checkKakaoId(String email);
	Member confirmIdDuplication(String id);
	Member confirmPhoneDuplication(String phone);
	Member confirmEmailDuplication(String email);
	int deleteMember(Member member);
	List<FavoriteList> getFavoriteList(String id);
	Favorite isFavorite(HashMap<String, String> info);
	int addToFavoriteList(HashMap<String, String> info);
	int removeFromFavoriteList(HashMap<String, String> info);
	Member getMemberInfo(String id);
	boolean checkNickname(String nickname);
	boolean editNickname(HashMap<String, Object> info);
	BusinessMember businessMemberLogin(BusinessMember businessMember);
}

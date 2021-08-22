package com.noh.spring.member.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.noh.spring.common.ConvertAddrToCoordinate;
import com.noh.spring.common.KakaoLoginService;
import com.noh.spring.common.SendEmail;
import com.noh.spring.member.model.service.MemberService;
import com.noh.spring.member.model.vo.FavoriteList;
import com.noh.spring.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Controller
@SessionAttributes({"loginMember"})
@Slf4j
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private KakaoLoginService kakaoLogin;
	
	@Autowired
	private ConvertAddrToCoordinate convert;
	
	@Autowired
	private SendEmail email;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private HashMap<String, Object> info;
	
	// 페이지 이동 //////////////////////////////////
	// 아이디 찾기 페이지로 이동
	@RequestMapping("/member/searchIdPage.do")
	public String moveToSearchId() {
		return "member/searchId";
	}
	
	// 비밀번호 찾기 페이지로 이동
	@RequestMapping("/member/searchPasswordPage.do")
	public String moveToSearchPassword() {
		return "member/searchPassword";
	}
	
	// 회원가입 동의 페이지로 이동
	@RequestMapping("/enroll/enrollPage.do")
	public String moveToEnrollPage() {
		return "/member/enroll";
	}
	
	// 회원가입 정보입력 페이지로 이동
	@RequestMapping("/enroll/enrollInfoPage.do")
	public String mobeToEnrollInfoPage() {
		return "/member/enrollInfo";
	}
	///////////////////////////////////////////////
	
	
	// 기능 ////////////////////////////////////////
	// 회원가입 등록
	@RequestMapping("/enroll/enrollMember.do")
	public String enrollMember(Model model, Member member) {
		// 패스워드 암호화처리
		member.setPassword(passwordEncoder.encode(member.getPassword()));
		// 성별 값 변환
		if(member.getGender().equals("1") || member.getGender().equals("3")) member.setGender("M");
		else member.setGender("F");
		
		// 입력받은 주소값 -> 위도, 경도값 반환
		HashMap<String, String> coodinate = convert.getCoordinate(member.getAddress());
		member.setLocationLat(coodinate.get("latitude"));
		member.setLocationLng(coodinate.get("longitude"));
		
		// 회원등록 결과값 반환
		int result = service.enrollMember(member);
		
		// 회원등록 성공 시 리워드 0 등록
		info.put("id", member.getId());
		info.put("stars", 0);
		if(result > 0) service.addRewardsInfo(info);
		
		// 등록 여부 전송
		model.addAttribute("msg", result>0?"등록 성공":"등록 실패");
		model.addAttribute("loc", "/");
		return "common/msg";
	}
	
	// 아이디 확인
	@RequestMapping("/enroll/confirmIdDuplication.do")
	@ResponseBody
	public int confirmIdDuplication(@RequestParam("id") String id) {
		int result = service.confirmIdDuplication(id)!=null?1:0;
		return result;
	}
	
	// 전화번호 확인
	@RequestMapping("/enroll/confirmPhoneDuplication.do")
	@ResponseBody
	public int confirmPhoneDuplication(@RequestParam("phone") String phone) {
		int result = service.confirmPhoneDuplication(phone)!=null?1:0;
		return result;
	}
	
	// 이메일 확인
	@RequestMapping("/enroll/confirmEmailDuplication.do")
	@ResponseBody
	public int confirmEmailDuplication(@RequestParam("email") String email) {
		int result = service.confirmEmailDuplication(email)!=null?1:0;
		return result;
	}
	
	// 아이디 찾기
	@RequestMapping("/member/searchId.do")
	public void searchId(HttpServletResponse response, Member member) throws Exception {
		// 회원 정보가 있는지 확인 -> 아이디 값 반환
		String resultId = service.searchId(member);
		// JSON 설정
		JSONObject json = new JSONObject();
		// JSON 및 Gson 사용해서 데이터 반환
		json.put("result", resultId!=null?1:0);
		json.put("resultId", resultId);
		response.setContentType("application/json;charset=utf-8");
		new Gson().toJson(json, response.getWriter());
	}
	
	// 비밀번호 찾기 - 일치하는 회원정보 확인 및 인증번호 발송
	@RequestMapping("/member/checkInfo.do")
	public void checkInfo(HttpServletResponse response, Member member) throws Exception {
		// 회원 정보 일치하는지 확인
		Member memberInfo = service.checkInfo(member);
		// JSON 설정
		JSONObject json = new JSONObject();
		// 일치하는 회원정보 유무에 따른 반환값 설정
		if(memberInfo != null) {
			String verificationCode = email.getVerificationCode(memberInfo.getName(), memberInfo.getEmail());
			json.put("result", 1);
			json.put("verificationCode", verificationCode);
		} else {
			json.put("result", 0);
		}
		response.setContentType("application/json;charset=utf-8");
		new Gson().toJson(json, response.getWriter());
	}
	
	// 비밀번호 변경
	@RequestMapping("/member/changePassword.do")
	public void changePassword(HttpServletResponse response, Member member) throws Exception {
		// 비밀번호 암호화
		member.setPassword(passwordEncoder.encode(member.getPassword()));
		// JSON 설정
		JSONObject json = new JSONObject();
		// DB에 반영
		json.put("result", service.changePassword(member));
		// ajax 요청 값 반환
		response.setContentType("application/json;charset=utf-8");
		new Gson().toJson(json, response.getWriter());
	}
	
	// 로그인
	@RequestMapping("/member/login.do")
	public String login(Member member, Model model, SessionStatus sessionStatus, HttpServletRequest request) {
		// 회원정보 확인
		Member loginMember = service.login(member);
		// 비밀번호 일치여부 확인
		if(loginMember != null) {
			if(passwordEncoder.matches(member.getPassword(), loginMember.getPassword())) {
				// 리워드 정보 설정
				int stars = service.getRewardsInfo(loginMember.getId());
				if(stars < 5) info.put("membership", "welcome");
				else if(stars < 30) info.put("membership", "green");
				else info.put("membership", "gold");
				
				info.put("id", loginMember.getId());
				info.put("stars", stars);
				int result = service.setRewardsInfoToMember(info);
				if(result > 0) loginMember.setStars(stars);
				
				// 로그인 설정
				String button = "home";
				model.addAttribute("msg", "none");
				model.addAttribute("loc", "/navigation/" + button + ".do");
				model.addAttribute("button", button);
				model.addAttribute("loginMember", loginMember);
				return "common/msg";
			} else {
				sessionStatus.setComplete();
				model.addAttribute("msg", "다시 시도해주세요.");
				model.addAttribute("loc", "/");
				return "common/msg";
			}
		} else {
			sessionStatus.setComplete();
			model.addAttribute("msg", "다시 시도해주세요.");
			model.addAttribute("loc", "/");
			return "common/msg";
		}
	}
	
	// 카카오 로그인
	@RequestMapping(value="/member/kakaoLogin.do", method=RequestMethod.GET)
	public String kakaoLogin(@RequestParam(value="code", required=false) String code, Model model) {
		// accessToken을 가져옴
		String accessToken = kakaoLogin.getAccessToken(code);
		// 사용자 kakaoId 정보를 가져옴
		String email = kakaoLogin.getUserInfo(accessToken);
		model.addAttribute("email", email);
		// kakaoId 정보가 DB에 있으면 로그인 or 없으면 추가
		Member member = service.checkKakaoId(email);
		
		if(member != null) {
			// 리워드 정보 설정
			int stars = service.getRewardsInfo(member.getId());
			if(stars < 5) info.put("membership", "welcome");
			else if(stars < 30) info.put("membership", "green");
			else info.put("membership", "gold");
			
			info.put("id", member.getId());
			info.put("stars", stars);
			int result = service.setRewardsInfoToMember(info);
			if(result > 0) member.setStars(stars);
			
			String button = "home";
			model.addAttribute("msg", "none");
			model.addAttribute("loc", "/navigation/" + button + ".do");
			model.addAttribute("button", button);
			model.addAttribute("loginMember", member);
			return "common/msg";
		} else {
			return "member/enrollInfo";
		}
	}
	
	// 로그아웃
	@RequestMapping("/member/logout.do")
	public String logout(SessionStatus sessionStatus, HttpSession session) {
		session.invalidate();
		if(!sessionStatus.isComplete()) sessionStatus.setComplete();
		return "index";
	}
	///////////////////////////////////////////////
	
	// 회원탈퇴
	@RequestMapping("/member/deleteMember.do")
	public String deleteMember(SessionStatus sessionStatus, HttpServletRequest request, Model model) {
		Member member = (Member)request.getSession().getAttribute("loginMember");
		
		int result = 0;
		// 회원정보 확인 후 탈퇴 진행
		if(member != null) result = service.deleteMember(member);
		else model.addAttribute("msg", "회원탈퇴 실패");
		
		// 회원탈퇴 DB반영 여부 확인
		if(result > 0) {
			if(!sessionStatus.isComplete()) sessionStatus.setComplete();
			model.addAttribute("msg", "회원탈퇴 성공");
		}
		else model.addAttribute("msg", "회원탈퇴 실패");
		
		model.addAttribute("loc", "/");
		return "common/msg";
	}
	
	// 좋아하는 메뉴 리스트 조회
	@RequestMapping("/favorite/getFavoriteList.do")
	@ResponseBody
	public ModelAndView newProductList(ModelAndView mv, HttpSession session){
		String id = ((Member)session.getAttribute("loginMember")).getId();
		List<FavoriteList> favoriteList = service.getFavoriteList(id);
		mv.addObject("favoriteList", favoriteList);
		mv.setViewName("home/sub/favorite");
		return mv;
	}
	
	// 좋아하는 메뉴 추가
	@RequestMapping("/favorite/addToFavoriteList.do")
	@ResponseBody
	public int addToFavoriteList(
			@RequestParam("productId") String productId,
			HttpSession session
			) {
		String id = ((Member)session.getAttribute("loginMember")).getId();
		
		HashMap<String, String> info = new HashMap<String, String>();
		info.put("id", id);
		info.put("productId", productId);
		
		return service.addToFavoriteList(info);
	}
	
	// 좋아하는 메뉴 삭제
	@RequestMapping("/favorite/removeFromFavoriteList.do")
	@ResponseBody
	public int removeFromFavoriteList(
			@RequestParam("productId") String productId,
			HttpSession session
			) {
		String id = ((Member)session.getAttribute("loginMember")).getId();
		
		HashMap<String, String> info = new HashMap<String, String>();
		info.put("id", id);
		info.put("productId", productId);
		
		return service.removeFromFavoriteList(info);
	}
	
	// 리워드 확인
	@RequestMapping("/member/getRewardsInfo")
	@ResponseBody
	public ModelAndView getRewardsInfo(
			ModelAndView mv
			) {
		
		mv.setViewName("/");
		return mv;
	}
}
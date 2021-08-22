package com.noh.spring.store.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.noh.spring.member.model.vo.Member;
import com.noh.spring.store.model.service.StoreService;
import com.noh.spring.store.model.vo.Store;

import lombok.extern.slf4j.Slf4j;

@Controller
@SessionAttributes({"selectedStore"})
@Slf4j
public class StoreController {
	
	
	@Autowired
	private StoreService service;

	// 스토어 선택 페이지 이동
	@RequestMapping("/store/orderLocation.do")
	public String orderLocation(Model model) {
		model.addAttribute("button", "order");
		return "order/orderLocation";
	}
	
	// 스토어 검색에서 -> 지도 검색으로 변환
	@RequestMapping("/store/orderLocationMapPage.do")
	@ResponseBody
	public ModelAndView orderLocationMap(ModelAndView mv) {
//		@ResponsBody로 ModelAndView 가능
//		requestDispatcher().forward 가능
		
//		request.getRequestDispatcher("/WEB-INF/views/order/orderLocationMap.jsp").forward(request, response);
		mv.setViewName("order/orderLocationMap");
		return mv;
	}
	
	// 스토어 리스트 
	// page 처리
	// type : default, dt, reserve
	// keyword
	@RequestMapping("/store/orderLocationMenu.do")
	public ModelAndView orderLocationMenu(
			@RequestParam(value="page", defaultValue="1") int page,
			@RequestParam(value="type", defaultValue="all") String type,
			@RequestParam(value="keyword", required=false) String keyword,
			HttpServletRequest request,
			ModelAndView mv
			) {
		Member loginMember = (Member)request.getSession().getAttribute("loginMember");
		int linePerPage = 10;
		
		HashMap<String, String> storeInfo = new HashMap<String, String>();
		storeInfo.put("latitude", loginMember.getLocationLat());
		storeInfo.put("longitude", loginMember.getLocationLng());
		storeInfo.put("type", type);
		storeInfo.put("keyword", keyword);
		storeInfo.put("isMap", "false");
		
		List<Store> storeList = service.getStoreList(page, linePerPage, storeInfo);
		log.debug("page : {}", page);
		
		mv.addObject("storeList", storeList);
		mv.addObject("button", "order");
		mv.setViewName("order/orderLocationMenu");
		return mv;
	}
	
	// 스토어 리스트 - map용
	@RequestMapping("/store/orderLocationMap.do")
	@ResponseBody
	public List<Store> orderLocationMap(
			@RequestParam(value="page", defaultValue="1") int page,
			@RequestParam(value="type", defaultValue="all") String type,
			@RequestParam(value="keyword", required=false) String keyword,
			HttpServletRequest request
			){
		Member loginMember = (Member)request.getSession().getAttribute("loginMember");
		int linePerPage = 10;
		
		HashMap<String, String> storeInfo = new HashMap<String, String>();
		storeInfo.put("latitude", loginMember.getLocationLat());
		storeInfo.put("longitude", loginMember.getLocationLng());
		storeInfo.put("type", type);
		storeInfo.put("keyword", keyword);
		storeInfo.put("isMap", "true");
		
		List<Store> storeList = service.getStoreList(page, linePerPage, storeInfo);
		return storeList;
	}
	
	// 스토어 리스트 - 중심좌표로 이동해서 다시 요청
	@RequestMapping("/store/orderLocationMapCenter.do")
	@ResponseBody
	public List<Store> orderLocationMapCenter(
			@RequestParam(value="page", defaultValue="1") int page,
			@RequestParam(value="type", defaultValue="all") String type,
			@RequestParam(value="keyword", required=false) String keyword,
			@RequestParam(value="latitude") String latitude,
			@RequestParam(value="longitude") String longitude,
			HttpServletRequest request
			){
		int linePerPage = 10;
		
		HashMap<String, String> storeInfo = new HashMap<String, String>();
		storeInfo.put("latitude", latitude);
		storeInfo.put("longitude", longitude);
		storeInfo.put("type", type);
		storeInfo.put("keyword", keyword);
		storeInfo.put("isMap", "true");
		
		List<Store> storeList = service.getStoreList(page, linePerPage, storeInfo);
		return storeList;
	}
	
	// 가게 정보
	@RequestMapping("/store/storeInfo.do")
	@ResponseBody
	public Store storeInfo(
			@RequestParam("store") String store,
			Model model
			) {
		Store storeInfo = service.getStoreInfo(store);
		model.addAttribute("selectedStore", storeInfo);
		return storeInfo;
	}
}

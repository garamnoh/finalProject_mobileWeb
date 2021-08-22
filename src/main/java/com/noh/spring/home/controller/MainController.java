package com.noh.spring.home.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.noh.spring.home.model.service.HomeService;
import com.noh.spring.order.model.vo.Product;

@Controller
public class MainController {

	@Autowired
	private HomeService service;
	
	// 새로 나온 메뉴 리스트
	@RequestMapping("/home/newProductList.do")
	@ResponseBody
	public ModelAndView newProductList(ModelAndView mv){
		List<Product> newProductList = service.newProductList();
		mv.addObject("newProductList", newProductList);
		mv.setViewName("home/sub/newProduct");
		return mv;
	}
}

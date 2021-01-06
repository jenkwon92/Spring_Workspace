package com.koreait.petshop.controller.product;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ProductController {
	
	//목록 폼
	@RequestMapping(value="/admin/product/list", method=RequestMethod.GET )
	public String getProductList() {
		return "admin/product/product_list";
	}
	
	//등록 폼
	@RequestMapping(value="/admin/product/registform")
	public String registForm() {
		return "admin/product/regist_form";
	}
}

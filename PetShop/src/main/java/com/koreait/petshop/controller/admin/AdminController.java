package com.koreait.petshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {
	@RequestMapping("/admin")
	public String adminMain () {
		return "admin/main";
	}
	
	@RequestMapping("/admin/contact")
	public String adminContact() {
		return "admin/contact/contact_list";
	}
}

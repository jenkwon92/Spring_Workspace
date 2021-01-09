package com.koreait.petshop.controller.member;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.petshop.model.domain.Member;

@Controller
public class MemberController {
	private static final Logger logger=LoggerFactory.getLogger(MemberController.class);
	//회원가입 폼 
	@RequestMapping(value="/shop/member/registForm", method=RequestMethod.GET)
	public String getRegistForm() {
		return "/shop/member/regist_form";
	}
	
	//회원가입 요청처리
	@RequestMapping(value="/shop/member/regist", method=RequestMethod.POST)
	public ModelAndView regist(Member member) {
		logger.debug("아이디"+member.getUser_id());
		logger.debug("이름"+member.getName());
		logger.debug("비밀번호"+member.getPassword());
		logger.debug("이메일"+member.getEmail_id());
		logger.debug("이메일서버"+member.getEmail_server());
		logger.debug("우편번호"+member.getZipcode());
		logger.debug("주소"+member.getAddr());
		logger.debug("날짜"+member.getRegdate());
		return null;
	}
}

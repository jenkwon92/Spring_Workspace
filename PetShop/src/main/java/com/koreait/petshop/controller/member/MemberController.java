package com.koreait.petshop.controller.member;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.petshop.exception.MailSendException;
import com.koreait.petshop.exception.MemberRegistException;
import com.koreait.petshop.model.domain.Member;
import com.koreait.petshop.model.member.service.MemberService;

@Controller
public class MemberController {
	private static final Logger logger=LoggerFactory.getLogger(MemberController.class);
	@Autowired
	private MemberService memberService;
	
	//회원가입 폼 
	@RequestMapping(value="/shop/member/registForm", method=RequestMethod.GET)
	public String getRegistForm() {
		return "/shop/member/signup";
	}
	
	//회원 감사 폼
	@RequestMapping(value="/shop/member/thanksForm")
	public String getThanksForm() {
		return "/shop/member/thanks";
	}
	
	//로그인 폼
	@GetMapping("/shop/member/loginForm")
	public String getLoinForm() {
		return "/shop/member/signin";
	}
	
	
	
	//아이디 중복 검사
	@RequestMapping(value ="/shop/member/memberIdChk", method = RequestMethod.POST)
	@ResponseBody
	public String memberIdChkPost(String user_id) throws Exception{
			//logger.debug("memberIdChk() 진입");
		int result= memberService.duplicateCheck(user_id);
		//logger.debug("결과 값:"+result);
		if(result ==0 ) {
			return "success"; //중복아이디 없음
		}else {
			return "fail"; //중복아이디 있음
		}
	}
	
	//회원가입 요청처리
	@RequestMapping(value="/shop/member/regist", method=RequestMethod.POST, produces="text/html;charset=utf-8")
	@ResponseBody
	public String regist(Member member) {
		logger.debug("아이디"+member.getUser_id());
		logger.debug("이름"+member.getName());
		logger.debug("비밀번호"+member.getPassword());
		logger.debug("이메일"+member.getEmail_id());
		logger.debug("이메일서버"+member.getEmail_server());
		logger.debug("우편번호"+member.getZipcode());
		logger.debug("주소"+member.getAddr());
		
		memberService.regist(member);
		
		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append(" \"result\":1, ");
		sb.append(" \"msg\":\"회원가입 성공\"");
		sb.append("}");
		return sb.toString();
	}
	
	//예외 핸들러 처리 (가입오류)
	@ExceptionHandler(MemberRegistException.class)
	@ResponseBody
	public String handleException(MemberRegistException e) {
		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append(" \"result\":0, ");
		sb.append(" \"msg\":\""+e.getMessage()+"\"");
		//메일 서버 오류 발생으로 인해 회원가입이 진행되지 않고있습니다. 최대한 빨리 복구 진행하도록 하겠습니다. 이용에 불편을 드려서 죄송합니다.
		sb.append("}");
		
		return sb.toString();
	}
	
	//예외 핸들러 처리 (메일 발송 오류)
	@ExceptionHandler(MailSendException.class)
	public ModelAndView handleException(MailSendException e) {
		ModelAndView mav = new ModelAndView();
		//에러페이지 이동
		mav.addObject("msg", e.getMessage()); //사용자가 보게될 에러메시지
		mav.setViewName("shop/error/result");
		
		//시스템 관리자에게 에러알리기
		return mav;
	}
}

package com.koreait.petshop.model.member.service;

import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreait.petshop.exception.MailSendException;
import com.koreait.petshop.exception.MemberRegistException;
import com.koreait.petshop.model.common.MailSender;
import com.koreait.petshop.model.domain.Member;
import com.koreait.petshop.model.member.repository.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDAO memberDAO;
	
	//이메일 발송 객체
	@Autowired
	private MailSender mailSender;
	
	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Member select() {
		// TODO Auto-generated method stub
		return null;
	}

	//회원등록 및 기타필요사항 처리
	public void regist(Member member) throws MemberRegistException, MailSendException{
		memberDAO.insert(member);
		
		String email =member.getEmail_id()+"@"+member.getEmail_server();
		String name=member.getName();
		String user_id= member.getUser_id();
		String regdate = member.getRegdate();
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy년 mm월 dd일");
		
		mailSender.send(email, name+"님, [pet shop] 가입축하드려요", 
				format.format(regdate)+", id : "+user_id+"로 가입하셨습니다. 감사합니다");
		
	}

	@Override
	public void update(Member member) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(Member member) {
		// TODO Auto-generated method stub
		
	}

}

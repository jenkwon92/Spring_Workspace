package com.koreait.petshop.model.member.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreait.petshop.exception.MailSendException;
import com.koreait.petshop.exception.MemberDeleteException;
import com.koreait.petshop.exception.MemberEditException;
import com.koreait.petshop.exception.MemberNotFoundException;
import com.koreait.petshop.exception.MemberPasswordFailException;
import com.koreait.petshop.exception.MemberRegistException;
import com.koreait.petshop.model.common.MailSender;
import com.koreait.petshop.model.common.SecureManager;
import com.koreait.petshop.model.domain.Member;
import com.koreait.petshop.model.member.repository.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDAO memberDAO;
	
	//이메일 발송 객체
	@Autowired
	private MailSender mailSender;
	
	//암호화 객체 
	@Autowired
	private SecureManager secureManager;
	
//Shop 관련 영역	
	//회원등록 및 기타필요사항 처리
	public void regist(Member member) throws MemberRegistException, MailSendException{
		//비밀번호 암호화 처리 
		String secureData = secureManager.getSecureData(member.getPassword());
		member.setPassword(secureData); //변환시켜 다시 VO 에 대입
		
		memberDAO.insert(member);
		
		String email =member.getEmail_id()+"@"+member.getEmail_server();
		String name=member.getName();
		String user_id= member.getUser_id();
		
		Date today = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy년 MM월 dd일");
	
		mailSender.send(email, name+"님, [pet shop] 가입축하드려요", 
				format.format(today)+"<br> ID : "+user_id+"로 가입하셨습니다. <br> 감사합니다");
	}
	
	//아이디 중복검사
	public int duplicateCheck(String user_id) {
		int result = memberDAO.duplicateCheck(user_id);
		if(result == 0) {
			return 0;
		}else {
			return 1;
		}
	}
		
	//회원 로그인
	public Member select(Member member) throws MemberNotFoundException{
		//비번 해시값으로 변환하여 메서드호출
		String hash =secureManager.getSecureData(member.getPassword());
		member.setPassword(hash); //VO에 해시값 대입
		Member obj = memberDAO.select(member);
		return obj;
	}

	//회원 정보수정
	public void update(Member member) throws MemberEditException{
		String hash =secureManager.getSecureData(member.getPassword());
		member.setPassword(hash); //VO에 해시값 대입
		memberDAO.update(member);
	}
	

	//회원탈퇴
	public void delete(Member member) throws MemberDeleteException{
		String hash =secureManager.getSecureData(member.getPassword());
		
		memberDAO.delete(member);
	}
	
//Admin관련 영역
	//회원 목록 
	public List selectAll() {
		return memberDAO.selectAll();
	}
}

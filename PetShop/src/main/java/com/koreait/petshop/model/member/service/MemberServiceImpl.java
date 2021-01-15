package com.koreait.petshop.model.member.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreait.petshop.exception.MailSendException;
import com.koreait.petshop.exception.MemberDeleteException;
import com.koreait.petshop.exception.MemberEditException;
import com.koreait.petshop.exception.MemberNotFoundException;
import com.koreait.petshop.exception.MemberRegistException;
import com.koreait.petshop.model.common.MailSender;
import com.koreait.petshop.model.common.RandomNumber;
import com.koreait.petshop.model.common.SecureManager;
import com.koreait.petshop.model.domain.Member;
import com.koreait.petshop.model.member.repository.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService{
	private static final Logger logger=LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Autowired
	private MemberDAO memberDAO;
	
	//이메일 발송 객체
	@Autowired
	private MailSender mailSender;
	
	//난수 생성기 객체
	@Autowired
	private RandomNumber randomNumber;
	
	//암호화 객체 
	@Autowired
	private SecureManager secureManager;
	
/****************************************************************************
 	Shop관련 영역
 *****************************************************************************/
	//아이디 중복검사
	public int duplicateCheck(String user_id) {
		int result = memberDAO.duplicateCheck(user_id);
		if(result == 0) {
			return 0;
		}else {
			return 1;
		}
	}
	
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
	
	//회원 로그인
	public Member select(Member member) throws MemberNotFoundException{
		//비번 해시값으로 변환하여 메서드호출
		String hash =secureManager.getSecureData(member.getPassword());
		member.setPassword(hash); //VO에 해시값 대입
		Member obj = memberDAO.select(member);
		return obj;
	}

	//회원아이디찾기
	public ArrayList<String> forgot_id(Member member) throws MemberNotFoundException{
		logger.info("forgot_id 서비스 진입");
		List<Member> list = memberDAO.forgot_id(member);
		ArrayList<String> forgot_id = new ArrayList<String>();  
		for(int i =0; i <list.size(); i ++) {
			String user_id = list.get(i).getUser_id();
			forgot_id.add(user_id);
		}
		return forgot_id;
	}
	
	// 회원비밀번호 찾기이메일 발송
	public void forgot_pwd(Member member) throws MemberNotFoundException{
		// 비밀번호는 6자리로 보내고 데이터베이스 비밀번호를 바꿔준다
		String key = randomNumber.getKey(false, 6);
		
		String user_id = member.getUser_id();
		String email =member.getEmail_id()+"@"+member.getEmail_server();
		String htmlStr = "<h2>안녕하세요 '"+ user_id +"' 님</h2><br><br>" 
				+ "<p>임시로 발급 드린 비밀번호는 <span style='color : blue; font-size:15px'>[" + key +"]</span>이며, 로그인 후 마이페이지에서 비밀번호를 변경해주시면 됩니다.</p><br>"
				+ "<h4><a href='http://localhost:8888/shop/member/loginForm'> 로그인페이지 바로가기</a></h4><br><br>";
	
		 mailSender.send(email, user_id+"님, 임시비밀번호 발급이메일입니다", htmlStr);
		 logger.debug("key값은?" +key);
		// 비밀번호 암호화해주는 메서드
		 String password = secureManager.getSecureData(key);
		logger.debug("암호화된값은?"+password);

		member.setPassword(password);
		// 데이터 베이스 값은 암호한 값으로 저장시킨다.
		memberDAO.forgot_pwd(member);
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
		member.setPassword(hash); //VO에 해시값 대입
		memberDAO.delete(member);
	}
	
/****************************************************************************
 	Admin 관련 영역
 *****************************************************************************/
	//회원 목록 
	public List selectAll() {
		return memberDAO.selectAll();
	}

}

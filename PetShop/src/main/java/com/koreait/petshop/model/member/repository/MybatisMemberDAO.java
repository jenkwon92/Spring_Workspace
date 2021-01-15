package com.koreait.petshop.model.member.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.petshop.exception.MemberDeleteException;
import com.koreait.petshop.exception.MemberEditException;
import com.koreait.petshop.exception.MemberNotFoundException;
import com.koreait.petshop.exception.MemberPasswordFailException;
import com.koreait.petshop.exception.MemberRegistException;
import com.koreait.petshop.model.domain.Member;

@Repository
public class MybatisMemberDAO implements MemberDAO{
	private static final Logger logger=LoggerFactory.getLogger(MybatisMemberDAO.class);
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
/****************************************************************************
 	Shop관련 영역
 *****************************************************************************/
	//아이디 중복 체크
	public int duplicateCheck(String user_id) {
		int result = sqlSessionTemplate.selectOne("Member.duplicateCheck", user_id);
		return result;
	}
	
	//회원 가입
	public void insert(Member member) throws MemberRegistException{
		int result = sqlSessionTemplate.insert("Member.insert", member);
		if(result==0) {
			throw new MemberRegistException("회원가입에 실패하였습니다.");
		} 
	}
	
	//로그인 검증
	public Member select(Member member) throws MemberNotFoundException{
		Member obj = sqlSessionTemplate.selectOne("Member.select", member);
		if(obj == null) {//올바르지않은 정보로 로그인
			throw new MemberNotFoundException("로그인 정보가 올바르지 않습니다");
		}
		return obj;
	}
	
	//회원아이디 찾기
	public List forgot_id(Member member) {
		logger.debug("forgot_id DAO 진입");
		logger.debug(member.toString());
		return sqlSessionTemplate.selectList("Member.forgot_id" , member);
	}
	
	//회원비밀번호 찾기
	public void forgot_pwd(Member member) throws MemberNotFoundException{
		logger.debug("forgot_pwd DAO 진입");
		int result =  sqlSessionTemplate.update("Member.forgot_pwd", member);
	}
		
	
	//회원수정
	public void update(Member member) throws MemberEditException{
		int result = sqlSessionTemplate.update("Member.update", member);
	}
		
	//회원탈퇴
	public void delete(Member member) throws MemberDeleteException{
		int result = sqlSessionTemplate.delete("Member.delete", member);
		
	}
	

/****************************************************************************
 	Admin 관련 영역
 *****************************************************************************/
	//회원 목록 가져오기
	public List selectAll() {
		return sqlSessionTemplate.selectList("Member.selectAll");
	}


}

package com.koreait.petshop.model.member.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.petshop.exception.MemberNotFoundException;
import com.koreait.petshop.exception.MemberRegistException;
import com.koreait.petshop.model.domain.Member;

@Repository
public class MybatisMemberDAO implements MemberDAO{
	private static final Logger logger=LoggerFactory.getLogger(MybatisMemberDAO.class);
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	//로그인 검증
	public Member select(Member member) throws MemberNotFoundException{
		Member obj = sqlSessionTemplate.selectOne("Member.select", member);
		if(obj == null) {//올바르지않은 정보로 로그인
			throw new MemberNotFoundException("로그인 정보가 올바르지 않습니다");
		}
		return obj;
	}

	//회원 가입
	public void insert(Member member) throws MemberRegistException{
		int result = sqlSessionTemplate.insert("Member.insert", member);
		if(result==0) {
			throw new MemberRegistException("회원가입에 실패하였습니다.");
		} 
	}

	@Override
	public void update(Member member) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(Member member) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int duplicateCheck(String user_id) {
		int result = sqlSessionTemplate.selectOne("Member.duplicateCheck", user_id);
		return result;
	}
}

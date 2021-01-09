package com.koreait.petshop.model.member.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.petshop.exception.MemberRegistException;
import com.koreait.petshop.model.domain.Member;

@Repository
public class MybatisMemberDAO implements MemberDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
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
		List list = sqlSessionTemplate.selectList("Member.duplicateCheck", user_id);
		int result =list.size();
		return result;
	}


//	@Override
//	public void duplicateCheck(String user_id) {
//		List list = sqlSessionTemplate.selectList("Member.duplicateCheck", user_id);
//		if(list.size()>0) { // 아이디 중복
//			throw new MemberRegistException("이미 사용중인 아이디입니다.");
//		}
//	}


}

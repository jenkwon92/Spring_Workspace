package com.koreait.petshop.model.member.repository;

import java.util.List;

import com.koreait.petshop.model.domain.Member;

public interface MemberDAO {
	public List selectAll(); //모든 회원가져오기
	public Member select();//회원 1명 가져오기
}

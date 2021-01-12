package com.koreait.petshop.model.member.repository;

import java.util.List;

import com.koreait.petshop.model.domain.Member;

public interface MemberDAO {
	public List selectAll(); //모든 회원가져오기
	public Member select(Member member);//회원 1명 가져오기
	public void insert(Member member); //회원등록
	public void update(Member member); //회원수정
	public void delete(Member member); //회원삭제
	
	public int duplicateCheck(String user_id); //중복여부 체크
}

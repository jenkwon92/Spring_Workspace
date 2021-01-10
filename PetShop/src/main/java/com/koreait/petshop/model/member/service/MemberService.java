package com.koreait.petshop.model.member.service;

import java.util.List;

import com.koreait.petshop.model.domain.Member;

public interface MemberService {
	public List selectAll(); //모든 회원가져오기
	public Member select(Member member);//회원 1명 가져오기
	public void regist(Member member); //회원등록 및 기타필요사항 처리
	public void update(Member member); //회원수정
	public void delete(Member member); //회원삭제
	
	public int duplicateCheck(String user_id);
}

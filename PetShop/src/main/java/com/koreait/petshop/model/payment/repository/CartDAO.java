package com.koreait.petshop.model.payment.repository;

import java.util.List;

import com.koreait.petshop.model.domain.Cart;
import com.koreait.petshop.model.domain.Member;

public interface CartDAO {
	public List selectAll();//회원 구분없이 모든 데이터 가져오기 
	public List selectAll(int member_id);//특정 회원의 장바구니 내역
	public Cart select(int cart_id);
	public void duplicateCheck(Cart cart);//장바구니 중복상품 여부체크 
	public void insert(Cart cart);
	public void update(Cart cart);
	public void delete(Cart cart); //pk를 이용한 삭제 
	public void delete(Member member);//회원 id에 속한 데이터 삭제
}
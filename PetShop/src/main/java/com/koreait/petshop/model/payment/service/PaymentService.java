package com.koreait.petshop.model.payment.service;
import java.util.List;

import com.koreait.petshop.model.domain.Cart;
import com.koreait.petshop.model.domain.Member;
import com.koreait.petshop.model.domain.OrderDetail;
import com.koreait.petshop.model.domain.OrderSummary;
import com.koreait.petshop.model.domain.Product;
import com.koreait.petshop.model.domain.Receiver;
import com.koreait.petshop.model.domain.SubCategory;

//장바구니 관련 업무 
public interface PaymentService {
	//장바구니 관련 업무
	public List selectCartList();// 모든카트 
	public List selectCartList(int member_id);//특정 회원 장바구니 내역 조회
	public Cart selectCart(int cart_id);
	public void insert(Cart cart); // 카트 삽입 
	public void update(List<Cart> cartList); //일괄 수정
	public void delete(Cart cart); //pk에 속한 데이터 삭제할예정
	public void delete(Member member); //회원에 속한 데이터 삭제할예정
	
	//결제 업무
	public List selectPaymethodList();
	public void registOrder(OrderSummary orderSummary, Receiver receiver,OrderDetail orderDetail,Product product);//트랜잭션 처리
	//등록정보조회하기
}

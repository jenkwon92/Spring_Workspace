package com.koreait.petshop.model.domain;

public class OrderSummary {
	private int order_summeary_id;
	private int member_id;
	private int total_price;
	private String orderdate;
	private int order_state_id;
	private int paymethod_id;
	
	public int getOrder_summeary_id() {
		return order_summeary_id;
	}
	public void setOrder_summeary_id(int order_summeary_id) {
		this.order_summeary_id = order_summeary_id;
	}
	public int getMember_id() {
		return member_id;
	}
	public void setMember_id(int member_id) {
		this.member_id = member_id;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	public String getOrderdate() {
		return orderdate;
	}
	public void setOrderdate(String orderdate) {
		this.orderdate = orderdate;
	}
	public int getOrder_state_id() {
		return order_state_id;
	}
	public void setOrder_state_id(int order_state_id) {
		this.order_state_id = order_state_id;
	}
	public int getPaymethod_id() {
		return paymethod_id;
	}
	public void setPaymethod_id(int paymethod_id) {
		this.paymethod_id = paymethod_id;
	}
	
	
}
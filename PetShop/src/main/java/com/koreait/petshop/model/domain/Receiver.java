package com.koreait.petshop.model.domain;

import lombok.Data;

public class Receiver {
	private int receiver_id;
	private int order_summary_id;
	private String receiver_name;
	private String receiver_addr;
	private String receiver_phone;
	public int getReceiver_id() {
		return receiver_id;
	}
	public void setReceiver_id(int receiver_id) {
		this.receiver_id = receiver_id;
	}
	public int getOrder_summary_id() {
		return order_summary_id;
	}
	public void setOrder_summary_id(int order_summary_id) {
		this.order_summary_id = order_summary_id;
	}
	public String getReceiver_name() {
		return receiver_name;
	}
	public void setReceiver_name(String receiver_name) {
		this.receiver_name = receiver_name;
	}
	public String getReceiver_addr() {
		return receiver_addr;
	}
	public void setReceiver_addr(String receiver_addr) {
		this.receiver_addr = receiver_addr;
	}
	public String getReceiver_phone() {
		return receiver_phone;
	}
	public void setReceiver_phone(String receiver_phone) {
		this.receiver_phone = receiver_phone;
	}


}
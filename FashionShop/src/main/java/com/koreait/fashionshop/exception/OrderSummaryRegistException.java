package com.koreait.fashionshop.exception;

//CRUD 작업시 발생되는 예외
public class OrderSummaryRegistException extends RuntimeException{
	
	public OrderSummaryRegistException(String msg) {
		super(msg);
	}
	public OrderSummaryRegistException(String msg, Throwable e) {
		super(msg, e);
	}
}

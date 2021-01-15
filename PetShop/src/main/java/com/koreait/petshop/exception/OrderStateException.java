package com.koreait.petshop.exception;

public class OrderStateException extends RuntimeException{
	public OrderStateException(String msg) {
		super(msg);
	}
	public OrderStateException(String msg,Throwable e) {
		super(msg,e);
	}
}
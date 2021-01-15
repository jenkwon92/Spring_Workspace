package com.koreait.petshop.exception;

public class OrderDetailException extends RuntimeException{
	public OrderDetailException(String msg) {
		super(msg);
	}
	public OrderDetailException(String msg,Throwable e) {
		super(msg,e);
	}
}
package com.koreait.petshop.exception;

public class MemberRegistException extends RuntimeException{
	
	public MemberRegistException(String msg) {
		super(msg);
	}
	public MemberRegistException(String msg, Throwable e) {
		super(msg, e);
	}
}

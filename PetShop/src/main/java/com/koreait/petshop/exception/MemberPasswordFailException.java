package com.koreait.petshop.exception;

public class MemberPasswordFailException extends RuntimeException{
	
	public MemberPasswordFailException(String msg) {
		super(msg);
	}
	public MemberPasswordFailException(String msg, Throwable e) {
		super(msg, e);
	}
}

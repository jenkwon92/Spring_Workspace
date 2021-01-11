package com.koreait.petshop.exception;

public class MemberDeleteException extends RuntimeException{
	
	public MemberDeleteException(String msg) {
		super(msg);
	}
	public MemberDeleteException(String msg, Throwable e) {
		super(msg, e);
	}
}

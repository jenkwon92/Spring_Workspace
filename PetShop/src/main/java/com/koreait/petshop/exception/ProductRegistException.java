package com.koreait.petshop.exception;


//CRUD작업시 발생되는 예외 
//등록시 예외 exception
public class ProductRegistException extends RuntimeException{

	public ProductRegistException(String msg) {
		super(msg);
		
	}
	
	public ProductRegistException(String msg, Throwable e) {
		super(msg, e);
	}
}
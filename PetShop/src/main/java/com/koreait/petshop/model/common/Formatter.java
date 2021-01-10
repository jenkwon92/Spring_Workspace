package com.koreait.petshop.model.common;

import java.text.DecimalFormat;
import java.util.Currency;
import java.util.Locale;

//날짜 , 통화 등 자주 사용하는 표기에 대한 처리
public class Formatter {

	
	//숫자를 해당시스템의 통화로 반환하여 변환하는 메서드
	public static String getCurrency(long number) {//3자리 마다 쉼표 처리
		String currency = Currency.getInstance(Locale.KOREA).getSymbol();//해당 국의 통화 반환
		DecimalFormat df = new DecimalFormat("###,###.###");
																				//234,345.222
		String result = currency+df.format(number);
		return result;
	}
	

}
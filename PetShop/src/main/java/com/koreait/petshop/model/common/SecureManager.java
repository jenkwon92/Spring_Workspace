package com.koreait.petshop.model.common;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.stereotype.Component;

//비밀번호 암호화 (SHA256)
@Component
public class SecureManager {
	public String getSecureData(String password) {
		
		StringBuffer sb = new StringBuffer(); //문자열 누적시킬 객체 
		
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte [] data = password.getBytes("UTF-8"); //바이트 배열로 쪼개기
			byte [] hash = digest.digest(data); //암호화
			
			//쪼개진 데이터를 대상으로 16진수값으로 변환하여 문자열로 변환
			for(int i=0; i<hash.length; i++) {
				String hex = Integer.toHexString(0xff&hash[i]);
				
				if(hex.length()==1) {					
					sb.append("0");
				}
				sb.append(hex);
			}
			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 
		
		return sb.toString();
	}
	public static void main(String[] args) {
		String result =new SecureManager().getSecureData("bananaking");
		System.out.println(result);
	}
}

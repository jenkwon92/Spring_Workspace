package com.koreait.fashionshop.model.bank.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.koreait.fashionshop.exception.DepositFailException;
import com.koreait.fashionshop.exception.WithdrawFailException;

@Repository
public class JdbcSbankDAO implements SbankDAO {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	//입금
	public void deposit(int money) throws DepositFailException{
		int result = jdbcTemplate.update("INSERT INTO sbank(sbank_id, total) VALUES (seq_sbank.nextval, ?)" ,money);
		result =0; //일부러 실패로 처리
		if(result == 0) {
			throw new DepositFailException("Sorry, Deposit fail");
		}
	}
}

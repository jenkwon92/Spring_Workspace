package com.koreait.petshop.model.payment.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.petshop.exception.OrderSummaryException;
import com.koreait.petshop.model.domain.OrderSummary;

@Repository
public class MybatisOrderSummaryDAO implements OrderSummaryDAO {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	@Override
	public void insert(OrderSummary orderSummary) throws OrderSummaryException {
		int result = sqlSessionTemplate.insert("OrderSummary.insert", orderSummary);
		if (result == 0) {
			throw new OrderSummaryException("ÁÖ¹®¿ä¾à ½ÇÆÐ!");
		}
	}
}
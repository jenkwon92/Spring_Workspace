 package com.koreait.petshop.model.payment.repository;

import com.koreait.petshop.model.domain.OrderSummary;

public interface OrderSummaryDAO {

	public void insert(OrderSummary orderSummary);
}
package com.koreait.petshop.model.payment.repository;

import com.koreait.petshop.model.domain.OrderDetail;

public interface OrderDetailDAO {
	public void insert(OrderDetail orderDetail);
}
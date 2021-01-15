package com.koreait.petshop.model.payment.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.petshop.exception.OrderDetailException;
import com.koreait.petshop.model.domain.OrderDetail;

@Repository
public class MybatisOrderDetailDAO implements OrderDetailDAO {

	@Autowired
	private SqlSessionTemplate SqlSessionTemplate;

	@Override
	public void insert(OrderDetail orderDetail) throws OrderDetailException {
		int result = SqlSessionTemplate.insert("OrderDetail.insert", orderDetail);
		if (result == 0) {
			throw new OrderDetailException("???¡Æ ??¨ù¨ù?¢´¨¬¢¬ ??¡¤?¨ö?¨¡¨¢");
		}
	}
}
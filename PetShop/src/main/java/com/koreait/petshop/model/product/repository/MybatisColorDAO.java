package com.koreait.petshop.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.petshop.model.domain.Color;

@Repository
public class MybatisColorDAO implements ColorDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List selectAll() {
	
		return null;
	}

	
	public List selectById(int product_id) {
	
		return null;
	}

	
	public Color select(int color_id) {
	
		return null;
	}

	
	public void insert(Color color) {
		int result=sqlSessionTemplate.insert("Color.insert", color);
		
	}

	
	public void update(Color color) {
	
		
	}

	
	public void delete(int color_id) {
			
	} 
	
}
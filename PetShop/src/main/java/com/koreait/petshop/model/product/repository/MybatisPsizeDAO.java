package com.koreait.petshop.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.petshop.exception.ProductRegistException;
import com.koreait.petshop.model.domain.Psize;

@Repository
public class MybatisPsizeDAO implements PsizeDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List selectAll() {
		
		return null;
	}

	
	public List selectById(int product_id) {
	
		return null;
	}

	
	public Psize select(int psize_id) {
	
		return null;
	}

	
	public void insert(Psize psize) throws ProductRegistException{
		int result=sqlSessionTemplate.insert("Psize.insert", psize);
		if(result==0) {
			throw new ProductRegistException("사이즈 등록에 실패했습니다.");
		}
	}

	
	public void update(Psize psize) throws ProductRegistException{
		sqlSessionTemplate.update("Psize.update", psize);
		
	}

	
	public void delete(int product_id) throws ProductRegistException{
		int result = sqlSessionTemplate.delete("Psize.delete", product_id);
		
	}


}
package com.koreait.petshop.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.petshop.model.domain.Product;

@Repository
public class MybatisProductDAO implements ProductDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("Product.selectAll");
	}

	@Override
	public List selectById(int subcategory_id) {
		return sqlSessionTemplate.selectList("Product.selectById", subcategory_id);
	}

	@Override
	public Product select(int product_id) {
		return sqlSessionTemplate.selectOne("Product.select", product_id);
	}

	public void regist(Product product) {
		sqlSessionTemplate.insert("Product.insert", product);
			
	}

	@Override
	public void update(Product product) {
		sqlSessionTemplate.update("Product.update", product);
		
	}

	@Override
	public void delete(int product_id) {
		sqlSessionTemplate.delete("Product.delete", product_id);
	}

}
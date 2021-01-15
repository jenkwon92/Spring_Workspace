package com.koreait.petshop.model.product.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreait.petshop.model.domain.Image;

@Service
public class ImageServiceImpl implements ImageService{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List selectById(int product_id) {
		return sqlSessionTemplate.selectList("Image.selectByProductId", product_id);
	}

	@Override
	public Image select(int image_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(Image image) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(Image image) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int image_id) {
		// TODO Auto-generated method stub
		
	}

}
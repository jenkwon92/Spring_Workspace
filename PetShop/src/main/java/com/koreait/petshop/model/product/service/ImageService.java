package com.koreait.petshop.model.product.service;

import java.util.List;

import com.koreait.petshop.model.domain.Image;

public interface ImageService {
	public List selectAll();//그냥 모든 이미지
	public List selectById(int product_id);//fk에 소속된 모든 이미지
	public Image select(int image_id);
	public void insert(Image image);
	public void update(Image image);
	public void delete(int image_id);
}
package com.koreait.petshop.model.product.service;

import java.util.List;
import java.util.Map;

import com.koreait.petshop.model.common.FileManager;
import com.koreait.petshop.model.domain.Product;


public interface ProductService {
	public List selectAll();//모든 상품
	public List selectById(int subcategory_id);//subcategory에 등록된 상품
	public Product select(int product_id);//상품 한건
	public void regist(FileManager fileManager, Product product);//insert뿐만 아니라 파일 업로드 처리 
	public void update(Product product);
	public void delete(int product_id);
}
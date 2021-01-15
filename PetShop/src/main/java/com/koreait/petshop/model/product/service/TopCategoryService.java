package com.koreait.petshop.model.product.service;

import java.util.List;

import com.koreait.petshop.model.domain.TopCategory;


public interface TopCategoryService {
	public List selectAll();//모든 상위가져오기
	public TopCategory select(int topcategory_id);//상위레코드 하나 가져오기
	public void insert(TopCategory topcategory);
	public void update(TopCategory topcategory);
	public void delete(int topcategory_id);
	
}
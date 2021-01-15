package com.koreait.petshop.model.product.service;

import java.util.List;

import com.koreait.petshop.model.domain.SubCategory;

public interface SubCategoryService {

	public List selectAll();
	public List selectAllById(int topcategory_id);//상위레코드에 속해있는 하위레코드 전부
	public SubCategory select(int subcategory_id);//하위레코드 한건
	public void insert(SubCategory subCategory);
	public void update(SubCategory subCategory);
	public void delete(int SubCategory_id);
}
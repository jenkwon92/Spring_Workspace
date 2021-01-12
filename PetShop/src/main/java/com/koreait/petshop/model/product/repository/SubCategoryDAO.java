package com.koreait.petshop.model.product.repository;

import java.util.List;

import com.koreait.petshop.model.domain.SubCategory;

public interface SubCategoryDAO {
	public List selectAll();//하위 모두가져오기
	public List selectAllById(int topcategory_id);//상위에 소속된 하위정보 가져오기
	public SubCategory select(int subcategory_id);//하위한건가져오기
	public void insert(SubCategory subCategory);
	public void update(SubCategory subCategory);
	public void delete(int subcategory_id );
}
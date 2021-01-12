package com.koreait.petshop.model.product.repository;

import java.util.List;

import com.koreait.petshop.model.domain.TopCategory;

public interface TopCategoryDAO {
	public List selectAll();//전체 가졍괴
	public TopCategory select(int topcategory_id);//한건 가져오기
	public void insert(TopCategory topcategory);
	public void update(TopCategory topcategory);
	public void delete(int topcategory_id);
}

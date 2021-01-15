package com.koreait.petshop.model.product.repository;

import java.util.List;

import com.koreait.petshop.model.domain.Color;

public interface ColorDAO {
	public List selectAll();
	public List selectById(int product_id); //fkżĄ źŇźÓľČ ¸ńˇĎ °ĄÁŽżŔąâ
	public Color select(int color_id);
	public void insert(Color color);
	public void update(Color color);
	public void delete(int color_id);
	
}
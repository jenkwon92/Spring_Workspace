package com.koreait.petshop.model.domain;

import java.util.List;

import lombok.Data;

public class TopCategory {
	private int topcategory_id;           
	private String name;                               
	private int rank;
	private List<SubCategory> subCategory;//하위카테고리 리스트로 보유하기
	public int getTopcategory_id() {
		return topcategory_id;
	}
	public void setTopcategory_id(int topcategory_id) {
		this.topcategory_id = topcategory_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	public List<SubCategory> getSubCategory() {
		return subCategory;
	}
	public void setSubCategory(List<SubCategory> subCategory) {
		this.subCategory = subCategory;
	}
	
	
}
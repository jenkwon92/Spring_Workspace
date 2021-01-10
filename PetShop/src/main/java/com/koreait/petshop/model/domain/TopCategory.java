package com.koreait.petshop.model.domain;

import java.util.List;

import lombok.Data;

@Data
public class TopCategory {
	private int topcategory_id;           
	private String name;                               
	private int rank;
	private List<SubCategory> subCategory;//하위카테고리 리스트로 보유하기
}
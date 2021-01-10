package com.koreait.petshop.model.domain;

import lombok.Data;

@Data
public class SubCategory {
	private int subcategory_id;
	private int topcategory_id;
	private String name;
}
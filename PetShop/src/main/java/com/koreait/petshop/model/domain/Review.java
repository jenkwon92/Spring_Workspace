package com.koreait.petshop.model.domain;

import lombok.Data;

@Data
public class Review{
	private int review_id;
	private int product_id;
	private int member_id;
	private String reviews;
	private String regdate;
	private Member member;
}
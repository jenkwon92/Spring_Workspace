package com.koreait.petshop.model.domain;

import lombok.Data;

@Data
public class Score {
	private int score_id;
	private int product_id;
	private String star;
}
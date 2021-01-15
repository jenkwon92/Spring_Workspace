package com.koreait.petshop.model.review.repository;

import java.util.List;

import com.koreait.petshop.model.domain.Review;

public interface ReviewDAO {
	public List selectAll(int product_id);
	public Review select(int review_id);
	public void insert(Review review);
	public void delete(int review_id);
	public void update(Review review);

}
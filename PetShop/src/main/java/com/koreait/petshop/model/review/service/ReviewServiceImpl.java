package com.koreait.petshop.model.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreait.petshop.model.domain.Review;
import com.koreait.petshop.model.review.repository.ReviewDAO;

@Service
public class ReviewServiceImpl implements ReviewService{

	@Autowired
	private ReviewDAO reviewDAO;
	
	@Override
	public List selectAll(int product_id) {

		return reviewDAO.selectAll(product_id);
	}

	@Override
	public Review select(int review_id) {

		return reviewDAO.select(review_id);
	}

	@Override
	public void insert(Review review) {
		reviewDAO.insert(review);
		
	}

	@Override
	public void delete(int review_id) {
		reviewDAO.delete(review_id);
		
	}

	@Override
	public void update(Review review) {
		reviewDAO.update(review);
	}

}

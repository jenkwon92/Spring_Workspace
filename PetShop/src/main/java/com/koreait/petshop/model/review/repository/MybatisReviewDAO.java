package com.koreait.petshop.model.review.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.petshop.exception.ReviewException;
import com.koreait.petshop.model.domain.Review;

@Repository
public class MybatisReviewDAO implements ReviewDAO{

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List selectAll(int product_id) {
	
		return sqlSessionTemplate.selectList("Review.selectAll", product_id);
	}

	public Review select(int review_id) {
		return sqlSessionTemplate.selectOne("Review.select", review_id);
	}

	public void insert(Review review) throws ReviewException{
		int result = sqlSessionTemplate.insert("Review.insert", review);
		if(result==0) {
			throw new ReviewException("리뷰 등록에 실패!!");
		}
	}

	@Override
	public void delete(int review_id) throws ReviewException{
		int result = sqlSessionTemplate.delete("Review.delete", review_id);
		if(result ==0) {
			throw new ReviewException("리뷰 삭제 실패");
		}
	}

	@Override
	public void update(Review review) {
		sqlSessionTemplate.update("Review.update", review);		
	}

}
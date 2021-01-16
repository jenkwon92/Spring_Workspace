package com.koreait.petshop.model.product.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.petshop.exception.ProductRegistException;
import com.koreait.petshop.model.domain.Image;

@Repository
public class MybatisImageDAO implements ImageDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List selectAll() {
	
		return null;
	}
	
	
	public List selectById(int product_id) {
		return sqlSessionTemplate.selectList("Image.selectByProductId", product_id);
	}

	
	public Image select(int image_id) {
		return sqlSessionTemplate.selectOne("Image.select",image_id);
	}

	public void insert(Image image) throws ProductRegistException{
		int result=sqlSessionTemplate.insert("Image.insert", image);
		if(result==0) {
			throw new ProductRegistException("이미지 등록에 실패했습니다.");
		}
	}

	
	public void update(int image_id) throws ProductRegistException{
		sqlSessionTemplate.delete("Image.update", image_id);
	}

	@Override
	public void delete(int product_id) throws ProductRegistException{
		int result = sqlSessionTemplate.delete("Image.delete", product_id);
		if(result==0) {
			throw new ProductRegistException("이미지 삭제에 실패했습니다.");
		}
	}
	
}
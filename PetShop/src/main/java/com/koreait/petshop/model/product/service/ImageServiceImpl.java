package com.koreait.petshop.model.product.service;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreait.petshop.model.common.FileManager;
import com.koreait.petshop.model.domain.Image;
import com.koreait.petshop.model.domain.Product;
import com.koreait.petshop.model.product.repository.ImageDAO;

@Service
public class ImageServiceImpl implements ImageService{
	@Autowired
	private ImageDAO imageDAO;
	
	@Override
	public List selectAll() {
		return null;
	}

	@Override
	public List selectById(int product_id) {
		return imageDAO.selectById(product_id);	
	}

	@Override
	public Image select(int image_id) {
		return imageDAO.select(image_id);
	}

	@Override
	public void insert(Image image) {
		
	}

	@Override
	public void update(FileManager fileManager,int image_id) {
		Image image = imageDAO.select(image_id);
		fileManager.delFile(new File(fileManager.getSaveAddonDir()+File.separator+image_id+"."+image.getFilename()));
		imageDAO.update(image_id);
	}

	@Override
	public void delete(FileManager fileManager,Product product) {
		//메인 이미지 삭제
		fileManager.delFile(new File(fileManager.getSaveBasicDir()+File.separator+product.getDelRep()));
		//추가 이미지 삭제
		for(int i=0; i<product.getDelAdd().size();i++) {			
			//System.out.println("삭제할 이미지 : "+product.getDelAdd().get(i));
			fileManager.delFile(new File(fileManager.getSaveAddonDir()+File.separator+product.getDelAdd().get(i)));
		}
		//db삭제
		imageDAO.delete(product.getProduct_id());
	}

}

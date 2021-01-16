  
package com.koreait.petshop.model.product.service;

import java.io.File;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.koreait.petshop.model.common.FileManager;
import com.koreait.petshop.model.domain.Color;
import com.koreait.petshop.model.domain.Image;
import com.koreait.petshop.model.domain.Product;
import com.koreait.petshop.model.domain.Psize;
import com.koreait.petshop.model.product.repository.ColorDAO;
import com.koreait.petshop.model.product.repository.ImageDAO;
import com.koreait.petshop.model.product.repository.ProductDAO;
import com.koreait.petshop.model.product.repository.PsizeDAO;

@Service
public class ProductServiceImpl implements ProductService{
	private static final Logger logger = LoggerFactory.getLogger(ProductServiceImpl.class);
	
	@Autowired
	private ProductDAO productDAO;
	@Autowired
	private ImageDAO imageDAO;
	@Autowired
	private PsizeDAO psizeDAO;
	@Autowired
	private ColorDAO colorDAO;

	@Override
	public List selectAll() {
		return productDAO.selectAll();
	}
	
	@Override
	public List selectById(int subcategory_id) {
		return productDAO.selectById(subcategory_id);
	}
	
	@Override
	public Product select(int product_id) {
		return productDAO.select(product_id);
	}
	
	//등록
	public void regist(FileManager fileManager, Product product) {
		String ext=fileManager.getExtend(product.getRepImg().getOriginalFilename());
		product.setFilename(ext);
		productDAO.regist(product);
		
		String basicImg = product.getProduct_id()+"."+fileManager.getExtend(product.getRepImg().getOriginalFilename());
		fileManager.saveFile(fileManager.getSaveBasicDir()+File.separator+basicImg, product.getRepImg());
		
		//추가이미지 업로드
		for(int i=0; i<product.getAddImg().length; i++) {
			
			MultipartFile file=product.getAddImg()[i];
			ext=fileManager.getExtend(file.getOriginalFilename());
			
			Image image = new Image();
			image.setProduct_id(product.getProduct_id()); //fk
			image.setFilename(ext); //확장자 넣기
			imageDAO.insert(image);
			
			String addImg = image.getImage_id()+"."+fileManager.getExtend(file.getOriginalFilename());
			fileManager.saveFile(fileManager.getSaveAddonDir()+File.separator+addImg, file);
			logger.debug("파일이름 : "+file.getOriginalFilename());
			logger.debug("확장자 : "+ext);
			logger.debug("업로드될 파일이름 : "+addImg);
			logger.debug("업로드 위치 : "+fileManager.getSaveAddonDir());
			logger.debug("저장 결과 : "+fileManager.getSaveAddonDir()+File.separator+addImg);
			
		}
		
		//사이즈
		for(Psize psize : product.getPsize()) {
			logger.debug("선택한 사이즈는 ="+psize.getPetfit());
			psize.setProduct_id(product.getProduct_id());//fk대입
			psizeDAO.insert(psize);
		}
		
		//색상
		for(Color color : product.getColors()) {
			logger.debug("선택한 색상은 ="+color.getPicker());
			color.setProduct_id(product.getProduct_id());
			colorDAO.insert(color);
		}
		
	}
	
	@Override
	public void update(FileManager fileManager,Product product) {
		
		colorDAO.delete(product.getProduct_id());
		psizeDAO.delete(product.getProduct_id()); 
		//사이즈 삭제 후 재등록 
		for(int i=0;i<product.getPsize().length;i++) { 
			Psize psize= product.getPsize()[i];
			psize.setProduct_id(product.getProduct_id()); psizeDAO.insert(psize); 
		} 
		//컬러삭제후 재등록 
		for(int i=0; i<product.getColors().length;i++) { 
			Color color =product.getColors()[i]; color.setProduct_id(product.getProduct_id());
			colorDAO.insert(color); 
		}
		if(product.getAddImg()!=null) {			
			//추가 이미지 재등록
			for(int i=0; i<product.getAddImg().length;i++) {				
				System.out.println("삭제할??"+product.getAddImg());
				MultipartFile file=product.getAddImg()[i];
				String ext=fileManager.getExtend(file.getOriginalFilename());
				
				Image image = new Image();
				image.setProduct_id(product.getProduct_id()); //fk
				image.setFilename(ext); //확장자 넣기
				imageDAO.insert(image);
				
				String addImg = image.getImage_id()+"."+fileManager.getExtend(file.getOriginalFilename());
				fileManager.saveFile(fileManager.getSaveAddonDir()+File.separator+addImg, file);
			}
		} 
			
		if(product.getRepImg().getOriginalFilename()!="") {
			//System.out.println("RepImg : "+product.getRepImg().getOriginalFilename());
			//fileManager.delFile(new File(fileManager.getSaveBasicDir()+File.separator+product.getProduct_id()+"."+product.getFilename()));			
			//System.out.println("여긴가?"+product.getFilename());
			//메인 이미지 재등록
			String ext=fileManager.getExtend(product.getRepImg().getOriginalFilename());
			String basicImg = product.getProduct_id()+"."+ext;
			fileManager.saveFile(fileManager.getSaveBasicDir()+File.separator+basicImg, product.getRepImg());
			product.setFilename(ext);
		}
		System.out.println("getfilename"+product.getFilename());
		productDAO.update(product);
	}

	@Override
	public void delete(Product product) {
		
		//db에서 삭제
		colorDAO.delete(product.getProduct_id());
		psizeDAO.delete(product.getProduct_id());
		productDAO.delete(product.getProduct_id());
	}

}
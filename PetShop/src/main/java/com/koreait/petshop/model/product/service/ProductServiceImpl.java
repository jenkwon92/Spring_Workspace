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

	//관리자모드 목록 가져오기
	@Override
	public List selectAll() {
	
		return productDAO.selectAll();
	}

	@Override
	public List selectById(int subcategory_id) {
		// TODO Auto-generated method stub
		return productDAO.selectById(subcategory_id);
	}

	//관리자 모드 상품 상세보기
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
	public void update(Product product) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int product_id) {
		// TODO Auto-generated method stub
		
	}

}
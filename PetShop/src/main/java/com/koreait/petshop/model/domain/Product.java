package com.koreait.petshop.model.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Product {
	private int product_id;
	private SubCategory subCategory;
	private String product_name;
	private int price;
	private String detail;
	private String filename;
	

	private MultipartFile repImg;	//대표 이미지
	private MultipartFile[] addImg; //추가 이미지는 선택사항이며, 동시에 배열
	
	private List<Image> imageList;
	
	private List<Color> color;	//색상값들
	private List<Psize> psize;	//사이즈

	
}
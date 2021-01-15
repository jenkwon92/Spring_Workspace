package com.koreait.petshop.model.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

public class Product {
	private int product_id;
	private int subcategory_id; 
	private SubCategory subCategory;
	private String product_name; 
	private int price;
	private String detail; 
	private String filename;
	
	private MultipartFile repImg;	//대표 이미지
	private MultipartFile[] addImg; //추가 이미지는 선택사항이며, 동시에 배열
	
	private List<Image> imageList;
	private List<Score> score;	//색상값들
	private List<Color> colorList;	//색상값들
	private List<Psize> psize;	//사이즈
	
	private Color[] colors;	//색상값들

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public int getSubcategory_id() {
		return subcategory_id;
	}

	public void setSubcategory_id(int subcategory_id) {
		this.subcategory_id = subcategory_id;
	}

	public SubCategory getSubCategory() {
		return subCategory;
	}

	public void setSubCategory(SubCategory subCategory) {
		this.subCategory = subCategory;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public MultipartFile getRepImg() {
		return repImg;
	}

	public void setRepImg(MultipartFile repImg) {
		this.repImg = repImg;
	}

	public MultipartFile[] getAddImg() {
		return addImg;
	}

	public void setAddImg(MultipartFile[] addImg) {
		this.addImg = addImg;
	}

	public List<Image> getImageList() {
		return imageList;
	}

	public void setImageList(List<Image> imageList) {
		this.imageList = imageList;
	}

	public List<Score> getScore() {
		return score;
	}

	public void setScore(List<Score> score) {
		this.score = score;
	}

	public List<Color> getColorList() {
		return colorList;
	}

	public void setColorList(List<Color> colorList) {
		this.colorList = colorList;
	}

	public List<Psize> getPsize() {
		return psize;
	}

	public void setPsize(List<Psize> psize) {
		this.psize = psize;
	}

	public Color[] getColors() {
		return colors;
	}

	public void setColors(Color[] colors) {
		this.colors = colors;
	}
	
	
}
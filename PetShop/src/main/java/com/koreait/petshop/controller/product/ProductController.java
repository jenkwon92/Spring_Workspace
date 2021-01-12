package com.koreait.petshop.controller.product;

import java.util.List;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.petshop.model.common.FileManager;
import com.koreait.petshop.model.domain.Product;
import com.koreait.petshop.model.domain.SubCategory;
import com.koreait.petshop.model.product.service.ImageServiceImpl;
import com.koreait.petshop.model.product.service.ProductService;
import com.koreait.petshop.model.product.service.SubCategoryService;
import com.koreait.petshop.model.product.service.TopCategoryService;

@Controller
public class ProductController {
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private TopCategoryService topCategoryService;
	
	@Autowired
	private SubCategoryService subCategoryService;
	
	@Autowired
	private ImageServiceImpl imageService;
	
	@Autowired
	private FileManager fileManager;
	
	private ServletContext servletContext;
	
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		//이 타이밍을 놓치지말고 실제 물리적 경로를 FileManager에 대입해놓자!!
		fileManager.setSaveBasicDir(servletContext.getRealPath(fileManager.getSaveBasicDir()));
		fileManager.setSaveAddonDir(servletContext.getRealPath(fileManager.getSaveAddonDir()));
		
		
		logger.debug("저장 경로 "+this.servletContext.getRealPath(fileManager.getSaveBasicDir()));
		logger.debug(fileManager.getSaveBasicDir());
	}
	
	//@GetMapping("/admin/product/list")
	@RequestMapping(value="/admin/product/list", method=RequestMethod.GET )
	public ModelAndView getProductList() {
		ModelAndView mav = new ModelAndView("admin/product/product_list");
		
		List productList = productService.selectAll();	
		mav.addObject("productList", productList);
		
		return mav;
	}
	
	//등록 폼
	@RequestMapping(value="/admin/product/registform")
	public ModelAndView registForm() {
		List topList=topCategoryService.selectAll();
		ModelAndView mav = new ModelAndView("admin/product/regist_form");
		mav.addObject("topList", topList);
		
		return mav;
	}
	
	//하위 카테고리 가져오기
	@GetMapping("/admin/product/sublist")
	@ResponseBody
	public List getSubList(int topcategory_id) {
		List<SubCategory> subList=subCategoryService.selectAllById(topcategory_id);
		return subList;
	}
	
	//상세보기 요청
	@GetMapping("/admin/product/detail")
	public ModelAndView getDetail(int product_id) {
		List topList=topCategoryService.selectAll();
		Product product = productService.select(product_id);
		SubCategory subCategory=subCategoryService.select(product.getSubcategory_id());
		List subList=subCategoryService.selectAllById(subCategory.getTopcategory_id());
		List addonList=imageService.selectById(product_id);
		ModelAndView mav = new ModelAndView("admin/product/detail");
		mav.addObject("topList", topList);
		mav.addObject("subList", subList);
		mav.addObject("product", product);
		mav.addObject("subCategory",subCategory);
		mav.addObject("addonList", addonList);
		
		return mav;
	}
	
}
package com.koreait.petshop.controller.product;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.petshop.model.domain.Product;
import com.koreait.petshop.model.domain.SubCategory;
import com.koreait.petshop.model.product.service.ProductService;
import com.koreait.petshop.model.product.service.SubCategoryService;
import com.koreait.petshop.model.product.service.TopCategoryService;

@Controller
public class ProductController {
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@Autowired
	private TopCategoryService topCategoryService;
	
	@Autowired
	private SubCategoryService subCategoryService;
	
	@Autowired
	private ProductService productService;
	

	//목록 폼
	//등록된 상품목록 리스트
	//@GetMapping("/admin/product/list")
	@RequestMapping(value="/admin/product/list", method=RequestMethod.GET )
	public ModelAndView getProductList() {
		ModelAndView mav = new ModelAndView("admin/product/product_list");
		
		List productList = productService.selectAll();	
		mav.addObject("productList", productList);
	
		logger.debug("productList.size()"+productList.size());

	
		return mav;
	}
	
	//상품 상세보기
	@RequestMapping(value="/admin/product/detail", method=RequestMethod.GET )
	public ModelAndView getProductDetail(int product_id) {
	List topList = topCategoryService.selectAll();//상품카테고리 목록
		
		Product product = productService.select(product_id);//상품 한건 가져오기
		
		ModelAndView mav = new ModelAndView("admin/product/detail");
	
		mav.addObject("product",product);
		
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
		
		
		/**************************************
		 * shop페이지 구현하기
		 * **************************************/
		//상품 목록 보여주기
		@RequestMapping(value="/shop/product/list", method=RequestMethod.GET)
		public ModelAndView getShopProductList(int subcategory_id) {
			List topList = topCategoryService.selectAll();//상품 카테고리 가져오기
			List productList = productService.selectById(subcategory_id);
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("topList", topList);
			mav.addObject("productList", productList);
			mav.setViewName("shop/product/list");
			
			logger.debug("product.size() "+productList.size());
			return mav;
		}
		
		//상위에 소속된 모든 하위 보여주기
		@RequestMapping(value="/shop/product/listAll", method=RequestMethod.GET)
		public ModelAndView getShopTopProductList(int topcategory_id) {
			List topList = topCategoryService.selectAll();//상품 카테고리 가져오기
			List subList = subCategoryService.selectAllById(topcategory_id);
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("topList", topList);
			mav.addObject("subList", subList);
			mav.setViewName("shop/product/listAll");
			
			logger.debug("subList.size() "+subList.size());
			return mav;
		}
		
	
		//상품상세 보기 요청 
		@RequestMapping(value="/shop/product/detail", method=RequestMethod.GET)
		public ModelAndView getShopProductDetail(int product_id) {
			
			List topList = topCategoryService.selectAll();//상품카테고리 목록	
			Product product = productService.select(product_id);//상품 한건 가져오기
			
			
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("topList", topList);
			mav.addObject("product",product);
		
			mav.setViewName("shop/product/detail");
			
			logger.debug("product_id"+product_id);
			
			return mav;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	 
}
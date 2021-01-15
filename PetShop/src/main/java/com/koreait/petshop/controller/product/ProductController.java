package com.koreait.petshop.controller.product;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.petshop.model.common.FileManager;
import com.koreait.petshop.model.common.Pager;
import com.koreait.petshop.model.domain.Member;
import com.koreait.petshop.model.domain.Product;
import com.koreait.petshop.model.domain.Review;
import com.koreait.petshop.model.domain.SubCategory;
import com.koreait.petshop.model.product.service.ImageServiceImpl;
import com.koreait.petshop.model.product.service.ProductService;
import com.koreait.petshop.model.product.service.SubCategoryService;
import com.koreait.petshop.model.product.service.TopCategoryService;
import com.koreait.petshop.model.review.service.ReviewService;

@Controller
public class ProductController {
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@Autowired
	private TopCategoryService topCategoryService;
	
	@Autowired
	private SubCategoryService subCategoryService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private Pager pager;
		
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

	//목록 폼
	//등록된 상품목록 리스트
	//@GetMapping("/admin/product/list")
	@RequestMapping(value="/admin/product/list", method=RequestMethod.GET )
	public ModelAndView getProductList(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("admin/product/product_list");
		
		List productList = productService.selectAll();	
		pager.init(request, productList);
		mav.addObject("pager",pager);
	
	
		return mav;
	}
	
	//상품 상세보기
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
		public ModelAndView getShopProductList(HttpSession session, int subcategory_id,HttpServletRequest request) {
			
			//회원 정보 가져오기
			/*
			 * Member member = (Member)session.getAttribute("member");
			 * //review.setMember_id(member.getMember_id()); review.setMember(member);
			 */
			List topList = topCategoryService.selectAll();//상품 카테고리 가져오기
			List productList = productService.selectById(subcategory_id);
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("topList", topList);
			//mav.addObject("productList", productList);
			pager.init(request, productList);
			mav.addObject("pager",pager);
			mav.setViewName("shop/product/list");
			
			logger.debug("product.size() "+productList.size());
			return mav;
		}
		
		//상위에 소속된 모든 하위 보여주기
		@RequestMapping(value="/shop/product/listAll", method=RequestMethod.GET)
		public ModelAndView getProductAll() {
			
			List productList = productService.selectAll();
			ModelAndView mav = new ModelAndView();
			mav.addObject("productList",productList);
		
			mav.setViewName("shop/product/listAll");
			
			
			return mav;
		}
		
	
		//상품상세 보기 요청 
		@RequestMapping(value="/shop/product/detail", method=RequestMethod.GET)
		public ModelAndView getShopProductDetail(Review review,HttpSession session ,HttpServletRequest request,int product_id) {
			
			Member member = (Member)session.getAttribute("member");
			//review.setMember_id(member.getMember_id());
			review.setMember(member);
		
			Product product = productService.select(product_id);//상품 한건 가져오기
			//Review review = (Review)session.getAttribute("review");
			//logger.debug("review:"+review);
			//review.setProduct_id(product.getProduct_id());
			List topList = topCategoryService.selectAll();//상품카테고리 목록	
			List reviewList = reviewService.selectAll(product.getProduct_id());
			
		
			pager.init(request, reviewList);
			ModelAndView mav = new ModelAndView();
			mav.addObject("topList", topList);
			mav.addObject("product",product);
			mav.addObject("reviewList",reviewList);
			mav.addObject("review",review);
			mav.addObject("member",member);
			//mav.addObject("review",review);
			mav.addObject("pager", pager);
		
			mav.setViewName("shop/product/detail");
			
			logger.debug("product_id"+product_id);
			
			return mav;
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	 
}
package com.koreait.petshop.controller.review;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.petshop.exception.ReviewException;
import com.koreait.petshop.model.common.MessageData;
import com.koreait.petshop.model.domain.Member;
import com.koreait.petshop.model.domain.Product;
import com.koreait.petshop.model.domain.Review;
import com.koreait.petshop.model.member.service.MemberService;
import com.koreait.petshop.model.product.service.ProductService;
import com.koreait.petshop.model.review.service.ReviewService;

@Controller
public class ReviewController {
	private static final Logger logger=LoggerFactory.getLogger(ReviewController.class);
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private MemberService memberService;
	
	

	
	//리뷰 등록페이지 요청
	@GetMapping("/shop/cs/registForm")
	public ModelAndView reviewRegistForm(Review review,HttpSession session, int product_id, HttpServletRequest request) {
		session = request.getSession();
		//회원 정보 가져오기
		Member member = (Member)session.getAttribute("member");
		review.setMember_id(member.getMember_id());
		review.setMember(member);
		//상품 정보 가져오기
		Product product = productService.select(product_id);
		review.setProduct_id(product.getProduct_id()); 
		ModelAndView mav = new ModelAndView("/shop/cs/regist_form");
		mav.addObject("product",product);
		
		return mav;
	}
	
	//등록하기
	@PostMapping("/shop/cs/regist")
	public ModelAndView reviewRegist(Review review,int product_id,  HttpServletRequest request,HttpSession session) {
		//회원 정보 가져오기
//		session = request.getSession();
//		Member member = (Member)session.getAttribute("member");
//		Review review=(Review)session.getAttribute("review");
//		review.setMember_id(member.getMember_id());
//		review.setMember(member);
		reviewService.insert(review);
		ModelAndView mav = new ModelAndView("redirect:/shop/product/detail?product_id="+product_id+"");
		return mav;
	}
	
	//리뷰 상세보기 페이지 이동
	@GetMapping("/shop/cs/detail")
	public ModelAndView reviewDetail(HttpSession session,int review_id,  HttpServletRequest request,Review review) {
		session = request.getSession();
		Member member = (Member)session.getAttribute("member");
		
		review.setMember(member);
		ModelAndView mav= new ModelAndView();
		mav.setViewName("/shop/cs/detail");
		mav.addObject("review", reviewService.select(review_id));
		
		
		return mav;
	}
	
	//삭제하기
	@RequestMapping("/shop/cs/del")
	public ModelAndView reviewDel(int review_id, int product_id, HttpServletRequest request) {
		reviewService.delete(review_id);
		logger.debug("product_id::"+product_id);
		ModelAndView mav = new ModelAndView("redirect:/shop/product/detail?product_id="+product_id+"");
		return mav;
	}
	
	//수정하기
	@PostMapping("/shop/cs/edit")
	public ModelAndView reviewDel(Review review, int product_id) {
		reviewService.update(review);
		logger.debug("product_id::"+product_id);
		ModelAndView mav = new ModelAndView("redirect:/shop/product/detail?product_id="+product_id+"");
		return mav;
	}
	
	
	
	//등록 실패시
	@ExceptionHandler(ReviewException.class)
	public ModelAndView handleException(ReviewException e) {
		ModelAndView mav = new ModelAndView();
		MessageData messageData = new MessageData();
		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());
		mav.addObject("messageData", messageData);
		mav.setViewName("shop/error/message");
		return mav;
	}
	

}
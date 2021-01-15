package com.koreait.petshop.controller.payment;

import java.util.ArrayList;
import java.util.List;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.petshop.exception.CartException;
import com.koreait.petshop.exception.LoginRequiredException;
import com.koreait.petshop.model.common.MessageData;
import com.koreait.petshop.model.domain.Cart;
import com.koreait.petshop.model.domain.Member;
import com.koreait.petshop.model.domain.OrderDetail;
import com.koreait.petshop.model.domain.OrderSummary;
import com.koreait.petshop.model.domain.Product;
import com.koreait.petshop.model.domain.Receiver;
import com.koreait.petshop.model.domain.SubCategory;
import com.koreait.petshop.model.payment.service.PaymentService;
import com.koreait.petshop.model.product.service.TopCategoryService;

import sun.java2d.opengl.WGLSurfaceData.WGLVSyncOffScreenSurfaceData;
import sun.print.resources.serviceui;

@Controller
public class PaymentController {
	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);
	@Autowired
	private PaymentService paymentService;

	@Autowired
	private TopCategoryService topCategoryService;

	// 장바구니 목록 요청
	@RequestMapping(value = "/shop/cart/list", method = RequestMethod.GET)
	public ModelAndView getCartList(HttpServletRequest request) {
		System.out.println("hi");
		logger.debug(">>>getCartList");
		HttpSession session = request.getSession();
		Member member = (Member) session.getAttribute("member");
		System.out.println("member" + member.getMember_id());
		List topList = topCategoryService.selectAll();
		List cartList = paymentService.selectCartList(member.getMember_id());
		ModelAndView mav = new ModelAndView("shop/cart/cart_list");
		mav.addObject("topList", topList);
		mav.addObject("cartList", cartList);
		return mav;
	}

	// 장바구니에 상품 담기 요청
	@RequestMapping(value = "/shop/cart/regist", method = RequestMethod.POST)
	@ResponseBody
	public MessageData  registCart(Cart cart, HttpSession session) {
		logger.debug("장바구니 등록");
		if (session.getAttribute("member") == null) {
			throw new LoginRequiredException("로그인이 필요한 서비스입니다.");
		}
		Member member = (Member) session.getAttribute("member");
		logger.debug("product_id " + cart.getProduct_id());
		logger.debug("quantity " + cart.getQuantity());
		cart.setMember_id(member.getMember_id());
		paymentService.insert(cart);
		logger.debug("finished cart regist !!!");
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("장바구니에 상품이 담겼습니다");
		messageData.setUrl("/shop/cart/list");
		return messageData;
	}
	
	// 장바구니 비우기 하나 비우기 
	@RequestMapping(value = "/shop/cart/Onedel", method = RequestMethod.GET)
	public String delOne(HttpSession session,Cart cart) {
		// 장바구니를 삭제하기 위해서는, 로그인한 회원만 가능..
		if (session.getAttribute("member") == null) {
			throw new LoginRequiredException("로그인 먼저 해주세요");
		}
		logger.debug("카트 id는?", cart.getCart_id());
		paymentService.delete(cart); //카트 아이디 사용해서 1개 delete
		return "redirect:/shop/cart/list";
	}

	// 장바구니 전체 비우기
	@RequestMapping(value = "/shop/cart/del", method = RequestMethod.GET)
	public String delCart(HttpSession session) {
		// 장바구니를 삭제하기 위해서는, 로그인한 회원만 가능..
		if (session.getAttribute("member") == null) {
			throw new LoginRequiredException("로그인 먼저 해주세요");
		}
		paymentService.delete((Member) session.getAttribute("member"));
		return "redirect:/shop/cart/list";
	}

	// 장바구니 수정
	@RequestMapping(value = "/shop/cart/edit", method = RequestMethod.POST)
	public ModelAndView editCart(@RequestParam("cart_id") int[] cartArray, @RequestParam("quantity") int[] qArray) {
		// 넘겨받은 cart_id, quantity 파라미터 출력
		logger.debug("cartArray length " + cartArray.length);		
		List cartList = new ArrayList();
		for (int i = 0; i < cartArray.length; i++) {
			Cart cart = new Cart();
			cart.setCart_id(cartArray[i]);
			cart.setQuantity(qArray[i]);
			cartList.add(cart);
		}
		paymentService.update(cartList);
		// 수정되었으면
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("장바구니가 수정되었습니다");
		messageData.setUrl("/shop/cart/list");
		// 아니면 에러메세지
		ModelAndView mav = new ModelAndView();
		mav.addObject("messageData", messageData);
		mav.setViewName("shop/error/message");
		return mav;
	}
	
	
/*
	// 결제페이지
	@RequestMapping(value = "/shop/payment/form", method = RequestMethod.GET)
	public ModelAndView payForm() {
		ModelAndView mav = new ModelAndView();
		List topList = topCategoryService.selectAll();
		mav.addObject("topList", topList);
		mav.setViewName("shop/payment/checkout");
		return mav;
	}
*/	


	// 체크아웃 페이지 요청
	@GetMapping("/shop/payment/form")
	public String payForm(Model model, HttpSession session) {
		List topList = topCategoryService.selectAll();
		model.addAttribute("topList", topList); // ModelAndView에서의 Model만 사용..

		// 결제수단 가져오기
		List paymethodList = paymentService.selectPaymethodList();
		model.addAttribute("paymethodList", paymethodList);

		// 장바구니 정보도 가져오기
		Member member = (Member) session.getAttribute("member");
		List cartList = paymentService.selectCartList(member.getMember_id());
		model.addAttribute("cartList", cartList);
		
		return "shop/payment/checkout";
	}


	// 결제확인페이지
	@PostMapping("/shop/payment/confirm")
	public String pay(HttpSession session, OrderSummary orderSummary, Receiver receiver,OrderDetail orderDetail,Product product) {
		
		logger.debug("상품이름" + product.getSubCategory().getName());
		logger.debug("상품가격 " + product.getPrice());
		logger.debug("구매개수 " + orderDetail.getQuantity());
		logger.debug("받을 사람 이름 " + receiver.getReceiver_name());
		logger.debug("받을 사람 연락처 " + receiver.getReceiver_phone());
		logger.debug("받을 사람 주소 " + receiver.getReceiver_addr());
		logger.debug("결제방법은 " + orderSummary.getPaymethod_id());
		logger.debug("total_price " + orderSummary.getTotal_price());
		logger.debug("total_pay " + orderSummary.getTotal_price());
	
		
		Member member = (Member) session.getAttribute("member");
		orderSummary.setMember_id(member.getMember_id()); //  regist오더에 저 하위 매개변수가 전부 들어가는건가요.. 필요한 부분인데 , 이게 수업시간에 하다가 끝나서 ...감이 안잡혀요 ㅠ
		//맞아요, 컨트롤러는 절대로 로직을 작성하면 안되기 때문에, 클라이언트가 넘겨준 파라미터를 서비스에게 넘겨야 하고, 
		//주문할때는 단지 그 파라미터가 많은 뿐이에요, 수가 많다고 해서 당황할 필요 없음 .잘 한것임 ,, 이걸 짬뽕시켜서 가져와야한다는게,, 그냥 잘모르게성요;;막막하네요
		//근데 왠만하면, 서로 포함관계에 있을때 즉 특정VO가 특정 브이오를 포함할때는 일일이 명시할 필요는 없죠, 예를 들어 
		//OrderSummary가 보유한 VO가 있다면 굳이 또 명시힐 필요는 없는거죠 합번 열어볼께요 
		//매개변수중에서 SubCategory subCategory 는 이미 Product product 가 보유하고 이있으니 저렇게 둘다 줄필요는 없는것 이구요 ~이해하셧읍 ?네 
		//그대신 클라이언트가 매개변수 전송할때 벼수명은 상품 안에 들어있는 subCategory를 명시해줘야 해요 , 알죠 ? 으 ㅁㅓ주문 페이지 열어보세요 주문 요청 페이지 이거 지금 에러떠서 이미지로만 ㅐ캡쳐했는데 ..
		//그럼 예를 들어 볼께요, subCategory 값은 이미 Product에 들어있있는 브이오를 이용해야 하므로, 
		//제이에스피에서 전ㅅ송할때 이렇게 해야 돼요 , subCateogry.subcategory_id (product vo 안에 들어있기 ㄸ문에 )  이오케이 ?네 , 그럼 그렇게 진행해주세요 아 저 그리고 아까 그 수량 변경시 같이 바뀌는거 제이쿼리로 해봤는데 한번 봐주실수 있나요..
		paymentService.registOrder(orderSummary, receiver,orderDetail,product);
		
		return "/shop/payment/confirm_message";
		
	}


	
	
	/*
	//결제완료창
	@RequestMapping(value="/shop/payment/confirm")
	public String getConfirm() {
		return "/shop/payment/confirm_message";
	}
*/
	
	
	// 장바구니와 관련된 예외처리 핸들러
	@ExceptionHandler(CartException.class)
	@ResponseBody
	public MessageData handleException(CartException e) {
		logger.debug("핸들러 동작함 " + e.getMessage());
		MessageData messageData = new MessageData();
		messageData.setResultCode(0);
		messageData.setMsg(e.getMessage());
		return messageData;
	}
}
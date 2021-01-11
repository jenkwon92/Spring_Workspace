package com.koreait.petshop.controller.payment;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.sound.midi.Receiver;

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
import com.koreait.petshop.model.domain.OrderSummary;
import com.koreait.petshop.model.payment.service.PaymentService;
import com.koreait.petshop.model.product.service.TopCategoryService;
//동진씨가 지금 그러는데 인클루드 지웠더니 되엇ㄸ요 , 확인해보세요 jsp !!!
@Controller
public class PaymentController {
      private static final Logger logger=LoggerFactory.getLogger(PaymentController.class);
      @Autowired
      private PaymentService paymentService;
      
      @Autowired
      private TopCategoryService topCategoryService;
      
      //카트 요청 
      @RequestMapping(value="/shop/cart/list", method=RequestMethod.GET )
      public ModelAndView cart() {
         ModelAndView mav = new ModelAndView();
         List cartList = paymentService.selectCartList();
         logger.debug("casrtlist is "+cartList);
         mav.addObject("cartList", cartList);
         mav.setViewName("shop/cart/cart_list");
         return mav;
      }
      
      //장바구니에 상품 담기 요청 
      @RequestMapping(value="/shop/cart/regist", method=RequestMethod.POST)
      @ResponseBody
      public MessageData registCart(Cart cart, HttpSession session) {
         if(session.getAttribute("member")==null) {
            throw new LoginRequiredException("로그인이 필요한 서비스입니다.");
         }
         
         Member member = (Member)session.getAttribute("member");
         
         logger.debug("product_id "+cart.getProduct_id());
         logger.debug("quantity "+cart.getQuantity());
         cart.setMember_id(member.getMember_id());
         paymentService.insert(cart);
         
         MessageData messageData = new MessageData();
         messageData.setResultCode(1);
         messageData.setMsg("장바구니에 상품이 담겼습니다");
         messageData.setUrl("/shop/cart/list");
         
         return messageData;
      }
      
      //장바구니 비우기 
      @RequestMapping(value="/shop/cart/del", method=RequestMethod.GET)
      public String delCart(HttpSession session){
         //장바구니를 삭제하기 위해서는, 로그인한 회원만 가능..
         if(session.getAttribute("member")==null) {
            throw new LoginRequiredException("로그인 먼저 해주세요");
         }
         paymentService.delete((Member)session.getAttribute("member"));
         return "redirect:/shop/cart/list";
      }
      
      //장바구니 수정 
      @RequestMapping(value="/shop/cart/edit", method=RequestMethod.POST)
      public ModelAndView editCart(@RequestParam("cart_id") int[] cartArray, @RequestParam("quantity") int[] qArray) {
         //넘겨받은 cart_id,  quantity  파라미터 출력
         logger.debug("cartArray length "+cartArray.length);
         List cartList = new ArrayList();
         for(int i=0;i<cartArray.length;i++) {
            Cart cart  = new Cart();
            cart.setCart_id(cartArray[i]);
            cart.setQuantity(qArray[i]);
            cartList.add(cart);
         }
         paymentService.update(cartList);
         
         //수정되었으면 
         MessageData messageData = new MessageData();
         messageData.setResultCode(1);
         messageData.setMsg("장바구니가 수정되었습니다");
         messageData.setUrl("/shop/cart/list");
         //아니면 에러메세지
         ModelAndView mav = new ModelAndView();
         mav.addObject("messageData", messageData);
         mav.setViewName("shop/error/message");
         return mav;
      }
      
      //체크아웃 페이지 요청 
      @GetMapping("/shop/payment/form")
      public String payForm(Model model, HttpSession session) {
         List topList = topCategoryService.selectAll();
         model.addAttribute("topList", topList); //ModelAndView에서의 Model만 사용..
         
         //결제수단 가져오기 
         List paymethodList = paymentService.selectPaymethodList();
         model.addAttribute("paymethodList", paymethodList);
         
         //장바구니 정보도 가져오기 
         Member member =(Member)session.getAttribute("member");
         List cartList = paymentService.selectCartList(member.getMember_id());
         model.addAttribute("cartList", cartList);
         
         return "shop/payment/checkout";
      }
      
      //결제요청 처리
      @PostMapping("/shop/payment/regist")
      public String pay(HttpSession session, OrderSummary orderSummary, Receiver receiver) {
         logger.debug("받을 사람 이름 "+receiver.getReceiver_name());
         logger.debug("받을 사람 연락처 "+receiver.getReceiver_phone());
         logger.debug("받을 사람 주소 "+receiver.getReceiver_addr());
         logger.debug("결제방법은 "+orderSummary.getPaymethod_id());
         logger.debug("total_price "+orderSummary.getTotal_price());
         logger.debug("total_pay "+orderSummary.getTotal_price());
         Member member=(Member)session.getAttribute("member");
         orderSummary.setMember_id(member.getMember_id()); //회원 pk
         paymentService.registOrder(orderSummary, receiver);
         return "";
      }
      
      //장바구니와 관련된 예외처리 핸들러
      @ExceptionHandler(CartException.class)
      @ResponseBody
      public MessageData handleException(CartException e) {
         logger.debug("핸들러 동작함 "+ e.getMessage());
         MessageData messageData = new MessageData();
         messageData.setResultCode(0);
         messageData.setMsg(e.getMessage());   
         return messageData;
      }
      
}

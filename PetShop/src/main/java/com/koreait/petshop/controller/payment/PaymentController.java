package com.koreait.petshop.controller.payment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class PaymentController {
      
      //@Autowired
      //private PaymentService paymentService;
      
      //카트 요청 
      @RequestMapping(value="/shop/cart/list", method=RequestMethod.GET )
      public ModelAndView cart() {
         ModelAndView mav = new ModelAndView("shop/cart/cart-list");
         //List cartList = paymentService.selectCartList();
         //mav.addObject("cartList", cartList);
         //mav.setViewName("shop/cart/cart_list");
         return mav;
      }
}
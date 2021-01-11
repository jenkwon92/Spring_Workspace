package com.koreait.petshop.controller.payment;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

//동진씨가 지금 그러는데 인클루드 지웠더니 되엇ㄸ요 , 확인해보세요 jsp !!!
@Controller
public class PaymentController {
      private static final Logger logger=LoggerFactory.getLogger(PaymentController.class);
     
      
      //카트 요청 
      @RequestMapping(value="/shop/cart/list", method=RequestMethod.GET )
      public String cart() {
        
         return "/shop/cart/cart_list";
      }
}

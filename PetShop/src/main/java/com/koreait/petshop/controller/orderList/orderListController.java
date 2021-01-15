package com.koreait.petshop.controller.orderList;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class orderListController {


	@RequestMapping(value="/admin/order/list", method=RequestMethod.GET)
	public String getOrderList() {
		return "admin/order/order_list";
	}
}
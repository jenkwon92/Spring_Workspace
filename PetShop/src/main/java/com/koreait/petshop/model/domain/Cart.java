package com.koreait.petshop.model.domain;

import com.koreait.petshop.model.domain.Product;

import lombok.Data;

@Data
public class Cart extends Product{
   private int cart_id;
   private int quantity;
   private int member_id;
 
}
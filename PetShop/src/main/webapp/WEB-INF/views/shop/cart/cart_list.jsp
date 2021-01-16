<%@page import="com.koreait.petshop.model.domain.Member"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="com.koreait.petshop.model.common.Pager"%>
<%@page import="com.koreait.petshop.model.common.Formatter"%>
<%@page import="com.koreait.petshop.model.domain.Cart"%>
<%@page import="java.util.List"%>
<%
//장바구니에 상품이 담기긴 해요 ? 아니요 그럼 담는 쪽붙처 확인해ㅘ봐야 해요 
//Pager pager = (Pager)request.getAttribute("pager");
//List<Cart> cartList = pager.getList();
List<Cart> cartList = (List) request.getAttribute("cartList");
Member member=(Member)session.getAttribute("member");
String a = request.getParameter("quantity");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<%@ include file="./../../inc/header.jsp"%>
<script>
 
	//장바구니 비우기
	function delCart() {
		if (confirm("장바구니를 모두 비우시겠습니까?")) {
			location.href = "/shop/cart/del";
		}
	}
	//수량변경
	function editCart(){
		if(confirm("주문 수량을 변경하시겠어요?")){
			$("#cart-form").attr({
				action:"/shop/cart/edit",
				method:"post"
			});
			$("#cart-form").submit();
		}		
	}
	
	function delOneCart(cart_id){
		if(confirm("삭제?")){
			location.href="/shop/cart/Onedel?cart_id="+cart_id;
		}
	}
	function checkoutForm(){
		location.href="/shop/payment/form";
	}
	
</script>
</head>
<body>
	<%@ include file="./../../inc/shop_navi.jsp"%>
 	
    <div class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__links">
                        <a href="../../"><i class="fa fa-home"></i> Home</a>
                        <span>Shopping cart</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<!-- Breadcrumb End -->

	<!-- Shop Cart Section Begin -->
	<section class="shop-cart spad">
			<form id="cart-form">
				<div class="container">
					<p style="font-family:Geneva;" ><%=member.getName()%> 님이 장바구니 목록입니다 </p>
					<div class="row">
						<div class="col-lg-12">
							<div class="shop__cart__table">
								<table>
									
									<thead>
										<tr>
											<th>Product</th>
											<th>Price</th>
											<th>Quantity</th>
											<th>Total</th>
											<th></th>
										</tr>
									</thead>
		
									<tbody>
										<%int sum = 0; //합계%>
										<%for (Cart cart : cartList) { %>
										<tr>
											<td class="cart__product__item"><a href="#">
												<img src="/resources/data/basic/<%=cart.getProduct_id()%>.<%=cart.getFilename()%>" width="180" height="150" alt="Product"></a>
							 						 <h6><%=cart.getSubCategory().getName() %> > <%=cart.getProduct_name() %> </h6>
														<div class="cart__product__item__title">
															<h3><%=cart.getProduct_name() %></h3>
															<div class="rating">
																<i class="fa fa-star"></i> 
																<i class="fa fa-star"></i> 
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
																<i class="fa fa-star"></i>
															</div>
														</div>
											</td>
											
										
							           
							     			
                                    	
											<td class="cart__price" name="price" ><span><%=Formatter.getCurrency(cart.getPrice())%></span></td>
											
								            <!-- "장바구니 수량 변경" -->
											<td class="cart__quantity">
												<div class="pro-qty">
													<input type="hidden" name="cart_id" value="<%=cart.getCart_id()%>"> 
													<input type="text" name="quantity" value="<%=cart.getQuantity()%>">
												</div>
											</td>
											
												<%
												sum = sum + (cart.getPrice() * cart.getQuantity());
												%>
											 <!-- "장바구니 합계정보" -->
												 <td class="cart__total"><%=Formatter.getCurrency(cart.getPrice()*cart.getQuantity()) %></td>
											
												<td class="cart__close">											
													<span class="icon_close" onClick="delOneCart(<%=cart.getCart_id()%>)"> 							
													</span>												
												</td>										
										</tr>
										<%}%>	
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-6 col-md-6 col-sm-6">
							<div class="cart__btn">
								<a href="../../">메인으로</a>
							</div>
						</div>
						<div class="col-lg-6 col-md-6 col-sm-6">
							<div class="cart__btn update__btn">							
								<a href="javascript:editCart()"></span> Update cart</a>
								 <a href="javascript:delCart()"></span> 카트비우기</a>
							</div>
						</div>
					</div>
			</form>
			
					<div class="row">
		                <div class="col-lg-6">
		                    <div class="discount__content">
		                        <h6>Discount codes</h6>
		                        <form action="#">
		                            <input type="text" placeholder="Enter your coupon code">
		                            <button type="submit" class="site-btn">Apply</button>
		                        </form>
		                    </div>
		                </div>
		                
						<div class="col-lg-4 offset-lg-2">
							<div class="cart__total__procced">
								<h6>Cart total</h6>
								<ul>
									<li>Total <span><%=Formatter.getCurrency(sum)%></span></li>
								</ul>
								<a href="javascript:checkoutForm()" class="primary-btn">결제하기</a>
							</div>
						</div>
					</div>
			</div>
		</div>
	</section>
	<!-- Shop Cart Section End -->

	<!-- Search Begin -->
	<div class="search-model">
		<div class="h-100 d-flex align-items-center justify-content-center">
			<div class="search-close-switch">+</div>
			<form class="search-model-form">
				<input type="text" id="search-input" placeholder="Search here.....">
		</div>
	</div>

	<!-- Search End -->

	<!-- Js Plugins -->
	<%@ include file="../shopFooter.jsp"%>
	<%@ include file="./../../inc/footer.jsp"%>
</body>

</html>
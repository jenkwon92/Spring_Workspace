<%@page import="com.koreait.petshop.model.domain.Member"%>
<%@page import="com.koreait.petshop.model.domain.Review"%> 
<%@page import="com.koreait.petshop.model.common.Pager"%>
<%@page import="com.koreait.petshop.model.domain.Image"%>
<%@page import="com.koreait.petshop.model.domain.Color"%>
<%@page import="com.koreait.petshop.model.domain.TopCategory"%>
<%@page import="com.koreait.petshop.model.domain.Psize"%>
<%@page import="com.fasterxml.jackson.core.format.DataFormatMatcher"%>
<%@page import="com.koreait.petshop.model.common.Formatter"%>
<%@page import="com.koreait.petshop.model.domain.Product"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	Product product =(Product)request.getAttribute("product");
	Pager pager =(Pager)request.getAttribute("pager");
	List<Review> reviewList = pager.getList(); 
	
	//	Review review = (Review)request.getAttribute("review");
	Member member =(Member)request.getAttribute("member");//회원에 대한 정보
%>
<!DOCTYPE html>
<html>
<head>
 <%@ include file="./../../inc/header.jsp" %>
 <meta name="viewport" content="width=device-width, initial-scale=1">
<style>
table {
  border-collapse: collapse;
  width: 100%;
  border: 1px solid #ddd;
}
th, td {
  text-align: left;
  padding: 16px;
}
.btn {
  border: none;
  color: white;
  padding: 14px 28px;
  font-size: 16px;
  cursor: pointer;
}
.success {background-color: #4CAF50;} /* Green */
.success:hover {background-color: #46a049;}
</style>	
<script>
 $('input[name="psize"]').val();
 
//비동기로 장바구니에 담기
function addCart(){
	var fromData = $("#cartForm").serialize();//파라미터를 전송할 수 있는 상태의 문자열로 나열해줌
	$.ajax({
		url:"/async/shop/cart/regist",
		type:"post",
		data:fromData,
		success:function(responseData){
			
			if(responseData.resultCode==1){
				if(confirm(responseData.msg+"\n장바구니로 이동하시겠습니까?")){
					location.href=responseData.url;	
				}
			}else{
				alert(responseData.msg);
			}
		}
		
	});
}
</script>
</head>
<body>

	<%@ include file="./../../inc/shop_navi.jsp"%>


	    <!-- Product Details Section Begin -->
	   <%--  <input type="hidden" name="product_id" value="<%=product.getProduct_id()%>"> --%>
    <section class="product-details spad">
        <div class="container" >
            <div class="row">
                <div class="col-lg-6">
                    <div class="product__details__pic">
                    
                        <%for(int i=0;i<product.getImageList().size();i++){ %>
	                        <div class="product__details__pic__left product__thumb nice-scroll">
                       			 <span width="200" height="200"><%Image image = product.getImageList().get(i); %></span>
	                                	<%if(i>=4)break; //총 4개까지만 허용할 것이므로..%>   
	                            <a class="pt active" href="#product-1">
	                                <img src="/resources/data/addon/<%=image.getImage_id() %>.<%=image.getFilename()%>">
	                         	 </a>
	                        </div>                 
                          <%} %>
                        <div class="product__details__slider__content">
                            <div class="product__details__pic__slider owl-carousel">
                                <img data-hash="product-1" class="product__big__img" src="/resources/data/basic/<%=product.getProduct_id()%>.<%=product.getFilename()%>">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="product__details__text">
                        <h3><%=product.getProduct_name() %></h3>
                      
                        <div class="rating">
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            <i class="fa fa-star"></i>
                            
                        </div>
                        <div class="product__details__price"><%=Formatter.getCurrency(product.getPrice()) %></div>
                        <p><%=product.getDetail() %></p>
                        <div class="product__details__button">
<!-- 수량  -->
                            <form id="cartForm">
	                            <div class="quantity">                           
	                                <span>Quantity:</span>                                     
	                                  <div class="pro-qty" >
	                                    <input type="number" name="quantity" value="<%=1%>">   
	                                </div>
	                            </div>
                            	<input type="hidden" name="product_id" value="<%=product.getProduct_id() %>"> 
                            	
	                            <a href="javascript:addCart()" class="cart-btn"><span class="icon_bag_alt"></span> Add to cart</a>
                            </form>
                          
                          
                        </div>
                        <div class="product__details__widget">
                            <ul>
                                
                                <li>
                                    <span>Available color:</span>
                                    <div class="color__checkbox">
                                      <%for(int i=0; i<product.getColorList().size();i++){ %>
	                                    <%Color color = product.getColorList().get(i); %>
                                           	<input type="radio" name="color"><%=color.getPicker() %>
                                    <%} %>
                                    </div>
                                    
                                </li>
                                <li>
                            
                                    <span>Available size:</span>
                                    <div class="size__btn">
	                                    <%for(int i=0; i<product.getPsizeList().size();i++){ %>
	                                    <%Psize psize = product.getPsizeList().get(i); %>
	                                       <input type="radio" name="psize"><%=psize.getPetfit() %>
	                                    <%}%>
                                    </div>
                                 
                                </li>
                                
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="product__details__tab">
                        <ul class="nav nav-tabs" role="tablist">
                            
                            <li class="nav-item">
                                <a class="nav-link" data-toggle="tab" href="#tabs-3" role="tab">Reviews ( <%=reviewList.size() %> )</a>
                            </li>
                           
                                	<table>
                                	<%int num=reviewList.size(); %>
									  <tr>
									    <th>No</th>
									    <th>MemberID</th>
									    <th>Contents</th>
									    <th>date</th>
									  </tr>
									  <%for(int i = 0; i<reviewList.size();i++){ %>
									  <%Review review= reviewList.get(i) ; 
									  	
									  	%>
									  <tr>
									  	<td><%=num-- %></td>
									    <td><a href="/shop/cs/detail?review_id=<%=review.getReview_id()%>"><%=member.getUser_id()%></td>
									    <td><%=review.getReviews() %></td>
									    <td><%=review.getRegdate() %></td>
									  </tr>
									  <%} %>
									<td colspan="6">				
										<button class="btn success" onClick="location.href='/shop/cs/registForm?product_id=<%=product.getProduct_id()%>';">Regist</button>	
									</td>
									<tr>
										<td colspan="6" style="text-align:center">
										<%if((pager.getFirstPage()-1)>=1){ %>
											<a href = "/shop/product/detail?currentPage=<%=pager.getFirstPage()-1%>">◀</a>
										<%}else{ %>
											<a href ="javascript:alert('처음 페이지입니다.')">◀</a>
										<%} %>
										<%for(int i=pager.getFirstPage();i<pager.getLastPage();i++){ %>
											<%if(i>pager.getTotalPage())break; %>
											<a href ="/shop/product/detail?product_id=<%=product.getProduct_id() %>?currentPage=<%=i%>" <% if(pager.getCurrentPage()==i){%>class="pageNum"<%} %>>[<%=i %>]</a>
										<%} %>
										<%if((pager.getLastPage()+1)<pager.getTotalPage()){ %>
											<a href = "/shop/product/detail?product_id=<%=product.getProduct_id() %>?currentPage=<%=pager.getFirstPage()-1%>">▶</a>
										<%}else{ %>	
											<a href ="javascript:alert('마지막 페이지입니다.')">▶</a>
										<%} %>
										</td>
									</tr>
								</table>
                        </ul>
                   
                    </div>
                </div>
            </div>
            
        </div>
    </section>
    <!-- Product Details Section End -->

			
		</div>
		</div>
		</div>
		</div>
	</section>

	<%@ include file="../shopFooter.jsp"%>
	<%@ include file="./../../inc/footer.jsp"%>

</body>

</html>
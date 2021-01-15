<%@page import="com.koreait.petshop.model.common.Formatter"%>
<%@page import="com.koreait.petshop.model.domain.Product"%>
<%@page import="com.koreait.petshop.model.common.Pager"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	/* List<Product> productList  = (List)request.getAttribute("productList");
	Pager pager = new Pager();
	pager.init(request,productList); 
	*/
	
	Pager pager = (Pager)request.getAttribute("pager");
	List<Product> productList = pager.getList();
%>
<!DOCTYPE html>
<html>
<head>
 <%@ include file="./../../inc/header.jsp" %>
 <meta name="viewport" content="width=device-width, initial-scale=1">
<style>
</style>	
<script>
</script>
</head>
<body>

	<%@ include file="./../../inc/shop_navi.jsp"%>

	<!--상품 리스트 시작 -->
	<section class="shop spad">
		<div class="container">
			<div class="row">
			

				<div class="col-lg-9 col-md-9">
					<div class="row">
					<%for(int i = 0; i<productList.size();i++){ %>
					<%Product product = productList.get(i) ;%>
						<div class="col-lg-4 col-md-6">
							<div class="product__item">
								<div class="product__item__pic set-bg"
									data-setbg="/resources/data/basic/<%=product.getProduct_id()%>.<%=product.getFilename()%>">
									<ul class="product__hover">
										<form id="cart_from">
											<li><a href="/resources/data/basic/<%=product.getProduct_id()%>.<%=product.getFilename()%>"	class="image-popup"><span class="arrow_expand"></span></a></li>
											<li><a href="/shop/cart/list"><span class="icon_bag_alt" onClick="addCart()"></span></a></li>										
										</form>
										
									</ul>
								</div>
								<div class="product__item__text">
									<h6>
										<a href="#"><%=product.getProduct_name() %></a>
									</h6>
									<div class="rating">
										<i class="fa fa-star"></i> <i class="fa fa-star"></i> <i
											class="fa fa-star"></i> <i class="fa fa-star"></i> <i
											class="fa fa-star"></i>
									</div>
									<div class="product__price"><%=Formatter.getCurrency(product.getPrice()) %></div>
									<li><a href="/shop/product/detail?product_id=<%=product.getProduct_id()%>">상품 상세보기</a></li>
								</div>
							</div>
						</div>
					<%} %>
					</div>
				</div>
			</div>

			<!-- 상품 리스트 끝-->
			
			<div class="col-lg-12 text-center">
				<div class="pagination__option">
				</div>
				<%if((pager.getFirstPage()-1)>=1){ %>
				<a href = "/shop/product/list?currentPage=<%=pager.getFirstPage()-1%>">◀</a>
				<%}else{ %>
					<a href ="javascript:alert('처음 페이지입니다.')">◀</a>
				<%} %>
				<%for(int i=pager.getFirstPage();i<pager.getLastPage();i++){ %>
					<%if(i>pager.getTotalPage())break; %>
					<a href ="/shop/product/list?currentPage=<%=i%>" <% if(pager.getCurrentPage()==i){%>class="pageNum"<%} %>>[<%=i %>]</a>
				<%} %>
				<%if((pager.getLastPage()+1)<pager.getTotalPage()){ %>
					<a href = "/shop/product/list?currentPage=<%=pager.getFirstPage()-1%>">▶</a>
				<%}else{ %>	
					<a href ="javascript:alert('마지막 페이지입니다.')">▶</a>
				<%} %>
			</div>
			
		</div>
		</div>
		</div>
		</div>
	</section>

	<%@ include file="../shopFooter.jsp"%>
	<%@ include file="./../../inc/footer.jsp"%>

</body>

</html>
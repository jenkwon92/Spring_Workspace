<%@page import="com.koreait.petshop.model.domain.Product"%>
<%@page import="com.koreait.petshop.model.common.Pager"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
/* 	List<Product> productList =(List)request.getAttribute("productList");
	Pager pager = new Pager();
	pager.init(request, productList); //페이지 처리에 대한 계산!! 
	*/
	Pager pager = (Pager)request.getAttribute("pager");
	List<Product> productList=pager.getList();
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../inc/header.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
table {
  border-collapse: collapse;
  border-spacing: 0;
  width: 100%;
  border: 1px solid #ddd;
}
th, td {
  text-align: left;
  padding: 16px;
}
tr:nth-child(even) {
  background-color: #f2f2f2;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
//글쓰기 폼 요청하기
$(function(){
	$("button").click(function(){
			location.href ="/admin/product/registform";
	
		});
		
	});
</script>

</head>
<body>
<%@ include file="../inc/admin_navi.jsp" %>
<section class="product spad">
		<div class="container">
			<div class="section-title">
				<h4>목록</h4>
			</div>
			<P>
			<table>
				<tr>
					<th>NO</th>
					<th>이미지</th>
				
					<th>상품명</th>
					<th>가격</th>
				</tr>
				<%
				//순서
				int num = pager.getNum();
				int curPos  = pager.getCurPos();
				%>

				<%for(int i=0; i<pager.getPageSize();i++){ %>
				<%if(num<1)break; %>
				<%Product product = (Product)productList.get(curPos++); %>
				<tr>
					<td><a href="/admin/product/detail?product_id=<%=product.getProduct_id()%>"><%=num--%></td>
					<td><img src="/resources/data/basic/<%=product.getProduct_id()%>.<%=product.getFilename()%>" width="50px"></td>

					<td><%=product.getProduct_name() %></td>
					<td><%=product.getPrice() %></td>
				</tr>
				<%} %>
			<tr>
			<td colspan="6" style="text-align:center">
			<%if((pager.getFirstPage()-1)>=1){ %>
				<a href = "/admin/product/list?currentPage=<%=pager.getFirstPage()-1%>">◀</a>
			<%}else{ %>
				<a href ="javascript:alert('처음 페이지입니다.')">◀</a>
			<%} %>
			<%for(int i=pager.getFirstPage();i<pager.getLastPage();i++){ %>
				<%if(i>pager.getTotalPage())break; %>
				<a href ="/admin/product/list?currentPage=<%=i%>" <% if(pager.getCurrentPage()==i){%>class="pageNum"<%} %>>[<%=i %>]</a>
			<%} %>
			<%if((pager.getLastPage()+1)<pager.getTotalPage()){ %>
				<a href = "/admin/product/list?currentPage=<%=pager.getFirstPage()-1%>">▶</a>
			<%}else{ %>	
				<a href ="javascript:alert('마지막 페이지입니다.')">▶</a>
			<%} %>
			</td>
		</tr>
			<tr>
				<td colspan="6">
					<button type="button">상품등록</button>
				</td>
			</tr>
			</table>
		</div>
	</section>
<%@ include file="../../shop/shopFooter.jsp" %>
<%@ include file="../../inc/footer.jsp" %>
</body>
</html>
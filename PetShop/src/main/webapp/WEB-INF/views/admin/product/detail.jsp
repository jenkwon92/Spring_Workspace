<%@page import="com.koreait.petshop.model.domain.TopCategory"%>
<%@page import="com.koreait.petshop.model.domain.Product"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	Product product = (Product)request.getAttribute("product");
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../inc/header.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
body {
	font-family: Arial, Helvetica, sans-serif;
}
* {
	box-sizing: border-box;
}
input[type=text], select, textarea {
	width: 100%;
	padding: 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
	margin-top: 6px;
	margin-bottom: 16px;
	resize: vertical;
}
input[type=submit] {
	background-color: #ca1515;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}
input[type=submit]:hover {
	background-color: #111111;
}
.container {
	border-radius: 5px;
	//background-color: #f2f2f2;
	padding: 20px;
}
</style>
<script>
</script>
</head>
<body>
<%@ include file="../inc/admin_navi.jsp" %>
	<section class="product spad">
	<div class="container">
		<div class="section-title">
			<h4>상품 상세보기</h4>
		</div>
			<p>
				<form enctype="multipart/form-data">
				
					<%-- <input type="hidden" name="product_id" value="<%=product.getProduct_id()%>">
					<select name="country">
						<option value="<%=product.getSubCategory().getTopcategory_id()%>"></option>
					</select>
					<select name="subCategory_id">
						<option value="<%=product.getSubCategory().getSubcategory_id()%>"></option>
					</select>
					
					<input type="text" name="product_name"  value="<%=product.getProduct_name()%>"> 
					<input type="text"  name="price" value="<%=product.getPrice()%>">  
					 <p>상품이미지: <input type="file" name="repImg"></p>
					<textarea id="subject" name="detail" style="height: 200px"><%=product.getDetail()%></textarea> --%>
					<input type="button" value="수정하기">
					<input type="button" value="삭제하기">
					<input type="button" value="목록보기" onClick="location.href='/admin/product/list'">
				</form>
			</p>
		</div>
	</section>
<%@ include file="../../shop/shopFooter.jsp" %>
<%@ include file="../../inc/footer.jsp" %>
</body>
</html>
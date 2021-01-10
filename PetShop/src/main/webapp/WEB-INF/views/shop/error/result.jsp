<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <%@ include file="./../../inc/header.jsp" %>
 <meta name="viewport" content="width=device-width, initial-scale=1">
<style>
/* Add padding to containers */
.container {
  padding: 16px;
  background-color: white;
}
</style>	
<script>

		
</script>
</head>
<body>
	<%@ include file="./../../inc/shop_navi.jsp"%>

	<!-- 에러 출력 페이지 시작 -->
	<section class="product spad">
		<div class="container">
			<h3>이용에 불편을 드려 죄송합니다</h3>
			<hr>
			<h5><%=request.getAttribute("msg") %></h5>
		</div>
	</section>
	<!-- 에러 출력 페이지 종료 -->
	
	<%@ include file="../shopFooter.jsp"%>
	<%@ include file="./../../inc/footer.jsp"%>
</body>

</html>
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

/* Full-width input fields */
input[type=text], input[type=password] {
  width: 99%;
  padding: 15px;
  margin: 5px 0 22px 0;
  display: inline-block;
  border: none;
}


select {
	width: 100%;
	padding: 15px;
 	margin: 5px 0 22px 0;
 	display: inline;
  	border: 1px solid #e1e1e1;
  	font-size: 14px;
  	color: #666666;
  	border-radius: 2px;
}

input[type=text]:focus, input[type=password]:focus ,select:focus {
  background-color: #ddd;
  outline: none;
}

.site-btn:hover {
  background-color: #ddd;
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
			<h1>이용에 불편을 드려 죄송합니다</h1>
			<%=request.getAttribute("msg") %>
		</div>
	</section>
	<!-- 에러 출력 페이지 종료 -->
	
	<%@ include file="../shopFooter.jsp"%>
	<%@ include file="./../../inc/footer.jsp"%>
</body>

</html>
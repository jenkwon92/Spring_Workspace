<%@ page contentType="text/html;charset=UTF-8"%>
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
					<th>번호</th>
					<th>이미지</th>
					<th>카테고리명</th>
					<th>상품명</th>
					<th>가격</th>
				</tr>
				<tr>
					<td>Jill</td>
					<td>Smith</td>
					<td>50</td>
					<td>50</td>
					<td>50</td>
				</tr>
			</table>
			</p>
		</div>
	</section>
<%@ include file="../../shop/shopFooter.jsp" %>
<%@ include file="../../inc/footer.jsp" %>
</body>
</html>

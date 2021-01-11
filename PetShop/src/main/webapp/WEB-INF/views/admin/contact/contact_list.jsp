<%@page import="java.util.List"%>
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
  background-color: #fcfcfc;
}
</style>

<script>
</script>

</head>
<body>
<%@ include file="../inc/admin_navi.jsp" %>
<section  class="product spad">
		<div  class="container" >
			<div class="section-title">
				<h4>팀원</h4>
			</div>
			<P>
			<table>
				<tr>
					<th>이름</th>
					<th>담당업무</th>
					<th >깃허브 주소</th>
				</tr>
				<tr>
					<td>권용은</td>
					<td>회원관리</td>
					<td><a href="https://github.com/jenkwon92">https://github.com/jenkwon92</a></td>
				</tr>	
				<tr>
					<td>손동진</td>
					<td>상품(등록, 수정,삭제) 관리</td>
					<td><a href="https://github.com/sono53124">https://github.com/sono53124</a></td>
				</tr>	
				<tr>
					<td>조혜</td>
					<td>상품목록관리</td>
					<td><a href="https://github.com/johye45">https://github.com/johye45</a></td>
				</tr>	
				<tr>
					<td>최은영</td>
					<td>주문, 결제관리</td>
					<td><a href="#">#</a></td>
				</tr>		
			</table>
			</p>
		</div>
	</section>
<%@ include file="../../shop/shopFooter.jsp" %>
<%@ include file="../../inc/footer.jsp" %>
</body>
</html>
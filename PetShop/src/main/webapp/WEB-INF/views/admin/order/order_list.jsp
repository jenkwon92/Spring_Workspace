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
  text-align: center;
  padding: 10px;
  font-size: x-small;
}
tr:nth-child(even){background-color: #f2f2f2}
</style>
</head>
<body>
<%@ include file="../inc/admin_navi.jsp" %>
	<section class="product spad">

			<div class="section-title">
				<h4>목록</h4>
			</div>
			<div style="overflow-x:auto;">
			  <table>
			    <tr>
			      <th>상품코드</th>
			      <th>상품명</th>
			      <th>가격</th>
			      <th>상품정보</th>
			      <th>구매자아이디</th>
			      <th>구매자이름</th>
			      <th>구매자번호</th>
			      <th>구매자주소</th>
			      <th>구매자메일</th>
			      <th>구매날짜</th>
			    </tr>
			    
			    <tr>
			      <td>Jill</td>
			      <td>Smith</td>
			      <td>50</td>
			      <td>50</td>
			      <td>50</td>
			      <td>50</td>
			      <td>50</td>
			      <td>50</td>
			      <td>50</td>
			      <td>50</td>

			  
			    </tr>	
			  </table>
			</div>

	</section>
<%@ include file="../../shop/shopFooter.jsp" %>
<%@ include file="../../inc/footer.jsp" %>
</body>
</html>
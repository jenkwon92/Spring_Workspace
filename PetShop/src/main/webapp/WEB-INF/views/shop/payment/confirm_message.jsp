<%@page import="com.koreait.petshop.model.domain.Paymethod"%>
<%@page import="java.util.List"%>
<%@page import="com.koreait.petshop.model.domain.OrderSummary"%>
<%@page import="com.koreait.petshop.model.domain.Member"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<% 
	Member member=(Member)session.getAttribute("member");
	OrderSummary orderSummary=(OrderSummary)request.getAttribute("orderSummary");
%>
<!DOCTYPE html>
<html>
<head>
 <%@ include file="./../../inc/header.jsp" %>
 <meta name="viewport" content="width=device-width, initial-scale=1">
<style>
/* 주문목록리스트 */
table {
  border-collapse: collapse;
  border-spacing: 0;
  width: 90%;
  border: 1px solid #ddd;
  margin : auto;
  
}
th, td {
  text-align: center;
  padding: 10px;
  font-size: x-small;
}
tr:nth-child(even){background-color: #f2f2f2}
/* 컨테이너 영역 padding */
.container {
  background-color: white;
}
.site-btn:hover { 
   background-color: #ddd; 
} 
</style>	
</head>
<body>
<%@ include file="./../../inc/shop_navi.jsp"%>

	<!-- 사이트 이동경로 시작 -->
	<div class="breadcrumb-option">
    	<div class="container">
        	<div class="row">
            	<div class="col-lg-12">
                	<div class="breadcrumb__links">
                    	<a href="/"><i class="fa fa-home"></i> Home</a>
                    	<span>OrderCheck</span>
                	</div>
            	</div>
        	</div>
    	</div>
	</div>
	<!-- 사이트 이동경로 종료 -->

	<!-- 감사인사 폼 시작 -->

  
         			<h2 style="text-align:center">"주문이 완료되었습니다"</h2>
         				<div class="row">
         					<div class="col-lg-12">
         						<div class="checkout__form__input">
                     				<p style="text-align:center">
                     					<section class="product spad">

											<div class="section-title">
												
												<p style="font-family:Geneva;text-align:center;font-size:20px" ><%=member.getName()%> 님이 결제확인 목록입니다 </p>
											</div>
											<div style="overflow-x:auto;">
											  <table>
											    <tr>
											      
											      <th>상품명</th>
											      <th>상품가격</th>
											      <th>구매개수</th>
											      <th>구매자이름</th>
											      <th>휴대폰번호</th>
											      <th>수령주소</th>
											      <th>결제방법</th>
											      <th>구매날짜</th>
											      <th>결제금액</th>
											  
											    </tr>
											    
											    <tr>
											      
											      <td></td>
											      <td>50</td>
											      <td>50</td>
											      <td><%=member.getName()%></td>
											      <td><%=member.getPhone()%></td>
											      <td><%=member.getAddr()%></td>
											      <td>50</td>
											      <td>50</td>
											      <td>50</td>
											  
											    </tr>	
											  </table>
											</div>
								
									</section>
                     				</p>                       
                 				</div>
         					</div>	 	
						</div>
             			
             			<div style="text-align: center">
                           	<a href="/"><input type="button" class="site-btn" id="home_btn" value="홈으로 이동" ></a>
                           	<a href="/shop/member/loginForm"><input type="button" class="site-btn" id="login_btn" value="로그인"></a>
                    	</div>
					
				<!-- </div> -->
		
	<!-- 감사인사 폼 종료 -->
	
<%@ include file="../shopFooter.jsp"%>
<%@ include file="./../../inc/footer.jsp"%>
</body>
</html>

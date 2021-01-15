<%@page import="java.util.List"%>
<%@page import="com.koreait.petshop.model.domain.Review"%>
<%@page import="com.koreait.petshop.model.domain.Member"%>
<%@page import="com.koreait.petshop.model.domain.Product"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	Review review =(Review)request.getAttribute("review");
	//out.print("review:"+review);
	Member member =(Member)session.getAttribute("member");//회원에 대한 정보
	//out.print("member:"+member);
	//Product product =(Product)request.getAttribute("product");//내가 본 상품 번호
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="description" content="">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- The above 4 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <!-- Title  -->
    <title>Karl - Fashion Ecommerce Template | Home</title>
	<%@ include file="../../inc/header.jsp" %>
	<style>
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
		
		input[type=button],button {
		  background-color: #4CAF50;
		  color: white;
		  padding: 12px 20px;
		  border: none;
		  border-radius: 4px;
		  cursor: pointer;
		}
		
		input[type=button]:hover {
		  background-color: #45a049;
		}	
	.container {
	  border-radius: 5px;
	  background-color: #f2f2f2;
	  padding: 20px;
	}
	</style>	
	<script>
	
	$(function(){
		$($("input[type='button']")[0]).click(function(){
			del();
		});
		
	});
	function del(){
		if(confirm("삭제 하시겠어요?")){
			$("reviewForm").attr({
				action:"/shop/cs/del",
				method:"get"
			});		
			$("reviewForm").submit();		
		}
	}
	$(function(){
		$($("input[type='button']")[1]).click(function(){
			edit();
		});
		
	});
	function edit(){
		if(confirm("수정 하시겠어요?")){
			$("reviewForm").attr({
				action:"/shop/cs/edit",
				method:"post"
			});		
			$("reviewForm").submit();		
		}
	}
	</script>		
</head>

<body>
    	<%@include file="../../inc/shop_navi.jsp" %>
        <!-- ****** Top Discount Area End ****** -->
		<div class="container">   
		  <form id="reviewForm">
		    <%-- <input type="hidden" name="product_id" value="<%=product.getProduct_id() %>" > --%>
		   

		  	<label>MemberID</label>
		   
		    <input type="hidden" name="member_id" value="<%=review.getMember_id()%>">
		    <input type="text"  value="<%=member.getUser_id()%>">
		    
		    <label>Write</label>
		    
		    <input type="hidden" name="review_id" value="<%=review.getReview_id()%>">
		    <textarea name="reviews"  style="height:200px"><%=review.getReviews() %></textarea>
		    <input type="button"  value="delete">
		    <input type="button" value="edit">
		    <input type="button" value="list" onClick="location.href='/shop/product/detail?product_id=<%=review.getProduct_id()%>';">
		  </form>
	</div>	
        <!-- ****** Footer Area Start ****** -->
        <%@ include file="../../inc/footer.jsp" %>
        <!-- ****** Footer Area End ****** -->
    </div>
    <!-- /.wrapper end -->
</body>

</html>
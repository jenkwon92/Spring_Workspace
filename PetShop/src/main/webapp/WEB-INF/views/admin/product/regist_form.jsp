<%@ page contentType="text/html;charset=UTF-8"%>
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
</head>
<body>
<%@ include file="../inc/admin_navi.jsp" %>
	<section class="product spad">
	<div class="container">
		<div class="section-title">
			<h4>등록</h4>
		</div>
			<p>
				<form action="/action_page.php">
					<select id="country" name="country">
						<option value="australia">상위 카테고리</option>
						<option value="canada">Canada</option>
						<option value="usa">USA</option>
					</select>
					<select id="country" name="country">
						<option value="australia">하위 카테고리</option>
						<option value="canada">Canada</option>
						<option value="usa">USA</option>
					</select>
					<input type="text" id="fname" name="firstname" placeholder="상품명"> 
					<input type="text" id="lname" name="lastname" placeholder="가격"> 
					 
					<textarea id="subject" name="subject" placeholder="Write something.." style="height: 200px">상품설명</textarea>
					<input type="submit" value="Submit">
				</form>
			</p>
		</div>
	</section>
<%@ include file="../../shop/shopFooter.jsp" %>
<%@ include file="../../inc/footer.jsp" %>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <%@ include file="./../../inc/header.jsp" %>
 <meta name="viewport" content="width=device-width, initial-scale=1">
<style>
/* 컨테이너 영역 padding */
.container {
  padding: 16px;
  background-color: white;
}


/* 내용 영역 너비 조정 영역*/
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

/* 로딩 바 스타일 영역 */
.loader {
	width: 40px;
	height: 40px;
	position: absolute;
	top: 55%;
	left: 50%;
	margin-top: -13px;
	margin-left: -13px;
	border-radius: 60px;
 	animation: loader 0.8s linear infinite; 
	-webkit-animation: loader 0.8s linear infinite; 	
}

/* 아이디 사용가능한 경우*/
.id_available{
		color : green;
		display : none;
	}

/* 아이디 사용불가능한 경우 */
.id_unavailable{
	color : red;
	display : none;
}

</style>	
<script>
function login(){
	$("#login_form").attr({
		action:"/shop/member/login",
		method:"post"
	});
	$("#login_form").submit();
}
</script>
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
                        <span>Login</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 사이트 이동경로 종료 -->
	
	<!-- 로그인 폼 시작 -->
	<section class="product spad">
		<div class="container" >
			<form class="checkout__form" id="login_form">
				<div class="row" >
					<div class="col-lg-6" style="margin:0 auto;">
						<h5 >로그인</h5>
						<div class="row">
							<div class="col-lg-12">
								<div class="checkout__form__input">
									<p>아이디<span>*</span></p>
									<input type="text" name="user_id" class="user_id">                                   
								</div>
							</div>
							<div class="col-lg-12">
								<div class="checkout__form__input">
									<p>비밀번호<span>*</span></p>
									<input type="password" name="password">
								</div>
							</div>                        	 	
						</div>
						<hr>
						<div style="text-align: center">
							<input type="button" class="site-btn" value="로그인" onclick="login()">
						</div>
						<br>
						<div style="text-align: center">
							<span style="color:#666666; font-size:12px"><a href="/shop/member/forgot">아이디 찾기 | 비밀번호 찾기</a></span>						
						</div>
					</div>
				</div>
			</form>
		</div>
		<div id="loader" ></div>         
	</section>
	<!-- 로그인 폼 종료 -->
	
<%@ include file="../shopFooter.jsp"%>
<%@ include file="./../../inc/footer.jsp"%>

</body>
</html>
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
                    	<span>Thank you</span>
                	</div>
            	</div>
        	</div>
    	</div>
	</div>
	<!-- 사이트 이동경로 종료 -->

	<!-- 감사인사 폼 시작 -->
	<section class="product spad">
		<div class="container" >
     		<form class="checkout__form" id="member_form">
              <div class="row" >
                  <div class="col-lg-6" style="margin:0 auto;">
         			<h5 style="text-align:center">회원가입을 축하드립니다</h5>
         				<div class="row">
         					<div class="col-lg-12">
         						<div class="checkout__form__input">
                     				<p style="text-align:center">
                     					<span>이메일</span>로 회원가입메일이 발송이 되었습니다.<br>
                     					고객님의 사이트 이용에 불편하지 않도록 노력하겠습니다.<br>
                     					로그인 후 바로 서비스 이용이 가능합니다.<br>
                     					아래버튼을 선택해주세요.<br>
                     				</p>                       
                 				</div>
         					</div>	 	
						</div>
             				<hr>
             			<div style="text-align: center">
                           	<a href="/"><input type="button" class="site-btn" id="home_btn" value="홈으로 이동" ></a>
                           	<a href="/shop/member/loginForm"><input type="button" class="site-btn" id="login_btn" value="로그인"></a>
                    	</div>
					</div>
				</div>
			</form>
		</div>      
	</section>
	<!-- 감사인사 폼 종료 -->
	
<%@ include file="../shopFooter.jsp"%>
<%@ include file="./../../inc/footer.jsp"%>
</body>
</html>
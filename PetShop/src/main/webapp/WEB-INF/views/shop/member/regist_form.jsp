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
	$(function(){
		//아이디 중복검사 (비동기)
		
		//회원가입 처리
		$("input[type='button']").click(function(){
			regist();
		});
	});
	
	function regist(){
		$("#member_form").attr({
			action: "/shop/member/regist",
			method: "post"
		});
		$("#member_form").submit();
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
                        <span>Register</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 사이트 이동경로 종료 -->

	<!-- 회원 가입 폼 시작 -->
	<section class="product spad">
	<div class="container">
      <form class="checkout__form" id="member_form">
               <div class="row" >
                   <div class="col-lg-12">
                       <h5>회원 가입</h5>
                       <div class="row">
                       	<div class="col-lg-12">
                       		<div class="checkout__form__input">
                                   <p>아이디<span>*</span></p>
                                   <input type="text" name="user_id">
                                    <p>이름<span>*</span></p>
                                   <input type="text" name="name">
                               </div>
                       	</div>
                       	
                           <div class="col-lg-6 col-md-6 col-sm-6">
                               <div class="checkout__form__input">
                                   <p>비밀번호<span>*</span></p>
                                   <input type="password" name="password">
                               </div>
                           </div>
                           <div class="col-lg-6 col-md-6 col-sm-6">
                               <div class="checkout__form__input">
                                   <p>비밀번호 확인 <span>*</span></p>
                                   <input type="password">
                               </div>
                           </div>
                           
                           <div class="col-lg-6 col-md-6 col-sm-6">
                               <div class="checkout__form__input">
                                   <p>이메일 주소<span>* </span></p>
                                   <input type="text" name="email_id">
                               </div>
                           </div>
                           <div class="col-lg-6 col-md-6 col-sm-6">
                               <div class="checkout__form__input">
                                   	<p>도메인<span>* </span></p>
                                   <select name="email_server">
                                   	<option selected disabled>선택</option>
									<option value="gmail.com">gmail.com</option>
									<option value="naver.com">naver.com</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="nate.com">nate.com</option>
								</select>	
                               </div>
                           </div>
                           
                           <div class="col-lg-12">
                               <div class="checkout__form__input">
                                   <p>전화번호<span>*</span></p>
                                   <input type="text" name="phone">
                               </div>
                           </div>
                          <div class="col-md-2 col-md-2 col-sm-2" >
                               <div class="checkout__form__input">
                                   <p>우편번호 <span>*</span></p>
                                   <input type="text" name="zipcode">
                               </div>
                           </div>
                           <div class="col-md-10 col-md-10 col-sm-10">
                               <div class="checkout__form__input">
                                   	<p>주소 <span>*</span></p>
                                   	<input type="text" name="addr">
                               	</div>
                          	 	</div>
                          	 	
                           </div>
                           <hr>
                           <div style="text-align: center">
                           <input type="button" class="site-btn" value="가입">
                           </div>
                       </div>
                   </div>
               </form>
           </div>
</section>
	<!-- 회원 가입 폼 종료 -->
	
	<%@ include file="../shopFooter.jsp"%>
	<%@ include file="./../../inc/footer.jsp"%>
</body>

</html>
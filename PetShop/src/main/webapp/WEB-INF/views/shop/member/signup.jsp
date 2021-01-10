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
	$(function(){
		id_duplicate_check();
		
		$("input[type='button']").click(function(){
			regist();
		});
		
		//회원가입 처리
	});
	
	function id_duplicate_check(){
		//아이디 중복검사 (비동기)
		$('.user_id').on("propertychange change keyup paste input", function(){
			
			//console.log("keyup 테스트");	
			var user_id = $('.user_id').val();
			var data = {user_id : user_id}
			
			$.ajax({
				type : "post",
				url : "/shop/member/memberIdChk",
 				data : data,
				success: function(result){
 					//console.log("성공여부"+result);
					if(result != 'fail'){
						$('.id_available').css("display","inline-block");
						$('.id_unavailable').css("display", "none");				
					} else {
						$('.id_unavailable').css("display","inline-block");
						$('.id_available').css("display", "none");				
					}
				}
			}); // ajax 종료
		});// function 종료
	}
	
	//요청이 완료되는 시점에 로딩바를 감춘다
	function regist(){
		//로딩바 시작
		$("#loader").addClass("loader"); //class 동적 적용
		
		//form 태그의 파라미터들을 전송할수있는 상태로 둬야  data키값에 form 자체를 넣을 수 있다.
		var formData = $("#member_form").serialize(); //전부 문자열화 시킨다!!
		
		$.ajax({
			url:"/shop/member/regist",
			type:"post",
			data:formData,
			 async : false,
			success:function(responseData){
				//서버로부터 완료 응답을 받으면 로딩바 효과를 중단!!
				$("#loader").removeClass("loader"); //class 동적 제거
				var json = JSON.parse(responseData);
				if(json.result==1){
					alert(json.msg);
					location.href="/"; //추후 로그인 페이지로 보낼예정
				}else{
					alert(json.msg);
				}
			}
		});
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
                                   <p>아이디<span>*</span>
                                   </p>
                                   		<span class="id_available">사용 가능한 아이디입니다.</span>
										<span class="id_unavailable">아이디가 이미 존재합니다.</span>
                                   <input type="text" name="user_id" class="user_id">
                                    <p>이름<span>*</span></p>
                                   <input type="text" name="name" >
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
			<div id="loader" ></div>         
</section>

	<!-- 회원 가입 폼 종료 -->
	
	<%@ include file="../shopFooter.jsp"%>
	<%@ include file="./../../inc/footer.jsp"%>

</body>

</html>
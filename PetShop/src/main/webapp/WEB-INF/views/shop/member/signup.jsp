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
input[type=text], input[type=password] , .address_button{
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

input[type=text]:focus, input[type=password]:focus ,select:focus , .address_button:focus{
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
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	
	$(function(){
		id_duplicate_check();
		
		//회원가입 처리
		$(".site-btn").click(function(){
			regist();
		});
		
		
	});
	
	/* 아이디 중복겁사(비동기) */
	function id_duplicate_check(){
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
	
	/* 주소 API연동 */
	function execution_addr(){
		new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	        	 var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    //주소 변수 문자열과 참고항목 문자열 합치기
	                    addr += extraAddr;
	                
	                } else {
	                    addr += ' ';
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('zipcode').value = data.zonecode;
               		document.getElementById('addr_1').value = addr;
               	 	$('#addr_2').attr("readonly",false);
                	// 커서를 상세주소 필드로 이동한다.
               		 document.getElementById('addr_2').focus();
	        }
	    }).open(); 
		
	}
	
	//요청이 완료되는 시점에 로딩바를 감춘다
	function regist(){
		// 주소+ 상세주소 연결
		var addr_1 = $('#addr_1').val();
		var addr_2 = $('#addr_2').val();
		
		var addr= addr_1 + " "+addr_2;
		document.getElementById('addr').value = addr;
		
		//로딩바 시작
		$("#loader").addClass("loader"); //class 동적 적용
		
		//form 태그의 파라미터들을 전송할수있는 상태로 둬야  data키값에 form 자체를 넣을 수 있다.
		var formData = $("#member_form").serialize(); //전부 문자열화 시킨다!!
		
		$.ajax({
			url:"/shop/member/regist",
			type:"post",
			data:formData,
			success:function(responseData){
				//서버로부터 완료 응답을 받으면 로딩바 효과를 중단!!
				$("#loader").removeClass("loader"); //class 동적 제거
				var json = JSON.parse(responseData);
				if(json.result==1){
					alert(json.msg);
					location.href="/shop/member/thanksForm"; //추후 로그인 페이지로 보낼예정
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
                          <div class="col-md-6 col-md-6 col-sm-6" >
                               <div class="checkout__form__input">
                                   <p>우편번호 <span>*</span></p>
                                   <input type="text" id="zipcode" name="zipcode" readonly="readonly">                                   
                               </div>
                           </div>
                            <div class="col-md-6 col-md-6 col-sm-6" >
                               <div class="checkout__form__input">
                               	<p> 　<span> </span></p>
                                  <input type="button" class="address_button" onclick="execution_addr()" value="우편번호 검색"  >                              
                               </div>
                           </div>
                                  
                           <div class="col-md-12">
                               <div class="checkout__form__input">
                                   	<p>주소 <span>*</span></p>
                                   	<input type="text" id="addr_1" readonly="readonly">
                                   	<input type="text" id="addr_2" readonly="readonly">
                                   	<input type="hidden" id="addr" name="addr" value="">
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
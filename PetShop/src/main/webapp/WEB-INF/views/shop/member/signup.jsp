<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
 <%@ include file="./../../inc/header.jsp" %>
 <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/resources/css/signup_style.css" type="text/css">

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(function(){
		/* 아이디 중복 체크 */		
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
						idckCheck = true;
					} else {
						$('.id_unavailable').css("display","inline-block");
						$('.id_available').css("display", "none");				
						idckCheck = false;
					}
				}
			}); // ajax 종료
		});// function 종료
		
		/* 비밀번호 확인 */
		$('.pwdCheck').on("propertychange change keyup paste input", function(){
			var pwd = $('.password').val();
			var pwdck = $('.pwdCheck').val();
			$('.final_pwck_ck').css('display', 'none');
		    
		    if(pwd == pwdck){
		    	$('.pwdck_1').css("display","inline-block");
				$('.pwdck_2').css("display", "none");		
				pwd_pwdckCheck = true;
			} else {
				$('.pwdck_2').css("display","inline-block");
 				$('.pwdck_1').css("display", "none");	
 				pwd_pwdckCheck = false;	
 			}
 		});
		
		/* 유효성 검사 통과유무 변수*/
		var idCheck = false;
		var idckCheck = false; 
		var nameCheck = false;
		var pwdCheck = false;
		var pwdckCheck = false;
		var pwd_pwdckCheck = false;
		var mailIdCheck = false;
		var mailServerCheck = false;
		var phoneCheck = false;
		var zipcodeCheck = false;
		var addrCheck = false;	 
		
		//회원가입 처리
		$("#regist").click(function(){
			var user_id = $('.user_id').val();
			var name = $('.name').val();
			var password = $('.password').val();
			var pwdCheck = $('.pwdCheck').val();
			var email_id = $('.email_id').val();
			var email_server = $('.email_server').val();
			var phone = $('.phone').val();
			var zipcode = $('.zipcode').val();
			var addr = $('.addr_2').val();
			
			/* 아이디 유효성 확인 */
			if(user_id == ""){
				$('.final_user_id_ck').css('display', 'inline');
				idCheck = false;
			}else{
				$('.final_user_id_ck').css('display', 'none');
				idCheck = true;
			}
			
			/* 이름 유효성 확인 */
			if(name  == ""){
				$('.final_name_ck').css('display', 'inline');
				nameCheck = false;
			}else{
				$('.final_name_ck').css('display', 'none');
				nameCheck = true;
			}
			
			/* 비밀번호 유효성 확인 */
			if(password == ""){
				$('.final_password_ck').css('display', 'inline');
				pwdCheck = false;
			}else{
				$('.final_password_ck').css('display', 'none');
				pwdCheck = true;
			}
			
			/* 비밀번호 재입력 유효성 확인 */
			if(pwdCheck  == ""){
				$('.final_pwdck_ck').css('display', 'inline');
				pwdckCheck = false;
			}else{
				$('.final_pwdck_ck').css('display', 'none');
				pwdckCheck = true;
			}
			
			/* 이메일 id 유효성 검사 */
			if(email_id  == ""){
				$('.final_email_id_ck').css('display', 'inline');
				mailIdCheck = false;
			}else{
				$('.final_email_id_ck').css('display', 'none');
				mailIdCheck = true;
			}
			
			/* 이메일 server 유효성 검사 */
			if(email_server  == null){
				$('.final_email_server_ck').css('display', 'inline');
				mailServerCheck = false;
			}else{
				$('.final_email_server_ck').css('display', 'none');
				mailServerCheck = true;
			}
			
			/* 핸드폰 유효성 검사 */
			if(phone  == ""){
				$('.final_phone_ck').css('display', 'inline');
				phoneCheck = false;
			}else{
				$('.final_phone_ck').css('display', 'none');
				phoneCheck = true;
			}
			
			/* 우편번호 유효성 검사 */
			if(zipcode  == ""){
				$('.final_zipcode_ck').css('display', 'inline');
				zipcodeCheck = false;
			}else{
				$('.final_zipcode_ck').css('display', 'none');
				zipcodeCheck = true;
			}
			
			/* 주소 유효성 검사 */
			if(addr  == ""){
				$('.final_addr_ck').css('display', 'inline');
				addrCheck = false;
			}else{
				$('.final_addr_ck').css('display', 'none');
				addrCheck = true;
			}
			
			 if(idCheck&&idckCheck &&nameCheck &&pwdCheck &&pwdCheck &&pwd_pwdckCheck &&mailIdCheck &&mailServerCheck &&phoneCheck && zipcodeCheck &&addrCheck){
				//회원등록
				regist();
		     }  	
			 return false;
		});		
	});
	
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
									<p>아이디
										<span class="id_available">　사용 가능한 아이디입니다</span>
										<span class="id_unavailable">　이미 사용중인 아이디입니다</span>
										<span class="final_user_id_ck">　아이디를 입력해주세요</span>
									</p>
									<input type="text" name="user_id" class="user_id">
									<p>이름<span class="final_name_ck">　이름을 입력해주세요</span></p>
									<input type="text" name="name" class="name">
								</div>
							</div>
							<div class="col-lg-6 col-md-6 col-sm-6">
								<div class="checkout__form__input">
									<p>비밀번호<span class="final_password_ck">　비밀번호를 입력해주세요</span></p>
									<input type="password" name="password" class="password">
								</div>
							</div>
							<div class="col-lg-6 col-md-6 col-sm-6">
								<div class="checkout__form__input">
									<p>비밀번호 확인
										<span class="pwdck_1">　비밀번호가 일치합니다.</span>
										<span class="pwdck_2">　비밀번호가 일치하지 않습니다.</span>
										<span class="final_pwdck_ck">　비밀번호 확인을 입력해주세요</span>
									</p>
									<input type="password" class="pwdCheck">
								</div>
							</div>
							<div class="col-lg-6 col-md-6 col-sm-6">
								<div class="checkout__form__input">
									<p>이메일 주소<span class="final_email_id_ck">　이메일 주소를 입력해주세요</span></p>
									<input type="text" name="email_id" class="email_id">
								</div>
							</div>
							<div class="col-lg-6 col-md-6 col-sm-6">
								<div class="checkout__form__input">
									<p>도메인<span class="final_email_server_ck">　도메인을 선택해주세요</span></p>
									<select name="email_server" class="email_server">
										<option selected disabled value="select">선택</option>
										<option value="gmail.com">gmail.com</option>
										<option value="naver.com">naver.com</option>
										<option value="hanmail.net">hanmail.net</option>
										<option value="nate.com">nate.com</option>
									</select>	
								</div>
							</div>
							<div class="col-lg-12">
								<div class="checkout__form__input">
									<p>전화번호<span class="final_phone_ck">　전화번호를 입력해주세요</span></p>
									<input type="text" name="phone" class="phone">
								</div>
							</div>
							<div class="col-md-6 col-md-6 col-sm-6" >
								<div class="checkout__form__input">
									<p>우편번호 <span class="final_zipcode_ck">　우편번호를 입력해주세요</span></p>
									<input type="text" id="zipcode" class="zipcode" name="zipcode" readonly="readonly">                                   
								</div>
							</div>
							<div class="col-md-6 col-md-6 col-sm-6" >
								<div class="checkout__form__input">
									<p> 　</p>
								<input type="button" class="address_button" onclick="execution_addr()" value="우편번호 검색"  >                              
							</div>
						</div>
						<div class="col-md-12">
							<div class="checkout__form__input">
								<p>주소<span class="final_addr_ck">　주소를 입력해주세요</span></p>
								<input type="text" id="addr_1" readonly="readonly">
								<input type="text" id="addr_2" class="addr_2" readonly="readonly">
								<input type="hidden" class="addr" id="addr" name="addr" value="">
							</div>
						</div>
					</div>
					<hr>
					<div style="text-align: center">
						<input type="button" class="site-btn" id="regist" value="가입">
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
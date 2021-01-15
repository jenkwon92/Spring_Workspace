<%@page import="com.koreait.petshop.model.domain.Member"%>
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
  display: inline;
  border: none;
}

input[type=text]:focus, input[type=password]:focus ,select:focus {
  background-color: #ddd;
  outline: none;
}

select {
	padding: 15px;
 	margin: 5px 0 22px 0;
  	border: 1px solid #e1e1e1;
  	font-size: 14px;
  	color: #666666;
  	border-radius: 2px;
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

ul.tabs{
	margin: 0px;
	padding: 0px;
	list-style: none;
}
ul.tabs li{
	background: none;
	color: #222;
	display: inline-block;
	padding: 10px 15px;
	cursor: pointer;
}

ul.tabs li.current{
	background: #f7f7f7;
	color: #222;
}

.tab-content{
	display: none;
	padding: 15px;
	background: #f7f7f7;
}

.tab-content.current{
	display: inherit;
}

</style>	
<script>
$(document).ready(function(){
	$('ul.tabs li').click(function(){
// 		console.log($("#m_name").val());
// 		console.log($("#phone").val());
		
		$("#m_name").val(""); 
		$("#phone").val("");  
		$("#idList").empty();
		
		var tab_id = $(this).attr('data-tab');

		$('ul.tabs li').removeClass('current');
		$('.tab-content').removeClass('current');

		$(this).addClass('current');
		$("#"+tab_id).addClass('current');
		
		
	})
})

$(document).on('click','#idBtn',function(){
 		var user_name = $('#m_name').val();
  	var user_phone = $('#phone').val();

 	var postData = {'name' : user_name , 'phone' : user_phone};

	$.ajax({
        url:' /shop/member/forgot_id',
        type:'POST',
        data: postData,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType : "json",

        success:function(data){
        	var idLists = data.user_id;
        	var idLength = idLists.length
        	var idfind = idLists.substring(1, idLength-1)
       	 		 $("#idList").html("<p>"+"회원님의 정보로 등록된 아이디는 : <br>"+idfind+" 입니다.</p>")
        },
        error: function (XMLHttpRequest, textStatus, errorThrown){
        	alert('등록된 정보를 찾을 수 없습니다.' );
        }
    });
});

$(document).on('click','#pwdBtn',function(){
		console.log($("#user_id").val());
		console.log($("#email_id").val());
		console.log($("#email_server").val());

		var formData = $("#pwd_form").serialize(); //전부 문자열화 시킨다!!
 	$.ajax({
		url:"/shop/member/forgot_pwd",
		type:"post",
		data:formData,
		success:function(responseData){
			//서버로부터 완료 응답을 받으면 로딩바 효과를 중단!!
			$("#loader").removeClass("loader"); //class 동적 제거
			alert(responseData.msg)
			location.href=responseData.url;
		}
	});
});


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
                        <span>Forgot</span>
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
						<ul class="tabs">
							<li class="tab-link current" data-tab="tab-1">아이디 찾기</li>
							<li class="tab-link" data-tab="tab-2">비밀번호 찾기</li>
						</ul>
						<div class="row">
							<div class="col-lg-12">
								<div id="tab-1" class="tab-content current">
									<form id="id_form">
										<div class="checkout__form__input">
											<br>
											<p>이름<span>*</span></p>
											<input type="text" name="name" id="m_name"> 
										</div>                  
										<div class="checkout__form__input">
											<p>등록된 휴대폰<span>*</span></p>
											<input type="text" name="phone" id="phone">
										</div>
										<div style="text-align: center">
											<input type="button" class="site-btn" value="찾기"   id="idBtn">
										</div>
										<br>
										<span id="idList"></span>
									</form>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-lg-12">
								<div id="tab-2" class="tab-content">
									<form id="pwd_form">
										<div class="checkout__form__input">
											<br>
											<p>아이디<span>*</span></p>
											<input type="text" name="user_id" id="user_id"> 
											<p>등록된 이메일주소<span>*</span></p>
											<div class="checkout__form__input" >
												<input type="text" name="email_id" style="display: inline-block; width:55%" id="email_id">  
												 @ <select name="email_server" style="display: inline-block; width:40%" id="email_server">
													<option selected disabled value="select">선택</option>
													<option value="gmail.com">gmail.com</option>
													<option value="naver.com">naver.com</option>
													<option value="hanmail.net">hanmail.net</option>
													<option value="nate.com">nate.com</option>
												</select>	
											</div>
										</div>
										<div style="text-align: center">	
											<input type="button" class="site-btn" value="찾기"  id="pwdBtn">
										</div>
									</form>
								</div>
							</div>
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
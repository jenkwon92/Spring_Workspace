<%@page import="com.koreait.petshop.model.domain.Member"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	Member member = (Member)request.getSession().getAttribute("member");
%>
<!DOCTYPE html>
<html lang="zxx">

<head>
 <%@ include file="./../../inc/header.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/resources/css/signup_style.css" type="text/css">
<script>
//요청이 완료되는 시점에 로딩바를 감춘다
function delete(){
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
                        <a href="/shop/member/mypage_order"><i class="fa fa-home"></i> Mypage</a>
                        <span>Withdrawal</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 사이트 이동경로 종료 -->

	<!-- 회원탈퇴 폼 시작 -->
	<section class="product spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-2 col-md-2">
					<div class="blog__sidebar">
						<div class="blog__sidebar__item">
							<div class="section-title">
								<h4>My Page</h4>
							</div>
							<ul>
								<li><a href="/shop/member/mypage_cart">주문내역 </a></li>
								<li><a href="/shop/member/mypage_profile">계정관리 </a></li>
								<li><a href="/shop/memeber/mypage_delete">회원탈퇴 </a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="col-lg-9 col-md-9">
					<form class="checkout__form" id="login_form">
						<div class="row" >
							<div class="col-lg-6" style="margin:0 auto;">
								<h5 style="text-align:center">회원 탈퇴</h5>
								<div class="row">
									<div class="col-lg-12">
										<p style="text-align: center">비밀번호를 입력한 후 회원탈퇴하기 버튼을 클릭해주세요<br>
										<span style="color: red">회원탈퇴 후에는 취소가 불가</span>합니다.</p>
										<hr>
										<div class="checkout__form__input">
											<p>아이디</p>
											<input type="text" name="user_id" class="user_id" value="<%=member.getUser_id() %>" disabled>                                   
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
									<input type="button" class="site-btn" value="회원탈퇴" onclick="delete()">
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<!-- 회원탈퇴 폼 종료 -->
	
<%@ include file="../shopFooter.jsp"%>
<%@ include file="./../../inc/footer.jsp"%>
</body>
</html>
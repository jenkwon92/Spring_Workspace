<%@page import="com.koreait.petshop.model.domain.TopCategory"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	List<TopCategory> topList = (List)request.getAttribute("topList");
%>
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
input[type=button] {
	background-color: #ca1515;
	color: white;
	padding: 12px 20px;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	margin : 10px 10px 0px 0px;
}
input[type=button]:hover {
	background-color: #111111;
}
.container {
	border-radius: 5px;
	//background-color: #f2f2f2;
	padding: 20px;
}
#dragArea{
	width:100%;
	height:180px;
	border:1px solid #ced4da;
	border-radius: 5px 5px 5px 5px;
}
.filebox input[type="file"] { 
	position: absolute; 
	padding: 0; 
	overflow: hidden; 
	clip:rect(0,0,0,0); 
	border: 0; 
}
.filebox label { 
	display: inline-block; 
	padding: .5em .75em; 
	background-color: #ca1515;
	font-size: inherit; 
	line-height: normal; 
	vertical-align: middle; 
	cursor: pointer; 
	border: 1px solid #ebebeb; 
	border-bottom-color: #e2e2e2; 
	border-radius: .25em; 
	color: white;
}
.filebox .upload-name {
	height:38px;
	border: 1px solid #ebebeb; 
	border-radius: .25em;
}
.filebox img{
	width:80px;
	height:80px;
}
.box{
	width:100px;
	float:left;
	padding:5px;
	margin:0px;
}
.box > img{
	width:100%; 
	margin: 0px 0px 5px 0px;
}
.close{
	color:red;
	cursor:pointer;
}
</style>

<script>
var uploadFiles=[]; //미리보기 이미지 목록 
var psize=[] ; //유저가 선택한 사이즈를 담는 배열 
var color=[] ; //유저가 선택한 색상을 담는 배열 
$(function(){
	
	CKEDITOR.replace( 'detail' );
	$($("select")[0]).change(function(){
		
		getSubList(this);		
		
	});
	
	/*이미지 드래그*/
	
	$("#dragArea").on("dragenter", function(e){
		$("#dragArea").css("border","2px solid blue");
	});
	
	$("#dragArea").on("dragover", function(e){ //드래그영역 위에 있는 동안...
		e.preventDefault();
	});
	
	$("#dragArea").on("drop", function(e){ //드래그영역 위에서 이미지를 떨구면..
		e.preventDefault(); //여타 다른 이벤트를 비활성화시키자...
		$("#dragArea").css("border","1px solid #ced4da");
		
		//자바스크립트로 드래그된 이미지 정보를 구해와서, div영역에 미리보기 효과..
		var fileList = e.originalEvent.dataTransfer.files; //드래그한 파일들에 대한 배열 얻기!!
		console.log("fileList : ",fileList);
		
		//배열안에 들어있는 이미지들에 대한 미리보기처리...
		for(var i=0;i<fileList.length;i++){
			uploadFiles.push(fileList[i]); //fileList안의 요소들을 일반배열에 옮겨심기 
			//왜 심었나? 배열이 지원하는 여러 메서드들을 활용하기 위해...(ex : indexOf..)
			preview(uploadFiles[i], i,"#dragArea"); //파일 요소 하나를 넘기기
		}
	});
	
	$("#dragArea").on("dragleave", function(e){ //드래그 영역에서 빠져나가면
		$("#dragArea").css("border","1px solid #ced4da");
	});
	
	//
	$("label").on("mouseover",function(){
		$("label").css("background","black");
	});
	$("label").on("mouseout",function(){
		$("label").css("background","#ca1515");
	});	
	//대표 이미지 파일명 출력
	var fileTarget = $(".filebox .upload-hidden"); 
	fileTarget.on("change", function(e){ // 값이 변경되면
		if(window.FileReader){ // modern browser
			if($(this)[0].files[0].name!=null){				
				var filename = $(this)[0].files[0].name; 
				var file= $(this)[0].files[0];
			}
		} else { // old IE 
			var filename = $(this).val().split("/").pop().split("\\").pop(); // 파일명만 추출 
			console.log("this.val",$(this)[0].val());
		} // 추출한 파일명 삽입 
		console.log("this.files : "+$(this)[0].files[0]);
		$(this).siblings(".upload-name").val(filename); 
		
		preview(file, 1,".filebox"); //파일 요소 하나를 넘기기
	}); 
	
	
	//추가 이미지 삭제 이벤트 처리
	$("#dragArea").on("click",function(e){
		console.log(e.target.id);
		
		var f = uploadFiles[e.target.id];
		var index = uploadFiles.indexOf(f); //파일 객체가 몇번째 들어있는지 추출
		
		//alert("클린한거 = "+e.target.id)
		uploadFiles.splice(index, 1);
		if(e.target.id>=0){
			$(e.target).parent().remove();			
		}
	});
	
	//사이즈 체크박스 이벤트 구현 
	$("input[name='size']").on("click", function(e){
		//var ch = e.target;//이벤트 일으킨 주체컴포넌트 즉 체크박스
		//체크박스의 길이 얻기 
		var ch=$("input[name='size']");
		var len =$(ch).length; //반복문이용하려고..
	
		
		psize=[];//배열 초기화
		console.log("채우기 전 psize의 길이는 ",psize.length);
		
		for(var i=0;i<len;i++){
			//만일 체크가 되어있다면, 기존 배열을 모두 지우고, 체크된 체크박스 값만 배열에 넣자!!
			if($($(ch)[i]).is(":checked")){
				psize.push($($(ch)[i]).val());
			}
			console.log(i,"번째 체크박스 상태는 ", $($(ch)[i]).is(":checked"));
		}		
		console.log("psize의 길이는 ",psize.length);
		console.log("서버에 전송할 사이즈 배열의 구성은 ", psize);
	});
	
	//컬러 체크박스 이벤트
	$("input[name='colorcheck']").on("click", function(e){
		//alert($($("input[type='color']")[0]).val());
		//var ch = e.target;//이벤트 일으킨 주체컴포넌트 즉 체크박스
		//체크박스의 길이 얻기 
		var ch=$("input[name='colorcheck']");
		var len =$(ch).length; //반복문이용하려고..
	
		
		color=[];//배열 초기화
		//console.log("채우기 전 color의 길이는 ",color.length);
		
		
		for(var i=0;i<len;i++){
			//만일 체크가 되어있다면, 기존 배열을 모두 지우고, 체크된 체크박스 값만 배열에 넣자!!
			if($($(ch)[i]).is(":checked")){		
				console.log($($("input[type='color']")[i]).val());		
				color.push($($("input[type='color']")[i]).val());
			}
			//console.log(i,"번째 체크박스 상태는 ", $($(ch)[i]).is(":checked"));
		}		
		console.log("color의 길이는 ",color.length);
		console.log("서버에 전송할 컬러 배열의 구성은 ", color);
	});
	
});
function getSubList(obj){
	//alert($(obj).val());
	$.ajax({
		url:"/admin/product/sublist",
		type:"get",
		data:{
			topcategory_id:$(obj).val()
		},
		success:function(result){
			//alert("서버로 받은 결과 "+result[0].topcategory_id);
			$($("select")[1]).empty();
			$($("select")[1]).append("<option>하위 카테고리</option>")
			for(var i=0; i<result.length; i++){
				var subCategory = result[i];
				$($("select")[1]).append("<option value=\""+subCategory.subcategory_id+"\">"+subCategory.name+"</option>")
			}
		}
	});
	
}
//업로드 이미지 미리보기
function preview(file, index, c){
	//js로 이미지 미리보기를 구현하려면, 파일리더를 이용하면 된다 FileReader
	var reader = new FileReader(); //아직은 읽을 대상 파일이 결정되지 않음..
	//파일일 읽어들이면, 이벤트 발생시킴 
	reader.onload=function(e){
		//console.log(e.currentTarget.size);
		
		if(c=="#dragArea"){			
			var tag="<div class=\"box\" id=\"box\">";
			tag+="<div class=\"close\" id=\""+index+"\">X</div>";
			tag+="<img src=\""+e.currentTarget.result+"\">";
			tag+="</div>";
		}else{
			if($("input[type='file']").val()!=null){				
				$("img").remove("#mainImage");
			}
			var tag="<img id='mainImage' src=\""+e.currentTarget.result+"\">";
		}
		
		$(c).append(tag);
		
	};
	
	reader.readAsDataURL(file); //지정한 파일을 읽는다(매개변수로는 파일이 와야함)
}
function regist(){
	var formData = new FormData(document.getElementById('data'));//<form>태그와는 틀리다..전송할때 파라미터들을 담을수있지만 이 자체가
																								//폼태그는 아니다!!
	//미리보기했떤 이미지들은 파일컴포넌트화 되어있지 않기 때문에 , 전송데이터에서 빠져잇다..
	//따라서 formData전송 전에, 동적으로 파일컴포넌트화시켜 formData에 추가하자!!!
	//java에서의 improved for문과 동일한 역할(주로 컬렉션에서 객체를 꺼낼때 편하게 사용..)
	$.each(uploadFiles, function( i, file){
		formData.append("addImg", file,  file.name); // <input type="file" name="addImg> 동일한 효과
		console.log(file.name);
	});	
	
	//폼데이터에 에디터의 값 추가하기!!
	formData.append("detail", CKEDITOR.instances["detail"].getData());
	for(var i=0;i<psize.length;i++){
		console.log("psize["+i+"]번째 form data 추가", psize[i]);
		formData.append("psize["+i+"].petfit", psize[i]);
	}
	for(var i=0;i<color.length;i++){
		console.log("color i번째 form data 추가", color[i]);
		formData.append("color["+i+"].picker", color[i]);
	}
	/* console.log($('form [name="topcategory_id"]').val());
	console.log($('form [name="subcategory_id"]').val());
	console.log($('form [name="price"]').val());
	console.log($('form [name="detail"]').val()); */
	$.ajax({
		url:"/async/admin/product/regist",
		data:formData,
		contentType:false,
		processData:false,
		type:"post",
		success:function(responseData){
			if(responseData.resultCode==1){
				alert(responseData.msg);
				location.href=responseData.url;
			}else{
				alert(responseData.msg);
			}
		}
	});
}
</script>
</head>
<body>
<%@ include file="../inc/admin_navi.jsp" %>
	<section class="product spad">
	<div class="container">
		<div class="section-title">
			<h4>등록</h4>
		</div>
			<form id="data">
						
				<select name="topcategory_id">
					<option value="<%=topList.size()+1%>">상위 카테고리</option>
					<%for(TopCategory topCategory : topList){ %>
					<option value="<%=topCategory.getTopcategory_id()%>"><%=topCategory.getName() %></option>
					<%} %>
				</select>
				<select name="subCategory.subcategory_id">
					<option>하위 카테고리</option>
				</select>
				<input type="text" name="product_name" placeholder="상품명"> 
				<input type="text" name="price" placeholder="가격"> 
				
				<div class="filebox"> 
					<input class="upload-name" value="파일이름" disabled="disabled"> 
					<label for="ex_filename">업로드</label> 
					<input type="file" id="ex_filename" class="upload-hidden" name="repImg"> 
				</div>
				
				<div id="dragArea">
					<p>등록할 이미지를 드래그 해주세요.</p>
				</div>
				
				<p>
					XS<input type="checkbox" 	name="size" value="XS">
					S<input type="checkbox" 		name="size" value="S">
					M<input type="checkbox" 	name="size" value="M">
					L<input type="checkbox" 		name="size" value="L">
					XL<input type="checkbox" 	name="size" value="XL">
					XXL<input type="checkbox" 	name="size" value="XXL">
				</p>
				
				<p>
					<input type="checkbox" 	name="colorcheck">
					<input type="color" value="#ccfefe">
					<input type="checkbox" 	name="colorcheck">
					<input type="color" value="#ffffff">
					<input type="checkbox" 	name="colorcheck">
					<input type="color" value="#000000">
					<input type="checkbox" 	name="colorcheck">
					<input type="color" value="#fdfdfd">
					<input type="checkbox" 	name="colorcheck">
					<input type="color" value="#0000ff">
					<input type="checkbox" 	name="colorcheck">
					<input type="color" value="#ff0000">
				</p>	
				
				<textarea name="detail">상품설명</textarea>
				<input type="button" value="상품등록" onClick="regist()">
				<input type="button" value="목록으로" onClick="location.href='/admin/product/list'">
			</form>
		</div>
	</section>
<%@ include file="../../shop/shopFooter.jsp" %>
<%@ include file="../../inc/footer.jsp" %>
</body>
</html>
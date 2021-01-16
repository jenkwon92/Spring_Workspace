<%@page import="com.koreait.petshop.model.domain.Image"%>
<%@page import="com.koreait.petshop.model.domain.SubCategory"%>
<%@page import="com.koreait.petshop.model.domain.Color"%>
<%@page import="com.koreait.petshop.model.domain.TopCategory"%>
<%@page import="com.koreait.petshop.model.domain.Product"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
Product product = (Product)request.getAttribute("product");
	List<TopCategory> topList = (List)request.getAttribute("topList");
	List<SubCategory> subList = (List)request.getAttribute("subList");
	SubCategory subCategory = (SubCategory)request.getAttribute("subCategory");
	List<Image>addonList = (List)request.getAttribute("addonList");
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
input[type=checkbox]{
	padding-left:50px;
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
	overflow: auto;
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
.del{
	color:red;
	cursor:pointer;
}
input[name=color]{
	width:50px;
	height:30px;
	font-size:5px;
}
</style>
<script>
var uploadFiles=[]; //미리보기 이미지 목록 
var psize=[]; //유저가 선택한 사이즈를 담는 배열 
var color=[]; //유저가 선택한 색상을 담는 배열 
//값 불러올때 쓸 변수
var id; 
var name; 
var thumbnail;
var newThum;
var oldThum;
var sizeArray=[];
var colorArray=[];
var delAdd=[];
var editAdd=[];
$(function(){
		thumbnail="<%=product.getProduct_id()%>.<%=product.getFilename()%>";
		oldThum="<%=product.getFilename()%>";
	<%
		for(int i=0; i<addonList.size(); i++){
		Image addon=addonList.get(i);
		String fileName =addon.getImage_id()+"."+addon.getFilename();
		int fileId=addon.getImage_id();
	%>
		delAdd.push("<%=fileName%>");
		var tag="<div class=\"box\" id=\"box\">";
		tag+="<div class=\"close\" name=\""+<%=fileId%>+"\" id=\"edit\">X</div>";
		tag+="<img src=\"/resources/data/addon/"+"<%=fileName%>"+"\">";
		tag+="</div>";
		$("#dragArea").append(tag);
	<%}%>
	
	//셀렉트 박스 변경
	$($("select")[0]).val(<%=subCategory.getTopcategory_id()%>).prop("selected", true);
	<%for(int i=0; i< subList.size(); i++){
		SubCategory select= subList.get(i);
	%>
		id="<%=select.getSubcategory_id()%>";
		name="<%=select.getName()%>";
		$($("select")[1]).append("<option value=\""+id+"\">"+name+"</option>");	
		console.log("id = ",id);
	<%}%>
	$($("select")[1]).val(<%=subCategory.getSubcategory_id()%>).prop("selected", true);
	
	//사이즈 체크 박스 값 불러오기
	<%for(int i=0; i<product.getPsizeList().size(); i++){%>
		sizeArray[<%=i%>]="<%=product.getPsizeList().get(i).getPetfit()%>";
	<%}%>	
	console.log("arr값 ",sizeArray);
	for(var i=0; i<$("input:checkbox[name='size']").length; i++){
		console.log("체크박스 값",$($("input:checkbox[name='size']")[i]).val());
			switch(sizeArray[i]){
				case sizeArray[i]:$("input:checkbox[value='"+sizeArray[i]+"']").prop("checked",true);
				break;
			}
	}
	psizeCheck();//사이즈 값 넣는
	
	//색상 체크박스+텍스트 불러오기
	var a=<%=product.getPsizeList().size()%>;
	<%for(int i=0; i<product.getColorList().size(); i++){%>
		colorArray[<%=i%>]="<%=product.getColorList().get(i).getPicker()%>";
	<%}%>	
	console.log("colorArray 값 ",colorArray);
	for(var a=0; a<colorArray.length; a++){	
		switch(colorArray[a]){
			case colorArray[a]:
				$($("input:checkbox[name='colorcheck']")[a]).prop("checked",true);
				$($("input:text[name='color']")[a]).prop("value",colorArray[a]);
				var c =colorArray[a];
				color.push(c);
				break;
		}
	}
});
$(function(){
	
	CKEDITOR.replace('detail');	
	
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
			if(fileList.length==1){
				preview(fileList[i], i,"#dragArea"); //파일 요소 하나를 넘기기							
			}else{
				preview(uploadFiles[i], i,"#dragArea"); //파일 요소 하나를 넘기기								
			}
		}
	});
	
	$("#dragArea").on("dragleave", function(e){ //드래그 영역에서 빠져나가면
		$("#dragArea").css("border","1px solid #ced4da");
	});
	
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
				newThum= $(this)[0].files[0];
			}
		} else { // old IE 
			var filename = $(this).val().split("/").pop().split("\\").pop(); // 파일명만 추출 
			console.log("this.val",$(this)[0].val());
		} // 추출한 파일명 삽입 
		console.log("this.files : "+$(this)[0].files[0].name);
		$(this).siblings(".upload-name").val(filename); 
		
		preview(newThum, 1,".filebox"); //파일 요소 하나를 넘기기
	});
	
	$("#dragArea").on("click", ".close", function(e){
		//대상 요소 배열에서 삭제
		//삭제전에 uploadFiles 라는 배열에 들어있는 file의 index를 구하자!!
		var f = uploadFiles[e.target.id];
		
		if(e.target.id=="edit"){			
			alert($(this).attr("name"));
			editAdd.push($(this).attr("name"));
			console.log("수정시 삭제될 이미지 id : ",editAdd);
		}
		
		var index = uploadFiles.indexOf(f); //파일 객체가 몇번째 들어있는지 추출
		
		uploadFiles.splice(index ,1);	
		//대상 요소 삭제 (시각적으로 삭제) 
		
		$(e.target).parent().remove();
	});
	
	
	//사이즈 체크박스 이벤트 구현 
	$("input[name='size']").on("click", function(e){
		psizeCheck();
	});
	
	//컬러 체크박스 이벤트
	$("input[name='colorcheck']").on("click", function(e){
		colorCheck();
	});
	
});
function psizeCheck(){
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
}
function colorCheck(){
	var ch=$("input[name='colorcheck']");
	var len =$(ch).length; //반복문이용하려고..
	color=[];//배열 초기화
	
	for(var i=0;i<len;i++){
		//만일 체크가 되어있다면, 기존 배열을 모두 지우고, 체크된 체크박스 값만 배열에 넣자!!
		if($($(ch)[i]).is(":checked")){		
			console.log($($("input[name='color']")[i]).val());		
			color.push($($("input[name='color']")[i]).val());
		}
	}		
	console.log("서버에 전송할 컬러 배열의 구성은 ", color);
}
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
function edit(){
	if(confirm("수정하시겠습니까?")){
		var formData = new FormData(document.getElementById('data'));
		
		if(newThum!=null){		
			formData.append("repImg",newThum);	//새로 저장될 썸네일
			formData.append("delRep", thumbnail);
			console.log("repImg : ",newThum.name);
			console.log("delRep : ",thumbnail);
		}else{
			formData.append("filename",oldThum);
		}
		
		$.each(uploadFiles, function( i, file){
			formData.append("addImg", file,  file.name); // <input type="file" name="addImg> 동일한 효과 
			console.log("수정시 등록될 이미지 : ",file.name);
		});
		
 		for(var i=0; i<editAdd.length; i++){
			formData.append("editAdd["+i+"]", editAdd[i]);
		}
		
		for(var i=0;i<psize.length;i++){
			formData.append("psize["+i+"].petfit", psize[i]);
		}
		
		//색상 체크가 되어있으면 값을 불러와서 바꾸기
		colorCheck();
		for(var i=0;i<color.length;i++){
			formData.append("colors["+i+"].picker", color[i]);
		}
		console.log("탑카테고리 id : ",$($("select")[0]).val());
		console.log("서브카테고리 id : ",$($("select")[1]).val());		
		console.log("상품이름 : ",$('form [name="product_name"]').val());
		console.log("가격 : ",$('form [name="price"]').val());
		console.log("상세설명 : ",$('form [name="detail"]').val());
		console.log("formData : ",formData);
		console.log("color : ",color);
		console.log("psize : ",psize);
		$.ajax({
			url:"/async/admin/product/update",
			data:formData,
			contentType:false,
			processData:false,
			type:"post",
			success:function(responseData){
				if(responseData.resultCode==1){
					alert(responseData.msg);
				}else{
					alert(responseData.msg);
				}
			}
		});
	}
}
function del(){
	if(confirm("삭제하시겠습니까?")){
		var formData = new FormData(document.getElementById('data'));
		
		formData.append("delRep", thumbnail);
		
		for(var i=0; i<delAdd.length; i++){
			formData.append("delAdd["+i+"]", delAdd[i]);
		}
		
		$.ajax({
				url:"/async/admin/product/del",
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
}
</script>
</head>
<body>
<%@ include file="../inc/admin_navi.jsp" %>
	<section class="product spad">
	<div class="container">
		<div class="section-title">
			<h4>상품 상세보기</h4>
		</div>
		<form id="data">
				<input type="hidden" name="product_id" value="<%=product.getProduct_id()%>"/>		
				<select name="topcategory_id">
					<option value="<%=topList.size()+1%>">상위 카테고리</option>
					<%for(TopCategory topCategory : topList){ %>
					<option value="<%=topCategory.getTopcategory_id()%>"><%=topCategory.getName() %></option>
					<%} %>
				</select>
				<select name="subCategory.subcategory_id">
					<option>하위 카테고리</option>
				</select>
				<input type="text" name="product_name" value="<%=product.getProduct_name()%>"> 
				<input type="text" name="price" value="<%=product.getPrice()%>"> 
				
				<div class="filebox"> 
					<input class="upload-name" value="파일이름" disabled="disabled"> 
					<label for="ex_filename">업로드</label> 
					<input type="file" id="ex_filename" class="upload-hidden" name="repImg"> 
					<img id="mainImage" src="/resources/data/basic/<%=product.getProduct_id()%>.<%=product.getFilename()%>">
				</div>

				등록할 이미지를 드래그 해주세요.
				<div id="dragArea"></div>
				
				
					XS<input type="checkbox" name="size" value="XS">
					S<input type="checkbox" name="size" value="S">
					M<input type="checkbox" name="size" value="M">
					L<input type="checkbox" name="size" value="L">
					XL<input type="checkbox" name="size" value="XL">
					XXL<input type="checkbox" name="size" value="XXL">
					<p>*등록할 사이즈를 선택해주세요.</p>				
				
					<input type="checkbox" 	name="colorcheck">
					<input type="text" name="color" placeholder="색상 적는 곳">				
					<input type="checkbox" 	name="colorcheck">
					<input type="text" name="color" placeholder="색상 적는 곳">				
					<input type="checkbox" 	name="colorcheck">
					<input type="text" name="color" placeholder="색상 적는 곳">			
					<input type="checkbox" 	name="colorcheck">
					<input type="text" name="color" placeholder="색상 적는 곳">			
					<input type="checkbox" 	name="colorcheck">
					<input type="text" name="color" placeholder="색상 적는 곳">			
					<input type="checkbox" 	name="colorcheck">
					<input type="text" name="color" placeholder="색상 적는 곳">
					<p>*원하는 색상을 적고 체크해주세요</p>
					
				
				<textarea name="detail"><%=product.getDetail() %></textarea>
				<input type="button" value="수정" onClick="edit()">
				<input type="button" value="삭제" onClick="del()">
				<input type="button" value="목록으로" onClick="location.href='/admin/product/list'">
			</form>
		</div>
	</section>
<%@ include file="../../shop/shopFooter.jsp" %>
<%@ include file="../../inc/footer.jsp" %>
</body>
</html>
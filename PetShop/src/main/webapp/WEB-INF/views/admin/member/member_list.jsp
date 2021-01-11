<%@page import="com.koreait.petshop.model.domain.Member"%>
<%@page import="com.koreait.petshop.model.common.Pager"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	List<Member> memberList =(List)request.getAttribute("memberList");
	Pager pager = new Pager();
	pager.init(request, memberList);
%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../../inc/header.jsp" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
table {
  border-collapse: collapse;
  border-spacing: 0;
  width: 100%;
  border: 1px solid #ddd;
}
th, td {
  text-align: left;
  padding: 16px;
}
tr:nth-child(even) {
  background-color: #fcfcfc;
}
</style>

<script>
</script>

</head>
<body>
<%@ include file="../inc/admin_navi.jsp" %>
<section  class="product spad">
		<div  class="container" >
			<div class="section-title">
				<h4>목록</h4>
			</div>
			<P>
			<table>
				<tr>
					<th>NO</th>
					<th >아이디</th>
					<th style="width:100px">이름</th>
					<th style="width:150px">전화번호</th>
					<th >이메일</th>
					<th style="width:100px">우편번호</th>
					<th style="width:250px">주소</th>
					<th style="width:120px">가입날짜</th>
				</tr>
				<%
				//순서
				int num = pager.getNum();
				int curPos  = pager.getCurPos();
				%>

				<%for(int i=0; i<pager.getPageSize();i++){ %>
				<%if(num<1)break; %>
				<%Member member = (Member)memberList.get(curPos++); %>
				<tr>
					<td><%=num--%></td>
					<td><%=member.getUser_id()%></td>
					<td><%=member.getName() %></td>
					<td><%=member.getPhone() %></td>
					<td><%=member.getEmail_id()+"@"+member.getEmail_server() %></td>
					<td><%=member.getZipcode() %></td>
					<td><%=member.getAddr() %></td>
					<td><%=member.getRegdate() %></td>
				</tr>
				<%} %>
			<tr>
			<td colspan="8" style="text-align:center">
			<%if((pager.getFirstPage()-1)>=1){ %>
				<a href = "/admin/member/list?currentPage=<%=pager.getFirstPage()-1%>">◀</a>
			<%}else{ %>
				<a href ="javascript:alert('처음 페이지입니다.')">◀</a>
			<%} %>
			<%for(int i=pager.getFirstPage();i<pager.getLastPage();i++){ %>
				<%if(i>pager.getTotalPage())break; %>
				<a href ="/admin/member/list?currentPage=<%=i%>" <% if(pager.getCurrentPage()==i){%>class="pageNum"<%} %>>[<%=i %>]</a>
			<%} %>
			<%if((pager.getLastPage()+1)<pager.getTotalPage()){ %>
				<a href = "/admin/member/list?currentPage=<%=pager.getFirstPage()-1%>">▶</a>
			<%}else{ %>	
				<a href ="javascript:alert('마지막 페이지입니다.')">▶</a>
			<%} %>
			</td>
		</tr>
			</table>
			</p>
		</div>
	</section>
<%@ include file="../../shop/shopFooter.jsp" %>
<%@ include file="../../inc/footer.jsp" %>
</body>
</html>
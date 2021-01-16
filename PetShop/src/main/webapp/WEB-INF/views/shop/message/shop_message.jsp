<%@page import="com.koreait.petshop.model.common.MessageData"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%
	MessageData messageData = (MessageData)request.getAttribute("messageData");		
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript">
<%if(messageData.getResultCode()==1){%>
	alert("<%=messageData.getMsg()%>");		
	location.href="<%=messageData.getUrl()%>";
<%}else{%>
	alert("<%=messageData.getMsg()%>");	
	history.back();
<%}%>
</script>
</head>
<body>
</body>
</html>
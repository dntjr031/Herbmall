<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>common/message.jsp</title>
</head>
<body>
<%
	String msg = (String)request.getAttribute("msg");
	String url = (String)request.getAttribute("url");
	String contextPath = request.getContextPath();
	url = contextPath + url; // => /herbmall/member/register.jsp
%>

	<script type="text/javascript">
		alert('<%= msg %>');
		location.href = "<%= url %>";
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main.jsp</title>
</head>
<body>
<h1>maim 페이지</h1>
<p>세션 아이디 : <%=session.getId() %></p>
<a href="setSession.jsp">setSession으로 이동</a>
</body>
</html>
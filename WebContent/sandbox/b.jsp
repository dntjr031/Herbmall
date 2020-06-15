<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>b.jsp</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	String userName = (String)request.getAttribute("userName");
%>
	<h1>b.jsp 페이지</h1>
	
	<h2>요청 파라미터</h2>
	<p>id : <%=id %></p>
	<p>pwd : <%=pwd %></p>
	<h2>속성 값</h2>
	<p>userName : <%=userName %></p>
</body>
</html>
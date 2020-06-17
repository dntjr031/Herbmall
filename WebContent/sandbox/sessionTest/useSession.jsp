<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>useSession.jsp</title>
</head>
<body>
<%
	String id = (String)session.getAttribute("id");
	String pwd = (String)session.getAttribute("pwd");
%>
<h1>세션 정보 읽어오기</h1>
<p>아이디 : <%=id %></p>
<p>비밀번호 : <%=pwd %></p>
<p>세션 아이디 : <%=session.getId() %></p>
<hr>
<a href="logout.jsp">로그아웃</a>
</body>
</html>
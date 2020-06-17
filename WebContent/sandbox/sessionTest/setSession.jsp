<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>setSession.jsp</title>
</head>
<body>
<%
	session.setAttribute("id", "kim");
	session.setAttribute("pwd", "123");
	
	String sessionId = session.getId();
%>
<h1>session에 저장하기</h1>
<p>세션 아이디 : <%=sessionId %></p>
<p>세션 유지시간 : <%=session.getMaxInactiveInterval() %></p>

<hr>
<a href="useSession.jsp">useSession으로 이동</a>
</body>
</html>
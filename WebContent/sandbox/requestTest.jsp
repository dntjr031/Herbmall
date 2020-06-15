<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>requestTest.jsp</title>
</head>
<body>
<h1>request메서드</h1>
<p>uri : <%=request.getRequestURI() %></p>
<p>contextPath : <%=request.getContextPath() %></p>
<p>method : <%=request.getMethod() %></p>
<p>ip : <%=request.getRemoteAddr() %></p>
<p>ip : <%=request.getRemoteHost()%></p>
<p>protocol : <%=request.getProtocol() %></p>
<p>serverName : <%=request.getServerName() %></p>
<p>serverPort : <%=request.getServerPort() %></p>
</body>
</html>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp" %>
<!-- 에러가 발생되면 에러를 처리하는 페이지인 error.jsp에서 처리함 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>date.jsp</title>
</head>
<body>
<%
	Date d = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String str = sdf.format(d);
%>
<h1>현재 일자</h1>
<p><%=str%></p> <!-- 고의로 에러 발생시킴 -->
</body>
</html>
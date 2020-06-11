<%@page import="com.herbmall.test.Person"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sandbox/singletonTest.jsp</title>
</head>
<body>
	<%
		// Person p = new Person();
		Person p = Person.getPerson();
		p.showInfo();
	
	%>
</body>
</html>
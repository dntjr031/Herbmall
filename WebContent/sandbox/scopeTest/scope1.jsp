<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="cb" class="com.herbmall.test.CounterBean" scope="page"></jsp:useBean>
<jsp:setProperty property="count" name="cb"/>

<h1>page 영역 연습 - scope1.jsp페이지</h1>
<p>count : <jsp:getProperty property="count" name="cb"/> </p>
<hr>
<a href="result1.jsp">result1으로 이동</a>
</body>
</html>
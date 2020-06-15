<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>scope2.jsp</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="cb" class="com.herbmall.test.CounterBean" scope="request"></jsp:useBean>
<jsp:setProperty property="count" name="cb"/>

<h1>request 영역 연습 - scope2.jsp페이지</h1>
<p>count : <jsp:getProperty property="count" name="cb"/> </p>
<hr>
<!-- <a href="result2.jsp">result2으로 이동</a> => redirect로 이동하기때문에 적용 x -->
<jsp:forward page="result2.jsp"></jsp:forward>
</body>
</html>
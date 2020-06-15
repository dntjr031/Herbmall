<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>result1.jsp 페이지</h1>
<jsp:useBean id="cb" class="com.herbmall.test.CounterBean" scope="page"></jsp:useBean>

<p>count : <jsp:getProperty property="count" name="cb"/> </p>
<hr>
<a href="scope1.jsp">scope1으로 이동</a>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>result4.jsp 페이지</h1>
<jsp:useBean id="cb" class="com.herbmall.test.CounterBean" scope="application"></jsp:useBean>

<p>count : <jsp:getProperty property="count" name="cb"/> </p>
<hr>
<a href="scope4.jsp">scope4으로 이동</a>
<br><br>
<h2>session id : <%=session.getId() %></h2>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IncludeTest.jsp</title>
</head>
<body>
<h1>main페이지</h1>
<h2>include 지시자 이용 - 소스가 포함됨</h2>
<%@ include file="copyright.jsp" %>
<h2>include 액션 태그 - 실행결과가 포함됨</h2>
<jsp:include page="copyright.jsp"></jsp:include>

<%
	String str = "copyright.jsp";
%>
<h3>표현식 이용 가능</h3>
<jsp:include page="<%=str %>"></jsp:include>

<h3>파라미터 전달가능</h3>
<jsp:include page="copyright.jsp">
	<jsp:param value="5" name="no"/>
	<jsp:param value="역삼동" name="address"/>
</jsp:include>
</body>
</html>
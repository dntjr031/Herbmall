<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login/loginCheck.jsp</title>
</head>
<body>
<%
	String l_userid = (String)session.getAttribute("userid");

	if(l_userid == null || l_userid.isEmpty()){
		request.setAttribute("msg", "로그인이 필요한 페이지입니다.");
		request.setAttribute("url", "/login/login.jsp");
		%><jsp:forward page="../common/message.jsp"></jsp:forward>
	<%}
%>
</body>
</html>
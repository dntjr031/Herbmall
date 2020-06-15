<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forwardTest.jsp</title>
</head>
<body>
	<h1>Forward 사용법 예제</h1>
	<FORM METHOD=POST ACTION="forwardTest_ok.jsp">
	아이디 : <INPUT TYPE="text" NAME="id"><p>
	패스워드 : <INPUT TYPE="password" NAME="pwd"><p>
	<INPUT TYPE="submit" VALUE="보내기">
	</FORM>
</body>
</html>
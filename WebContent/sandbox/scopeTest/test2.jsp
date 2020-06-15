<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test2.jsp</title>
</head>
<body>
	<h2>request scope 테스트</h2>
	<form name="frm1" method="post" action="scope2.jsp">
		카운트 : <input type="text" name="count"><br>
		<input type="submit" value="전송">
	</form>
</body>
</html>
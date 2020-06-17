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
	//쿠키 생성하기 - 상태 정보를 저장하기 위한 방법
	//=> 사용자의 pc의 임시파일로 저장됨, 최대 4kb 크기
	//1. 쿠키 생성
	Cookie ck1 = new Cookie("id","hong");
	//2. 쿠키 지속시간 설정
	ck1.setMaxAge(2*60);
	//3. 쿠키 추가
	response.addCookie(ck1);

	//두번째 쿠키 생성
	Cookie ck2 = new Cookie("age","20");
	ck2.setMaxAge(20*60);
	response.addCookie(ck2);
%>
<h1>쿠키가 생성됨</h1>
<a href="useCookie.jsp">쿠키사용하기</a>
</body>
</html>
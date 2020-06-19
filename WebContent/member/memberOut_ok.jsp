<%@page import="com.herbmall.member.model.MemberService"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberOut_ok.jsp</title>
</head>
<body>
<%@include file="../login/loginCheck.jsp" %>
<jsp:useBean id="memService" class="com.herbmall.member.model.MemberService" scope="session"></jsp:useBean>
<%
	// memberOut.jsp 에서 회원탈퇴를 누르면 post
	//=>http://localhost:9090/Herbmall/member/memberOut_ok.jsp
	//1
	request.setCharacterEncoding("utf-8");
	String userid = (String)session.getAttribute("userid");
	String pwd = request.getParameter("pwd");
	//2
	try{
	// 비밀번호 체크
		int check = memService.loginCheck(userid, pwd);
		if(check == MemberService.PWD_DISAGREE){
			request.setAttribute("msg", "비밀번호가 틀렸습니다.");
			request.setAttribute("url", "/member/memberOut.jsp");
			%>
			<jsp:forward page="../common/message.jsp"></jsp:forward>
		<%}
		
	// outdate 업데이트
		int cnt = memService.memberOut(userid);
		if(!(cnt > 0)){
			request.setAttribute("msg", "탈퇴 실패!");
			request.setAttribute("url", "/member/memberOut.jsp");
			%>
			<jsp:forward page="../common/message.jsp"></jsp:forward>
		<%}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	// session 초기화
	session.invalidate();
	// 쿠키 삭제
	Cookie[] ck = request.getCookies();
	for(Cookie c : ck){
		c.setMaxAge(0);
		c.setPath("/");
		response.addCookie(c);
	}
	//3
	request.setAttribute("msg", "탈퇴되었습니다!");
	request.setAttribute("url", "/index.jsp");
	%>
		<jsp:forward page="../common/message.jsp"></jsp:forward>
	<%
%>
</body>
</html>
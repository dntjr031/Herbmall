<%@page import="com.herbmall.member.model.MemberService"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean id="memService" class="com.herbmall.member.model.MemberService" scope="session">
</jsp:useBean>
<jsp:useBean id="memvo" class="com.herbmall.member.model.MemberVO" scope="page">
</jsp:useBean>
<%
	// login.jsp에서 로그인을 누르면 fost방식
	// => http://localhost:9090/Herbmall/login/login_ok.jsp
	// => 로그인 처리, 성공하면 세션에 아이디저장, 쿠키에 아이디 저장
	request.setCharacterEncoding("utf-8");
	//1
	String userid = request.getParameter("userid");
	String pwd = request.getParameter("pwd");
	String saveId = request.getParameter("saveId");
	
	//2
	int loginCheck = 0;
	try{
		loginCheck = memService.loginCheck(userid, pwd);
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	String msg = "로그인 처리 실패!", url = "/login/login.jsp";
	if(loginCheck == MemberService.LOGIN_OK){
		try{
			memvo = memService.selectMember(userid);
		}catch(SQLException e){
			e.printStackTrace();
		}
		
		//[1] 세션에 로그인정보 저장
		session.setAttribute("userid", userid);
		session.setAttribute("userName", memvo.getName());
		
		msg = memvo.getName() + "님 로그인되었습니다.";
		url = "/index.jsp";
	}else if(loginCheck == MemberService.PWD_DISAGREE){
		msg = "비밀번호가 일치하지 않습니다.";
	}else if(loginCheck == MemberService.ID_NONE){
		msg = "해당 아이디가 존재하지 않습니다.";
	}
	
	//3
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
	
	//[2] 쿠키에 저장
	if(saveId != null){ //체크한 경우 - on
		Cookie ck1 = new Cookie("ck_userid", userid);
		ck1.setMaxAge(1000*24*60*60); //쿠키 유효기간 : 1000일
		ck1.setPath("/"); //지정한 경로와 하위 경로에 쿠키 전송
		response.addCookie(ck1);
	}else{ // 체크하지 않은 경우 - null
		Cookie ck1 = new Cookie("ck_userid", userid);
		ck1.setMaxAge(0); //쿠키 유효기간 : 0 => 쿠키 제거됨
		ck1.setPath("/"); //지정한 경로와 하위 경로에 쿠키 전송
		response.addCookie(ck1);
	}
	%>
	<jsp:forward page="../common/message.jsp"></jsp:forward>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
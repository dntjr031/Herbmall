<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="memService" scope="session" class="com.herbmall.member.model.MemberService"></jsp:useBean>
<jsp:useBean id="memVo" scope="page" class="com.herbmall.member.model.MemberVO"></jsp:useBean>
<%
	//register에서 post
	request.setCharacterEncoding("utf-8");

	String name = request.getParameter("name");
	String userid = request.getParameter("userid");
	String pwd = request.getParameter("pwd");
	String zipcode = request.getParameter("zipcode");
	String address = request.getParameter("address");
	String addressDetail = request.getParameter("addressDetail");
	String hp1 = request.getParameter("hp1");
	String hp2 = request.getParameter("hp2");
	String hp3 = request.getParameter("hp3");
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	if("직접입력".equals(email2)){
		email2 = request.getParameter("email3");
	}
	String hp = "";
	if(hp2 != null && !hp2.isEmpty()){
		if(hp3 != null && !hp3.isEmpty()){
			hp = hp1 + "-" + hp2 + "-" + hp3;
		}
	}
	String email = "";
	if(email1 != null && !email1.isEmpty()){
		email = email1 + "@" + email2;
	}
	
	memVo.setName(name);
	memVo.setUserid(userid);
	memVo.setPwd(pwd);
	memVo.setZipcode(zipcode);
	memVo.setAddress(address);
	memVo.setAddressDetail(addressDetail);
	memVo.setHp(hp);
	memVo.setEmail(email);
	
	String msg = "", url = "";
	try{
		int cnt = memService.insertMember(memVo);
		
		if(cnt > 0){
			msg = "회원가입되었습니다.";
			url = "/index.jsp";
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
	
%>

<jsp:forward page="../common/message.jsp"></jsp:forward>
<!-- forward로 이동하면 request 공유함
현재페이지와 message.jsp는 같은 request를 갖는다 -->
</body>
</html>
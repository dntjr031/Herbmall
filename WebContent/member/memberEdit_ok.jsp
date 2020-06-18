<%@page import="com.herbmall.member.model.MemberService"%>
<%@page import="com.herbmall.member.model.MemberVO"%>
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
<jsp:useBean id="memService" class="com.herbmall.member.model.MemberService" scope="session"></jsp:useBean>
<%
	// memberEdit.jsp 에서 수정을 누르면 submit post
	// =>  http://localhost:9090/Herbmall/member/memberEdit_ok.jsp
	
	//1
	request.setCharacterEncoding("utf-8");
	String userid = (String)session.getAttribute("userid");
	String pwd = request.getParameter("pwd");
	String zipcode = request.getParameter("zipcode");
	String address = request.getParameter("address");
	String addressDetail = request.getParameter("addressDetail");
	String hp1 = request.getParameter("hp1");
	String hp2 = request.getParameter("hp2");
	String hp3 = request.getParameter("hp3");
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	
	String hp = "", email = "";
	if(hp2 != null && !hp2.isEmpty()){
		hp = hp1 + "-" + hp2 + "-" + hp3;
	}
	if(email1 != null && !email1.isEmpty()){
		email = email1 + "@" + email2;
	}
	//2
	MemberVO vo = new MemberVO();
	vo.setUserid(userid);
	vo.setZipcode(zipcode);
	vo.setAddress(address);
	vo.setAddressDetail(addressDetail);
	vo.setHp(hp);
	vo.setEmail(email);
	
	System.out.println("비밀번호 = " + pwd);
	String msg = "수정실패!", url = "/member/memberEdit.jsp";
	try{
		int check = memService.loginCheck(userid, pwd);
		
		if(check == MemberService.PWD_DISAGREE){%>
			<script type="text/javascript">
				alert("비밀번호가 틀렸습니다.");
				history.back();
			</script>
			<%return;
		}
		
		int cnt = memService.updateMember(vo);
		
		if(cnt >0){
			msg = "수정 완료!";
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	// 3
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
	
	<jsp:forward page="../common/message.jsp"></jsp:forward>
</body>
</html>
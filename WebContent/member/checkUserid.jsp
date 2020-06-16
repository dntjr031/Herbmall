<%@page import="com.herbmall.member.model.MemberService"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="memserv" class="com.herbmall.member.model.MemberService" scope="session"></jsp:useBean>
<%
	//[1] register.jsp 에서 중복확인 누르면 새창 열림 = >get
	//=> 	http://localhost:9090/Herbmall/member/checkUserid.jsp?userid=fae
	//[2] checkUserid.jsp에서 아이디확인 누르면 post방식으로 서브밋
	
	//1
	request.setCharacterEncoding("utf-8");
	String userid = request.getParameter("userid");
	
	//2
	int result = 0; 
	if(userid != null && !userid.isEmpty()){
		try{
			result = memserv.duplicateId(userid);
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
	//3
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>checkUserid.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mainstyle.css">
<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("input[type=button]").click(function() {
			$(opener.document).find("#userid").val("<%=userid%>");
			$(opener.document).find("#chkId").val("Y");
			$(opener.document).find("#userid").attr("disabled","disabled");
			self.close();
		});
		
		$("form[name=frmDup]").submit(function() {
			var id = $("#userid").val();
			if(id == ''){
				alert("아이디를 입력하세요");
				return false;
			}
		});
	});
</script>
</head>
<body>
	<h1>아이디 중복 검사</h1>
	<form action="checkUserid.jsp" method="post" name="frmDup">
		<label for="userid">회원ID</label>
		<input type="text" id="userid" value="<%= userid %>" name="userid">
		<input type="submit" value="아이디 확인">
		<%if(result == MemberService.EXIST_ID){%>
			<p>이미 등록된 아이디입니다. 다른 아이디를 입력하세요</p>
		<%}else if(result == MemberService.NON_EXIST_ID){%>
			<input type="button" value="사용하기">
			<p>사용 가능한 아이디입니다. [사용하기]버튼을 클릭하세요</p>
		<%}%>
	</form>
	
</body>
</html>
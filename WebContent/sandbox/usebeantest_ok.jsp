<%@page import="com.herbmall.test.SimpleBean"%>
<%@page import="java.util.Set"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>usebeantest_ok.jsp</title>
</head>
<body>
<%
	//기존 방식
	/* request.setCharacterEncoding("utf-8");
	
	String userid = request.getParameter("userid");
	String name = request.getParameter("name");
	String no = request.getParameter("no");
	
	SimpleBean bean = new SimpleBean();
	bean.setName(name);
	bean.setNo(Integer.parseInt(no));
	bean.setUserid(userid); */
	
	//useBean, setProperty 액션 태그 이용
	request.setCharacterEncoding("utf-8");
%>
	<!-- useBean 액션태그를 이용하여 SimpleBean 객체 생성 -->
	<jsp:useBean id="sb" class="com.herbmall.test.SimpleBean" scope="page"></jsp:useBean>
	<!-- setProperty 액션태그를 이용하여 파라미터를 읽어서 SimpleBean의 멤버변수(프로퍼티)에 파라미터값 셋팅 -->
	<jsp:setProperty property="name" name="sb"/>
	<jsp:setProperty property="userid" name="sb"/>
	<jsp:setProperty property="no" name="sb"/>

	<h1>요청 파라미터 값</h1>
	<%-- <p>아이디 : <%=bean.getUserid() %></p>
	<p>이름 : <%=bean.getName() %></p>
	<p>번호 : <%=bean.getNo() %></p> --%>
	
	<p>아이디 : <jsp:getProperty property="userid" name="sb"/> </p>
	<p>이름 : <jsp:getProperty property="name" name="sb"/> </p>
	<p>번호 : <jsp:getProperty property="no" name="sb"/> </p>
	
</body>
</html>
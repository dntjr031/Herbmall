<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Date d = new Date();
	String s = d.toLocaleString();
	
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");
	String address = request.getParameter("address");
%>

<hr>
<p>현재 날짜 : <%=s %></p>
<p>&copy; Herbmall.com</p>
<h4>파라미터</h4>
<p>번호 : <%=no %></p>
<p>주소 : <%=address %></p>
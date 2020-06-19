<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.herbmall.comment.model.CommentVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
.commentList table{
	border-collapse: collapse;
	border: 1px solid gray;
	width: 500px;
}
.commentList table td{
	border: 1px solid gray;
}
</style>
<jsp:useBean id="cservice" class="com.herbmall.comment.model.CommentService" scope="session"></jsp:useBean>
<%
	String bdno = (String)request.getAttribute("bdno");

	List<CommentVO> list = null;
	try{
		list = cservice.selectAll(Integer.parseInt(bdno));
	}catch(SQLException e){
		e.printStackTrace();
	}

	SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");%>
	
	<div class="commentList">
		<table>
		<colgroup>
			<col style="width: 20%">
			<col style="width: 50%">
			<col style="width: 30%">
		</colgroup>
	<%if(list != null && !list.isEmpty()){
		for(int i = 0; i < list.size(); i++){
			CommentVO cvo = list.get(i);%>
			
			<tr>
				<td><%=cvo.getName() %></td>
				<td><%=cvo.getContent() %></td>
				<td><%=sdf2.format(cvo.getRegdate()) %></td>
			</tr>
		<%}%>
	<%}else{%>
		<tr>
			<td colspan="3">댓글이 없습니다.</td>
		</tr>
	<%}%>
		</table>
	</div>
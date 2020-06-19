<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String bdno = (String)request.getAttribute("bdno");
%>
<h3>댓글</h3>
<form action="comment_ok.jsp" name="frm">
	<div class="comment">
		<input type="hidden" name="bdno" id="bdno" value="<%=bdno%>">
		<span class="c_name"><label for="name">이름</label>
			<input type="text" id="name" name="name">
		</span>
		<span class="c_pwd"><label for="pwd">비밀번호</label>
			<input type="password" id="pwd" name="pwd">
		</span>
	</div>
	<div class="content">
		<textarea rows="5" cols="75" name="content"></textarea>
	</div>
	<input type="submit" value="댓글달기">
</form>
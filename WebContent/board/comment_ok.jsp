<%@page import="com.herbmall.comment.model.CommentVO"%>
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
<jsp:useBean id="dao" class="com.herbmall.comment.model.CommentDAO" scope="session"></jsp:useBean>
<%
	request.setCharacterEncoding("utf-8");
	String name = request.getParameter("name");
	String pwd = request.getParameter("pwd");
	String content = request.getParameter("content");
	String bdno = request.getParameter("bdno");
	
	CommentVO vo = new CommentVO();
	vo.setBdno(Integer.parseInt(bdno));
	vo.setContent(content);
	vo.setName(name);
	vo.setPwd(pwd);
	try{
		int cnt = dao.insertComment(vo);
		if(cnt > 0){%>
			<script type="text/javascript">
				alert("댓글 등록 완료");
				location.href = "detail.jsp?no=<%=bdno%>";
			</script>
		<%}else{%>
			<script type="text/javascript">
				alert("댓글 등록 실패");
				location.href = "detail.jsp?no=<%=bdno%>";
			</script>
		<%}
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
</body>
</html>
<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
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
<%
	//1
	request.setCharacterEncoding("utf-8");

	String pwd=request.getParameter("pwd");
	String no=request.getParameter("no");
	
	//2
	ReBoardDAO dao = new ReBoardDAO();
	
	int cnt=0;
	try{
		cnt=dao.deleteReBoard(Integer.parseInt(no), pwd);	
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3
	if(cnt>0){ %>
		<script type="text/javascript">
			alert('글 삭제되었습니다.');
			location.href="list.jsp";
		</script>	
<%	}else{%>
		<script type="text/javascript">
			alert('글 삭제 실패!');
			history.go(-1);
		</script>
<%	}
%>
</body>
</html>
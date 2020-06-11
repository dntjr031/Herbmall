<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// delete.jsp 에서 삭제버튼 누르면 post방식으로 전송
	
	String no = request.getParameter("no");
	String pwd = request.getParameter("pwd");
	
	if(no == null || no.isEmpty()){%>
	<script type="text/javascript">
		alert("잘못된 url입니다.");
		location.href = "list.jsp";
	</script>
	<%	return;
	}
	
	boardDAO dao = new boardDAO();
	String check = "";
	try{
		check = dao.pwdByNo(Integer.parseInt(no));
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	int cnt = 0;
	if(check.equals(pwd)){
		cnt = dao.deleteByNo(Integer.parseInt(no));
		if(cnt>0){
			%>
			<script type="text/javascript">
				alert("삭제 완료되었습니다.");
				location.href = "list.jsp"
			</script>
		<%
		}else{
			%>
			<script type="text/javascript">
				alert("삭제 실패!");
				history.back();
			</script>
		<% 
		}
	}else{%>
		<script type="text/javascript">
			alert("비밀번호가 틀립니다.");
			history.back();
		</script>
	<% 
	}
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete_ok.jsp</title>

</head>
<body>

</body>
</html>
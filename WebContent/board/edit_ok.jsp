<%@page import="com.herbmall.board.model.BoardVo"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//edit.jsp에서 post방식으로 서브밋
	//1
	request.setCharacterEncoding("utf-8");
	String no = request.getParameter("no");
	String name = request.getParameter("name");
	String pwd = request.getParameter("pwd");
	String title = request.getParameter("title");
	String email = request.getParameter("email");
	String content = request.getParameter("content");

	//2
	boardDAO dao = new boardDAO();
	BoardVo vo = new BoardVo();
	vo.setContent(content);
	vo.setEmail(email);
	vo.setName(name);
	vo.setNo(Integer.parseInt(no));
	vo.setPwd(pwd);
	vo.setTitle(title);
	
	int cnt = 0;
	try {
		cnt = dao.updateBoard(vo);
		
	} catch (SQLException e) {
		e.printStackTrace();
	}
	//3
	if(cnt>0){%>
		<script type="text/javascript">
			alert('글 수정되었습니다.');
			location.href = "detail.jsp?no=<%= no%>";
		</script>
	<%}else{%>
		<script type="text/javascript">
			alert('글 수정 실패!');
			history.go(-1);
		</script>
	<%}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>edit_od.jsp</title>
</head>
<body>

</body>
</html>
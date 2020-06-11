<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.BoardVo"%>
<%@page import="com.herbmall.board.model.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write.jsp</title>
</head>
<body>
	<%
		// write.jsp 에서 post방식으로 연결
		request.setCharacterEncoding("utf-8");

		// 1. 요청 파라미터 읽어오기
		String title = request.getParameter("title");
		String name = request.getParameter("name");
		String pwd = request.getParameter("title");
		String email = request.getParameter("email");
		String content = request.getParameter("content");

		String ip = request.getRemoteAddr();
		String ip2 = request.getRemoteHost();
		System.out.println("ip=" + ip);
		System.out.println("ip2=" + ip2);

		// 2. db작업
		boardDAO dao = new boardDAO();
		BoardVo vo = new BoardVo();

		vo.setName(name);
		vo.setPwd(pwd);
		vo.setTitle(title);
		vo.setEmail(email);
		vo.setContent(content);

		int cnt = 0;
		try {

			cnt = dao.insertBoard(vo);

			// 3. 결과처리

		} catch (SQLException e) {
			e.printStackTrace();
		}

		if (cnt > 0) {
	%>


	<script type="text/javascript">
		alert('글 등록되었습니다.');
		location.href = "list.jsp";
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
		alert('글 등록 실패!');
		history.back();
	</script>
	<%
		}
	%>
</body>
</html>
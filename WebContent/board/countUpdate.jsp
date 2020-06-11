<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.boardDAO"%>
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
	// list.jsp 에서 제목을 누르면 get방식으로 전송
	//=> http://localhost:9090/Herbmall/board/countUpdate.jsp?no=4
	// list.jsp에서 글 제목을 눌르면 해당하는 no의 조회수가 증가되게 처리 후 detail.jsp로 이동
	// 파라미터 no에 해당하는 글의 조회수를 증가시킨 후 detail.jsp로 이동
	
	//1
	String no = request.getParameter("no");
	if(no == null || no.isEmpty()){%>
		<script type="text/javascript">
			alert('잘못된 url입니다.');
			location.href = 'list.jsp';
		</script>
		<%return;
	}
	//2
	boardDAO dao = new boardDAO();
	int cnt = 0;
	try{
		cnt = dao.updateReadCount(Integer.parseInt(no));
	}catch(SQLException e){
		e.printStackTrace();
	}
	//3
	
	if(cnt>0){
		System.out.println("조회수 증가 성공");
		response.sendRedirect("detail.jsp?no=" + no);
	}else{%>
		<script type="text/javascript">
			alert("조회수 증가 실패");
			history.back();
		</script>
	<%}
%>
</body>
</html>
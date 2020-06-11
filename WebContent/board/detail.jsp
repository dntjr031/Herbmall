<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.herbmall.board.model.BoardVo"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	// countUpdate.jsp 에서 조회수를 증가시키면 get방식으로 이동
	//=> http://localhost:9090/Herbmall/board/countUpdate.jsp?no=3
	
	// 1.
	String no = request.getParameter("no");
	
	if(no.isEmpty() || no == null){%>
		<script type="text/javacript">
			alert("잘못된 url입니다.");
			location.href="list.jsp";
		</script>
		<%return;
	}
	// 2.
	boardDAO dao = new boardDAO();
	BoardVo vo = new BoardVo();
	try{
		vo = dao.selectByNo(Integer.parseInt(no));
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	// 3.
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String content = vo.getContent();
	if(content == null || content.isEmpty()){
		content = "";
	}else{
		content = content.replace("\r\n", "<br>");
	}
	
%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>자유게시판 상세보기 - 허브몰</title>
<link rel="stylesheet" type="text/css" href="../css/mainstyle.css" />
<link rel="stylesheet" type="text/css" href="../css/clear.css" />
<link rel="stylesheet" type="text/css" href="../css/formLayout.css" />
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />
<style type="text/css">
	body{
		padding:5px;
		margin:5px;
	 }
	.divForm {
		width: 500px;
		}
</style>  
</head>
<body>
	<h2>글 상세보기</h2>
	<div class="divForm">
		<div class="firstDiv">
			<span class="sp1">제목</span> <span><%=vo.getTitle() %></span>
		</div>
		<div>
			<span class="sp1">작성자</span> <span><%= vo.getName() %></span>
		</div>
		<div>
			<span class="sp1">등록일</span> <span><%= sdf.format(vo.getRegdate()) %></span>
		</div>
		<div>
			<span class="sp1">조회수</span> <span><%= vo.getReadcount() %></span>
		</div>
		<div class="lastDiv">			
			<p class="content"><%= content %></p>
		</div>
		<div class="center">
			<a href='edit.jsp?no=<%= vo.getNo()%>'>수정</a> |
        	<a href='delete.jsp?no=<%= vo.getNo()%>'>삭제</a> |
        	<a href='list.jsp'>목록</a>			
		</div>
	</div>

	
</body>
</html>
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
	//list.jsp 에서 제목 클릭하면  get방식으로 이동
	//=> http://localhost:9090/herbmall/reBoard/countUpdate.jsp?no=3
	//파라미터인 no에 해당하는 글의 조회수를 증가시킨 후  detail.jsp 로 이동
	
	//1
	String no=request.getParameter("no");
	if(no==null || no.isEmpty()){ %>
		<script type="text/javascript">
			alert("잘못된 url입니다.");
			location.href="list.jsp";
		</script>
		
	<%	return;	
	}
	
	//2
	ReBoardDAO dao = new ReBoardDAO();
	int cnt=0;
	try{
		cnt=dao.updateReadCount(Integer.parseInt(no));	
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3
	if(cnt>0){ 
		System.out.println("조회수 증가 성공");
		response.sendRedirect("detail.jsp?no="+no);
	}else{%>
		<script type="text/javascript">
			alert("조회수 증가 실패");
			history.back();
		</script>
	<%}%>
</body>
</html>





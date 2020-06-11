<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write_ok.jsp</title>
</head>
<body>
<%
	//write.jsp에서 post방식으로 서브밋
	//1.
	request.setCharacterEncoding("utf-8");
	String title=request.getParameter("title");
	String name=request.getParameter("name");
	String pwd=request.getParameter("pwd");
	String email=request.getParameter("email");
	String content=request.getParameter("content");
	
	String ip=request.getRemoteAddr();
	String ip2=request.getRemoteHost();
	System.out.println("ip="+ip);
	System.out.println("ip2="+ip2);
	
	//2.
	ReBoardDAO dao = new ReBoardDAO();
	ReBoardVO vo = new ReBoardVO();
	vo.setContent(content);
	vo.setEmail(email);
	vo.setName(name);
	vo.setPwd(pwd);
	vo.setTitle(title);
	
	int cnt = 0;
	try{
		cnt =dao.insertReBoard(vo);		
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3.
	if(cnt>0){%>
		<script type="text/javascript">
			alert('글 등록되었습니다.');
			location.href="list.jsp";
		</script>	
  <%}else{%>
		<script type="text/javascript">
			alert('글 등록 실패!');
			history.back();
		</script>
  <%}
%>
</body>
</html>



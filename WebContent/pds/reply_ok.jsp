<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
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
	//reply.jsp에서 post방식으로 서브밋
	//1
	request.setCharacterEncoding("utf-8");
	String title=request.getParameter("title");
	String name=request.getParameter("name");
	String pwd=request.getParameter("pwd");
	String email=request.getParameter("email");
	String content=request.getParameter("content");
	String groupNo=request.getParameter("groupNo");
	String step=request.getParameter("step");
	String sortNo=request.getParameter("sortNo");
	
	//2
	ReBoardDAO dao = new ReBoardDAO();
	ReBoardVO vo=new ReBoardVO();
	vo.setContent(content);
	vo.setEmail(email);
	vo.setGroupNo(Integer.parseInt(groupNo));
	vo.setName(name);
	vo.setPwd(pwd);
	vo.setSortNo(Integer.parseInt(sortNo));
	vo.setStep(Integer.parseInt(step));
	vo.setTitle(title);
	
	int cnt=0;
	try{
		cnt=dao.reply(vo);	
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3
	if(cnt>0){ %>
		<script type="text/javascript">
			alert("답변하기 성공!");
			location.href="list.jsp";
		</script>
	<%}else{%>
		<script type="text/javascript">
			alert("답변하기 실패!");
			history.back();
		</script>		
	<%}
%>
</body>
</html>
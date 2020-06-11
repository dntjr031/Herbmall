<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reply_ok.jsp</title>
</head>
<body>
<%
	// reply.jsp 에서 [답변]을 누르면 post방식으로 이동
	request.setCharacterEncoding("utf-8");
	//1
	String groupNo = request.getParameter("groupNo");
	String step = request.getParameter("step");
	String sortNo = request.getParameter("sortNo");
	
	String title = request.getParameter("title");
	String name = request.getParameter("name");
	String pwd = request.getParameter("pwd");
	String email = request.getParameter("email");
	String content = request.getParameter("content");
	
	//2
	ReBoardDAO dao = new ReBoardDAO();
	ReBoardVO vo = new ReBoardVO();
	vo.setGroupNo(Integer.parseInt(groupNo));
	vo.setStep(Integer.parseInt(step));
	vo.setSortNo(Integer.parseInt(sortNo));
	vo.setTitle(title);
	vo.setName(name);
	vo.setPwd(pwd);
	vo.setEmail(email);
	vo.setContent(content);
	
	int cnt = 0;
	try{
		cnt = dao.reply(vo);
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3
	if(cnt > 0){%>
		<script type="text/javascript">
			alert("답변하기 성공!");
			location.href = "list.jsp";
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
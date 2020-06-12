<%@page import="com.herbmall.common.Utility"%>
<%@page import="java.io.File"%>
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
	String step=request.getParameter("step");
	String groupNo=request.getParameter("groupNo");
	String fileName=request.getParameter("fileName");
	
	//2
	ReBoardDAO dao = new ReBoardDAO();
	ReBoardVO vo = new ReBoardVO();
	vo.setNo(Integer.parseInt(no));
	vo.setGroupNo(Integer.parseInt(groupNo));
	vo.setStep(Integer.parseInt(step));
	
	try{
		if(dao.checkPwd(Integer.parseInt(no), pwd)){
			dao.deleteReBoard(vo);
			
			// 첨부된 파일도 삭제
			String filePath = Utility.TEST_PATH + "\\" + fileName;
			File deleteFile = new File(filePath);
			System.out.println(filePath);
			
			if(deleteFile.exists()){
				deleteFile.delete();
				System.out.println("파일 삭제 성공!");
			}else{
				System.out.println("파일 삭제 실패!");
			}
			%>
			<script type="text/javascript">
				alert('글 삭제되었습니다.');
				location.href="list.jsp";
			</script>
		<%}else{%>
			<script type="text/javascript">
				alert("비밀번호가 일치하지 않습니다.");
				history.back();
			</script>	
	<%	}
	}catch(SQLException e){
		e.printStackTrace();%>
		<script type="text/javascript">
			alert('글 삭제 실패!');
			history.go(-1);
		</script>
	<%} %>
	
</body>
</html>
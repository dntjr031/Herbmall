<%@page import="com.herbmall.common.Utility"%>
<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	//list.jsp에서 [제목]클릭하면 get방식으로 이동
	//=> http://192.168.11.31:9090/herbmall/reBoard/detail.jsp?no=7  

	//1
	String no=request.getParameter("no");
	if(no==null || no.isEmpty()){ %>
		<script type="text/javascript">
			alert("잘못된 url 입니다.");
			location.href="list.jsp";
		</script>
		
		<%return;
	} 
	
	//2
	ReBoardDAO dao = new ReBoardDAO();
	ReBoardVO vo=null;
	try{
		vo=dao.selectByNo(Integer.parseInt(no));
	}catch(SQLException e){
		e.printStackTrace();	
	}
	
	//3
	String content = vo.getContent();
	if(content!=null && !content.isEmpty()){
		content=content.replace("\r\n", "<br>");
	}else{
		content="";
	}
	
	//파일이 첨부된 경우 파일정보와 다운로드 수 출력
	String fileInfo = "", downInfo="";
	String fileName = vo.getFileName();
	
	if(fileName != null && !fileName.isEmpty()){
		fileInfo = Utility.getFileInfo(vo.getOriginalFileName(), vo.getFileSize());
		
		downInfo = "다운 : " + vo.getDownCount();
	}else{
		fileName = "";
	}
%>    
<!DOCTYPE HTML>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>자료실 상세보기 - 허브몰</title>
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
			<span class="sp1">작성자</span> <span><%=vo.getName() %></span>
		</div>
		<div>
			<span class="sp1">등록일</span> <span><%=vo.getRegdate() %></span>
		</div>
		<div>
			<span class="sp1">조회수</span> <span><%=vo.getReadcount() %></span>
		</div>
		<div>
			<span class="sp1">첨부화일</span> 
			<span>
				<a href="down.jsp?fileName=<%=fileName%>&no=<%=no%>"><%=fileInfo %></a>
				&ensp;<%=downInfo %>
			</span>
		</div>
		<div class="lastDiv">			
			<p class="content"><%=content %></p>
		</div>
		<div class="center">		
			<a href='edit.jsp?no=<%=no%>'>수정</a> |
        	<a href
='delete.jsp?no=<%=no%>&step=<%=vo.getStep()%>&groupNo=<%=vo.getGroupNo()%>&fileName=<%=fileName%>'>
        		삭제</a> |
        	<a href='reply.jsp?no=<%=no%>'>답변</a> |
        	<a href='list.jsp'>목록</a>			
		</div>
	</div>
</body>
</html>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	//[1] write.jsp에서 [글목록] 클릭하면 get방식으로 이동
	//[2] write_ok.jsp에서 글쓰기 성공하면 get방식으로 이동
	//[3] list.jsp에서 [검색]버튼 클릭하면 post방식으로 서브밋
	//[4] list.jsp에서 페이지번호 클릭하면 get방식으로 이동
			
	//1	
	request.setCharacterEncoding("utf-8");
	String condition=request.getParameter("searchCondition");
	String keyword=request.getParameter("searchKeyword");
	
	//2
	ReBoardDAO dao = new ReBoardDAO();

	List<ReBoardVO> list=null;
	try{
		list=dao.selectAll(condition, keyword);		
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	//페이징 처리
	//list.jsp?currentPage=2
	int currentPage=1;  //현재 페이지
	
	if(request.getParameter("currentPage")!=null 
		&& !request.getParameter("currentPage").isEmpty()){
		currentPage
		=Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int pageSize=5; //한 페이지에 보여줄 레코드 개수
	int blockSize=10; //블럭 사이즈 1~10, 11~20 => 10
	int totalRecord=list.size(); //전체 레코드 개수, 예)17
	int totalPage= (int)Math.ceil((float)totalRecord/pageSize);
	//=> 전체 페이지 개수
	
	//현재 페이지를 이용하는 변수
	int firstPage=currentPage - (currentPage-1)%blockSize;
	//=> 블럭의 시작 페이지 1,11,21..
	int lastPage = firstPage+(blockSize-1); //10,20,30...
	//=> 블럭의 마지막 페이지 10, 20, 30...
	int curPos = (currentPage-1)*pageSize;
	//=> ArrayList에서의 시작 인덱스 0,5,10,...
	int num=totalRecord - curPos;
	//=> 페이지당 글 리스트 시작번호 17, 12, 7, 2
			
%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>답변형 게시판 글 목록 - 허브몰</title>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="../css/mainstyle.css" />
<link rel="stylesheet" type="text/css" href="../css/clear.css" />
<link rel="stylesheet" type="text/css" href="../css/formLayout.css" />
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />
<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">	

</script>
<style type="text/css">
	body{
		padding:5px;
		margin:5px;
	 }	
</style>	
</head>	
<body>
<h2>답변형 게시판</h2>
<%if(keyword!=null && !keyword.isEmpty()){ %>
	<p>검색어 : <%=keyword %>, <%=list.size() %>건 검색되었습니다.</p>
<%}else{ 
	keyword="";
} %>

<div class="divList">
<table class="box2"
	 	summary="답변형 게시판에 관한 표로써, 번호, 제목, 작성자, 작성일, 조회수에 대한 정보를 제공합니다.">
	<caption>답변형 게시판</caption>
	<colgroup>
		<col style="width:10%;" />
		<col style="width:50%;" />
		<col style="width:15%;" />
		<col style="width:15%;" />
		<col style="width:10%;" />		
	</colgroup>
	<thead>
	  <tr>
	    <th scope="col">번호</th>
	    <th scope="col">제목</th>
	    <th scope="col">작성자</th>
	    <th scope="col">작성일</th>
	    <th scope="col">조회수</th>
	  </tr>
	</thead> 
	<tbody>
		<%if(list==null || list.isEmpty()){ %>
			<tr>
				<td colspan="5" class="align_center">
					게시판 글이 존재하지 않습니다.</td>
			</tr>			
		<%}else{ %>  
		  	<!--게시판 내용 반복문 시작  -->
		  	<%for(int i=0;i<pageSize;i++){
		  		if(num-- < 1) break;
		  		
		  		ReBoardVO vo = list.get(curPos++);
		  	%>		
				<tr class="align_center">
					<td><%=vo.getNo() %></td>
					<td class="align_left">
						<a href="countUpdate.jsp?no=<%=vo.getNo()%>">
							<%=vo.getTitle() %></a></td>
					<td><%=vo.getName() %></td>
					<td><%=sdf.format(vo.getRegdate()) %></td>
					<td><%=vo.getReadcount() %></td>		
				</tr> 
			<%}//for %>
		  	<!--반복처리 끝  -->
	  	<%}//if %>
	  </tbody>
</table>	   
</div>
<div class="divPage">
	<!-- 페이지 번호 추가 -->		
	<!-- 이전 블럭으로 이동 ◀ -->
	<%if(firstPage>1){ %>
		<a href="list.jsp?currentPage=<%=firstPage-1%>">
			<img src="../images/first.JPG" alt="이전 블럭으로 이동">
		</a>
	<%} %>
	
	<!-- [1][2][3][4][5][6][7][8][9][10] -->
	<%for(int i=firstPage;i<=lastPage;i++){ 
		if(i > totalPage) break;
	%>
		<%if(i!=currentPage){%>
			<a href="list.jsp?currentPage=<%=i%>">[<%=i %>]</a>
		<%}else{ %>
			<span style="color:blue;font-weight:bold"><%=i %></span>
		<%}//if %>					
	<%}//for %>	
	
	<!-- 다음 블럭으로 이동 ▶ -->
	<%if(lastPage < totalPage){ %>
		<a href="list.jsp?currentPage=<%=lastPage+1%>">
			<img src="../images/last.JPG" alt="다음 블럭으로 이동">
		</a>
	<%} %>
	<!--  페이지 번호 끝 -->
</div>
<div class="divSearch">
   	<form name="frmSearch" method="post" action='list.jsp'>
        <select name="searchCondition">
            <option value="title" 
            	<%if("title".equals(condition)){ %>
            		selected="selected"
            	<%} %>
            >제목</option>
            <option value="content" 
            	<%if("content".equals(condition)){ %>
            		selected="selected"
            	<%} %>
            >내용</option>
            <option value="name" 
            	<%if("name".equals(condition)){ %>
            		selected="selected"
            	<%} %>
            >작성자</option>
        </select>   
        <input type="text" name="searchKeyword" title="검색어 입력"
        	value="<%=keyword%>">   
		<input type="submit" value="검색">
    </form>
</div>

<div class="divBtn">
    <a href='write.jsp' >글쓰기</a>
</div>

</body>
</html>


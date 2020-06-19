<%@page import="com.herbmall.board.model.BoardService"%>
<%@page import="com.herbmall.board.model.BoardVo"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style type="text/css">
#divMainNotice{
	width: 310px;
}
#divMainNotice div span:first-of-type {
	padding: 0 0 0 160px;
}
#divMainNotice div:first-of-type > img {
	width: 95px;
}
#divMainNotice div:nth-of-type(2) img{
	width: 310px;
	height: 5px;
}
#divMainNotice div:nth-of-type(3) ul{	
	list-style-type: none;
	margin: 10px 0 0 0;
	padding: 0;
	font-size: 0.9em;
}
#divMainNotice div:nth-of-type(3) ul li{
	padding: 5px 0 5px 2px;
}
</style>
<%
	//1
	//2
	List<BoardVo> list = null;
	try{
		BoardService service = new BoardService();
		list =  service.selectNotice();
	}catch(SQLException e){
		e.printStackTrace();
	}
	//3
%>
<div id="divMainNotice">
	<div>
		<img alt="공지사항" src="<%=request.getContextPath()%>/images/notice2.JPG">
		<span>
			<a href="<%=request.getContextPath()%>/board/list.jsp">
				<img alt="more" src="<%=request.getContextPath() %>/images/more.JPG">
			</a>
		</span>
	</div>
	<div>
		<img alt="line" src="<%=request.getContextPath() %>/images/Line.JPG">
	</div>
	<div>
		<ul>
		<!-- 반복시작 -->
		<%
		if(list != null && !list.isEmpty()){
			for(int i = 0; i < list.size(); i++){
				BoardVo vo = list.get(i);
			%>
				<li><img alt="dot" src="<%=request.getContextPath() %>/images/dot.JPG"> <%=vo.getTitle() %></li>
			<%}
			
		}else{%>
			<li>공지사항이 없습니다.</li>
		<%}%>
		<!-- 반복끝 -->
		</ul>
	</div>
</div>
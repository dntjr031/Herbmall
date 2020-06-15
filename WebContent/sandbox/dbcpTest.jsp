<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>dbcpTest.jsp</title>
</head>
<body>
<h1>dbcp연습</h1>
<table border="1" style="width: 600px">
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
	</tr>

<%
	Connection con = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	try{
		Context ctx = new InitialContext();
		Context envCtx =  (Context)ctx.lookup("java:/comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/oracledb");
		//=> DataSource - 톰캣이 구현한 커넥션풀 객체
		con = ds.getConnection();
		
		String sql = "select * from reboard order by no desc";
		ps = con.prepareStatement(sql);
		
		rs = ps.executeQuery();
		
		while(rs.next()){
			int no = rs.getInt("no");
			String title = rs.getString("title");
			String name = rs.getString("name");%>
			
			<tr>
				<td><%=no %></td>
				<td><%=title %></td>
				<td><%=name %></td>
			</tr>
		<%	
		}
		
	}catch(SQLException e){
		e.printStackTrace();
	}finally{
		if(rs!=null) rs.close();
		if(ps!=null) ps.close();
		if(con!=null) con.close();
	}
%>
	</table>
</body>
</html>
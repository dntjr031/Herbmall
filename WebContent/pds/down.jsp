<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%@page import="com.herbmall.common.Utility"%>
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
	// detail.jsp 에서 [fileName]을 누르면 get방식으로 이동
	//=> http://localhost:9090/Herbmall/pds/down.jsp?fileName=%ED%8C%A8%ED%82%A4%EC%A7%80%20%EB%84%A3%EB%8A%94%20%EA%B2%BD%EB%A1%9C.txt&no=5
	//=>[1] 파라미터인 no에 해당하는 글의 다운로드 수 증가시키기
	//=>[2] 파일 다운로드 처리
	
	//1.
	String no = request.getParameter("no");
	String fileName = request.getParameter("fileName");
	
	//2
	ReBoardDAO dao = new ReBoardDAO();
	BufferedInputStream bis = null;
	BufferedOutputStream bos = null;
	try{
		int cnt = dao.updateDownCount(Integer.parseInt(no));
		
		//3
		//파일 다운로드 처리
		response.reset(); //page의 설정을 바꾸기 위해서 response를 다 날려버림
		
		//setContentType는 MIME 타입을 지정-octet-stream으로 지정시, 
		//형식을 지정하지 않겠다는 것
		response.setContentType("application/octet-stream");
		
		//브라우저 파일 확장자를 포함하여 모든 확장자의 파일들에 대해 다운로드시 무조건
		//파일다운로드 대화상자가 뜨도록 하는 헤더속성
		response.setHeader("Content-Disposition", 
			"attachment;filename=" 
			+ new String(fileName.getBytes("euc-kr"),"ISO-8859-1"));
		//=> url 전송시 ISO-8859-1 로 인코딩되므로 한글 처리 위해 인코딩
				
		out.clear();
		out = pageContext.pushBody();
		//=> 이를 생략하면 프로그램 상엔 이상이 없으나 이미 존재하고 있는
		// out객체로 바이트 기반의 스트림 작업을 명시하면서 오류가 발생함
		
		String upPath = application.getRealPath(Utility.UP_PATH);
		upPath = config.getServletContext().getRealPath(Utility.UP_PATH);
		upPath = Utility.TEST_PATH;
		
		File file = new File(upPath, fileName);
		
		byte[] buf = new byte[1024*1024];
		bis = new BufferedInputStream(new FileInputStream(file));
		bos = new BufferedOutputStream(response.getOutputStream());
		
		int len = 0;
		while((len = bis.read(buf)) != -1){
			bos.write(buf);
		}
		
	}catch(SQLException e){
		e.printStackTrace();
	}finally{
		if(bis != null) bis.close();
		if(bos != null) bos.close();
	}
	
%>
</body>
</html>
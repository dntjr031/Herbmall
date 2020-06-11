<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.IOException"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>uploadTest_ok.jsp</title>
</head>
<body>
	<%
		String upPath="pds_upload";
		//업로드할 디렉토리
		String saveDir=application.getRealPath(upPath);
		//=> 실제 물리적 경로
		System.out.println("saveDir="+saveDir);
		saveDir=config.getServletContext().getRealPath(upPath);
		System.out.println("saveDir="+saveDir);
		
		int maxSize=2*1024*1024; //업로드할 최대 용량 : 2M
		String encoding="utf-8"; //인코딩
		
		//파일 업로드 처리
		try{
			MultipartRequest mr
				=new MultipartRequest(request, saveDir, maxSize,
						encoding, new DefaultFileRenamePolicy());
			//마지막 매개변수-파일 덮어쓰기 방지, 동일한 파일명이 업로드되면 파일명 변경해줌
			System.out.println("파일 업로드 완료됨!");
			
			String fileName=mr.getFilesystemName("fileName");
			long fileSize=0;
			String originName="", contentType="";
			if(fileName!=null && !fileName.isEmpty()){
				//파일 업로드 한 경우
				File file=mr.getFile("fileName");
				fileSize=file.length();
				
				originName=mr.getOriginalFileName("fileName");
				contentType=mr.getContentType("fileName");
			}
			
			String id=request.getParameter("id");
			String id2=mr.getParameter("id"); %>
			
			<p>업로드한 파일명:<%=fileName %></p>
			<p>업로드한 파일크기:<%=fileSize %></p>
			<p>원래 파일명:<%=originName %></p>
			<p>업로드한 파일의 컨텐트 타입:<%=contentType %></p>
			<p>파라미터 id(request 이용):<%=id %></p>
			<p>파라미터 id(mr 이용):<%=id2 %></p>
	<%	}catch(IOException e){
			e.printStackTrace();
		}
	%>
</body>
</html>







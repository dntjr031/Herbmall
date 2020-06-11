<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.IOException"%>
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
	String upPath="pds_upload";
	String saveDir=application.getRealPath(upPath);
	saveDir=config.getServletContext().getRealPath(upPath);
	saveDir
="C:\\Users\\STU-03\\Documents\\lecture\\java\\workspace_list\\jsp_ws\\Herbmall\\WebContent\\pds_upload";

	int maxSize=2*1024*1024;
	
	try{
		MultipartRequest mr 
		= new MultipartRequest(request, saveDir, maxSize, "utf-8",
				new DefaultFileRenamePolicy());
		System.out.println("파일 업로드 완료!");
		
		Enumeration en=mr.getFileNames();
		while(en.hasMoreElements()){
			String name=(String)en.nextElement();
			
			String fileName=mr.getFilesystemName(name);
			if(fileName!=null && !fileName.isEmpty()){
				File file=mr.getFile(name);
				long fileSize=file.length();
				String originName=mr.getOriginalFileName(name);
				
				out.print("<p>업로드 파일:"+fileName+"</p>");
				out.print("<p>업로드 파일크기:"+fileSize+"</p>");
				out.print("<p>원래 파일:"+originName+"</p><hr>");
			}
		}
		
		String id=mr.getParameter("id");
		String addr=mr.getParameter("address");
		
		out.print("<p>id : "+id+"</p>");
		out.print("<p>address : "+addr+"</p>");
	}catch(IOException e){
		System.out.println("2M이상의 파일은 업로드 불가!!");
		e.printStackTrace();
	}
%>

</body>
</html>






<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.IOException"%>
<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write_ok.jsp</title>
</head>
<body>
<%
	//write.jsp에서 post방식으로 서브밋
	//1.
	String upPath="pds_upload";
	String saveDir=application.getRealPath(upPath);
	saveDir=config.getServletContext().getRealPath(upPath);
	System.out.println("saveDir="+saveDir);
	
	//test경로
	saveDir
="C:\\Users\\STU-03\\Documents\\lecture\\java\\workspace_list\\jsp_ws\\Herbmall\\WebContent\\pds_upload";
	System.out.println("test 경로 ="+saveDir);

	int maxSize=2*1024*1024;  //2M
	String encoding="utf-8";
	
	try{
		MultipartRequest mr 
			= new MultipartRequest(request, saveDir, maxSize, encoding,
					new DefaultFileRenamePolicy());
		System.out.println("업로드 완료!!");

		String fileName=mr.getFilesystemName("upfile");
		long fileSize=0;
		String originName="";
		
		//파일이 업로드된 경우
		if(fileName!=null && !fileName.isEmpty()){
			File file = mr.getFile("upfile");
			fileSize=file.length();
			originName=mr.getOriginalFileName("upfile");
		}
		
		String title=mr.getParameter("title");
		String name=mr.getParameter("name");
		String pwd=mr.getParameter("pwd");
		String email=mr.getParameter("email");
		String content=mr.getParameter("content");
		
		String ip=request.getRemoteAddr();
		String ip2=request.getRemoteHost();
		System.out.println("ip="+ip);
		System.out.println("ip2="+ip2);
		
		//2.
		ReBoardDAO dao = new ReBoardDAO();
		ReBoardVO vo = new ReBoardVO();
		vo.setContent(content);
		vo.setEmail(email);
		vo.setName(name);
		vo.setPwd(pwd);
		vo.setTitle(title);
		
		int cnt = 0;
	
		cnt =dao.insertReBoard(vo);		
		if(cnt>0){%>
			<script type="text/javascript">
				alert('글 등록되었습니다.');
				location.href="list.jsp";
			</script>	
	  <%}else{%>
			<script type="text/javascript">
				alert('글 등록 실패!');
				history.back();
			</script>
	  <%}
	}catch(SQLException e){
		e.printStackTrace();
	}catch(IOException e){%>
		<script type="text/javascript">
			alert('2M 이상의 파일은 업로드할 수 없습니다!');
			history.back();
		</script>
		<%e.printStackTrace();
	}
	
	//3.
%>
</body>
</html>



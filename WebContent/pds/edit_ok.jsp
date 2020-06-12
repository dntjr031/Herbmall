<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.herbmall.common.Utility"%>
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
	//edit.jsp에서 post방식으로 서브밋
	//1
	request.setCharacterEncoding("utf-8");

	//file 저장
	String saveDir=application.getRealPath(Utility.UP_PATH); 
	saveDir=config.getServletContext().getRealPath(Utility.UP_PATH);
	// => 웹 어플리케이션의 실제 물리적 경로를 구하기 위해 사용(위 2가지 방법 중 하나 이용)
	// => application, config.getServletContext() 는 웹 어플리케이션 즉, Herbmall을 뜻함
	
	//테스트 경로로 바꿔줌(개발하면서 바로 확인하기 위해)
	saveDir = Utility.TEST_PATH;
	
	System.out.println("saveDir="+saveDir);
	
	//test경로
	saveDir= Utility.TEST_PATH;
	System.out.println("test 경로 ="+saveDir);
	
	int maxSize = 2*1024*1024;  //2M
	String encoding = "utf-8";
	
	int cnt=0;
	try{
		MultipartRequest mr 
		= new MultipartRequest(request, saveDir, maxSize, encoding,
				new DefaultFileRenamePolicy());
		System.out.println("업로드 완료!!");
	
		//DB에 넣기 위해 fileName, originName, fileSize를 받아옴
		String fileName = mr.getFilesystemName("upfile");
		long fileSize = 0;
		String originName = "";
		
		ReBoardDAO dao = new ReBoardDAO();
		ReBoardVO vo = new ReBoardVO();
		//파일이 업로드된 경우
		if(fileName!=null && !fileName.isEmpty()){
			File file = mr.getFile("upfile");
			fileSize = file.length();
			originName = mr.getOriginalFileName("upfile");
		}
		
		String title = mr.getParameter("title");
		String name = mr.getParameter("name");
		String pwd = mr.getParameter("pwd");
		String email = mr.getParameter("email");
		String content = mr.getParameter("content");
		String no = mr.getParameter("no");
		String oldFileName = mr.getParameter("oldFileName");
		
		//2
		vo.setContent(content);
		vo.setEmail(email);
		vo.setName(name);
		vo.setNo(Integer.parseInt(no));
		vo.setPwd(pwd);
		vo.setTitle(title);
		vo.setFileName(fileName);
		vo.setFileSize(fileSize);
		vo.setOriginalFileName(originName);
		
		if(dao.checkPwd(Integer.parseInt(no), pwd)){ //비번체크
			cnt=dao.updateReBoard(vo);	
			
			if(cnt>0){ 
				//새로 파일이 첨부된 경우 기존 파일 삭제
				if(fileName != null && !fileName.isEmpty()){
					
					if(oldFileName != null && !oldFileName.isEmpty()){
						File oldFile = new File(saveDir, oldFileName);
						if(oldFile.exists()){
							oldFile.delete();
							System.out.println("파일 삭제 완료!");
						}else{
							System.out.println("파일 삭제 실패!");
						}
					}
				}
			%>
				<script type="text/javascript">
					alert('글 수정되었습니다.');
					location.href="detail.jsp?no=<%=no%>";
				</script>	
		<%	}else{%>
				<script type="text/javascript">
					alert('글 수정 실패!');
					history.go(-1);
				</script>
		<%	}
		}else{%>
			<script type="text/javascript">
				alert('비밀번호가 일치하지 않습니다.');
				history.go(-1);
			</script>
	<%	}
		
	}catch(SQLException e){
		e.printStackTrace();
	}catch(IOException e){
		e.printStackTrace();
	}
%>
</body>
</html>
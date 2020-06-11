<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>다중 파일 업로드 연습</h1>

	<form name="frm1" method="post"  action="uploadTest2_ok.jsp" 
		enctype="multipart/form-data">
		아이디 <input type="text" name="id"/><br>
		주소 <input type="text" name="address"/><br>
		파일첨부<br> 
		<input type="file" name="upfile1" /><br>
		<input type="file" name="upfile2" /><br>
		<input type="file" name="upfile3" /><br><br>
		
		<input type="submit" value="전송" />
		
	</form>

</body>
</html>



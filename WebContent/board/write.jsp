<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="../css/mainstyle.css" />
<link rel="stylesheet" type="text/css" href="../css/clear.css" />
<link rel="stylesheet" type="text/css" href="../css/formLayout.css" />
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />

<title>자유게시판 글쓰기 - 허브몰</title>
<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$(".btList").click(function() {
			location.href = 'list.jsp';
		});
		
		$("form[name=frmWrite]").submit(function() {
			if($("#title").val() == ''){
				alert("제목을 입력하세요");
				$("#title").focus();
				event.preventDefault();
			}else if($("#name").val().length<1){
				alert("이름을 입력하세요");
				$("#name").focus();
				event.preventDefault();
			}else if($("#pwd").val() == ''){
				alert("비밀번호를 입력하세요");
				$("#pwd").focus();
				event.preventDefault();
			}
		});
	});
</script>

</head>
<body>
<div class="divForm">
<form name="frmWrite" method="post" action="write_ok.jsp" >
 <fieldset>
	<legend>글쓰기</legend>
        <div class="firstDiv">
            <label for="title">제목</label>
            <input type="text" id="title" name="title"  />
        </div>
        <div>
            <label for="name">작성자</label>
            <input type="text" id="name" name="name" />
        </div>
        <div>
            <label for="pwd">비밀번호</label>
            <input type="password" id="pwd" name="pwd" />
        </div>
        <div>
            <label for="email">이메일</label>
            <input type="text" id="email" name="email" />
        </div>
        <div>  
        	<label for="content">내용</label>        
 			<textarea id="content" name="content" rows="12" cols="40"></textarea>
        </div>
        <div class="center">
            <input type = "submit" value="등록"/>
            <input type = "Button" value="글목록" class="btList"/>         
        </div>
    </fieldset>
</form>
</div>   

              
</body>
</html>
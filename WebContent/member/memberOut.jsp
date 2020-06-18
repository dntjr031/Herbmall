<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>
<%@ include file="../login/loginCheck.jsp" %>
<script type="text/javascript">
	$(function() {
		$("#pwd").focus();
		
		$("form[name=frmOut]").submit(function() {
			if($("#pwd").val() == ''){
				alert("비밀번호를 입력해야 합니다");
				return false;
			}
			if(!confirm("정말로 탈퇴하시겠습니까?")){
				return false;
			}
		});
	});
</script>
<article class="simpleForm">
	<h2>회원탈퇴</h2>
	<p class="p">회원탈퇴하시겠습니까?</p>
	<form action="memberOut_ok.jsp" name="frmOut" method="post">
		<div>
			<label for="pwd">비밀번호</label>
			<input type="password" id="pwd" name="pwd">
		</div>
		<div class="align_center">
			<input type="submit" value="회원탈퇴">
			<input type="reset" value="취소">
		</div>
	</form>
</article>
<%@ include file="../inc/bottom.jsp"%>
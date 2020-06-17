<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/top.jsp" %>
<%
	//쿠키 읽어오기
	Cookie[] ckArr = request.getCookies();
	String ckUserid = "";
	for(int i = 0; i < ckArr.length; i++){
		String cName = ckArr[i].getName();
		if(cName.equals("ck_userid")){
			ckUserid = ckArr[i].getValue();
			break;
		}
	}
	
%>
<style type="text/css">
#chkId + label{
	font-size: 0.9em;
}
</style>
<script type="text/javascript">
	$(function() {
		
		$("form[name=frmLogin]").submit(function() {
			if($("#userid").val() == ''){
				alert("아이디를 입력하세요");
				$("#userid").focus();
				return false;
			}
			
			if($("#pwd").val() == ''){
				alert("비밀번호를 입력하세요");
				$("#pwd").focus();
				return false;
			}
		});
	});
	
</script>
<article class="simpleForm">
	<form name="frmLogin" method="post" action="login_ok.jsp">
		<legend>로그인</legend>
		<fieldset>
			<div>
				<label for="userid" class="label">아이디</label>
				<input type="text" name="userid" id="userid" value="<%= ckUserid%>">
			</div>
			<div>
				<label for="pwd" class="label">비밀번호</label>
				<input type="password" name="pwd" id="pwd">
			</div>
			<div class=align_center>
				<input type="submit" value="로그인">
				<input type="checkbox" name="saveId" id="chkId"
				<%if(ckUserid != null && !ckUserid.isEmpty()){%>
						checked="checked"
				<%}%> >
				<label for="chkId">아이디 저장하기</label>
			</div>
		</fieldset>
	</form>
</article>
<%@include file="../inc/bottom.jsp" %>
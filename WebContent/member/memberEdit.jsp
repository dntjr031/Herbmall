<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp" %>
<jsp:useBean id="memVo" class="com.herbmall.member.model.MemberVO" scope="page"></jsp:useBean>
<jsp:useBean id="memDAO" class="com.herbmall.member.model.MemberDAO" scope="session"></jsp:useBean>
<%
	// top.jsp 에서 회원정보수정을 누르면 get방식으로 이동 
	// => http://localhost:9090/Herbmall/member/memberEdit.jsp
	String c_userid = (String)session.getAttribute("userid");
	String c_userName = (String)session.getAttribute("userName");
	
	try{
		memVo = memDAO.selectMember(c_userid);
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	String address = memVo.getAddress();
	String addressDetail = memVo.getAddressDetail();
	String zipcode = memVo.getZipcode();
	String hp = memVo.getHp();
	String hp1 = "";
	String hp2 = "";
	String hp3 = "";
	String email = memVo.getEmail();
	String email1 = "";
	String email2 = "";
	
	if(address==null||address.isEmpty()){
		address = "";
	}
	if(addressDetail==null||addressDetail.isEmpty()){
		addressDetail = "";
	}
	if(zipcode==null||zipcode.isEmpty()){
		zipcode = "";
	}
	if(hp!=null&&!hp.isEmpty()){
		hp1 = hp.substring(0, hp.indexOf("-"));
		hp2 = hp.substring(hp.indexOf("-")+1, hp.lastIndexOf("-"));
		hp3 = hp.substring(hp.lastIndexOf("-")+1);
	}
	if(email!=null&&!email.isEmpty()){
		email1 = email.substring(0, email.indexOf("@"));
		email2 = email.substring(email.indexOf("@")+1);
	}
%>
<script type="text/javascript">
	$(function() {
		$("#wr_submit").click(function() {
			
			if($("#name").val() == ''){
				alert("이름을 입력해야 합니다.");
				return false;
			}else if($("#userid").val() == ''){
				alert("회원ID를 입력해야 합니다.");
				return false;
			}else if($("#pwd").val() == ''){
				alert("비밀번호를 입력해야 합니다.");
				return false;
			}else if(!validate_userid($("#userid").val())){
				alert("아이디는 대소문자와 숫자, _ 만 올 수 있습니다.");
				return false;
			}else if(!validate_phone($("#hp2").val())){
				alert("전화번호는 숫자만 올 수 있습니다.");
				return false;
			}else if(!validate_phone($("#hp3").val())){
				alert("전화번호는 숫자만 올 수 있습니다.");
				return false;
			}else if($("#pwd").val() != $("#pwd2").val()){
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}else if($("#chkId").val() != "Y"){
				alert("중복확인을 해야합니다.");
				return false;
			}
			
			
		});
		
		$("#email2").change(function() {
			
			$( "select option:selected" ).each(function() {
			      var str = $( this ).text();
			      if(str == "직접입력"){
			    	  $("#email3").css("visibility","visible");
			    	  $("#email3").val("");
			    	  $("#email3").focus();
			      }else{
			    	  $("#email3").css("visibility","hidden");
			    	  $("#email3").val("");
			      }
			    });
		});
		
		$("#btnZipcode").click(function() {
			var url = "<%=request.getContextPath()%>/zipcode/zipcode.jsp";
            window.open(url, " _blank", "width=600,height=400,left=400,top=300,location=yes,resizable=yes"); 
		});
		
		if('<%=hp%>' != ""){
			$("#hp1 option").each(function() {
				if($(this).text() == '<%=hp1%>'){
					$(this).attr("selected","selected");
				}
			});
		}
		
		if('<%=email%>' != ""){
			$("#email2 option").each(function() {
				if($(this).text() == '<%=email2%>'){
					$(this).attr("selected","selected");
				}else{
					$("option[value=etc]").attr("selected","selected");
					$("#email3").css("visibility","visible");
					$("#email3").val('<%=email2%>');
				}
			});
		}
	});
	
	function validate_userid(id) {
		var pattern = new RegExp(/^[a-zA-Z0-9_]+$/g);
		return pattern.test(id);
		/* 정규식  /^[a-zA-Z0-9_]+$/g 
		a에서 z 사이의 문자, A에서 Z사이의 문자, 0에서 9사이의 숫자나 _ 로 시작하거나 끝나야 한다는 의미
		닫기 대괄호(]) 뒤의 + 기호는 이 패턴이 한 번 또는 그 이상 반복된다는 의미
		*/ 
	}
	
	function validate_phone(tel) {
		var pattern = new RegExp(/^[0-9]*$/g);
		return pattern.test(tel);
		/* 정규식  /^[0-9]*$/g
		0에서 9사이의 숫자로 시작하거나 끝나야 한다는 의미(^는 시작, $는 끝을 의미)
		닫기 대괄호(]) 뒤의 * 기호는 0번 이상 반복
		*/ 
	}
	
	
</script>

<style type="text/css">
	.width_80{
		width:80px;
	}
	.width_350{
		width:350px;
	}	
</style>
<article>
<div class="divForm">
<form name="frm1" method="post" action="register_ok.jsp">
<fieldset>
	<legend>회원 정보 수정</legend>
    <div>        
        <label for="name">성명</label>
        <span><%=memVo.getName() %></span>
    </div>
    <div>
        <label for="userid">회원ID</label>
        <span><%= memVo.getUserid() %></span>
    </div>
    <div>
        <label for="pwd">비밀번호</label>
        <input type="Password" name="pwd" id="pwd">
    </div>
    <div>
        <label for="pwd2">비밀번호 확인</label>
        <input type="Password" name="pwd2" id="pwd2">
    </div>
    <div>
        <label for="zipcode">주소</label>
        <input type="text" name="zipcode" id="zipcode" ReadOnly  
        	title="우편번호" class="width_80" value="<%= zipcode%>">
        <input type="Button" value="우편번호 찾기" id="btnZipcode" title="새창열림"><br />
        <span class="sp1">&nbsp;</span>
        <input type="text" name="address" ReadOnly title="주소"  class="width_350"  value="<%= address%>"><br />
        <span class="sp1">&nbsp;</span>
        <input type="text" name="addressDetail" title="상세주소"  class="width_350"  value="<%= addressDetail%>">
    </div>
    <div>
        <label for="hp1">핸드폰</label>&nbsp;<select name="hp1" id="hp1" title="휴대폰 앞자리">
            <option value="010">010</option>
            <option value="011">011</option>
            <option value="016">016</option>
            <option value="017">017</option>
            <option value="018">018</option>
            <option value="019">019</option>
       	</select>
        -
        <input type="text" name="hp2" id="hp2" maxlength="4" title="휴대폰 가운데자리"
        	class="width_80" value="<%=hp2%>">-
        <input type="text" name="hp3" id="hp3" maxlength="4" title="휴대폰 뒷자리"
        	class="width_80" value="<%=hp3%>">
    </div>
    <div>
        <label for="email1">이메일 주소</label>
        <input type="text" name="email1"  id="email1" title="이메일주소 앞자리" value="<%=email1%>">@
        <select name="email2" id="email2"  title="이메일주소 뒷자리">
            <option value="naver.com">naver.com</option>
            <option value="hanmail.net">hanmail.net</option>
            <option value="nate.com">nate.com</option>
            <option value="gmail.com">gmail.com</option>
            <option value="etc">직접입력</option>
        </select>
        <input type="text" name="email3" id="email3" title="직접입력인 경우 이메일주소 뒷자리"
        	style="visibility:hidden;">
    </div>
    <div class="center">
         <input type="submit" id="wr_submit" value="정보수정">
    </div>
</fieldset>

    <input type ="hidden" name="chkId" id="chkId">
        
</form>
</div>
</article>

<%@ include file="../inc/bottom.jsp"%>
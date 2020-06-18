/**
 * member.js
 * 
 */
var contextPath = "/Herbmall";
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
		
		$("#btnChkId").click(function() {
			var userid = $("#userid").val();
			var url = contextPath+"/member/checkUserid.jsp?userid=" + userid;
            window.open(url, " _blank", "width=500,height=200,left=400,top=300,location=yes,resizable=yes"); 
		});
		
		$("#btnZipcode").click(function() {
			var url = contextPath+"/zipcode/zipcode.jsp";
            window.open(url, " _blank", "width=600,height=400,left=400,top=300,location=yes,resizable=yes"); 
		});
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
	
	
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String t_userid = (String)session.getAttribute("userid");
	boolean isLogin = false;
	if(t_userid != null && !t_userid.isEmpty()){
		isLogin = true;
	}
%>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>Herb Mall</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mainstyle.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/clear.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mystyle.css"/>
<script type="text/javascript" src="../js/jquery-3.5.1.min.js"></script>
</head>
<body>	
	<!-- 상단 띠 이미지 영역-->
	<div id="topImg" class="top_Img" style="background:url(<%=request.getContextPath()%>/images/bg_top1.PNG)  repeat-x">
		&nbsp;
	</div>

	<div id="wrap">
		<!-- header -->				
		<header id="header">
			<h1><a href="<%=request.getContextPath()%>/index.jsp"><img alt="로고 이미지" src="<%=request.getContextPath()%>/images/herbLogo7.jpg" height="95px" /></a></h1>
			<nav id="headerRight">
				<ul class="views">		
				<%if(isLogin){%>
					<li><a href="<%=request.getContextPath()%>/login/logout.jsp">로그아웃</a></li>
					<li><a href="<%=request.getContextPath()%>/member/memberEdit.jsp">회원정보수정</a></li>
					<li><a href="<%=request.getContextPath()%>/member/memberOut.jsp">회원탈퇴</a></li>
				<%}else{%>
					<li><a href="<%=request.getContextPath()%>/login/login.jsp">로그인</a></li>
					<li><a href="<%=request.getContextPath()%>/member/agreement.jsp">회원가입</a></li>
				<%}%>		            
					<li><a href="<%=request.getContextPath()%>/shop/cart/cartList.jsp">장바구니</a></li>
					<li><a href="<%=request.getContextPath()%>/shop/order/orderList.jsp">주문내역</a></li>
					<li><a href="<%=request.getContextPath()%>/shop/mypage.jsp">마이페이지</a></li>
					<li><a href="<%=request.getContextPath()%>/board/list.jsp">고객센터</a></li>					
				</ul>				
			</nav>
		</header>

		<nav id="top_navi">
			<div id='cssmenu'>
				<ul>			   
				   <li><a href="#"><span>베스트</span></a></li>
				   <li><a href="#"><span>자유게시판</span></a></li>
				   <li><a href="#"><span>이용후기</span></a></li>
				   <li><a href="#"><span>Q&A</span></a></li>
				   <li><a href="#"><span>FAQ</span></a></li>
				   <li class='last'><a href="#"><span>이벤트&쿠폰</span></a></li>
				</ul>
			</div>
		</nav>
		
		<!-- 라인 이미지 영역-->
		<div id="topLine" class="top_Line" style="background:url(<%=request.getContextPath()%>/images/line6.jpg)  repeat-x;font-size:7px">
			&nbsp;
		</div>
		
		<!-- container -->
		<div id="container">
			<nav>
				<dl id="leftNavi">
					<!-- category list -->
					<dt>허브</dt>
					<dd><a href="default.jsp">허브차</a></dd>
					<dd><a href="default.jsp">아로마 오일</a></dd>
					<dd><a href="default.jsp">향초</a></dd>
					<dd><a href="default.jsp">허브비누</a></dd>
				</dl>
			</nav>
			<section id="contents">
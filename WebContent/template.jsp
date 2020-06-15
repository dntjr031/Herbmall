<%@ page language="java" contentType="text/html; charset=utf-8"   pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mainstyle.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/clear.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mystyle.css"/>

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
					<li><a href="<%=request.getContextPath()%>/login/login.jsp">로그인</a></li>
					<li><a href="<%=request.getContextPath()%>/member/agreement.jsp">회원가입</a></li>	            
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
				<!-- content page -->
				<%-- <article id="centerCon">
					<img src="<%=request.getContextPath()%>/images/herb.JPG" border="0" class="mainImg" /><br/><br/>
					<p class="mainP">Main page입니다!!</p>
				</article>
				<article id="rightCon">
					공지사항
				</article>
				<article id="listCon">
					상품 목록
				</article> --%>
			</section>
		</div>
	</div>

	<!-- footer -->
	<footer id="footer">
		<!-- bottom page -->
		<div id="footer01">
			<div id="footer-left">
				<p>
					<a href="#">허브몰</a> 대표:김허브 사업자정보 : 123-45-67890 
					통신판매업 신고업번호 : 서울 제1호-허브몰 <a href="#">[사업자정보확인]</a> </br> 
					주소 : 서울시 강남구 역삼동 123-4 ABC타워 3층 101호 TEL : 02-1234-5678 
					fax : 02-1234-5678 </br> 
					개인정보관리책임자 :	이허브 (admin@herbmall.com) </br> 
					Copyright &copy; 2015 <a href="#" class="green">HerbMall</a>
					All Rights Reserved.				
				</p>
			</div>
		</div>						
	</footer>
</body>
</html>
    
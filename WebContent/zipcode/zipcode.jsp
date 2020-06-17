<%@page import="com.herbmall.common.PagingVO"%>
<%@page import="com.herbmall.zipcode.model.ZipcodeVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="zipService" class="com.herbmall.zipcode.model.ZipcodeService" scope="session"></jsp:useBean>
<%
	//[1] register.jsp에서 우편번호 찾기 누르면 get방식
	//[2] 자신에서 찾기누르면 submit
	//[3] 페이지 번호 누르면 자신에게 get
	//1 
	request.setCharacterEncoding("utf-8");
	String dong = request.getParameter("dong");

	int currentPage = 1;
	int pageSize=10;
	int blockSize=10;
	int totalRecord=0;
	
	if(request.getParameter("currentPage")!=null 
		&& !request.getParameter("currentPage").isEmpty()){
		currentPage
		= Integer.parseInt(request.getParameter("currentPage"));
	}
	
	List<ZipcodeVO> list = null; 
	PagingVO pagingVo = null;
	if(dong != null && !dong.isEmpty()){
		list = zipService.searchByDong(dong);
		totalRecord = list.size();
		pagingVo = new PagingVO(currentPage, totalRecord, pageSize, blockSize);
	}else{
		dong = "";
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>zipcode/zipcode.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mainstyle.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mystyle.css"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#dong").focus();
		
		$("form[name=frmZip]").submit(function() {
			if($("#dong").val() == ""){
				alert("검색할 지역명을 입력하세요");
				$("#dong").focus();
				return false;
			}
		});
		
	});
	
	function setZipcode(zipcode, address) {
		$(opener.document).find("#zipcode").val(zipcode);
		$(opener.document).find("input[name=address]").val(address);
		self.close()
	}
</script>
<style type="text/css">
.box2{
	width: 490px;
}

#divZip{
	margin: 10px 0;
}

label {
	font-size: 0.9em;
}
</style>
</head>
<body>
	<h1>우편번호 검색</h1>
	<form action="zipcode.jsp" name="frmZip" method="post">
		<label for="dong">지역명</label>
		<input type="text" id="dong" name="dong" value="<%=dong%>">
		<input type="submit" value="찾기">
	</form>
	<%
	if(list != null && !list.isEmpty()){%>
	<div id="divZip">
		<table class="box2"
		 summary="우편번호 검색 결과에 관한 표로써 우편번호, 주소에 대한 정보를 제공합니다.">
		<colgroup>
			<col style="width: 20%">
			<col style="width: *">
		</colgroup>
		
			<thead>
				<tr>
					<th scope="col">우편번호</th>
					<th scope="col">주소</th>
				</tr>
			</thead>
			<tbody>
				<!-- 반복 시작 -->
				<%if(list.size() > 0 ){
					int num = pagingVo.getNum();
					int curPos = pagingVo.getCurPos();
					
					for(int i = 0; i < pagingVo.getPageSize(); i++){
						if(num-- < 1) break;
						
						ZipcodeVO vo = list.get(curPos++);
						String bunji = vo.getStartbunji();
						String endbunji = vo.getEndbunji();
						if(endbunji != null && !endbunji.isEmpty()){
							bunji = " ( " + bunji;
							bunji += " ~ " + endbunji + " ) ";
						}
						
						String address = vo.getSido() + " " + vo.getSido() + " "
								+ vo.getGugun() + " " + vo.getDong();
						%>
						<tr>
							<td><%=vo.getZipcode() %></td>
							<td>
							<a href="#" onclick="setZipcode('<%=vo.getZipcode()%>','<%=address%>')">
							<%= address  + " " + bunji %>
							</a></td>
						</tr>
					<%}
				}else{%>
					<tr>
						<td colspan="2">검색결과가 없습니다.</td>
					</tr>
				<%}%>
				<!-- 반복 끝 -->
			</tbody>
		</table>
	</div>
	<%}%>
	<div style="text-align: center;">
	<%
	if(pagingVo != null){
		if(pagingVo.getFirstPage()>1){ %>
		<a href="zipcode.jsp?currentPage=<%=pagingVo.getFirstPage()-1%>&dong=<%=dong%>">
			<img src="../images/first.JPG" alt="이전 블럭으로 이동">
		</a>
	<%} %>
	
	<%for(int i=pagingVo.getFirstPage();i<=pagingVo.getLastPage();i++){ 
		if(i > pagingVo.getTotalPage()) break;
	%>
		<%if(i!=currentPage){%>
			<a href="zipcode.jsp?currentPage=<%=i%>&dong=<%=dong%>">[<%=i %>]</a>
		<%}else{ %>
			<span style="color:blue;font-weight:bold"><%=i %></span>
		<%}//if %>					
	<%}//for %>	
	
	<%if(pagingVo.getLastPage() < pagingVo.getTotalPage()){ %>
		<a href="zipcode.jsp?currentPage=<%=pagingVo.getLastPage()+1%>&dong=<%=dong%>">
			<img src="../images/last.JPG" alt="다음 블럭으로 이동">
		</a>
	<%} 
	}%>
	
	</div>
</body>
</html>
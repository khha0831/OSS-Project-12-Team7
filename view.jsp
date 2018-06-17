<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDTO" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1,shrink-to-fit=no">
<title>Insert title here</title>

<!--부트스트랩 CSS 추가-->
<link rel="stylesheet" href="./css/bootstrap.min.css">
<!--커스텀 CSS 추가-->
<link rel="stylesheet" href="./css/custom.css">
</head>
<body>
<% 
	String userID=null; 
	if(session.getAttribute("userID") != null){
	userID=(String)session.getAttribute("userID");	 
	}
	if(userID==null){
		PrintWriter script=response.getWriter();
		script.println("<script>"); 
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href='userLogin.jsp';");
		script.println("</script>");
	}
	int pageNumber2=1;
	if(request.getParameter("pageNumber2")!=null){
		pageNumber2=Integer.parseInt(request.getParameter("pageNumber2"));
	}
	
	int bbsID=0;
	if(request.getParameter("bbsID") != null){
		bbsID=Integer.parseInt(request.getParameter("bbsID"));
	}
	BbsDTO bbsDTO = new BbsDAO().getBbsDTO(bbsID);
	
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">Team_7</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
		<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item">
				<a class="nav-link" href="index.jsp">메인</a>
			</li>
			<li class="nav-item active">
				<a class="nav-link" href="bbs.jsp">게시판</a>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown"> 	
					회원관리
				</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
<%
	if(userID==null){
	
%>
						<a class="dropdown-item" href="userLogin.jsp">로그인</a>
						<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
<%
	} else{
%>						
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
<%
	}
%>						
					</div>			
		</ul>
		<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
			<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="search">
		 	<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
		</form>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center;border:1px solid #dddddd">
			<thead>
				<tr>
					<th colspan="2" style="background-color:#eeeeee; text-align:center;">게시판 글 보기</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width: 20%;">글 제목</td>
					<td colspan="2"><%=bbsDTO.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","<br>").replaceAll(" ","&nbsp;") %></td>
				</tr>
				<tr>
					<td>작성자</td>
					<td colspan="2"><%=bbsDTO.getUserID() %></td>
				</tr>
				<tr>
					<td>작성일자</td>
					<td colspan="2"><%=bbsDTO.getBbsDate().substring(0,11)+bbsDTO.getBbsDate().substring(11,13)+"시"+bbsDTO.getBbsDate().substring(14,16) + "분" %></td>
				</tr>
				<tr>
					<td>내용</td>
					<td colspan="2" style="min-height:200px; text-align:left"><%= bbsDTO.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","<br>").replaceAll(" ","&nbsp;")%></td>
				</tr>
			</tbody>
		</table>
				<a href="bbs.jsp" class="btn btn-primary">목록</a>
		<%
			if(userID != null && userID.equals(bbsDTO.getUserID())){
		%>
				<a href="update.jsp?bbsID= <%=bbsID%>" class="btn btn-primary">수정</a>
				<a onclick="return confirm('정말로 삭제하시겠습니까 ?')" href="deleteAction.jsp?bbsID= <%=bbsID%>" class="btn btn-danger">삭제</a>
		<%
			}
		%>
		</div>
	</div>
	<footer class="bg-dark mt-4 p-5 text-center" style="color:#ffffff;">
		Copyright &copy; 2018 Team_7 All Rights Reserved.
	</footer>
<!-- 제이쿼리 추가  -->
<script src="./js/jquery.min.js"></script>
<!-- 파퍼 추가  -->
<script src="./js/popper.js"></script>
<!-- 부트스트랩 자바스크립트 추가  -->
<script src="./js/bootstrap.min.js"></script>


</body>
</html>

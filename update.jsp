<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.BbsDTO" %>
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
	int bbsID=0;
	if(request.getParameter("bbsID") != null){
		bbsID = Integer.parseInt(request.getParameter("bbsID").trim());
	}
	if(bbsID==0){
		PrintWriter script=response.getWriter();
		script.println("<script>"); 
		script.println("alert('유효하지 않은 글입니다.');");
		script.println("location.href='bbs.jsp';");
		script.println("</script>");
	}
	BbsDTO bbsDTO = new BbsDAO().getBbsDTO(bbsID);
	if(!userID.equals(bbsDTO.getUserID())){
		PrintWriter script=response.getWriter();
		script.println("<script>"); 
		script.println("alert('권한이 없습니다.');");
		script.println("location.href='bbs.jsp';");
		script.println("</script>");
	}
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
					<div class="dropdown-menu" aria-labelledby="dropdown"></div>			
				</ul>
			<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="search">
		 		<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	<form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>">
	<div class="container">
		<div class="row">
			
				<table class="table table-striped" style="text-align: center;border:1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color:#eeeeee; text-align:center;">게시판 글 수정</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%=bbsDTO.getBbsTitle()%>" required></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height:350px;" required><%=bbsDTO.getBbsContent()%></textarea></td>
					</tr>
				</tbody>
			</table>	
			<div style=float:right;>
				<input type="submit" class="btn btn-primary" value="수정">	
			</div>		
		</div>
	</div>
	</form>
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

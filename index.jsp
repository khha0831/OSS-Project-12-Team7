<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
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
	if(session.getAttribute("userID")!=null){
	userID=(String)session.getAttribute("userID");	 
	}
	if(userID == null){
		PrintWriter script=response.getWriter();
		script.println("<script>"); 
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href='userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;	
	}
	boolean emailChecked=new UserDAO().getUserEmailChecked(userID);	
	if(emailChecked==false){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("location.href='emailSendConfirm.jsp';");
		script.println("</script>");
		script.close();
		return;	
	}	
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">회원가입</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
		<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active">
				<a class="nav-link" href="index.jsp">메인</a>
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
		<form class="form-inline my-2 my-lg-0">
			<input class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="search">
		 	<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
		</form>
		</div>
	</nav>
	
	<section class="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="lectureDivide" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="전공">전공</option>
				<option value="교양">교양</option>
				<option value="기타">기타</option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-2" placeolder="내용을 입력하세요.">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
		 	<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>
		</form>
	</section>
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelldby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
				<h5 class="modal-title" id="modal">게시판 등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>				
				</div>
				<div class="modal-body">
					<form action="./textAction.jsp" method="post">
						<div class="form-group">
							<label>제목</label>
							<input type="text" name="title" class="form-control" maxlength="30"> 
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="bulletinContent" class="form-control" maxlengh="2048" style="height: 180px;"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">등록</button>							
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelldby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
				<h5 class="modal-title" id="modal">신고하기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>				
				</div>
				<div class="modal-body">
					<form action="./reportAction.jsp" method="post">	
						<div class="form-group">
							<label>신고 제목</label>
							<input type="text" name="reportTitle" class="form-control" maxlength="30"> 
						</div>
						<div class="form-group">
							<label>신고 내용</label>
							<textarea name="reportContent" class="form-control" maxlengh="2048" style="height: 180px;"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="button" class="btn danger">등록</button>							
						</div>	
					</form>
				</div>
			</div>
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

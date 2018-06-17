<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.DatabaseUtil" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="cal.CalDAO" %>
<%@ page import="cal.CalDTO" %>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1,shrink-to-fit=no">
<title>Insert title here</title>
<style type="text/css">
tr,td{
	padding:10px;
}
a:link,a:visited{text-decoration:none; color:black;}   
a:hover{text-decoration:none; color:black;}

</style>

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
	int calID=0;
	if(request.getParameter("calID") != null){
		calID=Integer.parseInt(request.getParameter("calID"));
	}
	CalDTO calDTO = new CalDTO();
	
	 java.util.Calendar cal=java.util.Calendar.getInstance(); //Calendar객체 cal생성
	  int currentYear=cal.get(java.util.Calendar.YEAR); //현재 날짜 기억
	  int currentMonth=cal.get(java.util.Calendar.MONTH);
	  int currentDate=cal.get(java.util.Calendar.DATE);
	  String Year=request.getParameter("year"); //나타내고자 하는 날짜
	  String Month=request.getParameter("month");
	  int year, month;
	  if(Year == null && Month == null){ //처음 호출했을 때
	  year=currentYear;
	  month=currentMonth;
	  }
	  else { //나타내고자 하는 날짜를 숫자로 변환
	   year=Integer.parseInt(Year);
	   month=Integer.parseInt(Month);
	   if(month<0) { month=11; year=year-1; } //1월부터 12월까지 범위 지정.
	   if(month>11) { month=0; year=year+1; }
	  }
	  Connection conn= null;
	  PreparedStatement pstmt = null;
%>


<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<a class="navbar-brand" href="index.jsp">Team_7</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
			<div id="navbar" class="collapse navbar-collapse">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item active">
					<a class="nav-link" href="index.jsp">메인</a>
					</li>
					<li class="nav-item">
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
<center>
	<table border=0> <!-- 달력 상단 부분 -->
		<tr>
			<td align=left width=200> <!-- 년 도-->
			<a href="index.jsp?year=<%out.print(year-1);%>&month=<%out.print(month);%>">◀</a>
<% out.print(year); %>년
			<a href="index.jsp?year=<%out.print(year+1);%>&month=<%out.print(month);%>">▶</a>
			</td>
			<td align=center width=300> <!-- 월 -->
			<a href="index.jsp?year=<%out.print(year);%>&month=<%out.print(month-1);%>">◀</a>
<% out.print(month+1); %>월
			<a href="index.jsp?year=<%out.print(year);%>&month=<%out.print(month+1);%>">▶</a>
			</td>
			<td align=right width=200><% out.print(currentYear + "-" + (currentMonth+1) + "-" + currentDate); %></td>
		</tr>
	</table>
	
	<table border=3 cellspacing=3> <!-- 달력 부분 -->
		<tr bgcolor=#6799FF height=50 style=text-align:center>
			<td width=100>일</td> <!-- 일=1 -->
				<td width=100>월</td> <!-- 월=2 -->
				<td width=100>화</td> <!-- 화=3 -->
				<td width=100>수</td> <!-- 수=4 -->
				<td width=100>목</td> <!-- 목=5 -->
				<td width=100>금</td> <!-- 금=6 -->
				<td width=100>토</td> <!-- 토=7 -->
			</tr>
		<tr height=30>
<%
			cal.set(year, month, 1); //현재 날짜를 현재 월의 1일로 설정
				int startDay=cal.get(java.util.Calendar.DAY_OF_WEEK); //현재날짜(1일)의 요일
				int end=cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH); //이 달의 끝나는 날
				int br=0; //7일마다 줄 바꾸기
				for(int i=0; i<(startDay-1); i++) { //빈칸출력
					out.println("<td>&nbsp;</td>");
					br++;
					if((br%7)==0) {
					out.println("<br>");
					}
				}	
				for(int i=1; i<=end; i++) { //날짜출력
					out.println("<td align=right height=80><i><strong><font size =5>" + i + "</font></strong><i><br>");
					//메모(일정) 추가 
					int memoyear, memomonth, memoday;
					try{
					// select 문장을 문자열 형태로 구성한다.
					String SQL= " SELECT calendarmemo_year, calendarmemo_month, calendarmemo_day, calendarmemo_contents FROM cal ";
					conn=DatabaseUtil.getConnection();
					pstmt =conn.prepareStatement(SQL);
					// select 를 수행하면 데이터 정보가 ResultSet 클래스의 인스턴스로 리턴
					ResultSet rs= pstmt.executeQuery();
						while (rs.next()) { // 마지막 데이터까지 반복함.
						//날짜가 같으면 데이터 출력
						memoyear=rs.getInt("calendarmemo_year");
						memomonth=rs.getInt("calendarmemo_month");
						memoday=rs.getInt("calendarmemo_day");
							if(year==memoyear && month+1==memomonth && i==memoday) {
								out.println("<a href=calupdate.jsp style=background-color:pink;padding-right:5px;font-size:11px>"+rs.getString("calendarmemo_contents")+"</a>"+"<br>"); 
							}
						}
					rs.close();
					}
					catch(Exception e) {
					System.out.println(e);
					}finally{
					try {if(conn != null)conn.close();}catch(Exception e) {e.printStackTrace();}
					try {if(pstmt != null)pstmt.close();}catch(Exception e) {e.printStackTrace();}
					};
					out.println("</td>");
					br++;
						if((br%7)==0 && i!=end) {
						out.println("</tr><tr height=30>");
						}
					}
					while((br++)%7!=0) //말일 이후 빈칸출력
					out.println("<td>&nbsp;</td>");
%>
		</tr>
	</table>
	<a href="memoAdd.jsp" class="btn btn-primary">일정추가</a>
</center>
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


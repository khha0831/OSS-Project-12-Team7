<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cal.CalDAO" %>
<%@ page import="cal.CalDTO" %>
<%@ page import = "java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID=null; 
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}

	String calendarmemo_year=null;
	String calendarmemo_month=null;
	String calendarmemo_day=null;
	String calendarmemo_contents=null;
	
	
	if(request.getParameter("calendarmemo_year")!=null){
		calendarmemo_year=request.getParameter("calendarmemo_year");
	}
	if(request.getParameter("calendarmemo_month")!=null){
		calendarmemo_month=request.getParameter("calendarmemo_month");
	}
	if(request.getParameter("calendarmemo_day")!=null){
		calendarmemo_day=request.getParameter("calendarmemo_day");
	}
	if(request.getParameter("calendarmemo_contents")!=null){
		calendarmemo_contents=request.getParameter("calendarmemo_contents");
	}
	CalDAO calDAO=new CalDAO();
	int result=calDAO.calupdate(calendarmemo_contents);
	if(result == -1){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('등록에 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}else{
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('수정되었습니다.');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;	
	}
	
%>

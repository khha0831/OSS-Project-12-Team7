<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "text.TextDTO"%>
<%@ page import = "text.TextDAO"%>
<%@ page import = "util.SHA256"%>
<%@ page import = "java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID=null; 
	
	if(session.getAttribute("userID")!=null){
	userID=(String)session.getAttribute("userID");	 
	}
	if(userID ==null){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href='userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;	
	}
	
	String title=null;
	String bulletinContent=null;
	
	if(request.getParameter("title") != null){
		title=request.getParameter("title");
	}
	if(request.getParameter("bulletinContent") != null){
		bulletinContent=request.getParameter("bulletinContent");
	}
	TextDAO textDAO=new TextDAO();
	int result=textDAO.write(new TextDTO(0, userID, title ,bulletinContent ,0));
	
	if(result==-1){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('등록 실패.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;	
	} 
	else{
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("location.href='index.jsp';");
		script.println("</script>");
		script.close();
		return;	
	}	
%>

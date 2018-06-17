<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "bbs.BbsDTO"%>
<%@ page import = "bbs.BbsDAO"%>
<%@ page import = "java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID=null; 
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	
	int bbsID =0;
	String bbsTitle=null;
	String bbsDate=null;
	String bbsContent=null;
	int bbsAvailable=0;
	
	if(request.getParameter("bbsID")!=null){
		try{
		bbsID=Integer.parseInt(request.getParameter("bbsID"));
		}catch(Exception e){
			System.out.println("데이터 오류");
		}
	}
	if(request.getParameter("bbsTitle")!=null){
		bbsTitle=request.getParameter("bbsTitle");
	}
	if(request.getParameter("bbsDate")!=null){
		bbsDate=request.getParameter("bbsDate");
	}
	if(request.getParameter("bbsContent")!=null){
		bbsContent=request.getParameter("bbsContent");
	}
	if(request.getParameter("bbsAvailable")!=null){
		try{
			bbsAvailable=Integer.parseInt(request.getParameter("bbsAvailable"));
			}catch(Exception e){
				System.out.println("데이터 오류");
			}
	}
	BbsDAO bbsDAO=new BbsDAO();
	int result=bbsDAO.write(new BbsDTO(0,bbsTitle,userID,bbsDate,bbsContent,0));
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
		script.println("alert('등록되었습니다.');");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
		script.close();
		return;	
	}
	
%>

package bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import util.DatabaseUtil;

public class BbsDAO {
	public String getDate() {
		String SQL="SELECT CURRENT_TIMESTAMP";
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt =conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn != null)conn.close();}catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null)pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try {if(rs != null)rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return "";
	}
	
	public int getNext() {
		String SQL="SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt =conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn != null)conn.close();}catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null)pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try {if(rs != null)rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return -1;
	}
	
	public int write(BbsDTO bbsDTO) {
		String SQL="INSERT INTO BBS VALUES(?,?,?,?,?,?)";
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setInt(1,getNext());
			pstmt.setString(2, bbsDTO.getBbsTitle());
			pstmt.setString(3, bbsDTO.getUserID());
			pstmt.setString(4, bbsDTO.getBbsDate());
			pstmt.setString(5, bbsDTO.getBbsContent());
			pstmt.setInt(6,1);		
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn != null)conn.close();}catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null)pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try {if(rs != null)rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return -1;//DB 오류
	}
	public ArrayList<BbsDTO> getList(int pageNumber){
		String SQL="SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable=1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<BbsDTO> list =new ArrayList<BbsDTO>();
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				BbsDTO bbsDTO=new BbsDTO();
				bbsDTO.setBbsID(rs.getInt(1));
				bbsDTO.setBbsTitle(rs.getString(2));
				bbsDTO.setUserID(rs.getString(3));
				bbsDTO.setBbsDate(rs.getString(4));
				bbsDTO.setBbsContent(rs.getString(5));
				bbsDTO.setBbsAvailable(rs.getInt(6));
				list.add(bbsDTO);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn != null)conn.close();}catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null)pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try {if(rs != null)rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL="SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable=1";
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn != null)conn.close();}catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null)pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try {if(rs != null)rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return false;
	}
	public BbsDTO getBbsDTO(int bbsID) {
		String SQL="SELECT * FROM BBS WHERE bbsID =?";
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setInt(1,bbsID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				BbsDTO bbsDTO=new BbsDTO();
				bbsDTO.setBbsID(rs.getInt(1));
				bbsDTO.setBbsTitle(rs.getString(2));
				bbsDTO.setUserID(rs.getString(3));
				bbsDTO.setBbsDate(rs.getString(4));
				bbsDTO.setBbsContent(rs.getString(5));
				bbsDTO.setBbsAvailable(rs.getInt(6));
				return bbsDTO;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn != null)conn.close();}catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null)pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try {if(rs != null)rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return null;
	}
	
	public int update(int bbsID,String bbsTitle,String bbsContent) {
		String SQL="UPDATE BBS SET bbsTitle = ?, bbsContent = ? where bbsID = ?";
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setString(1,bbsTitle);
			pstmt.setString(2,bbsContent);
			pstmt.setInt(3,bbsID);	
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn != null)conn.close();}catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null)pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try {if(rs != null)rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return -1;//DB 오류
	}
	
	public int delete(int bbsID) {
		String SQL="UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {if(conn != null)conn.close();}catch(Exception e) {e.printStackTrace();}
			try {if(pstmt != null)pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try {if(rs != null)rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return -1;//DB 오류
	}
	
} 


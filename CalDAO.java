package cal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bbs.BbsDTO;
import cal.CalDTO;
import util.DatabaseUtil;

public class CalDAO {	
	
	public int getcalNext() {
		String SQL="SELECT calID FROM cal ORDER BY calID DESC";
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
	
	public CalDTO getCalDTO(int calID) {
		String SQL="SELECT * FROM cal WHERE calID =?";
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setInt(1,calID);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				CalDTO calDTO=new CalDTO();
				calDTO.setCalID(rs.getInt(1));
				calDTO.setUserID(rs.getString(2));
				calDTO.setCalendarmemo_year(rs.getString(3));
				calDTO.setCalendarmemo_month(rs.getString(4));
				calDTO.setCalendarmemo_day(rs.getString(5));
				calDTO.setCalendarmemo_contents(rs.getString(6));
				calDTO.setCalAvabilable(rs.getInt(7));
				return calDTO;
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
	
	public int memo(CalDTO calDTO) {
		String SQL="INSERT INTO cal VALUES(?,?,?,?,?,?,?)";
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setInt(1,getcalNext());
			pstmt.setString(2,calDTO.getUserID());
			pstmt.setString(3,calDTO.getCalendarmemo_year());
			pstmt.setString(4,calDTO.getCalendarmemo_month());
			pstmt.setString(5,calDTO.getCalendarmemo_day());
			pstmt.setString(6,calDTO.getCalendarmemo_contents());
			pstmt.setInt(7,1);
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
	
	public int calupdate(String calendarmemo_contents) {
		String SQL="UPDATE cal SET calendarmemo_contents = ?";
		Connection conn=null;
		PreparedStatement pstmt = null;
		ResultSet rs=null;
		try {
			conn=DatabaseUtil.getConnection();
			pstmt =conn.prepareStatement(SQL);
			pstmt.setString(1, calendarmemo_contents);
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
	

package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
	
	public static Connection getConnection() {
		
		try {
			String dbURL ="DB주소";
			String dbID="아이디";
			String dbPW="비밀번호";
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection(dbURL, dbID, dbPW);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}

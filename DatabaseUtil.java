package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
	
	public static Connection getConnection() {
		
		try {
			String dbURL ="jdbc:mysql://localhost:3306/MEMBER?useUnicode=true&characterEncoding=UTF-8";
			String dbID="root";
			String dbPW="7434";
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection(dbURL, dbID, dbPW);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
}

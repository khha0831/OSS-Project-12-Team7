package cal;

public class CalDTO {
	
	int calID;
	String userID;
	String calendarmemo_year;
	String calendarmemo_month;
	String calendarmemo_day;
	String calendarmemo_contents;
	int calAvabilable;
	
	public int getCalID() {
		return calID;
	}

	public void setCalID(int calID) {
		this.calID = calID;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getCalendarmemo_year() {
		return calendarmemo_year;
	}

	public void setCalendarmemo_year(String calendarmemo_year) {
		this.calendarmemo_year = calendarmemo_year;
	}

	public String getCalendarmemo_month() {
		return calendarmemo_month;
	}

	public void setCalendarmemo_month(String calendarmemo_month) {
		this.calendarmemo_month = calendarmemo_month;
	}

	public String getCalendarmemo_day() {
		return calendarmemo_day;
	}

	public void setCalendarmemo_day(String calendarmemo_day) {
		this.calendarmemo_day = calendarmemo_day;
	}

	public String getCalendarmemo_contents() {
		return calendarmemo_contents;
	}

	public void setCalendarmemo_contents(String calendarmemo_contents) {
		this.calendarmemo_contents = calendarmemo_contents;
	}

	public int getCalAvabilable() {
		return calAvabilable;
	}

	public void setCalAvabilable(int calAvabilable) {
		this.calAvabilable = calAvabilable;
	}
	

	public CalDTO() {
		
	}

	public CalDTO(int calID, String userID, String calendarmemo_year, String calendarmemo_month,
			String calendarmemo_day, String calendarmemo_contents, int calAvabilable) {
		super();
		this.calID = calID;
		this.userID = userID;
		this.calendarmemo_year = calendarmemo_year;
		this.calendarmemo_month = calendarmemo_month;
		this.calendarmemo_day = calendarmemo_day;
		this.calendarmemo_contents = calendarmemo_contents;
		this.calAvabilable = calAvabilable;
	}


}

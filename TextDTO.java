package text;

public class TextDTO {

	int textID;
	String userID;
	String title;
	String bulletinContent;
	int likeCount;
	
	public int getTextID() {
		return textID;
	}
	public void setTextID(int textID) {
		this.textID = textID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getBulletinContent() {
		return bulletinContent;
	}
	public void setBulletinContent(String bulletinContent) {
		this.bulletinContent = bulletinContent;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	public TextDTO(int textID, String userID, String title, String bulletinContent, int likeCount) {
		super();
		this.textID = textID;
		this.userID = userID;
		this.title = title;
		this.bulletinContent = bulletinContent;
		this.likeCount = likeCount;
	}
}

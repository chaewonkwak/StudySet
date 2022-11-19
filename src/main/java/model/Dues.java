package model;

public class Dues {
	
	private String duesId;
	private String userId;
	private String groupId;
	private String duesDate;
	private int price;
	
	
	public Dues(String duesId, String userId, String groupId, String duesDate, int price) {
		super();
		this.duesId = duesId;
		this.userId = userId;
		this.groupId = groupId;
		this.duesDate = duesDate;
		this.price = price;
	}
	
	public String getDuesId() {
		return duesId;
	}
	public void setDuesId(String duesId) {
		this.duesId = duesId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	public String getDuesDate() {
		return duesDate;
	}
	public void setDuesDate(String duesDate) {
		this.duesDate = duesDate;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	
	
}

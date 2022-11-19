package model;

public class Payment {

	private String groupId;
	private String paymentDate;
	private int price;
	private String paymentDescription;
	private String paymentId;
	
	public Payment(String groupId, String paymentDate, int price, String paymentDescription, String paymentId) {
		super();
		this.groupId = groupId;
		this.paymentDate = paymentDate;
		this.price = price;
		this.paymentDescription = paymentDescription;
		this.paymentId = paymentId;
	}
	
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	public String getPaymentDate() {
		return paymentDate;
	}
	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getPaymentDescription() {
		return paymentDescription;
	}
	public void setPaymentDescription(String paymentDescription) {
		this.paymentDescription = paymentDescription;
	}
	public String getPaymentId() {
		return paymentId;
	}
	public void setPaymentId(String paymentId) {
		this.paymentId = paymentId;
	}
	
	
}

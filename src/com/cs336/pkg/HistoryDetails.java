package com.cs336.pkg;

public class HistoryDetails {

	private String PID;
	private String winner;
	private String startDate;
	private String endDate;
	private String bidder;
	private String itemName;
	private String itemType;
	private String bidAmount;
	private String bidDate;
	/***********************************************/
	public void setPID(String PID) {
		this.PID = PID;
	}
	public void setWinner(String winner) {
		this.winner = winner;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public void setBidder(String bidder) {
		this.bidder = bidder;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public void setItemType(String itemType) {
		this.itemType = itemType;
	}
	public void setBidAmount(String bidAmount) {
		this.bidAmount = bidAmount;
	}
	public void setBidDate(String bidDate) {
		this.bidDate = bidDate;
	}
	/***********************************************/
	public String getPID() {
		return PID;
	}
	public String getWinner() {
		return winner;
	}
	public String getStartDate() {
		return startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public String getBidder() {
		return bidder;
	}
	public String getItemName() {
		return itemName;
	}
	public String getItemType() {
		return itemType;
	}
	public String getBidAmount() {
		return bidAmount;
	}
	public String getBidDate() {
		return bidDate;
	}
}
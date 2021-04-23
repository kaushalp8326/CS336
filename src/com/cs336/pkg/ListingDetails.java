package com.cs336.pkg;

public class ListingDetails {

	private String id;
	private String type;
	private String itemName;
	private String price;
	private String startDate;
	private String endDate;

	public void setID(String id) {
		this.id = id;
	}

	public void setType(String type) {
		this.type = type;
	}

	public void setName(String itemName) {
		this.itemName = itemName;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getID() {
		return id;
	}

	public String getType() {
		return type;
	}

	public String getName() {
		return itemName;
	}

	public String getPrice() {
		return price;
	}

	public String getStartDate() {
		return startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	@Override
	public String toString() {
		return "ListingDetails [id=" + id + ", type=" + type + ", itemName=" + itemName + ", price=" + price
				+ ", startDate=" + startDate + ", endDate=" + endDate + "]";
	}
}
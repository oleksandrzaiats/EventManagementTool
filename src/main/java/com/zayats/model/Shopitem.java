package com.zayats.model;

public class Shopitem {

	private int shopitemId;
	private String name;
	private String quantity;
	private String bought;

	public int getShopitemId() {
		return shopitemId;
	}

	public void setShopitemId(int shopitemId) {
		this.shopitemId = shopitemId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public String getBought() {
		return bought;
	}

	public void setBought(String bought) {
		this.bought = bought;
	}

}

package model;

import java.util.ArrayList;

public class Cart {

	public Cart(ArrayList<CartItem> cartItems) {
		setItems(cartItems);
	}
	public Cart() {
		
	}
	private ArrayList<CartItem> items;

	public ArrayList<CartItem> getItems() {
		return items;
	}

	public void setItems(ArrayList<CartItem> items) {
		this.items = items;
	}

}

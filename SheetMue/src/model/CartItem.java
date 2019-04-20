package model;

public class CartItem extends Book{

	public CartItem(int pBookID, boolean savedStatus) {
		setBookID(pBookID);
		setSavedForLater(savedStatus);
	}
	public CartItem() {
		
	}
	
boolean savedForLater;
public boolean isSavedForLater() {
	return savedForLater;
}
public void setSavedForLater(boolean savedForLater) {
	this.savedForLater = savedForLater;
}
}

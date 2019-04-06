package model;

public class CartItem extends Book{

boolean savedForLater;
public boolean isSavedForLater() {
	return savedForLater;
}
public void setSavedForLater(boolean savedForLater) {
	this.savedForLater = savedForLater;
}
}

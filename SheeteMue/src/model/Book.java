package model;

import java.sql.Date;

public class Book {
	int bookID;
	int publisherID; 
	String AuthorName;
	String title;
	int edition;
	Date PubDate;
	String Description;
	Double CurrentPrice;
	int AmountInStock;
	
	public int getBookID() {
		return bookID;
	}
	public void setBookID(int bookID) {
		this.bookID = bookID;
	}
	public void setBookID(String bookID) {
		this.bookID = Integer.parseInt(bookID);
	}
	public int getPublisherID() {
		return publisherID;
	}
	public void setPublisherID(int publisherID) {
		this.publisherID = publisherID;
	}
	public String getAuthorName() {
		return AuthorName;
	}
	public void setAuthorName(String authorName) {
		AuthorName = authorName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getEdition() {
		return edition;
	}
	public void setEdition(int edition) {
		this.edition = edition;
	}
	public Date getPubDate() {
		return PubDate;
	}
	public void setPubDate(Date pubDate) {
		PubDate = pubDate;
	}
	public String getDescription() {
		return Description;
	}
	public void setDescription(String description) {
		Description = description;
	}
	public Double getCurrentPrice() {
		return CurrentPrice;
	}
	public void setCurrentPrice(Double currentPrice) {
		CurrentPrice = currentPrice;
	}
	public int getAmountInStock() {
		return AmountInStock;
	}
	public void setAmountInStock(int amountInStock) {
		AmountInStock = amountInStock;
	}
	@Override
	public String toString() {
		return "Id: " + bookID + " " + title;
	}
}

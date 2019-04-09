package model;

import java.io.File;
import java.sql.Date;

public class Book {
	int bookID;
	int publisherID; 
	String authorName;
	String title;
	int edition;
	Date pubDate;
	String description;
	Double currentPrice;
	int amountInStock;
	File img;
	
	public File getImg() {
		return img;
	}
	public void setImg(File img) {
		File nImg = new File("/WebContent/img/" + bookID +".png");
		img.renameTo(nImg);
			this.img = nImg;
	}
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
		return authorName;
	}
	public void setAuthorName(String authorName) {
		this.authorName = authorName;
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
		return pubDate;
	}
	public void setPubDate(Date pubDate) {
		this.pubDate = pubDate;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Double getCurrentPrice() {
		return currentPrice;
	}
	public void setCurrentPrice(Double currentPrice) {
		this.currentPrice = currentPrice;
	}
	public int getAmountInStock() {
		return amountInStock;
	}
	public void setAmountInStock(int amountInStock) {
		this.amountInStock = amountInStock;
	}
	@Override
	public String toString() {
		return "Id: " + bookID + " " + title;
	}
}

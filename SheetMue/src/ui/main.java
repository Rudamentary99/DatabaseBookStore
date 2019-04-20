package ui;

import model.Book;
import model.BookDao;

public class main {

	public static void main(String[] args) {
		BookDao bd = new BookDao();
		Book b = bd.load(1);
		
		System.out.println( b.getBookID());
		System.out.println( b.getPublisherID());
		System.out.println( b.getPubDate());
		System.out.println( b.getTitle());
		System.out.println( b.getCurrentPrice());
		
		for(Book book: bd.Search("college book")) {
			System.out.println(book);
		}
	}

}

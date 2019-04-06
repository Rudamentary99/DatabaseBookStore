package model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookDao implements Dao<Book> {
	public BookDao() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Book create(Book objectToCreate) {

		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_CreateBook(?,?,?,?,?,?,?,?)}")) {
			int n = 0;
			stmt.setInt(++n, objectToCreate.getPublisherID());
			stmt.setString(++n, objectToCreate.getAuthorName());
			stmt.setString(++n, objectToCreate.getTitle());
			stmt.setInt(++n, objectToCreate.getEdition());
			stmt.setDate(++n, objectToCreate.getPubDate());
			stmt.setString(++n, objectToCreate.getDescription());
			stmt.setDouble(++n, objectToCreate.getCurrentPrice());
			stmt.setInt(++n, objectToCreate.getAmountInStock());
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				objectToCreate.setBookID(rs.getInt("BookID"));
				return objectToCreate;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Book load(int keyValueToLoad) {
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_LoadBook(?)}")) {

			int n = 0;
			stmt.setInt(++n, keyValueToLoad);

			// executeQuery I expect something//execute I don't expect
			// anything//executeUpdate get an idea of how many where changed
			ResultSet rsCircuits = stmt.executeQuery();

			if (rsCircuits.next()) {
				Book b = new Book();
				b.setBookID(rsCircuits.getInt("BookID"));
				b.setPublisherID(rsCircuits.getInt("PublisherID"));
				b.setAuthorName(rsCircuits.getString("AuthorName"));
				b.setTitle(rsCircuits.getString("Title"));
				b.setEdition(rsCircuits.getInt("Edition"));
				b.setPubDate(rsCircuits.getDate("PubDate"));
				b.setDescription(rsCircuits.getString("Description"));
				b.setCurrentPrice(rsCircuits.getDouble("CurrentPrice"));
				b.setAmountInStock(rsCircuits.getInt("AmountInStock"));

				return b;

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

	public ArrayList<SearchBook> Search(String query) {

		System.out.println("initializing book.search");
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_SearchBook(?)}")) {

			int n = 0;
			stmt.setString(++n, query);

			// executeQuery I expect something//execute I don't expect
			// anything//executeUpdate get an idea of how many where changed
			ResultSet rsCircuits = stmt.executeQuery();
			ArrayList<SearchBook> books = new ArrayList<>();
			int i = 0;
			while (rsCircuits.next()) {
				SearchBook b = new SearchBook();
				b.setBookID(rsCircuits.getInt("BookID"));
				b.setPublisherID(rsCircuits.getInt("PublisherID"));
				b.setAuthorName(rsCircuits.getString("AuthorName"));
				b.setTitle(rsCircuits.getString("Title"));
				b.setEdition(rsCircuits.getInt("Edition"));
				b.setPubDate(rsCircuits.getDate("PubDate"));
				b.setDescription(rsCircuits.getString("Description"));
				b.setCurrentPrice(rsCircuits.getDouble("CurrentPrice"));
				b.setAmountInStock(rsCircuits.getInt("AmountInStock"));
				b.setIndex(i++);
				books.add(b);
				
			}
			System.out.println("search result: " + books);
			return books;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;

	}

	@Override
	public List loadAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Book objectToCreate) {
		// updates product information
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_UpdateBookDetails(?,?,?,?,?,?,?)}")) {
			int n = 0;
			stmt.setInt(++n, objectToCreate.getBookID());
			stmt.setInt(++n, objectToCreate.getPublisherID());
			stmt.setString(++n, objectToCreate.getAuthorName());
			stmt.setString(++n, objectToCreate.getTitle());
			stmt.setInt(++n, objectToCreate.getEdition());
			stmt.setDate(++n, objectToCreate.getPubDate());
			stmt.setString(++n, objectToCreate.getDescription());

			return stmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}
	
	public Cart loadCart(int userID){

		System.out.println("initializing book.loadCart");
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_LoadCart(?)}")) {

			int n = 0;
			stmt.setInt(++n, userID);

			// executeQuery I expect something//execute I don't expect
			// anything//executeUpdate get an idea of how many where changed
			ResultSet rsCircuits = stmt.executeQuery();
			ArrayList<CartItem> cIs = new ArrayList<>();
			int i = 0;
			while (rsCircuits.next()) {
				CartItem b = new CartItem();
				b.setBookID(rsCircuits.getInt("BookID"));
				b.setPublisherID(rsCircuits.getInt("PublisherID"));
				b.setAuthorName(rsCircuits.getString("AuthorName"));
				b.setTitle(rsCircuits.getString("Title"));
				b.setEdition(rsCircuits.getInt("Edition"));
				b.setPubDate(rsCircuits.getDate("PubDate"));
				b.setDescription(rsCircuits.getString("Description"));
				b.setCurrentPrice(rsCircuits.getDouble("CurrentPrice"));
				b.setAmountInStock(rsCircuits.getInt("AmountInStock"));
				b.setSavedForLater(rsCircuits.getBoolean("SavedForLater"));
			cIs.add(b);
			}
			System.out.println("search result: " + cIs );
					return new Cart(cIs);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;

		
	}
	
	public boolean addToCart(int pUserID, int pBookID) {
		System.out.println("running addToCart()");
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_AddToCart(?,?)}")) {
			int n = 0;
			stmt.setInt(++n, pUserID);
			stmt.setInt(++n, pBookID);
				ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				System.out.println("success");
				return true; 
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("failure");
		return false;
		
		
	}
	public int updateBookPrice(Book objectToCreate) {
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_UpdateBookPrice(?,?)}")) {
			int n = 0;
			stmt.setInt(++n, objectToCreate.getBookID());
			stmt.setDouble(++n, objectToCreate.getCurrentPrice());

			return stmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;

	}

	public int updateBookStock(Book objectToCreate) {
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_UpdateBookStock(?,?)}")) {
			int n = 0;
			stmt.setInt(++n, objectToCreate.getBookID());
			stmt.setDouble(++n, objectToCreate.getCurrentPrice());
			stmt.setInt(++n, objectToCreate.getAmountInStock());

			return stmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;

	}
	@Override
	public void delete(Book objectToCreate) {
		// TODO Auto-generated method stub

	}

}

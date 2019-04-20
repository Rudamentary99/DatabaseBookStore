package model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDao {
	public CartDao() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public final String connectionString = "jdbc:mysql://db.cberkstresser.name:3306/NathanAndNoah?noAccessToProcedureBodies=true&useSSL=false";

	public boolean create(int pUserID, int pBookID) {
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

	public int update(int pUserID, CartItem c) {
		System.out.println("initializing CartDao.updateCart()");
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_UpdateCart(?,?,?)}")) {
			int n = 0;
			stmt.setInt(++n, pUserID);
			stmt.setInt(++n, c.getBookID());
			stmt.setBoolean(++n, c.isSavedForLater());
			System.out.println("success");
			return stmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("failure");
		return -1;

	}

	public int delete(int userID, CartItem c) {
		System.out.println("running CartDao.delete()");
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_DeleteCartITem(?,?)}")) {
			int n = 0;
			stmt.setInt(++n, userID);
			stmt.setInt(++n, c.getBookID());

			// executeQuery I expect something//execute I don't expect
			// anything//executeUpdate get an idea of how many where changed

			int rowsDeleted = stmt.executeUpdate();
			System.out.println("RowsDeleted:  " + rowsDeleted);
			return rowsDeleted;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("CartDao.delete() failed");
		return -1;
	}

	public Cart load(int userID) {
		System.out.println("initializing CartDao.loadCart");
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
			System.out.println("CartItems: " + cIs);
			return new Cart(cIs);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

	public List<CartItem> loadAll() {
		// TODO Auto-generated method stub
		return null;
	}

}

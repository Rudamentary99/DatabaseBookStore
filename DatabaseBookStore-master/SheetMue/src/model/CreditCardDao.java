package model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class CreditCardDao implements Dao<CreditCard> {
	public CreditCardDao() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public CreditCard create(CreditCard objectToCreate) {
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_CreateCard(?,?,?)}")) {
			System.out.println("running CreditCardDao.create()");
			int n = 0;
			stmt.setString(++n, objectToCreate.getCcn());
			stmt.setString(++n, objectToCreate.getCcv());
			stmt.setString(++n, objectToCreate.getExp());

			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				System.out.println("success " + objectToCreate);
				return objectToCreate;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("failure");
		return null;
	}

	@Override
	public int delete(CreditCard objectToCreate) {
		System.out.println("running CreditCardDao.delete()");
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_DeleteCard(?)}")) {
			int n = 0;
			stmt.setString(++n, objectToCreate.getCcn());

			// executeQuery I expect something//execute I don't expect
			// anything//executeUpdate get an idea of how many where changed

			int rowsDeleted = stmt.executeUpdate();
			System.out.println("RowsDeleted:  " + rowsDeleted);
			return rowsDeleted;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("GenreDao.delete() failed");
		return -1;
	}

	@Override
	public List<CreditCard> loadAll() {
		System.out.println("running CreditCardDao.loadAll()");

		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_LoadAllCards()}")) {

			int n = 0;

			// executeQuery I expect something//execute I don't expect
			// anything//executeUpdate get an idea of how many where changed
			ResultSet rsCircuits = stmt.executeQuery();
			List<CreditCard> cards = new ArrayList<>();
			while (rsCircuits.next()) {
				CreditCard card = new CreditCard();
				card.setCcn(rsCircuits.getString("CreditCardNumber"));
				card.setCcv(rsCircuits.getString("CCV"));
				card.setExp(rsCircuits.getString("ExpirationDate"));
				cards.add(card);
			}
			System.out.println(cards);
			return cards;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public int update(CreditCard objectToCreate) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	public CreditCard load(String keyValueToLoad) {
		System.out.println("running BooDao.load()");
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_LoadBook(?)}")) {

			int n = 0;
			stmt.setString(++n, keyValueToLoad);

			// executeQuery I expect something//execute I don't expect
			// anything//executeUpdate get an idea of how many where changed
			ResultSet rsCircuits = stmt.executeQuery();

			if (rsCircuits.next()) {
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

	@Override
	public CreditCard load(int keyValueToLoad) {
		// TODO Auto-generated method stub
		return null;
	}

}

package model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
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
			stmt.setInt(++n, objectToCreate.getCcn());
			stmt.setInt(++n, objectToCreate.getCcv());
			stmt.setInt(++n, objectToCreate.getExp());

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
		
		return 0;
	}

	public CreditCard load(String keyValueToLoad) {
		
		return null;
	}

	@Override
	public List<CreditCard> loadAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(CreditCard objectToCreate) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public CreditCard load(int keyValueToLoad) {
		// TODO Auto-generated method stub
		return null;
	}

}

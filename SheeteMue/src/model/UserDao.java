package model;

import java.math.BigInteger;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class UserDao implements Dao<User>{
	public UserDao() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public User create(User objectToCreate) {
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_CreateUser(?,?,?,?,?,?,?,?)}")) {
			int n = 0;
			stmt.setString(++n, objectToCreate.getFirstName());
			stmt.setString(++n, objectToCreate.getLastName());
			stmt.setString(++n, objectToCreate.getEmail());
			stmt.setString(++n, objectToCreate.getPhone());
			stmt.setDate(++n, objectToCreate.getDate_of_birth());
			stmt.setDate(++n, objectToCreate.getCreated_at());
			stmt.setBoolean(++n, objectToCreate.isAdmin());
			
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				objectToCreate.setUserID(rs.getInt("UserID"));
				return objectToCreate;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public int update(User objectToCreate) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void delete(User objectToCreate) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public User load(int keyValueToLoad) {
		
		return null;
	}

	public User loginUser(String pEmail, String pPassword ) {
		System.out.println("running loginUser");
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_LoginUser(?, ?)}")) {
			int n = 0;
			stmt.setString(++n, pEmail);
			//stmt.setString(++n, pPassword);
			stmt.setString(++n, pPassword);

			// executeQuery I expect something//execute I don't expect
			// anything//executeUpdate get an idea of how many where changed
			ResultSet rsCircuits = stmt.executeQuery();

			if (rsCircuits.next()) {
				User u = new User();
				u.setUserID(rsCircuits.getInt("UserID"));
				u.setFirstName(rsCircuits.getString("FirstName"));
				u.setLastName(rsCircuits.getString("LastName"));
				u.setEmail(rsCircuits.getString("Email"));
				u.setPhone(rsCircuits.getString("Phone"));
				u.setDate_of_birth(rsCircuits.getDate("DateOfBirth"));
				u.setCreated_at(rsCircuits.getDate("CreatedAt"));
				u.setAdmin(rsCircuits.getBoolean("IsAdmin"));
				System.out.println(u);
				return u;
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("no match");
		return null;
	}
	@Override
	public List<User> loadAll() {
		// TODO Auto-generated method stub
		return null;
	}

}

package model;

import java.math.BigInteger;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;

public class UserDao implements Dao<User> {
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
			System.out.println("running UserDao.create()");
			int n = 0;
			stmt.setString(++n, objectToCreate.getFirstName());
			stmt.setString(++n, objectToCreate.getLastName());
			stmt.setString(++n, objectToCreate.getEmail());
			stmt.setString(++n, objectToCreate.getPassword());
			stmt.setString(++n, objectToCreate.getPhone());
			stmt.setDate(++n, objectToCreate.getDate_of_birth());
			stmt.setDate(++n, java.sql.Date.valueOf(LocalDate.now()));
			stmt.setBoolean(++n, objectToCreate.isAdmin());

			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				System.out.println("success " + objectToCreate);
				objectToCreate.setUserID(rs.getInt("UserID"));
				return objectToCreate;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("failure");
		return null;
	}

	public User updateEmail(User objectToUpdate) {
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_UpdateEmail(?,?,?)}")) {
			int n = 0;
			stmt.setString(++n, objectToUpdate.getEmail());
			stmt.setString(++n, objectToUpdate.getPassword());

			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				objectToUpdate.setEmail(rs.getString("Email2"));
				return objectToUpdate;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public User updatePhone(User objectToUpdate) {
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_UpdatePhone(?,?,?)}")) {
			int n = 0;
			stmt.setString(++n, objectToUpdate.getEmail());
			stmt.setString(++n, objectToUpdate.getPhone());
			stmt.setString(++n, objectToUpdate.getPassword());

			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				objectToUpdate.setPhone(rs.getString("Phone"));
				return objectToUpdate;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public int delete(User objectToCreate) {
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_DeleteUser(?)}")) {
			int n = 0;
			stmt.setInt(++n, objectToCreate.getUserID());
			return stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}

	@Override
	public User load(int keyValueToLoad) {
		try (Connection cn = DriverManager.getConnection(connectionString, "dbclass", "test");
				CallableStatement stmt = cn.prepareCall("{call usp_LoadUser(?)}")) {
			int n = 0;
			stmt.setInt(++n, keyValueToLoad);
			ResultSet rsUser = stmt.executeQuery();
			if (rsUser.next()) {
				User u = new User();
				u.setUserID(rsUser.getInt("UserID"));
				u.setFirstName(rsUser.getString("FirstName"));
				u.setLastName(rsUser.getString("LastName"));
				u.setEmail(rsUser.getString("Email"));
				u.setPhone(rsUser.getString("Phone"));
				u.setDate_of_birth(rsUser.getDate("DateOfBirth"));
				u.setCreated_at(rsUser.getDate("CreatedAt"));
				u.setAdmin(rsUser.getBoolean("IsAdmin"));
				System.out.println(u);
				return u;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public User loginUser(String pEmail, String pPassword) {
		System.out.println("running loginUser");
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_LoginUser(?, ?)}")) {
			int n = 0;
			stmt.setString(++n, pEmail);
			// stmt.setString(++n, pPassword);
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
			e.printStackTrace();
		}
		System.out.println("no match");
		return null;
	}

	public boolean updatePassword(int userID, String currentPassword, String newPassword) {
		System.out.println("running UserDao.updatePassword()");
		HashVal hash = new HashVal();
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_UpdatePassword(?,?,?)}")) {
			int n = 0;
			stmt.setInt(++n, userID);
			stmt.setString(++n, hash.hashValue(currentPassword).toString());
			stmt.setString(++n, hash.hashValue(newPassword).toString());

			int rs = stmt.executeUpdate();
			if (rs > 0) {
				System.out.println("Password Updated");
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("password failed");
		return false;

	}

	@Override
	public List<User> loadAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(User objectToCreate) {
		// TODO Auto-generated method stub
		return 0;
	}

}

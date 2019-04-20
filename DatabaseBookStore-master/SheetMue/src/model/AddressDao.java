package model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AddressDao implements Dao<Address> {
	public AddressDao() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public boolean createUserAddress(Address objectToCreate, int userID) {
		System.out.println("Running AddressDao.createUserAddress()");
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_CreateUserAddress(?,?,?,?,?)}")) {
			int n = 0;
			stmt.setInt(++n, userID);
			stmt.setString(++n, objectToCreate.getStreet());
			stmt.setString(++n, objectToCreate.getCity());
			stmt.setString(++n, objectToCreate.getState());
			stmt.setString(++n, objectToCreate.getZip());

			stmt.execute();
			System.out.println("success");
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("failure");
		return false;
	}

	public List<Address> loadAllUserAddress(int userID) {
		System.out.println("running AddressDao.loadAllUserAddresses()");
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_LoadUserAddresses(?)}")) {
			int n = 0;
			stmt.setInt(++n, userID);
			// executeQuery I expect something//execute I don't expect
			// anything//executeUpdate get an idea of how many where changed
			ResultSet rsUserAddress = stmt.executeQuery();
			List<Address> as = new ArrayList<>();
			while (rsUserAddress.next()) {
				Address a = new Address();
				a.setAddressID(rsUserAddress.getInt("AddressID"));
				a.setStreet(rsUserAddress.getString("Street"));
				a.setCity(rsUserAddress.getString("City"));
				a.setState(rsUserAddress.getString("State"));
				a.setZip(rsUserAddress.getString("Zip"));
				as.add(a);

			}
			System.out.println("user Adresses loaded");
			return as;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("user has no Addresses");
		return null;
	}

	@Override
	public int update(Address objectToCreate) {

		return -1;

	}

	@Override
	public int delete(Address objectToCreate) {
		System.out.println("running AddressDao.delete()");
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_DeleteAddress(?)}")) {
			int n = 0;
			stmt.setInt(++n, objectToCreate.getAddressID());
			

			// executeQuery I expect something//execute I don't expect
			// anything//executeUpdate get an idea of how many where changed
			int rowsDeleted = stmt.executeUpdate();
			System.out.println("number of rows deleted: " + rowsDeleted);
			return rowsDeleted;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return -1;
	}

	@Override
	public Address load(int keyValueToLoad) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Address> loadAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Address create(Address objectToCreate) {
		// TODO Auto-generated method stub
		return null;
	}

}

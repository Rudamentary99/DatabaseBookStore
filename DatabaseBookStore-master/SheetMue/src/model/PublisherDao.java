package model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PublisherDao implements Dao<Publisher> {
	public PublisherDao() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public Publisher create(Publisher objectToCreate) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Publisher objectToCreate) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(Publisher objectToCreate) {
		// TODO Auto-generated method stub
	return -1; 	
	}

	@Override
	public Publisher load(int keyValueToLoad) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public List<Publisher> loadAll() {
		System.out.println("initializing PublisherDao.loadAll()");
		List<Publisher> rPublisher = new ArrayList<>();
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_LoadAllPublishers()}")) {
		ResultSet rsPublisher = stmt.executeQuery();
			while (rsPublisher.next()) {
				Publisher p = new Publisher();
				
				p.setPublisherID(rsPublisher.getInt("PublisherID"));
				p.setName(rsPublisher.getString("PublisherName"));
				p.setEmail(rsPublisher.getString("Email"));
				p.setPhone(rsPublisher.getString("Phone"));
				
				rPublisher.add(p);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(rPublisher);
		return rPublisher;
	}
	public boolean createPublisherAddress(Address objectToCreate, int pubID) {
		System.out.println("Running PublisherDao.createPublisherAddress()");
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_CreatePublisherAddress(?,?,?,?,?)}")) {
			int n = 0;
			stmt.setInt(++n, pubID);
			stmt.setString(++n, objectToCreate.getStreet());
			stmt.setString(++n, objectToCreate.getCity());
			stmt.setString(++n, objectToCreate.getState());
			stmt.setString(++n, objectToCreate.getZip());

			stmt.execute();
			System.out.println("Publihser address created");
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("failured to create publisher address");
		return false;
	}

	public List<Address> loadPublisherAddresses(int pubID) {
		System.out.println("running PublisherDao.loadPublisherAddresses()");
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_LoadPublisherAddresses(?)}")) {
			int n = 0;
			stmt.setInt(++n, pubID);
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
			System.out.println("pub Adresses loaded");
			return as;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("pub has no Addresses");
		return null;
		
		
		
	}
}

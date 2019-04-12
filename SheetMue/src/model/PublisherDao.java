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
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_CreatePublisher(?,?,?)}")) {
			int n = 0;
			stmt.setString(++n, objectToCreate.getName());
			stmt.setString(++n, objectToCreate.getEmail());
			stmt.setString(++n, objectToCreate.getPhone());
			
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				objectToCreate.setName(rs.getString("PublisherName"));
				objectToCreate.setEmail(rs.getString("Email"));
				objectToCreate.setPhone(rs.getString("Phone"));
				return objectToCreate;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public int update(Publisher objectToCreate) {
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_UpdatePhone(?,?)}")) {
			int n = 0;
			stmt.setString(++n, objectToCreate.getName());
			stmt.setString(++n, objectToCreate.getEmail());
			stmt.setString(++n, objectToCreate.getPhone());
			stmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 1;
	}

	@Override
	public void delete(Publisher objectToCreate) {
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_DeletePublisher(?)}")) {
			int n=0;
			stmt.setString(++n, objectToCreate.getName());
			stmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public Publisher load(String keyValueToLoad) {
		try (Connection cn = DriverManager.getConnection(connectionString, "dbclass", "test");
				CallableStatement stmt = cn.prepareCall("{call usp_LoadPublisher(?)}")) {
			int n=0;
			stmt.setString(++n, keyValueToLoad);
			ResultSet rsUser = stmt.executeQuery();
			if (rsUser.next() ) {
				Publisher u = new Publisher();
				u.setName(rsUser.getString("PublisherName"));
				u.setEmail(rsUser.getString("Email"));
				u.setPhone(rsUser.getString("Phone"));
				System.out.println(u);
				return u;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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
	@Override
	public Publisher load(int keyValueToLoad) {
		// TODO Auto-generated method stub
		return null;
	}

}

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
	public void delete(Publisher objectToCreate) {
		// TODO Auto-generated method stub
		
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

}

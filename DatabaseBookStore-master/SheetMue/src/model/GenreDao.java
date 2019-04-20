package model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class GenreDao implements Dao<String> {
	public GenreDao() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public String create(String objectToCreate) {
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_CreateGenre(?)}")) {
			System.out.println("running GenreDao.create()");
			int n = 0;
			stmt.setString(++n, objectToCreate);

			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				System.out.println("Genre Created: " + objectToCreate);

				return rs.getString("GenreID");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Genre creation failed");
		return null;
	}

	@Override
	public int update(String objectToCreate) {
		// updates product information
				try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
						CallableStatement stmt = cn.prepareCall("{call usp_UpdateBookDetails(?)}")) {
					int n = 0;
					stmt.setString(++n, objectToCreate);
					System.out.println("genre updated");
					return stmt.executeUpdate();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				return -1;
	}

	@Override
	public int delete(String objectToCreate) {
		System.out.println("running GenreDao.delete()");
		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_DeleteGenre(?)}")) {
			int n = 0;
			stmt.setString(++n, objectToCreate);

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

	public List<String> loadGenresByBook(Book b) {
		System.out.println("running GenreDao.loadGenresByBooks()");

		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_LoadGenresByBook(?)}")) {

			int n = 0;

			stmt.setInt(++n, b.getBookID());
			// executeQuery I expect something//execute I don't expect
			// anything//executeUpdate get an idea of how many where changed
			ResultSet rsCircuits = stmt.executeQuery();
			List<String> genres = new ArrayList<>();
			while (rsCircuits.next()) {
				genres.add(rsCircuits.getString("GenreName"));
			}
			System.out.println("Genres: " + genres);
			return genres;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("failed loading Book's genres");
		return null;

	}

	@Override
	public String load(int keyValueToLoad) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<String> loadAll() {

		System.out.println("running GenreDao.loadAll()");

		try (Connection cn = DriverManager.getConnection(connectionString, "nathanandnoahapp", "timAvengers18");
				CallableStatement stmt = cn.prepareCall("{call usp_LoadAllGenres()}")) {

			int n = 0;

			// executeQuery I expect something//execute I don't expect
			// anything//executeUpdate get an idea of how many where changed
			ResultSet rsCircuits = stmt.executeQuery();
			List<String> genres = new ArrayList<>();
			while (rsCircuits.next()) {

				genres.add(rsCircuits.getString("GenreName"));
			}
			System.out.println(genres);
			return genres;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;

	}

}

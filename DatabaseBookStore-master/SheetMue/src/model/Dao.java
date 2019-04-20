package model;

import java.util.List;
//
public interface Dao<T> {
	
	String connectionString = "jdbc:mysql://db.cberkstresser.name:3306/NathanAndNoah?noAccessToProcedureBodies=true&useSSL=false";
	public T create(T objectToCreate);
	public int update(T objectToCreate);
	public int delete(T objectToCreate);
	public T load(int keyValueToLoad);
	public List<T> loadAll();
}
	
	


package model;
import java.sql.*;

public class DB
{
	MyAdapter adapter;
	public DB(MyAdapter adapter)
	{
		this.adapter = adapter;
	}
	
	public Connection getConnection()
	{
		return adapter.getConnection();
	}
	
}

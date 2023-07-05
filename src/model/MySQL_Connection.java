package model;
import java.sql.*;

public class MySQL_Connection implements MyAdapter 
{
	Connection con = null;	
	
	public Connection getConnection()
	{		
		
		try
		{
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:8889/project_shoppingcart","root","root");
			System.out.println(con);															
		}
		catch(Exception e)
		{
			System.out.println(e);			
		}
		
		return con;		
	}
	public static void main(String[] args)
	{
		MySQL_Connection run = new MySQL_Connection();
		System.out.println(run.getConnection());							
	}
}



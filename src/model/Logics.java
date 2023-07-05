package model;
import java.sql.*;

public class Logics
{
	Connection con = new DB(new MySQL_Connection()).getConnection();
	
	public ResultSet userCheck(String email, String password) throws SQLException
	{		
		PreparedStatement stmt1 = con.prepareStatement("select * from customer_info where email=? and password=?");
		stmt1.setString(1, email);
		stmt1.setString(2, password);		
		return stmt1.executeQuery();
	}
	
	public int registerUser(String register_email) throws SQLException
	{
		int y;
		PreparedStatement stmt2 = con.prepareStatement("select * from customer_info where email=?");
		stmt2.setString(1, register_email);
		ResultSet rs2 = stmt2.executeQuery();
		
		if(!rs2.next())
		{
			y = 1;			
		}
		else
		{
			y = 0;
		}
		return y;
	}
	
	public ResultSet productDisplay(String Category, String ID) throws SQLException
	{
		PreparedStatement product_stmt = con.prepareStatement("select * from Products where Category = ? and ID = ?");
		product_stmt.setString(1, Category);
		product_stmt.setString(2, ID);		
		
		ResultSet product_rs = product_stmt.executeQuery();
		return product_rs;		
	}	
}

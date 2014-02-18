package main.java.servlet;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.net.URISyntaxException;
import java.net.URI;

public class DbManager {

	private DbManager () {}

	public static Connection getConnection()
	throws URISyntaxException, SQLException {
		URI dbUri = new URI(System.getenv("DATABASE_URL"));

		String username = dbUri.getUserInfo().split(":")[0];
		String password = dbUri.getUserInfo().split(":")[1];
		// Make sure the $DATABASE_URL environment variable is set
		String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + dbUri.getPath();
		return DriverManager.getConnection(dbUrl, username, password);

		// String url = "jdbc:postgresql://ec2-54-225-112-205.compute-1.amazonaws.com:5432/d1bkge3e9i256r?user=zbksnwwacmdjta&password=2pqVFmkjkoi7qrxdc09qdRKd-2&ssl=true";
		// Connection conn = DriverManager.getConnection(url);
		// return conn;
	}
}

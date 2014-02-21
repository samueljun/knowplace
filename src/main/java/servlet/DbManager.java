package main.java.servlet;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;
import java.net.URISyntaxException;
import java.net.URI;

public class DbManager {

	private DbManager () {}

	public static Connection getConnection()
	throws URISyntaxException, SQLException {
		URI dbUri = new URI(System.getenv("DATABASE_URL"));
		// Make sure the $DATABASE_URL environment variable is set

		Properties props = new Properties();
		props.setProperty("user", dbUri.getUserInfo().split(":")[0]);
		props.setProperty("password", dbUri.getUserInfo().split(":")[1]);
		props.setProperty("ssl", "true");
		props.setProperty("sslfactory", "org.postgresql.ssl.NonValidatingFactory");

		String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + dbUri.getPath();
		return DriverManager.getConnection(dbUrl, props);
	}
}

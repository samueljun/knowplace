package main.java.servlet;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.net.URISyntaxException;
import java.net.URI;

public class DbManager {
    public static Connection getConnection()
    throws URISyntaxException, SQLException {
        URI dbUri = new URI(System.getenv("DATABASE_URL"));

        String username = dbUri.getUserInfo().split(":")[0];
        String password = dbUri.getUserInfo().split(":")[1];
        // Make sure the $DATABASE_URL environment variable is set
        String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + dbUri.getPath();
        return DriverManager.getConnection(dbUrl, username, password);
    }

    private DbManager () {}
}

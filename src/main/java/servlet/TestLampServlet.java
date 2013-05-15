package main.java.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.*;

public class TestLampServlet extends HttpServlet {

    // Database Connection
    private static Connection getConnection() throws URISyntaxException, SQLException {
        URI dbUri = new URI(System.getenv("DATABASE_URL"));

        String username = dbUri.getUserInfo().split(":")[0];
        String password = dbUri.getUserInfo().split(":")[1];
        String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + dbUri.getPath();

        return DriverManager.getConnection(dbUrl, username, password);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Connection connection = getConnection();

            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT data_value FROM test_lamp ORDER BY time DESC LIMIT 1");
            rs.next();
            request.setAttribute("data_value", rs.getString(1) );
        }
        catch (SQLException e) {
            request.setAttribute("SQLException", e.getMessage());
        }
        catch (URISyntaxException e) {
            request.setAttribute("URISyntaxException", e.getMessage());
        }

        request.getRequestDispatcher("/testlamp-get.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String data_value = (String)request.getParameter("data_value");

        try {
            Connection connection = getConnection();

            Statement stmt = connection.createStatement();
            stmt.executeUpdate("INSERT INTO test_lamp VALUES ('" + data_value + "', now())");
        }
        catch (SQLException e) {
            request.setAttribute("SQLException", e.getMessage());
        }
        catch (URISyntaxException e) {
            request.setAttribute("URISyntaxException", e.getMessage());
        }

        request.getRequestDispatcher("/testlamp-post.jsp").forward(request, response);
    }

}


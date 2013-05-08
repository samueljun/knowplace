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

// @WebServlet(
//         name = "HelloServlet",
//         urlPatterns = {"/hello"}
//     )
public class HelloServlet extends HttpServlet {

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
        // response.getWriter().print("Hello from Java!\n");

        try {
            Connection connection = getConnection();

            Statement stmt = connection.createStatement();
            stmt.executeUpdate("DROP TABLE IF EXISTS ticks");
            stmt.executeUpdate("CREATE TABLE ticks (tick timestamp)");
            stmt.executeUpdate("INSERT INTO ticks VALUES (now())");
            ResultSet rs = stmt.executeQuery("SELECT tick FROM ticks");
            while (rs.next()) {
                request.setAttribute("test_var", rs.getTimestamp("tick").toString());
            }
        }
        catch (SQLException e) {
            request.setAttribute("SQLException", e.getMessage());
        }
        catch (URISyntaxException e) {
            request.setAttribute("URISyntaxException", e.getMessage());
        }

        request.setAttribute("test_var2", "This is test var 2");
        request.getRequestDispatcher("/hello.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String response1 = (String)request.getAttribute("name1");
/*
        try {
            Connection connection = getConnection();

            Statement stmt = connection.createStatement();
            stmt.executeUpdate("DROP TABLE IF EXISTS ticks");
            stmt.executeUpdate("CREATE TABLE ticks (tick timestamp)");
            stmt.executeUpdate("INSERT INTO ticks VALUES (now())");
            ResultSet rs = stmt.executeQuery("SELECT tick FROM ticks");
            while (rs.next()) {
                request.setAttribute("test_var", rs.getTimestamp("tick").toString());
            }
        }
        catch (SQLException e) {
            request.setAttribute("SQLException", e.getMessage());
        }
        catch (URISyntaxException e) {
            request.setAttribute("URISyntaxException", e.getMessage());
        }
*/
        request.setAttribute("response1", response1);
        request.getRequestDispatcher("/hello.jsp").forward(request, response);
    }

}


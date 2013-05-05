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
        String test_var;
        boolean test_var_set = false;

        try {
            Connection connection = getConnection();

            Statement stmt = connection.createStatement();
            stmt.executeUpdate("DROP TABLE IF EXISTS ticks");
            stmt.executeUpdate("CREATE TABLE ticks (tick timestamp)");
            stmt.executeUpdate("INSERT INTO ticks VALUES (now())");
            ResultSet rs = stmt.executeQuery("SELECT tick FROM ticks");
            while (rs.next()) {
                test_var = rs.getTimestamp("tick").toString();
                test_var_set = true;
            }
        }
        catch (SQLException e) {
            response.getWriter().print("SQLException: " + e.getMessage());
        }
        catch (URISyntaxException e) {
            response.getWriter().print("URISyntaxException: " + e.getMessage());
        }

        if (test_var_set == false) {
            test_var = "Did not initialize";
        }

        request.setAttribute("test_var", test_var);
        request.setAttribute("test_var2", "This is test var 2");

        request.getRequestDispatcher("/hello.jsp").forward(request, response);
    }

}


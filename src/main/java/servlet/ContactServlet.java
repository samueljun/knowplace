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

@WebServlet(
    name = "ContactServlet",
    urlPatterns = {"/contact"}
)
public class ContactServlet extends HttpServlet {

    // Database Connection

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Connection connection = DbManager.getConnection();
            // Return the latest status of the test lamp
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE user_id = 'sehunchoi'");
            rs.next();
            request.setAttribute("user_id", rs.getString(1));
            request.setAttribute("email", rs.getString(2));
            request.setAttribute("first_name", rs.getString(3));
            request.setAttribute("last_name", rs.getString(4));
            request.setAttribute("security_pin", rs.getString(5));
            connection.close();
        }
        catch (SQLException e) {
            request.setAttribute("SQLException", e.getMessage());
        }
        catch (URISyntaxException e) {
            request.setAttribute("URISyntaxException", e.getMessage());
        }

        request.getRequestDispatcher("/contact-get.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String node_address = request.getParameter("node_address").toLowerCase().replaceAll("\\s","");
        String data_value_str = request.getParameter("data_value").toLowerCase().replaceAll("\\s","");
        int data_value_int = 0;

        if (node_address == null) {
            request.setAttribute("error", "No node_address specified.");
        }

        if (data_value_str == null) {
            request.setAttribute("error", "No data_value specified.");
        }
        else {
            // Convert string to corresponding int 0-off 1-on
            if (data_value_str.contains("off")) {
                data_value_int = 0;
            }
            else {
                data_value_int = 1;
            }
        }

        try {
            Connection connection = DbManager.getConnection();

            // Insert latest test lamp change
            Statement stmt = connection.createStatement();
            stmt.executeUpdate("INSERT INTO test_lamps VALUES ('" + node_address + "', " + data_value_int + ", now())");

            // Return the latest status of the test lamp
            ResultSet rs = stmt.executeQuery("SELECT * FROM test_lamps ORDER BY time DESC LIMIT 1");
            rs.next();
            request.setAttribute("lampAddress", rs.getString(1));
            request.setAttribute("lampStatus", rs.getString(2));
            request.setAttribute("lampStatusTime", rs.getString(3));
            connection.close();
        }
        catch (SQLException e) {
            request.setAttribute("SQLException", e.getMessage());
        }
        catch (URISyntaxException e) {
            request.setAttribute("URISyntaxException", e.getMessage());
        }

        request.getRequestDispatcher("/testlamp-post.jsp").forward(request, response);
    }

};


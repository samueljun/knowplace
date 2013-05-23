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
        // String node_address = request.getParameter("node_address").toLowerCase().replaceAll("\\s","");
        // String data_value_str = request.getParameter("data_value").toLowerCase().replaceAll("\\s","");
        String user_id = request.getParameter("user_id");
        String input_email = request.getParameter("new_email");
        String input_fname = request.getParameter("new_fname");
        String input_lname = request.getParameter("new_lname");    
        String input_pin = request.getParameter("new_pin");


        try {
            Connection connection = DbManager.getConnection();

            // Insert latest test lamp change
            Statement stmt = connection.createStatement();
            if(input_email != "")
                stmt.executeUpdate("UPDATE users SET email = '" + input_email + "' WHERE user_id = '" + user_id + "'");
            if(input_fname != "")
                stmt.executeUpdate("UPDATE users SET first_name = '" + input_fname + "' WHERE user_id = '" + user_id + "'");
            if(input_lname != "")
                stmt.executeUpdate("UPDATE users SET last_name = '" + input_lname + "' WHERE user_id = '" + user_id + "'");
            if(input_pin != "")
                stmt.executeUpdate("UPDATE users SET security_pin = '" + input_pin + "' WHERE user_id = '" + user_id + "'");


            // Return the latest status of the test lamp
            ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE user_id = '" + user_id + "'");
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

};


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
    name = "AddNodeServlet",
    urlPatterns = {"/addnode"}
)
public class ContactServlet extends HttpServlet {

    // Database Connection

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Connection connection = DbManager.getConnection();
            // Return the latest status of the test lamp
            Statement stmt = connection.createStatement();
            ResultSet rs0 = stmt.executeQuery("SELECT id FROM public.max_node_id");
            rs0.next();
            String max_node_id = rs0.getString(1);
            ResultSet rs = stmt.executeQuery("SELECT * FROM nodes WHERE hubs_hub_id = '0' && node_id = " + max_node_id + "");
            rs.next();

            request.setAttribute("hubs_hub_id", rs.getString(1));
            request.setAttribute("node_id", rs.getString(2));
            request.setAttribute("address_low", rs.getString(3));
            request.setAttribute("address_high", rs.getString(4));
            request.setAttribute("name", rs.getString(5));
            request.setAttribute("type", rs.getString(6));
            connection.close();
        }
        catch (SQLException e) {
            request.setAttribute("SQLException", e.getMessage());
        }
        catch (URISyntaxException e) {
            request.setAttribute("URISyntaxException", e.getMessage());
        }

        request.getRequestDispatcher("/addNodeResult.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String hub_id = 0;
        //String input_node_id = request.getParameter("new_node_id");
        String input_address_low = request.getParameter("new_address_low");   
        String input_address_high = request.getParameter("new_address_high");  
        String input_name = request.getParameter("new_name");
        String input_type = request.getParameter("new_type");


        try {
            Connection connection = DbManager.getConnection();

            Statement stmt = connection.createStatement();
            //INSERT INTO public.nodes ( node_id, address_low, address_high, hubs_hub_id, name, type ) VALUES ( ?, ?, ?, ?, ?, ? )
            ResultSet rs = stmt.executeQuery("SELECT id FROM public.max_node_id");
            rs.next();
            int max_node_id = rs.getInt(1);
            max_node_id++;

            stmt.executeQuery("INSERT INTO public.nodes ( node_id, address_low, address_high, hubs_hub_id, name, type ) VALUE (" 
                + max_node_id + ", '" + input_address_low + "', '" + input_address_high +  "', " + 
                hub_id + ", '" + input_name + "', '"  + input_type +  "')");

            stmt.excuteUpdate("UPDATE public.max_node_id SET id = " + max_node_id);

            // Return the latest status of the node
            //SELECT node_id, address_low, address_high, hubs_hub_id, name, type FROM public.nodes

            ResultSet rs = stmt.executeQuery("SELECT * FROM nodes WHERE hubs_hub_id = '0' && node_id = " + max_node_id + "");
            rs.next();

            request.setAttribute("hubs_hub_id", rs.getString(1));
            request.setAttribute("node_id", rs.getString(2));
            request.setAttribute("address_low", rs.getString(3));
            request.setAttribute("address_high", rs.getString(4));
            request.setAttribute("name", rs.getString(5));
            request.setAttribute("type", rs.getString(6));
            connection.close();
        }
        catch (SQLException e) {
            request.setAttribute("SQLException", e.getMessage());
        }
        catch (URISyntaxException e) {
            request.setAttribute("URISyntaxException", e.getMessage());
        }

        request.getRequestDispatcher("/addNodeResult.jsp").forward(request, response);
    }

};


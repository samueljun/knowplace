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

import java.util.Map;
import java.util.Vector;

@WebServlet(
    name = "TestLampServlet",
    urlPatterns = {"/testlamp"}
)
public class TestLampServlet extends HttpServlet {

    private static String convertIntToStatus(int data_value_int) {
        // Convert int to string
        String status_str = "on";
        if (data_value_int == 0) {
            status_str = "off";
        }

        return status_str;
    }

    private static Boolean containsReqParameters(Vector reqParameterList, Map parameterMap) {
        for (Object parameter : reqParameterList) {
            if (!parameterMap.containsKey((String)parameter)) {
                return false;
            }
        }
        return true;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check Required Parameters are Set
        Vector reqParameterList = new Vector();
        reqParameterList.addElement("node_address");

        if (!containsReqParameters(reqParameterList, request.getParameterMap()))
        {
            request.setAttribute("error", "node_address was not given");
            request.getRequestDispatcher("/testlamp-get.jsp").forward(request, response);
            return;
            // response.sendError(400, "Client did not request a node_address");
        }

        // Get Parameters
        String requested_node_address = request.getParameter("node_address");

        // Check for SQL injections

        String node_address = "";
        String time = "";
        String data_value = "";

        try {
            Connection conn = DbManager.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM test_lamps WHERE node_address=" + requested_node_address + " ORDER BY time DESC LIMIT 1");
            rs.next();

            node_address = rs.getString("node_address");
            time = rs.getString("time");
            data_value = rs.getString("data_value");

            conn.close();
        }
        catch (SQLException e) {
            request.setAttribute("SQLException", e.getMessage());
        }
        catch (URISyntaxException e) {
            request.setAttribute("URISyntaxException", e.getMessage());
        }
        catch (Exception e) {
            throw new ServletException(e);
        }

        request.setAttribute("lampAddress", node_address);
        request.setAttribute("lampStatusTime", time);
        request.setAttribute("lampStatus", data_value);

        request.getRequestDispatcher("/testlamp-get.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Vector reqParameterList = new Vector();
        reqParameterList.addElement("node_address");
        reqParameterList.addElement("data_value");

        if (!containsReqParameters(reqParameterList, request.getParameterMap()))
        {
            request.setAttribute("error", "Client is missing parameters was not given");
            request.getRequestDispatcher("/testlamp-post.jsp").forward(request, response);
            return;
            // response.sendError(400, "Client did not request a node_address");
        }


        // String node_address = request.getParameter("node_address").toLowerCase();
        String data_value_str = request.getParameter("data_value").toLowerCase();

        if (!data_value_str.equals("off") && !data_value_str.equals("on")) {
            request.setAttribute("error", "Client has provided invalid data_value");
            request.getRequestDispatcher("/testlamp-post.jsp").forward(request, response);
            return;
            // response.sendError(400, "Client did not request a node_address");
        }

        String requested_node_address = request.getParameter("node_address");

        int data_value_int = 0;

        // Convert string to corresponding int 0-off 1-on
        if (data_value_str.equals("off")) {
            data_value_int = 0;
        }
        else {
            data_value_int = 1;
        }

        String node_address = "";
        String time = "";
        String data_value = "";

        try {
            Connection conn = DbManager.getConnection();
            Statement stmt = conn.createStatement();
            stmt.executeUpdate("INSERT INTO test_lamps VALUES (" + requested_node_address + ", now(), " + data_value_int + ")");

            // Return the latest status of the test lamp
            ResultSet rs = stmt.executeQuery("SELECT * FROM test_lamps WHERE node_address=" + requested_node_address + " ORDER BY time DESC LIMIT 1");
            rs.next();

            node_address = rs.getString("node_address");
            time = rs.getString("time");
            data_value = rs.getString("data_value");

            conn.close();
        }
        catch (SQLException e) {
            request.setAttribute("SQLException", e.getMessage());
        }
        catch (URISyntaxException e) {
            request.setAttribute("URISyntaxException", e.getMessage());
        }

        request.setAttribute("lampAddress", node_address);
        request.setAttribute("lampStatusTime", time);
        request.setAttribute("lampStatus", data_value);

        request.getRequestDispatcher("/testlamp-post.jsp").forward(request, response);
    }

};


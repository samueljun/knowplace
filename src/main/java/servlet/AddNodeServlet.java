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
import java.util.HashMap;
import com.google.gson.Gson;

@WebServlet(
	name = "AddNodeServlet",
	urlPatterns = {"/addnode"}
)
public class AddNodeServlet extends HttpServlet {
/*
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		try {
			Connection connection = DbManager.getConnection();
			// Return the latest status of the test lamp
			Statement stmt = connection.createStatement();
			ResultSet rs0 = stmt.executeQuery("SELECT id FROM public.max_node_id");
			rs0.next();
			String max_node_id = rs0.getString(1);
			ResultSet rs = stmt.executeQuery("SELECT * FROM nodes WHERE hubs_hub_id = 0 && node_id = " + String.valueOf(max_node_id));
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
*/

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");

		if (action.equals("addNode")) {
			String user_id = "0"; // TEMPORARY
			String hub_id = "0"; // TEMPORARY
			String input_name = request.getParameter("name");
			String input_address_high = request.getParameter("address_high");
			String input_address_low = request.getParameter("address_low");
			String input_current_value = request.getParameter("current_value");

			// For Pin
			// String input_pin_name = request.getParameter("pin_name");
			String input_pin_name = input_name + " Pin"; // TEMPORARY
			String input_type = request.getParameter("type"); // Change front end

			// For Pin Data
			String input_pin_value = input_current_value;

			try {
				Connection connection = DbManager.getConnection();
				Statement stmt = connection.createStatement();
				ResultSet rs = stmt.executeQuery("SELECT id FROM public.max_node_id");
				rs.next();
				int prev_node_id = rs.getInt(1);
				int curr_node_id = prev_node_id + 1;
				// int curr_pin_id = curr_node_id;

				stmt.execute("INSERT INTO public.nodes (node_id, name, address_high, address_low, current_value, hubs_hub_id) VALUES (" + String.valueOf(curr_node_id) + ", '" + input_name + "', '" + input_address_high + "', '" + input_address_low + "', '" + input_current_value + "', '" + hub_id + "')");
				
				stmt.executeUpdate("UPDATE max_node_id SET id = '" + String.valueOf(curr_node_id) + "' WHERE id = '" + String.valueOf(prev_node_id) + "'");

				rs.close();
				stmt.close();
				
				stmt = connection.createStatement();
				rs = stmt.executeQuery("SELECT id FROM public.max_pin_id");
				rs.next();
				int prev_pin_id = rs.getInt(1);
				int curr_pin_id = prev_pin_id + 1;

				stmt.execute("INSERT INTO public.pins (pin_id, name, type, nodes_node_id) VALUES (" + String.valueOf(curr_pin_id) + ", '" + input_pin_name + "', '" + input_type +  "', " + String.valueOf(curr_node_id)  +  ")");
				stmt.execute("INSERT INTO public.pin_data (time, pin_value, pins_pin_id) VALUES (now(), '" + input_pin_value + "', '" + String.valueOf(curr_pin_id) + "')");

				stmt.executeUpdate("UPDATE max_pin_id SET id = '" + String.valueOf(curr_pin_id) + "' WHERE id = '" + String.valueOf(prev_pin_id) + "'");
				
				rs.close();
				stmt.close();

				connection.close();

				Map<String, String> responseJson = new HashMap<String, String>();
				responseJson.put("status", "SUCCESS");
				responseJson.put("pin_id", String.valueOf(curr_pin_id));
				responseJson.put("current_value", input_current_value);

				Gson gson = new Gson();
				String json = gson.toJson(responseJson);

				response.setContentType("application/json");
				response.setCharacterEncoding("UTF-8");
				response.getWriter().write(json);
			}
			catch (SQLException e) {
				String errorMessage = "SQLException:\n" + e.getMessage();
				returnJsonStatusFailed(response, errorMessage);
			}
			catch (URISyntaxException e) {
				String errorMessage = "URISyntaxException:\n" + e.getMessage();
				returnJsonStatusFailed(response, errorMessage);
			}
		}
	}

	private void returnJsonStatusFailed (HttpServletResponse response, String message) throws IOException {
		Map<String, String> responseJson = new HashMap<String, String>();
		responseJson.put("status", "FAILED");
		responseJson.put("message", message);
		Gson gson = new Gson();
		String json = gson.toJson(responseJson);

		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);
	}

};


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
import java.util.Vector;
import java.util.List;
import java.util.ArrayList;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@WebServlet(
	name = "MyDataServlet",
	urlPatterns = {"/mydata"}
)
public class MyDataServlet extends HttpServlet {

	public MyDataServlet () {}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");

		if (action.equals("getUserData")) {
			// String user_id = request.getParameter("user_id");
			String user_id = "0"; // TEMPORARY

			UserData userData = getData(user_id);
			Gson gson = new Gson();
			String json = gson.toJson(userData);

			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
		}
		else if (action.equals("getDataEmbedded")) {
			String user_id = "0"; // TEMPORARY
			UserData userData = getData(user_id);

			EmbeddedResponse embeddedResponse = new EmbeddedResponse();

			Hub curr_hub = userData.hubs.get(0);
			for (Node node:curr_hub.nodes) {
				String address_low = node.address_low;
				String address_high = node.address_high;
				String current_value = node.current_value;
				String type = node.pins.get(0).type;

				EmbeddedNodes responseNode = new EmbeddedNodes(address_low, address_high, current_value, type);
				embeddedResponse.nodes.add(responseNode);
			}

			// String address_low = userData.hubs.get(0).nodes.get(0).address_low;
			// String address_high = userData.hubs.get(0).nodes.get(0).address_high;
			// String current_value = userData.hubs.get(0).nodes.get(0).current_value;
			// String type = userData.hubs.get(0).nodes.get(0).pins.get(0).type;

			Gson gson = new Gson();
			String json = gson.toJson(embeddedResponse);

			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");

		if (action.equals("changeStatus")) {
			String user_id = "0";
			UserData userData = new UserData(user_id);

			Vector requiredParameterList = new Vector();
			requiredParameterList.addElement("node_id");
			requiredParameterList.addElement("new_current_value");
			if (!checkParameters(requiredParameterList, request.getParameterMap())) {
				returnJsonStatusFailed(response, "Missing Parameter");
			}
			else {
				String input_node_id = request.getParameter("node_id");
				String input_current_value = request.getParameter("new_current_value");

				if (newPinData(input_node_id, input_current_value) < 0) {
					returnJsonStatusFailed(response, "Error");
				}
				else {
					Map<String, String> responseJson = new HashMap<String, String>();
					responseJson.put("status", "SUCCESS");
					Gson gson = new Gson();
					String json = gson.toJson(responseJson);

					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					response.getWriter().write(json);
				}
			}
		}
	}

	private static Boolean checkParameters(Vector requiredParameterList, Map parameterMap) {
		// Check for SQL Injection here

		for (Object parameter : requiredParameterList) {
			if (!parameterMap.containsKey((String)parameter)) {
				return false;
			}
		}
		return true;
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

	private static void returnError(HttpServletResponse response, String exceptionErrorMsg) throws IOException {
		System.out.println(exceptionErrorMsg);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write("{\"status\":\"FAILED\"}");
	}

	// public status_code getData(String user_id, UserData data) {
	public UserData getData(String user_id) {
		UserData data = new UserData(user_id);
		List<Hub> hubs = data.hubs;
		try {
			Connection connection = DbManager.getConnection();
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM hubs WHERE users_user_id = '" + user_id + "'");
			while (rs.next()) {
				Integer hub_id = rs.getInt("hub_id");
				String name = rs.getString("name");
				String api_key = rs.getString("api_key");
				Integer pan_id = rs.getInt("pan_id");
				hubs.add(new Hub(hub_id, name, api_key, pan_id));
			}
			rs.close();
			stmt.close();
			List<Node> nodes = new ArrayList<Node> ();
			for (Hub hub:hubs) {
				stmt = connection.createStatement();
				rs = stmt.executeQuery("SELECT * FROM nodes WHERE hubs_hub_id = '" + hub.hub_id + "'");
				while (rs.next()) {
					Integer node_id = rs.getInt("node_id");
					String name = rs.getString("name");
					String address_low = rs.getString("address_low");
					String address_high = rs.getString("address_high");
					String current_value = rs.getString("current_value");
					Node node = new Node(node_id, name, address_low, address_high, current_value);
					hub.nodes.add(node);
					nodes.add(node);
				}
				rs.close();
				stmt.close();
			}
			List<Pin> pins = new ArrayList<Pin> ();
			for (Node node:nodes) {
				stmt = connection.createStatement();
				rs = stmt.executeQuery("SELECT * FROM pins WHERE nodes_node_id = '" + node.node_id + "'");
				while (rs.next()) {
					Integer pin_id = rs.getInt("pin_id");
					String name = rs.getString("name");
					String type = rs.getString("type");
					Pin pin = new Pin(pin_id, name, type);
					node.pins.add(pin);
					pins.add(pin);
				}
				rs.close();
				stmt.close();
			}

			for (Pin pin:pins) {
				stmt = connection.createStatement();
				rs = stmt.executeQuery("SELECT * FROM pin_data WHERE pins_pin_id = '" + pin.pin_id + "' ORDER BY time");
				while (rs.next()) {
					Timestamp time = rs.getTimestamp("time");
					String pin_value = rs.getString("pin_value");
					PinData pinData = new PinData(time, pin_value);
					pin.pin_data.add(pinData);
				}
				rs.close();
				stmt.close();
			}

			for (Pin pin:pins) {
				stmt = connection.createStatement();
				rs = stmt.executeQuery("SELECT * FROM tags WHERE pins_pin_id = '" + pin.pin_id + "'");
				while (rs.next()) {
					String tag = rs.getString("tag");
					Tag t = new Tag(tag);
					pin.tags.add(t);
				}
				rs.close();
				stmt.close();
			}

			connection.close();

			data.status = "SUCCESS";
		}
		catch (SQLException e) {
			data.status = "FAILED";
			// returnError(response, "SQLException:\n" + e.getMessage());
		}
		catch (URISyntaxException e) {
			data.status = "FAILED";
			// returnError(response, "URISyntaxException:\n" + e.getMessage());
		}
		return data;
	}

	public int newPinData(String input_pin_id, String input_pin_value) {
		try {
			Connection connection = DbManager.getConnection();
			Statement stmt = connection.createStatement();
			// ResultSet rs = stmt.executeQuery("SELECT type FROM public.pin_data WHERE pins_pin_id = " + input_pin_id);
			// rs.next();
			// String type = rs.getString("type");

			stmt.executeUpdate("INSERT INTO public.pin_data (time, pin_value, pins_pin_id) VALUES (now(), '" + input_pin_value + "', " + input_pin_id + ")");
			ResultSet rs = stmt.executeQuery("SELECT nodes_node_id FROM pins WHERE pin_id = " + input_pin_id);
			rs.next();
			String node_id = rs.getString("nodes_node_id");
			stmt.executeUpdate("UPDATE nodes SET current_value = '" + input_pin_value + "' WHERE node_id = " + node_id);
			rs.close();
			stmt.close();
			connection.close();
			return 0;
		}
		catch (SQLException e) {
			System.out.println("SQLException:\n" + e.getMessage());
			return -1;
		}
		catch (URISyntaxException e) {
			System.out.println("URISyntaxException:\n" + e.getMessage());
			return -1;
		}
	}

};

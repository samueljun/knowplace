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

	private static Boolean checkRequiredParameters(Vector requiredParameterList, Map parameterMap) {
		for (Object parameter : requiredParameterList) {
			if (!parameterMap.containsKey((String)parameter)) {
				return false;
			}
		}
		return true;
	}

	private static void returnError(HttpServletResponse response, String exceptionErrorMsg)
	throws IOException {
		System.out.println(exceptionErrorMsg);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write("{\"status\":\"FAILED\"}");
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		String action = request.getParameter("action");

		if (action.equals("getUserData")) {
			// String user_id = request.getParameter("user_id");
			String user_id = "0";

			UserData userData = getData(user_id);
			Gson gson = new Gson();
			String json = gson.toJson(userData);

			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
		}
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
				hubs.add(new Hub(hub_id, api_key, name, pan_id));
			}
			rs.close();
			stmt.close();
			List<Node> nodes = new ArrayList<Node> ();
			for (Hub hub:hubs) {
				stmt = connection.createStatement();
				rs = stmt.executeQuery("SELECT * FROM nodes WHERE hubs_hub_id = '" + hub.hub_id + "'");
				while (rs.next()) {
					Integer node_id = rs.getInt("node_id");
					String address_high = rs.getString("address_high");
					String address_low = rs.getString("address_low");
					String name = rs.getString("name");
					String type = rs.getString("type");
					Node node = new Node(node_id, address_high, address_low, name, type);
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
					String data_type = rs.getString("data_type");
					String name = rs.getString("name");
					Pin pin = new Pin(pin_id, data_type, name);
					node.pins.add(pin);
					pins.add(pin);
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
			
			for (Pin pin:pins) {
				stmt = connection.createStatement();
				rs = stmt.executeQuery("SELECT * FROM pin_data WHERE pins_pin_id = '" + pin.pin_id + "' ORDER BY time");
				while (rs.next()) {
					Timestamp time = rs.getTimestamp("time");
					String pin_type = rs.getString("pin_type");
					String pin_value = rs.getString("pin_value");
					PinData pinData = new PinData(time, pin_type, pin_value);
					pin.pin_data.add(pinData);
				}       
			}
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

};

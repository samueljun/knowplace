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

			UserData userData = getUserData(user_id);
			Gson gson = new Gson();
			String json = gson.toJson(userData);

			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
		}
		else if (action.equals("getDataEmbedded")) {
			String user_id = "0"; // TEMPORARY
			String api_key = request.getParameter("api_key");
			HubData hubData = getHubData(api_key);
			// UserData hubData = getUserData("0");

			EmbeddedResponse embeddedResponse = new EmbeddedResponse();

			if(hubData.hubs.isEmpty() == false){
			Hub curr_hub = hubData.hubs.get(0);
			// for(Hub hub:hubData.hubs){
				for (Node node:curr_hub.nodes) {
					String address_high = node.address_high;
					String address_low = node.address_low;
					String current_value = node.current_value;
					String type = node.pins.get(0).type;

					EmbeddedNodes responseNode = new EmbeddedNodes(address_high, address_low, current_value, type);
					embeddedResponse.nodes.add(responseNode);
					//fill in pins later
				}
			// }
			}
			Gson gson = new Gson();
			String json = gson.toJson(embeddedResponse);

			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(json);
		}
		else if (action.equals("changeStatus")) {
			String user_id = "0";
			UserData userData = new UserData(user_id);

			Vector requiredParameterList = new Vector();
			requiredParameterList.addElement("node_id");
			requiredParameterList.addElement("new_current_value");
			if (!checkParameters(requiredParameterList, request.getParameterMap())) {
				returnJsonStatusFailed(response, "Missing Parameter");
			}
			else {
				String input_pin_id = request.getParameter("node_id");
				String input_current_value = request.getParameter("new_current_value");

				if (newPinData(input_pin_id, input_current_value) < 0 || bakeRecipes(input_pin_id, input_current_value) < 0) {
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
				String input_pin_id = request.getParameter("node_id");
				String input_current_value = request.getParameter("new_current_value");

				if (newPinData(input_pin_id, input_current_value) < 0 || bakeRecipes(input_pin_id, input_current_value) < 0) {
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

	// public status_code getUserData(String user_id, UserData data) {
	public UserData getUserData(String user_id) {
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
			if(hubs.isEmpty() == false){
				List<Node> nodes = new ArrayList<Node> ();
				for (Hub hub:hubs) {
					stmt = connection.createStatement();
					rs = stmt.executeQuery("SELECT * FROM nodes WHERE hubs_hub_id = '" + hub.hub_id + "'");
					while (rs.next()) {
						Integer node_id = rs.getInt("node_id");
						String name = rs.getString("name");
						String address_high = rs.getString("address_high");
						String address_low = rs.getString("address_low");
						String current_value = rs.getString("current_value");
						Node node = new Node(node_id, name, address_high, address_low, current_value);
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
						String current_value = rs.getString("current_value");
						Pin pin = new Pin(pin_id, name, type, current_value);
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

	// public status_code getHubData(String user_id, HubData data) {
	public HubData getHubData(String hub_api_key) {
		HubData data = new HubData(hub_api_key);
		List<Hub> hubs = data.hubs;
		try {
			Connection connection = DbManager.getConnection();
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery("SELECT * FROM hubs WHERE api_key = '" + hub_api_key + "'");
			// rs.next();
			while (rs.next()) {
			// if(rs.next()){
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
					String address_high = rs.getString("address_high");
					String address_low = rs.getString("address_low");
					String current_value = rs.getString("current_value");
					Node node = new Node(node_id, name, address_high, address_low, current_value);
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
					String current_value = rs.getString("current_value");
					Pin pin = new Pin(pin_id, name, type, current_value);
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

			stmt.executeUpdate("UPDATE pins SET current_value = '" + input_pin_value + "' WHERE pin_id = " + input_pin_id);
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

	public int compareData(String input_value_str, String trigger_value_str, String comparator){
		
			int input_value = Integer.parseInt(input_value_str);
			int trigger_value = Integer.parseInt(trigger_value_str);
			int ret = -1;

			if(comparator.equals(">")){
					if(input_value > trigger_value){
						ret = 0;				
					}
				}
				else if (comparator.equals(">=")){
					if(input_value >= trigger_value){
						ret = 0;
					}
				}
				else if (comparator.equals("<")){
					if(input_value < trigger_value){
						ret = 0;
					}
				}
				else if (comparator.equals("<=")){
					if(input_value <= trigger_value){
						ret = 0;
					}
				}
				else if (comparator.equals("!=")){
					if(input_value != trigger_value){
						ret = 0;
					}
				}
				else{	//default "=="
				
					if(input_value == trigger_value){
						ret = 0;
					}
				}
				return 0;
		
	}

	public int bakeRecipes(String input_pin_id, String input_pin_value){
		try{
			Connection connection = DbManager.getConnection();
			Statement stmtRec = connection.createStatement();
			ResultSet rsRec = stmtRec.executeQuery("SELECT * FROM recipes WHERE trigger_pin_id = " + input_pin_id);
			int ret = 0;

			while(rsRec.next()){
				int recipe_id = rsRec.getInt("recipe_id");
				String recipe_name = rsRec.getString("name");
				int executed = rsRec.getInt("executed");

			
				Statement stmtIng = connection.createStatement();
				ResultSet rsIng = stmtIng.executeQuery("SELECT * FROM ingredients WHERE recipes_recipe_id = " + recipe_id);
				boolean allIngredientsFound = true;
				
				//right now, assuming only one ingredient will be found
				if(rsIng.next()){	//eventually will change to a while

					int action_pin_id = rsIng.getInt("action_pin_id");
					String comparator = rsIng.getString("comparator");
					String  trigger_value = rsIng.getString("trigger_value");
					String action_value = rsIng.getString("action_value");
					boolean satisfied = rsIng.getBoolean("satisfied");

					if(compareData(input_pin_value, trigger_value, comparator) < 0)
					{
						ret = -1;
					}
					else{
						// rs.updateBoolean("satisfied", true);
						stmtIng.executeUpdate("UPDATE pins SET current_value = '" + action_value + "' WHERE pin_id = " + action_pin_id);
						stmtIng.executeUpdate("UPDATE nodes SET current_value = '" + action_value + "' WHERE node_id = " + action_pin_id);
						
					}
				}

				// if(allIngredientsFound == true){
				// 	stmt.executeUpdate("UPDATE automation_recipes SET executed = TRUE WHERE trigger_pin_id = " + input_pin_id + ", action_pin_id = " + action_pin_id + ", comparitor = " + comparitor);
				// 	if(executed == 0){
				// 		rs.updateInt("executed", 1);
				// 	}
				// }
				// else{
				// 	ret = -1; 
				// }
				rsIng.close();
				stmtIng.close();
			}
			rsRec.close();
			stmtRec.close();
			connection.close();
			return ret;
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

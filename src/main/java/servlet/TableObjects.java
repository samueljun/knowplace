package main.java.servlet;

import java.sql.*;

import java.util.Map;
import java.util.Vector;
import java.util.List;
import java.util.ArrayList;

class UserData {
	public String user_id;
	public List<Hub> hubs = new ArrayList<Hub>();
	public UserData(String user_id) {
		this.user_id = user_id;
	}
}

class Hub {
	public Integer hub_id;
	public String api_key;
	public String name;
	public Integer pan_id;

	public List<Node> nodes = new ArrayList<Node>();
	public Hub(Integer hub_id, String api_key, String name, Integer pan_id) {
		this.hub_id = hub_id;
		this.api_key = api_key;
		this.name = name;
		this.pan_id = pan_id;
	}
}

class Node {
	public Integer node_id;
	public String address_high;
	public String address_low;
	public String name;
	public String type;
	public List<Pin> pins = new ArrayList<Pin> ();
	public Node(Integer node_id, String address_high, String address_low, String name, String type) {
		this.node_id = node_id; 
		this.address_low = address_low;
		this.address_high = address_high;
		this.name = name;
		this.type = type;
	}
}

class Pin {
	public Integer pin_id;
	public String data_type;
	public String name;
	public List<Tag> tags = new ArrayList<Tag> ();
	public List<PinData> pin_data = new ArrayList<PinData> ();
	public Pin(Integer pin_id, String data_type, String name) {
		this.pin_id = pin_id;            
		this.data_type = data_type;
		this.name = name;
	}
}

class Tag {
	public String tag;
	public Tag(String tag) {
		this.tag = tag;
	}
}

class PinData {
	public Timestamp time;
	public String pin_value;
	public String pin_type;

	public PinData(Timestamp time, String pin_value, String pin_type) {
		this.time = time;            
		this.pin_value = pin_value;
		this.pin_type = pin_type; 
	}
}
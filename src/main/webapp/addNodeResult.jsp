<% if (request.getAttribute("error") == null) { %>
	<html>
	    <head>
	        <title>AddNodeResult Servlet Page</title>
	    </head>
	    <body>
 	        <p>Get Request</p>
	        <dl>
	            <dt>Hub ID: </dt>
	            <dd><%= request.getAttribute("hubs_hub_id") %> </dd>
	            <dt>Node ID:</dt>
	            <dd><%= request.getAttribute("node_id") %></dd>
	            <dt>Address Low:</dt>
	            <dd><%= request.getAttribute("address_low") %></dd>
	            <dt>Address High:</dt>
	            <dd><%= request.getAttribute("address_high") %></dd>
	            <dt>Node Name:</dt>
	            <dd><%= request.getAttribute("name") %></dd>
	            <dt>Node Type:</dt>
	            <dd><%= request.getAttribute("type") %></dd>

	            <dt>SQLException:</dt>
	            <dd><%= request.getAttribute("SQLException") %></dd>
	            <dt>URISyntaxException:<dt>
	            <dd><%= request.getAttribute("URI Syntax Exception") %></dd>
	        </dl> -

	        <p><a href="/">Index</a></p>

	    </body>
	</html>
<% } else { %>
	<%= request.getAttribute("error") %>
<% } %>
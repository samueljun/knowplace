<% if (request.getAttribute("error") == null) { %>
	<html>
	    <head>
	        <title>Contact Servlet Page</title>
	    </head>
	    <body>
<!-- 	        <p>Get Request</p>
	        <dl>
	            <dt>User ID: </dt>
	            <dd><%= request.getAttribute("user_id") %> </dd>
	            <dt>E-Mail:</dt>
	            <dd><%= request.getAttribute("email") %></dd>
	            <dt>First Name:</dt>
	            <dd><%= request.getAttribute("first_name") %></dd>
	            <dt>Last Name:</dt>
	            <dd><%= request.getAttribute("last_name") %></dd>
	            <dt>Security PIN:</dt>
	            <dd><%= request.getAttribute("security_pin") %></dd>


	            <dt>SQLException:</dt>
	            <dd><%= request.getAttribute("SQLException") %></dd>
	            <dt>URISyntaxException:<dt>
	            <dd><%= request.getAttribute("URI Syntax Exception") %></dd>
	        </dl> -->
	        <br><br><br>
	        <p><b>Add a new node</b></p> <br>
	        <form method="post" action="/addnode_result">
              Address Low: <input type="text" name="new_address_low"><br>
              Address High: <input type="text" name="new_address_high"><br>
  			  Name: <input type="text" name="new_name"><br>
  			  Type: <input type="text" name="new_type"><br>
              <input type="submit" inline class="btn" value="Submit">
            </form>
	        <br><br><br>
	        <p><a href="/">Index</a></p>

	    </body>
	</html>
<% } else { %>
	<%= request.getAttribute("error") %>
<% } %>
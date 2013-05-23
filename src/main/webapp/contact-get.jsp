<% if (request.getAttribute("error") != null) { %>
    <%= request.getAttribute("error") %>
<% } else { %>
	[user_id][<%= request.getAttribute("user_id") %>]
    [email][<%= request.getAttribute("email") %>]
    [firstname][<%=request.getAttribute("first_name") %>]
    [lastname][<%=request.getAttribute("last_name") %>]
    [pin][<%=request.getAttribute("security_pin") %>]
<% } %>
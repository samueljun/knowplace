<% if (request.getAttribute("error") != null) { %>
    <%= request.getAttribute("error") %>
<% } else { %>
    [email][<%= request.getAttribute("email") %>]
    [firstname][<%=request.getAttribute("first_name") %>]
    [lastname][<%=request.getAttribute("last_name") %>]
    [pin][<%=request.getAttribute("security_pin") %>]
<% } %>
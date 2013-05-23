<% if (request.getAttribute("error") != null) { %>
    <%= request.getAttribute("error") %>
<% } else { %>
    [firstName][<%= request.getAttribute("first_name") %>]
    [lastName][<%=request.getAttribute("last_name") %>]
    [email][<%=request.getAttribute("email") %>]>
<% } %>
<% if (request.getAttribute("error") != null) { %>
    <%= request.getAttribute("error") %>
<% } else { %>
    [lampStatus][<%= request.getAttribute("lampStatus") %>]
    [lampStatusTime][<%=request.getAttribute("lampStatusTime") %>]
    [lampAddress][<%=request.getAttribute("lampAddress") %>]>
<% } %>
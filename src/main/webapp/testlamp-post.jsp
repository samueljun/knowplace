<html>
    <head>
        <title>Test Lamp Servlet Page</title>
    </head>
    <body>
        <p>Post Request</p>
        <dl>
            <dt>Latest Lamp Status for the Lamp with address <%= request.getAttribute("lampAddress") %>:</dt>
            <dd>"<%= request.getAttribute("lampStatus") %>" with timestamp of: "<%=request.getAttribute("lampStatusTime") %>"</dd>
            <dt>Error:</dt>
            <dd><%= request.getAttribute("error") %></dd>
            <dt>SQLException:</dt>
            <dd><%= request.getAttribute("SQLException") %></dd>
            <dt>URISyntaxException:<dt>
            <dd><%= request.getAttribute("URI Syntax Exception") %></dd>
        </dl>
    </body>
</html>

<html>
    <head>
        <title>Test Lamp Servlet Page</title>
    </head>
    <body>
        <p>Get Request</p>
        <dl>
            <dt>Latest Lamp Status for the test_lamp:</dt>
            <dd>"<%= request.getAttribute("lampStatus") %>" with timestamp of: "<%=request.getAttribute("lampStatusTime") %>"</dd>
            <dt>SQLException:</dt>
            <dd><%= request.getAttribute("SQLException") %></dd>
            <dt>URISyntaxException:<dt>
            <dd><%= request.getAttribute("URI Syntax Exception") %></dd>
        </dl>
    </body>
</html>

<html>
    <head>
        <title>Test Lamp Servlet Page</title>
    </head>
    <body>
        <p>Post Request</p>
        <dl>
            <dt>response1:</dt>
            <dd><%= request.getAttribute("response1") %></dd>
            <dt>SQLException:</dt>
            <dd><%= request.getAttribute("SQLException") %></dd>
            <dt>URISyntaxException:<dt>
            <dd><%= request.getAttribute("URI Syntax Exception") %></dd>
        </dl>
    </body>
</html>

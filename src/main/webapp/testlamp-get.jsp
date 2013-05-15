<html>
    <head>
        <title>Test Lamp Servlet Page</title>
    </head>
    <body>
        <p>Get Request</p>
        <dl>
            <dt>data_value for test_lamp:</dt>
            <dd><%= request.getAttribute("data_value") %></dd>
            <dt>SQLException:</dt>
            <dd><%= request.getAttribute("SQLException") %></dd>
            <dt>URISyntaxException:<dt>
            <dd><%= request.getAttribute("URI Syntax Exception") %></dd>
        </dl>
    </body>
</html>

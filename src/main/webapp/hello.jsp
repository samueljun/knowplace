<html>
    <head>
        <title>Hello Servlet Page</title>
    </head>
    <body>
        <p>Get</p>
        <dl>
            <dt>data_value for test_lamp</dt>
            <dd><%= request.getAttribute("data_value") %></dd>
            <dt>SQLException:</dt>
            <dd><%= request.getAttribute("SQLException") %></dd>
            <dt>URISyntaxException:<dt>
            <dd><%= request.getAttribute("URI Syntax Exception") %></dd>
        </dl>
        <p><h1>Post</h1></p>
        <dl>
            <dt>response1:</dt>
            <dd><%= request.getAttribute("response1") %></dd>
        </dl>
    </body>
</html>

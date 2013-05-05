<html>
    <head>
        <title>Hello Servlet Page</title>
    </head>
    <body>
        <dl>
            <dt>Test Var</dt>
            <dd><%= request.getAttribute("test_var") %></dd>
            <dt>SQL Exception:</dt>
            <dd><%= request.getAttribute("SQLException") %></dd>
            <dt>URI Syntax Exception:<dt>
            <dd><%= request.getAttribute("URI Syntax Exception") %></dd>
            <dt>Test Var 2:</dt>
            <dd><%= request.getAttribute("test_var2") %></dt>
        </dl>
    </body>
</html>

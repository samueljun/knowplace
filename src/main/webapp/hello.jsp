<html>
    <head>
        <title>Hello Servlet Page</title>
    </head>
    <body>
        <%= request.getAttribute("test_var") %><br>

        SQLException:<br>
        <%= request.getAttribute("SQLException") %><br>

        URI Syntax Exception:<br>
        <%= request.getAttribute("URI Syntax Exception") %><br>

        Test Var 2:<br>
        <%= request.getAttribute("test_var2") %><br>
    </body>
</html>

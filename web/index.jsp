<!DOCTYPE html>
<html>

    <head>
        <title>Home - nelson</title>
        <link rel="shortcut icon" href="src/img/favicon.png">

        <%
            //CONFIGURATION

            final boolean ALLOW_ADMIN = true;
            final boolean ALLOW_STAFF = true;
            final boolean ALLOW_CUSTOMER = true;
            final boolean ALLOW_GUEST = true;

            //END OF CONFIGURATION
        %>
    </head>

    <body>
        <div class="nelson-greeter">
            <img src="src/img/white/nelson.png" alt="Nelson Logo" class="logo" style="width: 40%;">
        </div>
        <%@ include file="navigation.jsp" %>
        <div class="container" style="display: none;">

        </div>
    </body>
</html>

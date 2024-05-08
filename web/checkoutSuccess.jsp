<!DOCTYPE html>
<html>

    <head>
        <title>Home - nelson</title>
        <link rel="shortcut icon" href="src/img/favicon.png">
        <link rel="stylesheet" href="src/css/checkoutSuccess.css">

        <%
            //CONFIGURATION

            final boolean ALLOW_ADMIN = true;
            final boolean ALLOW_STAFF = true;
            final boolean ALLOW_CUSTOMER = true;
            final boolean ALLOW_GUEST = false;

            //END OF CONFIGURATION
        %>
    </head>

    <body>
        <div class="nelson-greeter">
            <img src="src/img/white/nelson.png" alt="Nelson Logo" class="logo" style="width: 40%;">
        </div>
        <%@ include file="navigation.jsp" %>
        <div class="container" style="display: none;">
            <div>
            <img src="src/img/white/check-circle.svg" alt="Success" class="success">
            <h1>&nbsp;Checkout Successful</h1>
            </div>
            <div>
                <h3>You can view your orders <a href="order.jsp">here</a></h3>
            </div>
        </div>
        <%@ include file="footer.jsp" %>
    </body>
</html>

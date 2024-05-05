<html>
<head>
    <link rel="shortcut icon" href="src/img/favicon.png">
    <link rel="stylesheet" type="text/css" href="src/css/header.css">
    <!--<link rel="stylesheet" href="src/css/topup.css"> -->
    <!--<link rel="stylesheet" href="src/css/register.css"> -->
    <!--<link rel="stylesheet" href="src/css/category.css"> -->
    <!--<link rel="stylesheet" href="src/css/feedback.css"> -->
    <!--<link rel="stylesheet" href="src/css/util.css"> -->
    <!--<link rel="stylesheet" href="src/css/profile.css"> -->
    <!--<link rel="stylesheet" href="src/css/productmgmt.css"> -->
    <!--<link rel="stylesheet" href="src/css/grid.css"> -->
    <script type="text/javascript" src="src/js/jquery.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="src/js/init.js"></script>
    <script src="src/js/topup.js"></script>
    <script src="src/js/register.js"></script>
    <script src="src/js/profile.js"></script>
    <script src="src/js/productmgmt.js"></script>
    <script src="src/js/category.js"></script>
    <script src="src/js/pay.js"></script>
    <%@ page import="jakarta.servlet.http.Cookie" %>
    <%@ page import="domain.Customer" %>
    <%@ page import="domain.Admin" %>
    <%@ page import="domain.Category" %>
    <%@ page import="domain.Card" %>
    <%@ page import="domain.Address" %>
    <%@ page import="domain.Staff" %>
    <%@ page import="domain.Product" %>
    <%@ page import="java.util.List" %>
    <%@ page import="control.CustomerControl" %>
    <%@ page import="control.AdminControl" %>
    <%@ page import="control.CategoryControl" %>
    <%@ page import="control.CardControl" %>
    <%@ page import="control.AddressControl" %>
    <%@ page import="control.StaffControl" %>
    <%@ page import="control.ProductControl" %>

    <%
        //CONFIGURATION

        final boolean ALLOW_ADMIN = true;
        final boolean ALLOW_STAFF = true;
        final boolean ALLOW_CUSTOMER = true;
        final boolean ALLOW_GUEST = true;

        //END OF CONFIGURATION
    %>
</head>
<header>
    <title>Pay Page</title>
    <link rel="stylesheet" href="src/css/pay.css">
</header>

<body>
    <div class="payment-method">
        <h1>Payment</h1>
        <input type="radio" id="visa-radio" name="payment" value="visa" onclick="toggleCardDetails()">
        <img src="src\img\visa.jpeg" style="width: 20%; height: 8%;">
        <button type="submit" class="nelson-button" onclick="addcard()">Add</button><br>
        <br><br>
        <input type="radio" id="payment" name="payment" value="nelsonpay">
        <img src="src\img\nelsonpay.png" style="width: 20%; height: 8%;">
        <br><br>
        <br><br>
        <div id="card-details" style="display: none;">
            Card Number: <input type="text" class="nelson-input" id="card-number" name="card-number"><br>
            Expiry Date: <input type="text" class="nelson-input" id="expiry-date" name="expiry-date"><br>
            CVV: <input type="text" class="nelson-input" id="cvv" name="cvv"><br>
        </div>
        
    <button class="nelson-button" onclick="history.back()">Cancel</button>
    <button class="nelson-button" onclick="submitPayment()">Confirm Payment</button>
    </div>

</body>

</html>
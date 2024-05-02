<!DOCTYPE html>
<html>

    <head>
        <title>Home - nelson</title>
        <link rel="shortcut icon" href="src/img/favicon.png">
        <link rel="stylesheet" type="text/css" href="src/css/header.css">
        <link rel="stylesheet" href="src/css/topup.css">
        <link rel="stylesheet" href="src/css/register.css">
        <link rel="stylesheet" href="src/css/category.css">
        <link rel="stylesheet" href="src/css/feedback.css">
        <link rel="stylesheet" href="src/css/util.css">
        <link rel="stylesheet" href="src/css/profile.css">
        <link rel="stylesheet" href="src/css/productmgmt.css">
        <script type="text/javascript" src="src/js/jquery.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="src/js/init.js"></script>
        <script src="src/js/topup.js"></script>
        <script src="src/js/register.js"></script>
        <script src="src/js/profile.js"></script>
        <script src="src/js/productmgmt.js"></script>
        <script src="src/js/category.js"></script>
        <%@ page contentType="text/html; charset=UTF-8" %>
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

    <body>
        <div class="nelson-greeter">
            <img src="src/img/white/nelson.png" alt="Nelson Logo" class="logo" style="width: 40%;">
        </div>
        <%@ include file="navigation.jsp" %>
        <%@ include file="snackbar.jsp" %>
        <div class="container" style="display: none;">

        </div>
    </body>
</html>

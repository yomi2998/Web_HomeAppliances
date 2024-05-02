<!DOCTYPE html>
<html>

    <head>
        <title>Dashboard - nelson</title>
        <link rel="shortcut icon" href="src/img/favicon.png">
        <link rel="stylesheet" href="src/css/dashboard.css"/>
        <link rel="stylesheet" type="text/css" href="src/css/header.css">
        <link rel="stylesheet" href="src/css/topup.css">
        <link rel="stylesheet" href="src/css/register.css">
        <link rel="stylesheet" href="src/css/category.css">
        <link rel="stylesheet" href="src/css/feedback.css">
        <link rel="stylesheet" href="src/css/util.css">
        <link rel="stylesheet" href="src/css/profile.css">
        <script type="text/javascript" src="src/js/jquery.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="src/js/init.js"></script>
        <script src="src/js/topup.js"></script>
        <script src="src/js/register.js"></script>
        <script src="src/js/profile.js"></script>
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
            final boolean ALLOW_CUSTOMER = false;
            final boolean ALLOW_GUEST = false;

            //END OF CONFIGURATION
        %>
    </head>

    <body>
        <div class="nelson-greeter">
            <p style="font-size: 10vw;">dashboard</p>
        </div>
        <%@ include file="navigation.jsp" %>
        <%@ include file="snackbar.jsp" %>
        <% if (userType.equals("admin") || userType.equals("staff")) { %>
        <div class="nelson-nav-extension" id="view-all-customer">
            <table class="nelson-table">
                <tr>
                    <th>Customer ID</th>
                    <th>Name</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Birthdate</th>
                    <th>Balance</th>
                </tr>
                <% CustomerControl customerControl = new CustomerControl(); List<Customer> customers = customerControl.retrieveCustomerALL(); customerControl.destroy(); for (Customer c : customers) { %>
                <tr>
                    <td><%= c.getId() %></td>
                    <td><%= c.getName() %></td>
                    <td><%= c.getUsername() %></td>
                    <td><%= c.getEmail() %></td>
                    <td><%= c.getBirthDate() %></td>
                    <td>RM <%= String.format("%.2f", c.getBalance()) %></td>
                </tr>
                <% } %>
            </table>
            <button class="nelson-button" onclick="extension_toggle('view-all-customer')">Back</button>
        </div>
        <div class="nelson-nav-extension" id="view-all-staff">
            <table class="nelson-table">
                <tr>
                    <th>Staff ID</th>
                    <th>Name</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Contact</th>
                    <th>Birthdate</th>
                </tr>
                <% StaffControl staffControl = new StaffControl(); List<Staff> staffs = staffControl.retrieveStaffALL(); staffControl.destroy(); for (Staff s : staffs) { %>
                <tr>
                    <td><%= s.getId() %></td>
                    <td><%= s.getName() %></td>
                    <td><%= s.getUsername() %></td>
                    <td><%= s.getEmail() %></td>
                    <td><%= s.getContact_number() %></td>
                    <td><%= s.getBirth_date() %></td>
                </tr>
                <% } %>
            </table>
            <button class="nelson-button" onclick="extension_toggle('view-all-staff')">Back</button>
        </div>
    <% } %>
    <div class="container" style="display: none;">
        <% CustomerControl customerControl = new CustomerControl(); %>
        <div class="card">
            <div class="dashboard-icon"><ion-icon name="person-outline"></ion-icon></div>
            <div class="content">
                <a>User Total: <%= customerControl.countTotalCustomer() %></a>
            </div>
            <div>
            <button class="nelson-button" onclick="extension_toggle('register-extension')">Register</button>
            <button class="nelson-button" onclick="extension_toggle('view-all-customer')">View all</button></div>
        </div>
        <% customerControl.destroy(); %>
        <% StaffControl staffControl = new StaffControl(); %>
        <div class="card">
            <div class="dashboard-icon"><ion-icon name="person-circle-outline"></ion-icon></div>
            <div class="content">
                <a>Staff Total: <%= staffControl.countTotalStaff() %></a>
            </div>
            <div>
            <% if (userType.equals("admin")) { %>
            <button class="nelson-button" onclick="extension_toggle('staff-register-extension')">Register</button>
            <% } %>
            <button class="nelson-button" onclick="extension_toggle('view-all-staff')">View all</button></div>
        </div>
        <% staffControl.destroy(); %>
        <% ProductControl productControl = new ProductControl(); %>
        <div class="card">
            <div class="dashboard-icon"><ion-icon name="pricetags-outline"></ion-icon></div>
            <div class="content">
                <a>Total Sold: <%= productControl.countTotalSales() %></a>
            </div>
            <a href="productmgmt.jsp"><button class="nelson-button">Manage products</button></a>
        </div>
        <div class="card">
            <div class="dashboard-icon"><ion-icon name="cash-outline"></ion-icon></div>
            <div class="content">
                <a>Total Earned: RM <%= String.format("%.2f", productControl.countTotalEarned()) %></a>
            </div>
            <button class="nelson-button">View top 10 sales list</button>
        </div>
        <% productControl.destroy(); %>
    </div>
</body>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</html>

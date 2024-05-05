<!DOCTYPE html>
<html>

    <head>
        <title>Dashboard - nelson</title>
        <link rel="shortcut icon" href="src/img/favicon.png">
        <link rel="stylesheet" href="src/css/dashboard.css"/>

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
            <p style="font-size: 10vw;">Dashboard</p>
        </div>
        <%@ include file="navigation.jsp" %>
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
                <% List<Customer> customers = cc.retrieveCustomerALL(); for (Customer c : customers) { %>
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
        <% if (userType.equals("admin")) { %>
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
                <% List<Staff> staffs = sc.retrieveStaffALL(); for (Staff s : staffs) { %>
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
    <% } } %>
    <div class="container" style="display: none;">
        <div class="card">
            <div class="dashboard-icon"><ion-icon name="person-outline"></ion-icon></div>
            <div class="content">
                <a>User Total: <%= cc.countTotalCustomer() %></a>
            </div>
            <div>
            <button class="nelson-button" onclick="extension_toggle('register-extension')">Register</button>
            <button class="nelson-button" onclick="extension_toggle('view-all-customer')">View all</button></div>
        </div>
        <div class="card">
            <div class="dashboard-icon"><ion-icon name="person-circle-outline"></ion-icon></div>
            <div class="content">
                <a>Staff Total: <%= sc.countTotalStaff() %></a>
            </div>
            <div>
            <% if (userType.equals("admin")) { %>
            <button class="nelson-button" onclick="extension_toggle('staff-register-extension')">Register</button>
            <button class="nelson-button" onclick="extension_toggle('view-all-staff')">View all</button>
            <% } %>
            </div>
        </div>
        <div class="card">
            <div class="dashboard-icon"><ion-icon name="pricetags-outline"></ion-icon></div>
            <div class="content">
                <a>Total Sold: <%= pc.countTotalSales() %></a>
            </div>
            <a href="productmgmt.jsp"><button class="nelson-button">Manage products</button></a>
        </div>
        <div class="card">
            <div class="dashboard-icon"><ion-icon name="cash-outline"></ion-icon></div>
            <div class="content">
                <a>Total Earned: RM <%= String.format("%.2f", pc.countTotalEarned()) %></a>
            </div>
            <button class="nelson-button">View top 10 sales list</button>
        </div>
    </div>
</body>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</html>

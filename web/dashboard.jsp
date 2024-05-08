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
        <script src="src/js/dashboard.js"></script>
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
                    <th>Action</th>
                </tr>
                <% List<Customer> customers = cc.retrieveCustomerALL(); for (Customer c : customers) { %>
                <tr>
                    <td><%= c.getId() %></td>
                    <td><%= c.getName() %></td>
                    <td><%= c.getUsername() %></td>
                    <td><%= c.getEmail() %></td>
                    <td><%= c.getBirthDate() %></td>
                    <td>RM <%= String.format("%.2f", c.getBalance()) %></td>
                    <td>
                        <div style="display: flex;">
                            <button class="nelson-button cust-manage" id="cust-edit-<%= c.getId() %>">Edit</button>
                            <button class="nelson-button cust-manage" id="cust-delete-<%= c.getId() %>">Delete</button>
                        </div>
                    </td>
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
                    <th>Action</th>
                </tr>
                <% List<Staff> staffs = sc.retrieveStaffALL(); for (Staff s : staffs) { %>
                <tr>
                    <td><%= s.getId() %></td>
                    <td><%= s.getName() %></td>
                    <td><%= s.getUsername() %></td>
                    <td><%= s.getEmail() %></td>
                    <td><%= s.getContact_number() %></td>
                    <td><%= s.getBirth_date() %></td>
                    <td>
                        <div style="display: flex;">
                            <button class="nelson-button staff-manage" id="staff-edit-<%= s.getId() %>">Edit</button>
                            <button class="nelson-button staff-manage" id="staff-delete-<%= s.getId() %>">Delete</button>
                    </div>
                </tr>
                <% } %>
            </table>
            <button class="nelson-button" onclick="extension_toggle('view-all-staff')">Back</button>
        </div>
        <% } } %>
        <div class="nelson-nav-extension" id="editCustomer">
            <img src="src/img/white/nelson.png" alt="Nelson Logo" class="logo" style="height: 50px; margin: 20px auto;">
            <div class="register-container">
                <h1 class="center">Edit Customer</h1>
                <hr>
                <form id="customerEditForm" action="">
                    <input type="hidden" name="id">
                    <div class="input-field">
                        <label for="name" class="label-with-margin">Name:</label><br>
                        <input autocomplete="off" type="text" name="name" placeholder="Name" class="nelson-input" required><br>
                        <p id="customer-edit-invalid-name" hidden style="color:red;">Username already taken/illegal username.</p>
                    </div>

                    <div class="input-field">
                        <label for="username" class="label-with-margin">Username:</label><br>
                        <input autocomplete="off" type="text" name="username" placeholder="Username" class="nelson-input" required><br>
                        <p id="customer-edit-invalid-username" hidden style="color:red;">Username already taken/illegal username.</p>
                    </div>

                    <div class="input-field">
                        <label for="email" class="label-with-margin">Email:</label><br>
                        <input autocomplete="off" type="email" name="email" placeholder="Email" class="nelson-input" required>
                        <p id="customer-edit-invalid-email" hidden style="color:red;">Invalid email format.</p>
                    </div>

                    <div class="input-field">
                        <label for="birthdate" class="label-with-margin">Birthdate:</label><br>
                        <input autocomplete="off" type="date" name="birthdate" placeholder="Birthdate" class="nelson-input" required>
                        <p id="customer-edit-invalid-birth" hidden style="color:red;">Invalid birth date.</p>
                    </div>
                    <hr>
                    <div class="buttons-field">
                        <button class="nelson-button" onclick="extension_toggle('editCustomer'); remove_edit_cust_reg_error()" type="reset">Cancel</button>
                        <input type="submit" class="nelson-button" value="Edit">
                    </div>
                </form>
            </div>
        </div>
        <div class="nelson-nav-extension" id="editStaff">
            <img src="src/img/white/nelson.png" alt="Nelson Logo" class="logo" style="height: 50px; margin: 20px auto;">
            <div class="register-container">
                <h1 class="center">Edit Staff</h1>
                <hr>
                <form id="staffEditForm" action="">
                    <input type="hidden" name="id">
                    <div class="input-field">
                        <label for="name" class="label-with-margin">Name:</label><br>
                        <input autocomplete="off" type="text" name="name" placeholder="Name" class="nelson-input" required><br>
                        <p id="staff-edit-invalid-name" hidden style="color:red;">Username already taken/illegal username.</p>
                    </div>

                    <div class="input-field">
                        <label for="username" class="label-with-margin">Username:</label><br>
                        <input autocomplete="off" type="text" name="username" placeholder="Username" class="nelson-input" required><br>
                        <p id="staff-edit-invalid-username" hidden style="color:red;">Username already taken/illegal username.</p>
                    </div>

                    <div class="input-field">
                        <label for="email" class="label-with-margin">Email:</label><br>
                        <input autocomplete="off" type="email" name="email" placeholder="Email" class="nelson-input" required>
                        <p id="staff-edit-invalid-email" hidden style="color:red;">Invalid email format.</p>
                    </div>

                    <div class="input-field">
                        <label for="birthdate" class="label-with-margin">Birthdate:</label><br>
                        <input autocomplete="off" type="date" name="birthdate" placeholder="Birthdate" class="nelson-input" required>
                        <p id="staff-edit-invalid-birth" hidden style="color:red;">Invalid birth date.</p>
                    </div>
                    <hr>

                    <div class="input-field">
                        <label for="birthdate" class="label-with-margin">Contact number:</label><br>
                        <input autocomplete="off" type="text" name="contact_number" placeholder="Username" class="nelson-input" required><br>
                        <p id="staff-edit-invalid-contact-number" hidden style="color:red;">Username already taken/illegal username.</p>
                    </div>
                    <hr>

                    <div class="buttons-field">
                        <button class="nelson-button" onclick="extension_toggle('editStaff'); remove_edit_staff_reg_error()" type="reset">Cancel</button>
                        <input type="submit" class="nelson-button" onclick="remove_edit_staff_reg_error()" value="Edit">
                    </div>
                </form>
            </div>
        </div>
        <%
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.YEAR, calendar.getMinimum(Calendar.YEAR));
        long timeInMillis = calendar.getTimeInMillis();
        %>
        <div class="nelson-nav-extension" id="topsales-extension">
            <div id="alltime">
                <table class="nelson-table">
                    <h1>All Time</h1>
                    <tr>
                        <th>#</th>
                        <th>Image</th>
                        <th>Product name</th>
                        <th>Sold</th>
                        <th>Revenue</th>
                    </tr>
                    <% int cnt = 0; List<Sales> sales = pc.generateTop10SalesList(new Date(timeInMillis)); for (Sales s : sales) { %>
                    <tr>
                        <td><%= ++cnt %></td>
                        <td><img src="<%= s.getDisplay_image() %>" style="width: 50px; height: 50px;"></td>
                        <td><%= s.getName() %></td>
                        <td><%= s.getSold() %></td>
                        <td>RM <%= String.format("%.2f", s.getRevenue()) %></td>
                    </tr>
                    <% } %>
                </table>
            </div>
            <!-- year -->
            <% calendar = Calendar.getInstance(); calendar.set(Calendar.YEAR, calendar.get(Calendar.YEAR) - 1); timeInMillis = calendar.getTimeInMillis(); %>
            <div id="lastyear" hidden>
                <table class="nelson-table">
                    <h1>From Last Year</h1>
                    <tr>
                        <th>#</th>
                        <th>Image</th>
                        <th>Product name</th>
                        <th>Sold</th>
                        <th>Revenue</th>
                    </tr>
                    <% cnt = 0; sales = pc.generateTop10SalesList(new Date(timeInMillis)); for (Sales s : sales) { %>
                    <tr>
                        <td><%= ++cnt %></td>
                        <td><img src="<%= s.getDisplay_image() %>" style="width: 50px; height: 50px;"></td>
                        <td><%= s.getName() %></td>
                        <td><%= s.getSold() %></td>
                        <td>RM <%= String.format("%.2f", s.getRevenue()) %></td>
                    </tr>
                    <% } %>
                </table>
            </div>
            <!-- month -->
            <% calendar = Calendar.getInstance(); calendar.set(Calendar.MONTH, calendar.get(Calendar.MONTH) - 1); timeInMillis = calendar.getTimeInMillis(); %>
            <div id="lastmonth" hidden>
                <table class="nelson-table">
                    <h1>From Last Month</h1>
                    <tr>
                        <th>#</th>
                        <th>Image</th>
                        <th>Product name</th>
                        <th>Sold</th>
                        <th>Revenue</th>
                    </tr>
                    <% cnt = 0; sales = pc.generateTop10SalesList(new Date(timeInMillis)); for (Sales s : sales) { %>
                    <tr>
                        <td><%= ++cnt %></td>
                        <td><img src="<%= s.getDisplay_image() %>" style="width: 50px; height: 50px;"></td>
                        <td><%= s.getName() %></td>
                        <td><%= s.getSold() %></td>
                        <td>RM <%= String.format("%.2f", s.getRevenue()) %></td>
                    </tr>
                    <% } %>
                </table>
            </div>
            <!-- week -->
            <% calendar = Calendar.getInstance(); calendar.set(Calendar.WEEK_OF_YEAR, calendar.get(Calendar.WEEK_OF_YEAR) - 1); timeInMillis = calendar.getTimeInMillis(); %>
            <div id="lastweek" hidden>
                <table class="nelson-table">
                    <h1>From Last Week</h1>
                    <tr>
                        <th>#</th>
                        <th>Image</th>
                        <th>Product name</th>
                        <th>Sold</th>
                        <th>Revenue</th>
                    </tr>
                    <% cnt = 0; sales = pc.generateTop10SalesList(new Date(timeInMillis)); for (Sales s : sales) { %>
                    <tr>
                        <td><%= ++cnt %></td>
                        <td><img src="<%= s.getDisplay_image() %>" style="width: 50px; height: 50px;"></td>
                        <td><%= s.getName() %></td>
                        <td><%= s.getSold() %></td>
                        <td>RM <%= String.format("%.2f", s.getRevenue()) %></td>
                    </tr>
                    <% } %>
                </table>
            </div>
            <div id="time-filter">
                <button class="nelson-button" onclick="showTable('alltime')">All Time</button>
                <button class="nelson-button" onclick="showTable('lastyear')">Last Year</button>
                <button class="nelson-button" onclick="showTable('lastmonth')">Last Month</button>
                <button class="nelson-button" onclick="showTable('lastweek')">Last Week</button>
            </div>
            <button class="nelson-button" onclick="extension_toggle('topsales-extension')">Back</button>
        </div>
        <div class="container" style="display: none;">
            <div class="excontainer">
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
                        <a>Total Revenue: RM <%= String.format("%.2f", pc.countTotalEarned()) %></a>
                    </div>
                    <button class="nelson-button" onclick="extension_toggle('topsales-extension')">Generate Top 10 Sales Report</button>
                </div>
            </div>
            <hr>
            <div>
                <a href="ordermgmt.jsp"><button class="nelson-button">Manage Orders</button></a>
            </div>
        </div>
    </body>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</html>

<%
        Customer customer = new Customer();
        Admin admin = new Admin();
        Staff staff = new Staff();
        Cookie[] cookies = request.getCookies();
        int id = -1;
        String session_id = "";
        String userType = "";
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("id")) {
                    id = Integer.parseInt(cookie.getValue());
                } else if (cookie.getName().equals("session")) {
                    session_id = cookie.getValue();
                } else if (cookie.getName().equals("type")) {
                    userType = cookie.getValue();
                }
            }
        }

        boolean isLogin = false; 
        if (id != -1  && !session_id.equals("")) {
        switch(userType) {
            case "customer":
            CustomerControl cc = new CustomerControl();
            customer = cc.verifySession(id, session_id);
            cc.destroy();
            if (customer != null) {
            if (!ALLOW_CUSTOMER) {
        %><script>alert("You are not allowed to view this page.");</script> <%
                return;
            }
                isLogin = true;
            } else {
                for (Cookie cookie : cookies) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
                if (!ALLOW_GUEST) {
        %><script>alert("You are not allowed to view this page.");</script> <%
                    return;
                }
            }
            break;
            case "admin":
            AdminControl ac = new AdminControl();
            admin = ac.verifySession(id, session_id);
            ac.destroy();
            if (admin != null) {
            if (!ALLOW_ADMIN) {
        %><script>alert("You are not allowed to view this page.");</script> <%
                return;
            }
                isLogin = true;
            } else {
                for (Cookie cookie : cookies) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
                if (!ALLOW_GUEST) {
        %><script>alert("You are not allowed to view this page.");</script> <%
                    return;
                }
            }
            break;
            case "staff":
            StaffControl sc = new StaffControl();
            staff = sc.verifySession(id, session_id);
            sc.destroy();
            if (staff != null) {
            if (!ALLOW_STAFF) {
        %><script>alert("You are not allowed to view this page.");</script> <%
                return;
            }
            if (staff.getPassword().equals("$taff123")) {
        %><script>alert("Your password is a default password, please change it as soon as possible.");</script> <%
            }
                isLogin = true;
            } else {
                for (Cookie cookie : cookies) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
                if (!ALLOW_GUEST) {
        %><script>alert("You are not allowed to view this page.");</script> <%
                    return;
                }
            }
            break;
            default:
            break;
            }
            
        } else {
            if (!ALLOW_GUEST) {
        %><script>alert("You are not allowed to view this page.");</script> <%
                return;
            }
        }
            CategoryControl categoryControl = new CategoryControl();
            List<Category> categories = categoryControl.retrieveCategory();
            categoryControl.destroy();
        %>
        <div class="navigation-bar">
            <div id="navigation-container">
                <a href="/Web_HomeAppliances" class="has-image"><img class="left logo" id="inelson"
                                                                     src="src/img/white/nelson.png" style="height:60%;"></a>
                <a href="/Web_HomeAppliances/explore.jsp" class="left">Explore</a>
                <div class="left dropdown">
                    <a href="#" class="left dropbtn" onclick="extension_toggle('category-extension')">Category</a>
                    <div class="dropdown-content">
                        <%
                            int categoryCount = 0;
                            for (Category category : categories) {
                                categoryCount++;
                                if (categoryCount > 5) {
                                    break;
                                }
                        %>
                        <a href="/Web_HomeAppliances/search.jsp?category_id=<%= category.getId() %>"><%= category.getName() %></a>
                        <%
                            }
                            if (categories.size() != categoryCount) {
                        %>
                        <a href="#" onclick="extension_toggle('category-extension')">More...</a>
                        <%
                            }
                        %>
                    </div>
                </div>
                <% if (userType.equals("customer")) { %>
                <a href="#" class="left" onclick="extension_toggle('feedback-extension')">Feedback</a>
                <% } %>
                <div class="right profile-dropdown">
                    <a href="#" class="has-image"><img class="right icon" id="iprofile" src="src/img/white/user.svg"
                                                       style="height:60%;" alt="Profile"></a>
                        <%
                             if (!isLogin) {
                        %>
                    <div class="profile-dropdown-content login">
                        <div class="profile-dropdown-content-container">
                            <div class="profile-dropdown-content-container-header center">
                                <img src="src/img/white/user.svg" alt="Profile">
                            </div>
                            <h1 style="text-align: center;">Login</h1>
                            <div class="profile-dropdown-content-container-body">
                                <form class="login-form" action="/Web_HomeAppliances/Login" method="post">
                                    <input type="text" placeholder="Username" name="username" required
                                           autocomplete="off">
                                    <input type="password" placeholder="Password" name="password" required>
                                    <p class="invalid-login" style="display: none; color: red;">Invalid login credentials.</p>
                                    <button type="submit" class="nelson-button nomarginlr">Login</button>
                                </form>
                                <hr>
                                <div class="profile-dropdown-content-container-body-register">
                                    <p>Don't have an account?</p>
                                    <button class="nelson-button nomarginlr" onclick="extension_toggle('register-extension')">Register</button>

                                </div>
                            </div>
                        </div>
                    </div>
                    <% } else { %>
                    <div class="profile-dropdown-content">
                        <div class="profile-dropdown-content-container">
                            <div class="profile-dropdown-content-container-header">
                                <div class="center">
                                    <img src="src/img/white/user.svg" alt="Profile"><br>
                                </div>
                                <div class="center">
                                    <h1 id="profile-name">
                                        <% switch (userType) {
                                            case "customer": %>
                                        <%= customer.getName() %>
                                    </h1>
                                </div>
                                <h3 class="center" style="margin-top:0;" id="my-balance">Balance: RM <%= String.format("%.2f", customer.getBalance()) %></h3>
                                <% break;
                                case "admin": %>
                                <%= admin.getName() %>
                                <% break; case "staff":%>
                                <%= staff.getName() %>
                                <% break; default: break; } %>
                            </div>
                            <hr>
                            <div class="profile-dropdown-content-container-body">
                                <% if (!userType.equals("admin") && !userType.equals("staff")) { %>
                                <div class="profile-dropdown-content-container-body-anchor">
                                    <a href="#" onclick="extension_toggle('profile-extension')">My profile</a>
                                </div>
                                <hr>
                                <% if (userType.equals("customer")) {%>
                                <div class="profile-dropdown-content-container-body-anchor">
                                    <a href="#" onclick="extension_toggle('topup-extension')">Top up</a>
                                </div>
                                <hr>
                                <div class="profile-dropdown-content-container-body-anchor">
                                    <a href="/Web_HomeAppliances/order.jsp">My orders</a>
                                </div>
                                <hr>
                                <% }} else {
                                    if (userType.equals("staff")) { %>

                                <div class="profile-dropdown-content-container-body-anchor">
                                    <a href="#" onclick="extension_toggle('profile-extension')">My profile</a>
                                </div>
                                <hr>
                                <% } %>
                                <div class="profile-dropdown-content-container-body-anchor">
                                    <a href="/Web_HomeAppliances/dashboard.jsp">Dashboard</a>
                                </div>
                                <hr>
                                <div class="profile-dropdown-content-container-body-anchor">
                                    <a href="/Web_HomeAppliances/control.jsp">Control Panel</a>
                                </div>
                                <hr>
                                <% } %>
                                <div class="profile-dropdown-content-container-body-anchor">
                                    <a href="/Web_HomeAppliances/Logout" id="log-out">Logout</a>
                                </div>
                            </div>
                            <hr>
                        </div>
                    </div>
                    <% } %>
                </div>
                <% if (userType.equals("customer")) { %>
                <div class="right cart-dropdown">
                    <a href="#" class="has-image"><img class="right icon" id="icart" src="src/img/white/shopping-cart.svg"
                                                       style="height:60%;" alt="My cart"></a>
                    <div class="cart-dropdown-content">
                        <div class="cart-dropdown-content-container">
                            <div class="cart-dropdown-content-container-header">
                                <h1>My Cart</h1>
                                <div>
                                    <button class="right cart-dropdown-content-container-header-clear nelson-button">Checkout</button>
                                </div>
                            </div>
                            <div class="cart-dropdown-content-container-body">
                                <div class="cart-q">
                                    <div class="cart-item">
                                        <img class="cart-item-image" src="src/img/selipar.webp">
                                        <div class="cart-item-text">
                                            <h2>Selipar
                                            </h2>
                                            <div class="cart-add-remove">
                                                <button class="nelson-button">-</button>
                                                <input type="number" value="1" class="cart-quantity">
                                                <button class="nelson-button">+</button>
                                                <button id="cart-rem" class="nelson-button">Remove</button>
                                            </div>
                                            <p class="cart-item-text-price">RM 10.00</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <% } if (isLogin) { %>
                <div class="right noti-dropdown">
                    <a href="#" class="has-image"><img class="right icon" id="inoti" src="src/img/white/bell.svg"
                                                       style="height:60%;" alt="Notifications"></a>
                    <div class="noti-dropdown-content">
                        <div class="noti-dropdown-content-container">
                            <div class="noti-dropdown-content-container-header">
                                <h1 id="insert-noti-count">Notifications </h1>
                            </div>
                            <div class="noti-dropdown-content-container-header">
                                <div class="noti-dropdown-content-container-buttons">
                                    <button class="left nelson-button" id="noti-order">Order</button>
                                    <button class="left nelson-button" id="noti-convo">Conversation</button>
                                    <button class="right nelson-button" id="noti-clear">Clear</button>
                                    <button class="right nelson-button" id="noti-showall">Show all</button>
                                </div>
                            </div>
                            <div>
                            </div>
                            <div class="noti-dropdown-content-container-body">
                                <div class="noti-q">
                                    <div class="noti-item"> <!-- src/img/selipar.webp -->
                                        <img class="noti-item-image" src="src/img/selipar.webp">
                                        <div class="noti-item-text">
                                            <h2>Selipar
                                            </h2>
                                            <p>On the way to your face.
                                                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean non
                                                porttitor tortor, at mollis tortor.</p>
                                            <p class="noti-item-text-time">2 minutes ago</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
                <form class="search-container right" method="get" action="search.jsp">
                    <input type="text" placeholder="Search.." name="search" class="search-nelson" autocomplete="off" required>
                    <button type="submit" class="right search-btn" ></button>
                </form>
            </div>
        </div>
        <% if (userType.equals("admin") || userType.equals("staff")) { %>
    </div>
    <% } %>
    <div class="nelson-nav-extension" id="topup-extension">
        <img src="src/img/white/nelson.png" alt="Nelson Logo" style="margin-top:20px;height: 50px;">
        <br>
        <div class="topup-container">
            <header class="topup-header">
                <h1 id="topup-title">Top Up</h1>
            </header>
            <div class="balance" id="topup-current-balance">Current Balance: RM <%= String.format("%.2f", customer.getBalance()) %></div>
            <hr>
            <form id="topup-form">
                <input type="text" name="amount" id="topup-amount" value="0" hidden>
                <h2 id="topup-prompt-title">Top Up Amount</h2>
                <div class="amount-buttons">
                    <button type="button" class="nelson-button" value="10">RM 10</button>
                    <button type="button" class="nelson-button" value="20">RM 20</button>
                    <button type="button" class="nelson-button" value="50">RM 50</button>
                    <button type="button" class="nelson-button" value="100">RM 100</button>
                    <button type="button" class="nelson-button" value="200">RM 200</button>
                    <button type="button" class="nelson-button" value="500">RM 500</button>
                    <button type="button" class="nelson-button" value="1000">RM 1000</button>
                    <button type="button" class="nelson-button" value="2000">RM 2000</button>
                </div>
                <div class="selected-amount">
                    Selected Amount: <span id="displayedAmount">RM 0</span>
                </div>
                <p id="topup-invalid-amount" style="color: red;" hidden>Invalid</p>
                <hr>
                <h2>Payment</h2>
                <div class="input-field">
                    <p class="form-p">Select card:</p>
                    <select class="nelson-select" name="card_id" id="topup-card-select">
                        <option value="0">Select card</option>
                        <%
                            CardControl cardControl = new CardControl();
                            List<Card> cards = cardControl.retrieveCards(customer.getId());
                            cardControl.destroy();
                            for (Card c : cards) {
                        %>
                        <option value="<%= c.getId() %>"><%= c.getName() %> <%= c.getCard_number().substring(0, 4) %>-XXXX-XXXX-XXXX</option>
                        <%
                            }
                        %>
                    </select>
                    <button type="button" class="nelson-button" onclick="extension_toggle('profile-extension'); $('#profile-payment').click(); $('#add-card').click();">Add card</button>
                    <button type="button" class="nelson-button" id="topup-card-refresh">Refresh</button>
                </div>
                <p id="topup-invalid-card" style="color: red;" hidden>Invalid</p>
                <hr>
                <button type="reset" class="nelson-button" onclick="extension_toggle('topup-extension'); $('#displayedAmount').text(`RM 0`);">Cancel</button>
                <button type="submit" class="nelson-button">Top Up</button>
            </form>
            <hr>
            <footer>
                &copy; 2024 Nelson Home Appliances. All rights reserved.
            </footer>
        </div>
    </div>
    <div class="nelson-nav-extension" id="register-extension">
        <img src="src/img/white/nelson.png" alt="Nelson Logo" class="logo" style="height: 50px; margin: 20px auto;">
        <div class="register-container">
            <h1 class="center">Registration</h1>
            <hr>
            <form id="registrationForm" action="">
                <div class="input-field">
                    <label for="name" class="label-with-margin">Name:</label><br>
                    <input autocomplete="off" type="text" name="name" placeholder="Name" class="nelson-input" required><br>
                    <p id="invalid-name" class="hidden" style="color:red;">Username already taken/illegal username.</p>
                </div>

                <div class="input-field">
                    <label for="username" class="label-with-margin">Username:</label><br>
                    <input autocomplete="off" type="text" name="username" placeholder="Username" class="nelson-input" required><br>
                    <p id="invalid-username" class="hidden" style="color:red;">Username already taken/illegal username.</p>
                </div>

                <div class="input-field">
                    <label for="email" class="label-with-margin">Email:</label><br>
                    <input autocomplete="off" type="email" name="email" placeholder="Email" class="nelson-input" required>
                    <p id="invalid-email" class="hidden" style="color:red;">Invalid email format.</p>
                </div>

                <div class="input-field">
                    <label for="password" class="label-with-margin">Password:</label><br>
                    <input autocomplete="off" type="password" name="password" placeholder="Password" class="nelson-input" required>
                    <p id="invalid-password" class="hidden" style="color:red;">Password mismatch.</p>
                </div>

                <div class="input-field">
                    <label for="cpassword" class="label-with-margin">Confirm password:</label><br>
                    <input autocomplete="off" type="password" name="cpassword" placeholder="Confirm password" class="nelson-input" required>
                    <p id="invalid-password-confirm" class="hidden" style="color:red;">Password mismatch.</p>
                </div>

                <div class="input-field">
                    <label for="birthdate" class="label-with-margin">Birthdate:</label><br>
                    <input autocomplete="off" type="date" name="birthdate" placeholder="Birthdate" class="nelson-input" required>
                    <p id="invalid-birth" class="hidden" style="color:red;">Invalid birth date.</p>
                </div>
                <hr>
                <div class="input-field">
                    <label><input autocomplete="off" type="checkbox" name="term" id="term"> I agree that the above information is correct</label>
                    <p id="invalid-term" class="hidden" style="color:red;">Please agree to above information.</p>
                </div>

                <div class="buttons-field">
                    <button id="customer-cancel" class="nelson-button" onclick="extension_toggle('register-extension'); remove_reg_error()" type="reset">Cancel</button>
                    <input type="submit" class="nelson-button" onclick="remove_reg_error()" value="Register">
                </div>
            </form>
        </div>
    </div>
    <% if (userType.equals("admin")) { %>
    <div class="nelson-nav-extension" id="staff-register-extension">
        <img src="src/img/white/nelson.png" alt="Nelson Logo" class="logo" style="height: 50px; margin: 20px auto;">
        <div class="register-container">
            <h1 class="center">Staff Registration</h1>
            <hr>
            <form id="staffRegistrationForm" action="">
                <input type="password" value="$taff123" name="password" hidden>
                <div class="input-field">
                    <label for="name" class="label-with-margin">Name:</label><br>
                    <input autocomplete="off" type="text" name="name" placeholder="Name" class="nelson-input" required><br>
                    <p id="staff-invalid-name" class="hidden" style="color:red;">Username already taken/illegal username.</p>
                </div>

                <div class="input-field">
                    <label for="username" class="label-with-margin">Username:</label><br>
                    <input autocomplete="off" type="text" name="username" placeholder="Username" class="nelson-input" required><br>
                    <p id="staff-invalid-username" class="hidden" style="color:red;">Username already taken/illegal username.</p>
                </div>

                <div class="input-field">
                    <label for="email" class="label-with-margin">Email:</label><br>
                    <input autocomplete="off" type="email" name="email" placeholder="Email" class="nelson-input" required>
                    <p id="staff-invalid-email" class="hidden" style="color:red;">Invalid email format.</p>
                </div>

                <div class="input-field">
                    <label for="phone" class="label-with-margin">Phone number:</label><br>
                    <input autocomplete="off" type="tel" name="contact_number" placeholder="Phone number" class="nelson-input" required>
                    <p id="staff-invalid-phone" class="hidden" style="color:red;">Invalid phone format.</p>
                </div>

                <div class="input-field">
                    <label for="birthdate" class="label-with-margin">Birthdate:</label><br>
                    <input autocomplete="off" type="date" name="birthdate" placeholder="Birthdate" class="nelson-input" required>
                    <p id="staff-invalid-birth" class="hidden" style="color:red;">Invalid birth date.</p>
                </div>
                <hr>

                <div class="buttons-field">
                    <button id="staff-cancel" class="nelson-button" onclick="extension_toggle('staff-register-extension'); remove_staff_error()" type="reset">Cancel</button>
                    <input type="reset" id="staff-reg-reset" hidden>
                    <input type="submit" class="nelson-button" onclick="remove_staff_error()" value="Register">
                </div>
            </form>
        </div>
    </div>
    <% } %>
    <div class="nelson-nav-extension" id="category-extension">
        <img src="src/img/white/nelson.png" alt="Nelson Logo" class="logo" style="height: 50px; margin: 20px auto;">
        <div class="category-more-container">
            <div class="category-more-container-header">
                <h1>List of Categories</h1>
            </div>
            <hr>
            <div class="category-more-container-body">
                <%
                    for (Category category : categories) {
                %>
                <a href="/Web_HomeAppliances/search.jsp?category_id=<%= category.getId() %>" id="cat-<%= category.getId() %>"><button class="nelson-button"><%= category.getName() %></button></a>
                    <%
                        }
                    %>
            </div>
            <hr>
            <% if (userType.equals("admin") || userType.equals("staff")) { %>
            <button class="nelson-button" onclick="extension_toggle('manage-category-extension')">Manage</button>
            <% } %>
            <button class="nelson-button" onclick="extension_toggle('category-extension')">Back</button>
        </div>
    </div>
    <div class="nelson-nav-extension" id="feedback-extension">
        <img src="src/img/white/nelson.png" alt="Nelson Logo" class="logo" style="height: 50px; margin: 20px auto;">
        <div class="feedback-container">
            <h1 class="center">Feedback Form</h1>
            <hr>
            <form id="feedbackForm">
                <div class="input-field">
                    <p class="form-p">Title for issue:</p>
                    <input autocomplete="off" type="text" name="issue_title" placeholder="Eg: Unable to view products" class="nelson-input center" required>
                </div>

                <div class="input-field">
                    <p class="form-p">Issue description</p>
                    <textarea autocomplete="off" name="issue_description" placeholder="Please describe the issue you are facing" class="big-nelson-input" rows="10" required></textarea>
                </div>
                <hr>
                <div class="buttons-field">
                    <button class="nelson-button" id="feedbackCancel" onclick="extension_toggle('feedback-extension')" type="reset">Cancel</button>
                    <input type="submit" class="nelson-button" value="Submit">
                </div>
            </form>
        </div>
    </div>
    <div class="nelson-nav-extension" id="profile-extension">
        <img src="src/img/white/nelson.png" alt="Nelson Logo" class="logo" style="height: 50px; margin: 20px auto;">
        <div class="profile-container">
            <h1 class="left">My Profile</h1>
            <button class="nelson-button right" onclick="extension_toggle('profile-extension'); $('#profile-alter-pw-reset').click()">Back</button>
            <div id="edit-panel">
                <button class="nelson-button right" id="ext-profile-edit-pw" onclick="togglePasswordForm()">Edit password</button>
                <button class="nelson-button right hidden" id="ext-profile-done" onclick="$('#profile-alter').click()">Done</button>
                <button class="nelson-button right hidden" id="ext-profile-cancel" onclick="edit_profile()">Cancel</button>
                <button class="nelson-button right hidden" id="ext-profile-pw-done" onclick="$('#profile-alter-pw').click()">Done</button>
                <button class="nelson-button right hidden" id="ext-profile-pw-cancel" onclick="togglePasswordForm()">Cancel</button>
                <button class="nelson-button right" id="ext-profile-edit" onclick="edit_profile()">Edit</button>
            </div>
            <div id="card-panel" hidden>
                <div id="card-edit-panel" hidden>
                    <button class="nelson-button right" id="ext-card-edit-done" onclick="$('#card-alter').click()">Done</button>
                    <button class="nelson-button right" id="ext-card-edit-cancel">Cancel</button>
                </div>
                <div id="card-add-panel" hidden>
                    <button class="nelson-button right" id="ext-card-add-done" onclick="$('#card-insert').click()">Done</button>
                    <button class="nelson-button right" id="ext-card-add-cancel" onclick="$('#card-insert-reset').click()">Cancel</button>
                </div>
            </div>
            <div id="address-panel" hidden>
                <div id="address-edit-panel" hidden>
                    <button class="nelson-button right" id="ext-address-edit-done" onclick="$('#address-alter').click()">Done</button>
                    <button class="nelson-button right" id="ext-address-edit-cancel">Cancel</button>
                </div>
                <div id="address-add-panel" hidden>
                    <button class="nelson-button right" id="ext-address-add-done" onclick="$('#address-insert').click()">Done</button>
                    <button class="nelson-button right" id="ext-address-add-cancel" onclick="$('#address-insert-reset').click()">Cancel</button>
                </div>
            </div>
            <hr>
            <div class="profile-content">
                <div class="ext-left-profile">
                    <img src="src/img/white/user.svg" alt="Profile" class="center profile-ext-img" style="height: 200px;">
                    <h2><%= userType.equals("customer") ? customer.getName() :  staff.getName() %></h2>
                    <h3><%= userType.equals("") ? "Guest" : (userType.substring(0, 1).toUpperCase() + userType.substring(1)) %></h3>
                    <p><a href="#" class="ext-profile-select ext-profile-selected" id="profile-info">User information</a></p>
                    <% if (userType.equals("customer")) { %>
                    <p><a href="#" class="ext-profile-select" id="profile-orders">Orders</a></p>
                    <p><a href="#" class="ext-profile-select" id="profile-payment">Cards</a></p>
                    <p><a href="#" class="ext-profile-select" id="profile-shipping">Shipping address</a></p>
                    <% } %>
                </div>
                <div id="ext-profile">
                    <% switch(userType) {
                            case "customer": %>
                    <form method="post" id="profileForm">
                        <div class="input-field">
                            <p class="form-p">Name:</p>
                            <input id="cust-profile-name" autocomplete="off" type="text" name="name" placeholder="<%= customer.getName() %>" value="<%= customer.getName() %>" class="nelson-input toggle-input" required disabled><br>
                            <p id="profile-invalid-name" class="hidden" style="color:red;">Username already taken/illegal username.</p>
                        </div>
                        <div class="input-field">
                            <p class="form-p">Username:</p>
                            <input autocomplete="off" id="profile-username" type="text" name="username" placeholder="<%= customer.getUsername() %>" value="<%= customer.getUsername() %>" class="nelson-input toggle-input" required disabled><br>
                        </div>
                        <div class="input-field">
                            <p class="form-p">Email:</p>
                            <input id="cust-profile-email" autocomplete="off" type="email" name="email" placeholder="<%= customer.getEmail() %>" value="<%= customer.getEmail() %>" class="nelson-input toggle-input" required disabled>
                            <p id="profile-invalid-email" class="hidden" style="color:red;">Invalid email format.</p>
                        </div>
                        <div class="input-field">
                            <p class="form-p">Birthdate:</p>
                            <input id="cust-profile-birth" autocomplete="off" type="date" name="birthdate" value="<%= customer.getBirthDate() %>" value="<%= customer.getBirthDate() %>" class="nelson-input toggle-input" required disabled>
                            <p id="profile-invalid-birth" class="hidden" style="color:red;">Invalid birth date.</p>
                        </div>
                        <div class="input-field profile-edit-show hidden">
                            <p class="form-p">Confirm password:</p>
                            <input autocomplete="off" type="password" name="password" placeholder="Verify if it is really you" class="nelson-input toggle-input" required disabled>
                            <p id="profile-invalid-password" class="hidden" style="color:red;">Password mismatch.</p>
                        </div>
                        <hr>
                        <% break;
                            case "staff": %>
                        <form method="post" id="staffProfileForm">
                            <div class="input-field">
                                <p class="form-p">Name:</p>
                                <input id="staff-profile-name" autocomplete="off" type="text" name="name" placeholder="<%= staff.getName() %>" value="<%= staff.getName() %>" class="nelson-input toggle-input" required disabled><br>
                                <p id="profile-invalid-name" class="hidden" style="color:red;">Username already taken/illegal username.</p>
                            </div>
                            <div class="input-field">
                                <p class="form-p">Username:</p>
                                <input id="staff-profile-username" autocomplete="off" id="profile-username" type="text" name="username" placeholder="<%= staff.getUsername() %>" value="<%= staff.getUsername() %>" class="nelson-input toggle-input" required disabled><br>
                            </div>
                            <div class="input-field">
                                <p class="form-p">Email:</p>
                                <input id="staff-profile-email" autocomplete="off" type="email" name="email" placeholder="<%= staff.getEmail() %>" value="<%= staff.getEmail() %>" class="nelson-input toggle-input" required disabled>
                                <p id="profile-invalid-email" class="hidden" style="color:red;">Invalid email format.</p>
                            </div>
                            <div class="input-field">
                                <p class="form-p">Contact:</p>
                                <input id="staff-profile-phone" autocomplete="off" type="tel" name="contact_number" placeholder="<%= staff.getContact_number() %>" value="<%= staff.getContact_number() %>" class="nelson-input toggle-input" required disabled>
                                <p id="profile-invalid-phone" class="hidden" style="color:red;">Invalid email format.</p>
                            </div>
                            <div class="input-field">
                                <p class="form-p">Birthdate:</p>
                                <input id="staff-profile-birth" autocomplete="off" type="date" name="birthdate" value="<%= staff.getBirth_date() %>" value="<%= staff.getBirth_date() %>" class="nelson-input toggle-input" required disabled>
                                <p id="profile-invalid-birth" class="hidden" style="color:red;">Invalid birth date.</p>
                            </div>
                            <div class="input-field profile-edit-show hidden">
                                <p class="form-p">Confirm password:</p>
                                <input autocomplete="off" type="password" name="password" placeholder="Verify if it is really you" class="nelson-input toggle-input" required disabled>
                                <p id="profile-invalid-password" class="hidden" style="color:red;">Password mismatch.</p>
                            </div>
                            <hr>
                            <% break; } %>
                            <input type="submit" id="profile-alter" hidden>
                        </form>
                        <% if (userType.equals("customer")) { %>
                        <form method="post" id="profilePasswordForm" hidden>
                            <% } else { %>
                            <form method="post" id="staffProfilePasswordForm" hidden>
                                <% } %>
                                <div class="profile-edit-show">
                                    <div class="input-field">
                                        <p class="form-p">Old password:</p>
                                        <input autocomplete="off" type="password" name="opassword" placeholder="Enter old password" class="nelson-input toggle-input-pw" required>
                                        <p id="invalid-password-old" class="hidden" style="color:red;">Password mismatch.</p>
                                    </div>
                                    <div class="input-field">
                                        <p class="form-p">New password:</p>
                                        <input autocomplete="off" type="password" name="password" placeholder="Enter new password" class="nelson-input toggle-input-pw" required>
                                        <p id="invalid-password-new" class="hidden" style="color:red;">Password mismatch.</p>
                                    </div>
                                    <div class="input-field">
                                        <p class="form-p">Confirm password:</p>
                                        <input autocomplete="off" type="password" name="cpassword" placeholder="Re-enter new password" class="nelson-input toggle-input-pw" required>
                                        <p id="invalid-password-confirm-ii" class="hidden" style="color:red;">Password mismatch.</p>
                                    </div>
                                </div>
                                <input type="submit" id="profile-alter-pw" hidden>
                                <input type="reset" id="profile-alter-pw-reset" hidden>
                            </form>
                            </div>
                            <% if (userType.equals("customer")) { %>
                            <div id="ext-payment" style="display: none">
                                <div class="list-div">
                                    <h2>List of cards:</h2>
                                    <div class="payment-method-list">
                                        <% for (Card c : cards) { %>
                                        <div class="payment-method" id="<%= c.getId() %>">
                                            <img src="src/img/white/credit-card.svg" alt="card" class="left card-logo" style="height: 30px;">
                                            <p class="card-info" id="<%= c.getId() %>"><%= c.getName() %> <%= c.getCard_number().substring(0, 4) %>-XXXX-XXXX-XXXX</p>
                                            <div class="card-dropdown" id="<%= c.getId() %>">
                                                <img src="src/img/white/more-horizontal.svg" alt="more" class="right pay-extend-img" style="height: 30px;">
                                                <div class="card-dropdown-content" id="<%= c.getId() %>">
                                                    <a href="#" class="card-edit-button" id="<%= c.getId() %>">Edit</a>
                                                    <a href="#" class="card-delete-button" id="<%= c.getId() %>">Delete</a>
                                                </div>
                                            </div>
                                        </div>
                                        <hr style="margin:0" id="<%= c.getId() %>">
                                        <% } %>
                                        <div class="payment-method" id="add-card">
                                            <p>Add more...</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-edit" hidden>
                                    <form method="post" id="cardEditForm">
                                        <input type="password" name="password" hidden>
                                        <input type="text" name="card_id" id="alter-card-id" hidden>
                                        <div class="input-field">
                                            <p class="form-p">Cardholder's Name:</p>
                                            <input autocomplete="off" id="alter-card-name" type="text" name="name" placeholder="Enter cardholder's name" class="nelson-input" required><br>
                                            <p id="alter-card-invalid-name" class="hidden" style="color:red;">Invalid card name.</p>
                                        </div>
                                        <div class="input-field">
                                            <p class="form-p">Card Number:</p>
                                            <input autocomplete="off" id="alter-card-number" type="text" name="card_number" placeholder="Enter card number" class="nelson-input" required><br>
                                            <p id="alter-card-invalid-number" class="hidden" style="color:red;">Invalid card number.</p>
                                        </div>
                                        <div class="input-field">
                                            <p class="form-p">ExpiryDate (MM/YY):</p>
                                            <input autocomplete="off" id="alter-card-expiry-date" type="text" name="expiry_date" placeholder="Enter expiry date" class="nelson-input" required><br>
                                            <p id="alter-card-invalid-expiry" class="hidden" style="color:red;">Invalid expiry date.</p>
                                        </div>
                                        <div class="input-field">
                                            <p class="form-p">CVV:</p>
                                            <input autocomplete="off" id="alter-card-cvv" type="text" name="cvv" placeholder="Enter CVV" class="nelson-input" required><br>
                                            <p id="alter-card-invalid-cvv" class="hidden" style="color:red;">Invalid cvv.</p>
                                        </div>
                                        <input type="submit" id="card-alter" hidden>
                                    </form>
                                </div>
                                <div class="card-add" hidden>
                                    <form method="post" id="cardAddForm">
                                        <input type="password" name="password" hidden>
                                        <div class="input-field">
                                            <p class="form-p">Cardholder's Name:</p>
                                            <input autocomplete="off" id="add-card-name" type="text" name="name" placeholder="Enter cardholder's name" class="nelson-input" required><br>
                                            <p id="add-card-invalid-name" class="hidden" style="color:red;">Invalid card name.</p>
                                        </div>
                                        <div class="input-field">
                                            <p class="form-p">Card Number:</p>
                                            <input autocomplete="off" id="add-card-number" type="text" name="card_number" placeholder="Enter card number" class="nelson-input" required><br>
                                            <p id="add-card-invalid-number" class="hidden" style="color:red;">Invalid card number.</p>
                                        </div>
                                        <div class="input-field">
                                            <p class="form-p">ExpiryDate (MM/YY):</p>
                                            <input autocomplete="off" id="add-card-expiry-date" type="text" name="expiry_date" placeholder="Enter expiry date" class="nelson-input" required><br>
                                            <p id="add-card-invalid-expiry" class="hidden" style="color:red;">Invalid expiry date.</p>
                                        </div>
                                        <div class="input-field">
                                            <p class="form-p">CVV:</p>
                                            <input autocomplete="off" id="add-card-cvv" type="text" name="cvv" placeholder="CVV" class="nelson-input" required><br>
                                            <p id="add-card-invalid-cvv" class="hidden" style="color:red;">Invalid cvv.</p>
                                        </div>
                                        <input type="submit" id="card-insert" hidden>
                                        <input type="reset" id="card-insert-reset" hidden>
                                    </form>
                                </div>
                            </div>
                            <div id="ext-order" style="display: none">
                                <p>hello world 3</p>
                            </div>
                            <div id="ext-shipping" style="display: none">
                                <div class="list-addr-div">
                                    <h2>List of shipping address:</h2>
                                    <div class="shipping-address-list">
                                        <% AddressControl addrControl = new AddressControl(); List<Address> addresses = addrControl.retrieveAddresses(customer.getId()); addrControl.destroy(); for (Address c : addresses) { %>
                                        <div class="shipping-address" id="<%= c.getId() %>">
                                            <p class="addr-info" id="<%= c.getId() %>"><%= c.getRecipient_name() + " " + c.getContact_number() + " " + c.getAddress() + " " + (c.getAddress_2() == null ? "" : c.getAddress_2()) + " " + c.getCity() + " " + c.getState() + " " + c.getZip_code() %></p>
                                            <div class="addr-dropdown" id="<%= c.getId() %>">
                                                <img src="src/img/white/more-horizontal.svg" alt="more" class="right ship-extend-img" style="height: 30px;">
                                                <div class="address-dropdown-content" id="<%= c.getId() %>">
                                                    <a href="#" class="address-edit-button" id="<%= c.getId() %>">Edit</a>
                                                    <a href="#" class="address-delete-button" id="<%= c.getId() %>">Delete</a>
                                                </div>
                                            </div>
                                        </div>
                                        <hr style="margin:0" id="<%= c.getId() %>">
                                        <% } %>
                                        <div class="shipping-address" id="add-address">
                                            <p>Add more...</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="address-edit" hidden>
                                    <form method="post" id="addressEditForm">
                                        <input type="password" name="password" hidden>
                                        <input type="text" name="id" id="alter-address-id" hidden>
                                        <div class="input-field">
                                            <p class="form-p">Recipient's Name:</p>
                                            <input autocomplete="off" id="alter-recipient-name" type="text" name="name" placeholder="Enter recipient's name" class="nelson-input" required><br>
                                            <p id="alter-recipient-invalid-name" class="hidden" style="color:red;">Invalid recipient's name.</p>
                                        </div>
                                        <div class="input-field">
                                            <p class="form-p">Recipient's Phone Number:</p>
                                            <input autocomplete="off" id="alter-recipient-number" type="text" name="contact_number" placeholder="Enter recipient's phone number" class="nelson-input" required><br>
                                            <p id="alter-recipient-invalid-number" class="hidden" style="color:red;">Invalid recipient's phone number.</p>
                                        </div>
                                        <div class="input-field">
                                            <p class="form-p">Address:</p>
                                            <input autocomplete="off" id="alter-address-form" type="text" name="address" placeholder="Enter expiry date" class="nelson-input" required><br>
                                            <p id="alter-address-invalid" class="hidden" style="color:red;">Invalid address.</p>
                                        </div>
                                        <div class="input-field">
                                            <p class="form-p">Address Line 2 (Optional):</p>
                                            <input autocomplete="off" id="alter-address-two" type="text" name="address_2" placeholder="Address line 2 (optional)" class="nelson-input"><br>
                                            <p id="alter-address-two-invalid" class="hidden" style="color:red;">Invalid address.</p>
                                        </div>
                                        <div class="input-field">
                                            <p class="form-p">City:</p>
                                            <input autocomplete="off" id="alter-city" type="text" name="city" placeholder="Enter city" class="nelson-input" required><br>
                                            <p id="alter-address-invalid-city" class="hidden" style="color:red;">Invalid address.</p>
                                        </div>
                                        <div class="input-field">
                                            <p class="form-p">State:</p>
                                            <input autocomplete="off" id="alter-state" type="text" name="state" placeholder="State" class="nelson-input" required><br>
                                            <p id="alter-address-invalid-state" class="hidden" style="color:red;">Invalid address.</p>
                                        </div>
                                        <div class="input-field">
                                            <p class="form-p">Zip Code:</p>
                                            <input autocomplete="off" id="alter-zip" type="text" name="zip_code" placeholder="Enter zip code" class="nelson-input" required><br>
                                            <p id="alter-address-invalid-zip" class="hidden" style="color:red;">Invalid address.</p>
                                        </div>
                                        <input type="submit" id="address-alter" hidden>
                                    </form>
                                </div>
                                <div class="address-add" hidden>
                                    <form method="post" id="addressAddForm">
                                        <input type="password" name="password" hidden>
                                        <div class="input-field">
                                            <p class="form-p">Recipient's Name:</p>
                                            <input autocomplete="off" id="add-recipient-name" type="text" name="name" placeholder="Enter recipient's name" class="nelson-input" required><br>
                                            <p id="add-recipient-invalid-name" class="hidden" style="color:red;">Invalid recipient's name.</p>
                                        </div>
                                        <div class="input-field">
                                            <p class="form-p">Recipient's Phone Number:</p>
                                            <input autocomplete="off" id="add-recipient-number" type="text" name="contact_number" placeholder="Enter recipient's phone number" class="nelson-input" required><br>
                                            <p id="add-recipient-invalid-number" class="hidden" style="color:red;">Invalid recipient's phone number.</p>
                                        </div>
                                        <div class="input-field">
                                            <p class="form-p">Address:</p>
                                            <input autocomplete="off" id="add-address-form" type="text" name="address" placeholder="Enter expiry date" class="nelson-input" required><br>
                                            <p id="add-address-invalid" class="hidden" style="color:red;">Invalid address.</p>
                                        </div>
                                        <div class="input-field">
                                            <p class="form-p">Address Line 2 (Optional):</p>
                                            <input autocomplete="off" id="add-address-two" type="text" name="address_2" placeholder="Address line 2 (optional)" class="nelson-input"><br>
                                            <p id="add-address-two-invalid" class="hidden" style="color:red;">Invalid address.</p>
                                        </div>
                                        <div class="input-field">
                                            <p class="form-p">City:</p>
                                            <input autocomplete="off" id="add-city" type="text" name="city" placeholder="Enter city" class="nelson-input" required><br>
                                            <p id="add-address-invalid-city" class="hidden" style="color:red;">Invalid address.</p>
                                        </div>
                                        <div class="input-field">
                                            <p class="form-p">State:</p>
                                            <input autocomplete="off" id="add-state" type="text" name="state" placeholder="State" class="nelson-input" required><br>
                                            <p id="add-address-invalid-state" class="hidden" style="color:red;">Invalid address.</p>
                                        </div>
                                        <div class="input-field">
                                            <p class="form-p">Zip Code:</p>
                                            <input autocomplete="off" id="add-zip" type="text" name="zip_code" placeholder="Enter zip code" class="nelson-input" required><br>
                                            <p id="add-address-invalid-zip" class="hidden" style="color:red;">Invalid address.</p>
                                        </div>
                                        <input type="submit" id="address-insert" hidden>
                                        <input type="reset" id="address-insert-reset" hidden>
                                    </form>
                                </div>
                            </div>
                            <% } %>
                            </div>
                            </div>
                            </div>

                            <% if (userType.equals("admin") || userType.equals("staff")) { %>
                                <div class="nelson-nav-extension" id="manage-category-extension">
                                    <img src="src/img/white/nelson.png" alt="Nelson Logo" class="logo" style="height: 50px; margin: 20px auto;">
                                    <div class="category-more-container">
                                    <div class="category-list-tab">
                                        <div class="category-list">
                                            <h1>List of categories:</h1>
                                            <hr>
                                            <% for (Category category : categories) { %>
                                            <div class="category-item" id="<%= category.getId() %>">
                                                <p class="category-info" id="<%= category.getId() %>"><%= category.getName() %></p>
                                                <div class="category-dropdown" id="<%= category.getId() %>">
                                                    <img src="src/img/white/more-horizontal.svg" alt="more" class="right category-extend-img" style="height: 30px;">
                                                    <div class="category-dropdown-content" id="<%= category.getId() %>">
                                                        <a href="#" class="category-edit-button" id="<%= category.getId() %>">Rename</a>
                                                        <a href="#" class="category-delete-button" id="<%= category.getId() %>">Delete</a>
                                                    </div>
                                                </div>
                                            </div>
                                            <hr style="margin:0" id="<%= category.getId() %>">
                                            <% } %>
                                        </div>
                                        <button class="nelson-button" id="category-add-button">Add more</button>
                                        <button class="nelson-button" onclick="extension_toggle('manage-category-extension')">Back</button>
                                    </div>
                                        <div class="rename-category" hidden>
                                            <h1>Rename category</h1>
                                            <form method="post" id="categoryRenameForm">
                                                <input type="text" name="id" id="alter-category-id" hidden>
                                                <div class="input-field">
                                                    <p class="form-p">Category Name:</p>
                                                    <input autocomplete="off" id="alter-category-name" type="text" name="name" placeholder="Enter category name" class="nelson-input" required><br>
                                                </div>
                                                <hr>
                                                <button type="submit" class="nelson-button">Rename</button>
                                                <a href="#" class="category-edit-cancel-button"><button class="nelson-button">Cancel</button></a>
                                            </form>
                                        </div>
                                        <div class="add-category" hidden>
                                            <h1>Add category</h1>
                                            <form method="post" id="categoryAddForm">
                                                <input type="text" name="id" id="add-category-id" hidden>
                                                <div class="input-field">
                                                    <p class="form-p">Category Name:</p>
                                                    <input autocomplete="off" id="add-category-name" type="text" name="name" placeholder="Enter category name" class="nelson-input" required><br>
                                                </div>
                                                <hr>
                                                <button type="submit" class="nelson-button">Add</button>
                                                <a href="#" class="category-add-cancel-button"><button class="nelson-button">Cancel</button></a>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <% } %>
<!DOCTYPE html>
<html>

    <head>
        <title>Home - nelson</title>
        <link rel="shortcut icon" href="src/img/favicon.png">
        <link rel="stylesheet" type="text/css" href="src/css/header.css">
        <script type="text/javascript" src="src/js/jquery.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="src/js/init.js"></script>
        <%@ page import="jakarta.servlet.http.Cookie" %>
        <%@ page import="Java.domain.Customer" %>
        <%@ page import="domain.Admin" %>
        <%@ page import="java.util.ArrayList" %>
        <%@ page import="Java.control.CustomerControl" %>
        <%@ page import="control.AdminControl" %>
    </head>

    <body>

        <div class="navigation-bar">
            <div id="navigation-container">
                <a href="/Web_HomeAppliances" class="has-image"><img class="left logo" id="inelson"
                                                                     src="src/img/white/nelson.png" style="height:60%;"></a>
                <a href="/Web_HomeAppliances/explore.jsp" class="left">Explore</a>
                <div class="left dropdown">
                    <a href="#" class="left dropbtn">Category</a>
                    <div class="dropdown-content">
                        <a href="#">Placeholder1</a>
                        <a href="#">Placeholder2</a>
                        <a href="#">Placeholder3</a>
                    </div>
                </div>
                <a href="#" class="left">Feedback</a>
                <div class="right profile-dropdown">
                    <a href="#" class="has-image"><img class="right icon" id="iprofile" src="src/img/white/user.svg"
                                                       style="height:60%;" alt="Profile"></a>
                        <%
                            Customer customer = new Customer();
                            Admin admin = new Admin();
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
                                isLogin = true;
                            } else {
                                for (Cookie cookie : cookies) {
                                    cookie.setMaxAge(0);
                                    response.addCookie(cookie);
                                }
                            }
                            break;
                            case "admin":
                            AdminControl ac = new AdminControl();
                            admin = ac.verifySession(id, session_id);
                            ac.destroy();
                            if (admin != null) {
                                isLogin = true;
                            } else {
                                for (Cookie cookie : cookies) {
                                    cookie.setMaxAge(0);
                                    response.addCookie(cookie);
                                }
                            }
                            break;
                            case "staff":
                            break;
                            default:
                            break;
                            }
                            
                        }
        
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
                                    <button type="submit">Login</button>
                                </form>
                                <hr>
                                <div class="profile-dropdown-content-container-body-register">
                                    <p>Don't have an account?</p>
                                    <a id="nomargin" href="/Web_HomeAppliances/register.html"><button>Register</button></a>

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
                                <h3 class="center" style="margin-top:0;">Balance: RM <%= String.format("%.2f", customer.getBalance()) %></h3>
                                <% break;
                                case "admin": %>
                                <%= admin.getName() %>
                                <% break; case "staff": break; default: break; } %>
                            </div>
                            <hr>
                            <div class="profile-dropdown-content-container-body">
                                <% if (!userType.equals("admin") && !userType.equals("staff")) { %>
                                <div class="profile-dropdown-content-container-body-anchor">
                                    <a href="/Web_HomeAppliances/Profile">My profile</a>
                                </div>
                                <hr>
                                <% if (userType.equals("customer")) {%>
                                <div class="profile-dropdown-content-container-body-anchor">
                                    <a href="/Web_HomeAppliances/topup.jsp">Top up</a>
                                </div>
                                <hr>
                                <div class="profile-dropdown-content-container-body-anchor">
                                    <a href="/Web_HomeAppliances/order.jsp">My orders</a>
                                </div>
                                <hr>
                                <% }} else { %>
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
                                    <button class="right cart-dropdown-content-container-header-clear">Checkout</button>
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
                                                <button>-</button>
                                                <input type="text" value="1" class="cart-quantity">
                                                <button>+</button>
                                                <button id="cart-rem">Remove</button>
                                            </div>
                                            <p class="cart-item-text-price">RM 10.00</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="cart-q">
                                    <div class="cart-item">
                                        <img class="cart-item-image" src="src/img/selipar.webp">
                                        <div class="cart-item-text">
                                            <h2>Selipar
                                            </h2>
                                            <div class="cart-add-remove">
                                                <button>-</button>
                                                <input type="text" value="1" class="cart-quantity">
                                                <button>+</button>
                                                <button id="cart-rem">Remove</button>
                                            </div>
                                            <p class="cart-item-text-price">RM 10.00</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="cart-q">
                                    <div class="cart-item">
                                        <img class="cart-item-image" src="src/img/selipar.webp">
                                        <div class="cart-item-text">
                                            <h2>Selipar
                                            </h2>
                                            <div class="cart-add-remove">
                                                <button>-</button>
                                                <input type="text" value="1" class="cart-quantity">
                                                <button>+</button>
                                                <button id="cart-rem">Remove</button>
                                            </div>
                                            <p class="cart-item-text-price">RM 10.00</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="cart-q">
                                    <div class="cart-item">
                                        <img class="cart-item-image" src="src/img/selipar.webp">
                                        <div class="cart-item-text">
                                            <h2>Selipar
                                            </h2>
                                            <div class="cart-add-remove">
                                                <button>-</button>
                                                <input type="text" value="1" class="cart-quantity">
                                                <button>+</button>
                                                <button id="cart-rem">Remove</button>
                                            </div>
                                            <p class="cart-item-text-price">RM 10.00</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="cart-q">
                                    <div class="cart-item">
                                        <img class="cart-item-image" src="src/img/selipar.webp">
                                        <div class="cart-item-text">
                                            <h2>Selipar
                                            </h2>
                                            <div class="cart-add-remove">
                                                <button>-</button>
                                                <input type="text" value="1" class="cart-quantity">
                                                <button>+</button>
                                                <button id="cart-rem">Remove</button>
                                            </div>
                                            <p class="cart-item-text-price">RM 10.00</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="cart-q">
                                    <div class="cart-item">
                                        <img class="cart-item-image" src="src/img/selipar.webp">
                                        <div class="cart-item-text">
                                            <h2>Selipar
                                            </h2>
                                            <div class="cart-add-remove">
                                                <button>-</button>
                                                <input type="text" value="1" class="cart-quantity">
                                                <button>+</button>
                                                <button id="cart-rem">Remove</button>
                                            </div>
                                            <p class="cart-item-text-price">RM 10.00</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="cart-q">
                                    <div class="cart-item">
                                        <img class="cart-item-image" src="src/img/selipar.webp">
                                        <div class="cart-item-text">
                                            <h2>Selipar
                                            </h2>
                                            <div class="cart-add-remove">
                                                <button>-</button>
                                                <input type="text" value="1" class="cart-quantity">
                                                <button>+</button>
                                                <button id="cart-rem">Remove</button>
                                            </div>
                                            <p class="cart-item-text-price">RM 10.00</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
                <div class="right noti-dropdown">
                    <a href="#" class="has-image"><img class="right icon" id="inoti" src="src/img/white/bell.svg"
                                                       style="height:60%;" alt="Notifications"></a>
                    <div class="noti-dropdown-content">
                        <div class="noti-dropdown-content-container">
                            <div class="noti-dropdown-content-container-header">
                                <h1 id="insert-noti-count">Notifications </h1>
                                <div>
                                    <button class="right noti-dropdown-content-container-header-clear">Clear</button>
                                    <button class="right noti-dropdown-content-container-header-close">Show all</button>
                                </div>
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
                                <div class="noti-q">
                                    <div class="noti-item"> <!-- src/img/selipar.webp -->
                                        <img class="noti-item-image" src="src/img/selipar.webp">
                                        <div class="noti-item-text">
                                            <h2>Selipar
                                            </h2>
                                            <p>On the way to your face</p>
                                            <p class="noti-item-text-time">3 minutes ago</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="noti-q">
                                    <div class="noti-item"> <!-- src/img/selipar.webp -->
                                        <img class="noti-item-image" src="src/img/selipar.webp">
                                        <div class="noti-item-text">
                                            <h2>Selipar
                                            </h2>
                                            <p>On the way to your face</p>
                                            <p class="noti-item-text-time">4 minutes ago</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="noti-q">
                                    <div class="noti-item"> <!-- src/img/selipar.webp -->
                                        <img class="noti-item-image" src="src/img/selipar.webp">
                                        <div class="noti-item-text">
                                            <h2>Selipar
                                            </h2>
                                            <p>On the way to your face</p>
                                            <p class="noti-item-text-time">5 minutes ago</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="noti-q">
                                    <div class="noti-item"> <!-- src/img/selipar.webp -->
                                        <img class="noti-item-image" src="src/img/selipar.webp">
                                        <div class="noti-item-text">
                                            <h2>Selipar
                                            </h2>
                                            <p>On the way to your face</p>
                                            <p class="noti-item-text-time">6 minutes ago</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <form class="search-container right">
                        <input type="text" placeholder="Search.." name="search" class="search-nelson" autocomplete="off" required>
                        <button type="submit" class="right search-btn"></button>
                    </form>
                </div>
            </div>
    </body>

</html>

<!DOCTYPE html>
<html>

<head>
    <title>Home - nelson</title>
    <link rel="shortcut icon" href="src/img/favicon.png">
    <link rel="stylesheet" type="text/css" href="src/css/header.css">
    <link rel="stylesheet" type="text/css" href="src/css/body.css">
    <script type="text/javascript" src="src/js/jquery.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="src/js/init.js"></script>
    <%@ page import="jakarta.servlet.http.Cookie" %>
        <%@ page import="Java.domain.Customer" %>
            <%@ page import="java.util.ArrayList" %>
                <%@ page import="Java.control.CustomerControl" %>
</head>

<body>

    <div class="navigation-bar">
        <div id="navigation-container">
            <a href="/Web_HomeAppliances" class="has-image"><img class="left logo" id="inelson"
                    src="src/img/white/nelson.png" style="height:60%;"></a>
            <a href="#" class="left">Home</a>
            <div class="left dropdown">
                <a href="#" class="left dropbtn">Categories</a>
                <div class="dropdown-content">
                    <a href="#">Placeholder1</a>
                    <a href="#">Placeholder2</a>
                    <a href="#">Placeholder3</a>
                </div>
            </div>
            <a href="#" class="left">About</a>
            <a href="#" class="left">Feedback</a>
            <div class="right profile-dropdown">
                <a href="#" class="has-image"><img class="right icon" id="iprofile" src="src/img/white/user.svg"
                        style="height:60%;" alt="Profile"></a>
                        <%
                        Cookie[] cookies = request.getCookies();
                        int id = -1;
                        String session_id = "";
                        String userType = "";
                        Customer customer = new Customer();
                        if (cookies != null) {
                            for (Cookie cookie : cookies) {
                                System.out.println(cookie.getName());
                                System.out.println(cookie.getValue());
                                if (cookie.getName().equals("id")) {
                                    id = Integer.parseInt(cookie.getValue());
                                } else if (cookie.getName().equals("session")) {
                                    session_id = cookie.getValue();
                                }
                            }
                        }
        
                        boolean isLogin = false;
        
                        if (id != -1  && !session_id.equals("")) {
                            CustomerControl cc = new CustomerControl();
                            customer = cc.verifySession(id, session_id);
                            if (customer != null) {
                                userType = "customer";
                                isLogin = true;
                                // ...
                            }
                        }
        
                         if (!isLogin) {
                        %>
                    <div class="profile-dropdown-content login <%= id %>">
                        <div class="profile-dropdown-content-container">
                            <div class="profile-dropdown-content-container-header center">
                                <img src="src/img/white/user.svg" alt="Profile">
                            </div>
                            <div class="profile-dropdown-content-container-body">
                                <form class="login-form" action="/Web_HomeAppliances/Login" method="post">
                                    <input type="text" placeholder="Username" name="username" required
                                        autocomplete="off">
                                    <input type="password" placeholder="Password" name="password" required>
                                    <button type="submit">Login</button>
                                </form>
                                <hr>
                                <div class="profile-dropdown-content-container-body-register">
                                    <p>Don't have an account?</p>
                                    <button>Register</button>

                                </div>
                            </div>
                        </div>
                    </div>
                    <% } else { %>
                        <div class="profile-dropdown-content <%= userType %>">
                            <div class="profile-dropdown-content-container">
                                <div class="profile-dropdown-content-container-header">
                                    <div class="center">
                                        <img src="src/img/white/user.svg" alt="Profile"><br>
                                    </div>
                                    <div class="center">
                                        <h1 id="profile-name">
                                            <%= customer.getName() %>
                                        </h1>
                                    </div>
                                </div>
                                <hr>
                                <div class="profile-dropdown-content-container-body">
                                    <% if (userType.equals(customer)) { %>
                                    <div class="profile-dropdown-content-container-body-anchor">
                                        <a href="/Web_HomeAppliances/Profile">My profile</a>
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

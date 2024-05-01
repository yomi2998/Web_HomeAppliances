<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Climate Control Category</title>
        <link rel="stylesheet" type="text/css" href="src/css/grid.css">
        <link rel="shortcut icon" href="src/img/favicon.png">
        <link rel="stylesheet" type="text/css" href="src/css/header.css">
        <link rel="stylesheet" type="text/css" href="src/css/body.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="src/js/init.js"></script>
        <script type="text/javascript" src="src/js/jquery.js"></script>
    </head>
    <body>
        <header>
            <div class="sidenav" id="Securitynav">
                <a href="javascript:void(0)"
                   class="closebtn"
                   onclick="closeNav()">&times;</a>
                <a href="Cleaning.jsp">Cleaning</a>
                <a href="Entertainment.jsp">Entertainment</a>
                <a href="Kitchen.jsp">Kitchen</a>
                <a href="Laundry.jsp">Laundry</a>
                <a href="Security.jsp">Security</a>
            </div>
            <span style="font-size:30px;cursor:pointer"
                  onclick="openNav()">&#9776; open</span>
            <script>
                function openNav() {
                    document.getElementById("Securitynav").style.width = "250px";
                }

                function closeNav() {
                    document.getElementById("Securitynav").style.width = "0";
                }
            </script>

            <form class="search-container right">
                <input type="text" placeholder="Search.." name="search" class="search-nelson" autocomplete="off">
                <button type="submit" class="right search-btn"></button>
            </form>
        </header>
        
        <div class="grid-container">
            <div class="grid-item">
                <img src="src/img/Product/Climate Control/SmartAircon.jpg" alt="Product Image 1">
                <div class="description">
                    <h2>Daikin SMARTO Premium R32 Inverter</h2>
                    <p>allows the air flow to be orchestrated at different strength and speed</p><br>
                    <p>generates an air throw effect towards the far end of the room</p><br>
                    <p>gives excellent air modulation to entire room</p><br>
                    <p>Price: RM 2599.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Climate Control/SmartHeater.jpg" alt="Product Image 2">
                <div class="description">
                    <h2>Govee Smart Space Heater</h2>
                    <p>Digital Display</p>
                    <p>Remote Control</p><br>
                    <p>WiFi Enabled</p><br>
                    <p>Price: RM 1999.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Climate Control/CeilingFan.png" alt="Product Image 3">
                <div class="description">
                    <h2>Panasonic nanoe X 60" DC Motor Ceiling Fan</h2>
                    <p>Sample Product Page.</p>
                    <p>Lower the indoor temperature</p><br>
                    <p>Save Energy with Air Conditioners</p><br>
                    <p>Price: RM 1229.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Climate Control/Dehumidifier.jpg" alt="Product Image 4">
                <div class="description">
                    <h2>Noveco Technologies Portable Dehumidifier</h2>
                    <p>Humidity Automatic Control</p>
                    <p>Touch Sensitive Panel with LED display</p><br>
                    <p>Automatic defrost system</p><br>
                    <p>Price: RM 999.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>
        </div>

        <footer>
            <p>&copy; 2024 Nelson Company. All rights reserved.</p>
        </footer>
    </body>
</html>

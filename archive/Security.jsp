<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Security Category</title>
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
                <a href="ClimateControl.jsp">Climate Control</a>
                <a href="Entertainment.jsp">Entertainment</a>
                <a href="Kitchen.jsp">Kitchen</a>
                <a href="Laundry.jsp">Laundry</a>
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
                <img src="src/img/Product/Security/OutdoorCam.jpg" alt="Product Image 1">
                <div class="description">
                    <h2>1080P high definition real-time monitoring</h2>
                    <p>1080P high definition real-time monitoring</p><br>
                    <p>Active deterrence with sound-light alarm</p><br>
                    <p>IR night view</p><br>
                    <p>IP66 ingress protection for outdoor installation</p><br>
                    <p>Price: RM 250.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Security/IndoorCam.jpg" alt="Product Image 2">
                <div class="description">
                    <h2>Life Smart Indoor Camera (1080P)</h2>
                    <p>1080P high definition real-time monitoring</p><br>
                    <p>Two-way talk</p><br>
                    <p>IR night view</p><br>
                    <p>Communicates with devices and alarm notifications</p><br>
                    <p>Pan and tilt for 360-degree monitoring</p><br>
                    <p>Lens cover feature for personal information protection</p><br>
                    <p>Remotely monitor and control via mobile app</p><br>
                    <p>Price: RM 200.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Security/DoorLock.png" alt="Product Image 3">
                <div class="description">
                    <h2>Life Smart Door Lock</h2>
                    <p>Multiple access</p><br>
                    <p>Anti-theft lock case</p><br>
                    <p>Detect break-in and entrance attempts</p><br>
                    <p>Price: RM 150.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Security/MotionSensor.jpg" alt="Product Image 4">
                <div class="description">
                    <h2>CUBE Motion Sensor</h2>
                    <p>120° wide-angle detection</p><br>
                    <p>Built-in light sensor to switch day/night mode</p><br>
                    <p>Notifications and record searching via the app</p><br>
                    <p>Compact size and could be placed anywhere</p><br>
                    <p>Price: RM 99.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Security/DoorSensor.png" alt="Product Image 5">
                <div class="description">
                    <h2>CUBE Door/Window Sensor</h2>
                    <p>Remote alarm once opening or vibrating detected</p>
                    <p>Real-time feedback on door/window status</p><br>
                    <p>Notifications and record searching via the app</p><br>
                    <p>One-button for scenes control</p><br>
                    <p>Price: RM 69.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Security/GasSensor.png" alt="Product Image 6">
                <div class="description">
                    <h2>Life Smart Gas Sensor</h2>
                    <p>Multi-type gas detection including methane, natural gas, and biogas</p><br>
                    <p>Real-time monitoring of your house safety</p><br>
                    <p>Notifications and record searching via the app</p><br>
                    <p>Built-in sound alarm</p><br>
                    <p>Price: RM 69.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Security/AirQualityDetector.png" alt="Product Image 7">
                <div class="description">
                    <h2>Life Smart In-wall Air Quality Detector</h2>
                    <p>The built-in high-precision sensor is precise and stable.</p><br>
                    <p>TFT screen real-time display.</p><br>
                    <p>24-hour air quality monitoring.</p><br>
                    <p>The mobile APP checks the air quality in real time.</p><br>
                    <p>86 boxes embedded installation, beautiful and convenient.</p><br>
                    <p>Intelligent linkage to improve air quality.</p><br>
                    <p>Price: RM 79.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>
        </div>

        <footer>
            <p>&copy; 2024 Nelson Company. All rights reserved.</p>
        </footer>
    </body>
</html>

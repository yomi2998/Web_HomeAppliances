<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Cleaning Category</title>
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
                <a href="ClimateControl.jsp">Climate Control</a>
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
                <img src="src/img/Product/Cleaning & Laundry/AirPurifier.png" alt="Product Image 1">
                <div class="description">
                    <h2>COWAY LOMBOK 3rdGen Air Purifier</h2>
                    <p>0-Pressure Touch Panel</p><br>
                    <p>3-stage Speed Control</p><br>
                    <p>Child Lock System</p><br>
                    <p>Price: RM 2999.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Cleaning & Laundry/DishWasher.avif" alt="Product Image 2">
                <div class="description">
                    <h2>IKEA LAGAN Integrated dishwasher</h2>
                    <p>Muffled sound signal indicates when program finished</p><br>
                    <p>Delayed start function of up to 3 hours</p><br>
                    <p>Height of upper basket is Adjustable</p><br>
                    <p>Price: RM 1999.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Cleaning & Laundry/IronSystem.avif" alt="Product Image 3">
                <div class="description">
                    <h2>Laurastar SMART I Ironing System</h2>
                    <p>Hygenic Steam - Kills 99.999% of bacteria, dust mites and fungi in your textiles</p><br>
                    <p>3 in 1 iron - steam, iron and purify your textiles with the Laurastar performance</p><br>
                    <p>Price: RM 9900.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Cleaning & Laundry/Iron.avif" alt="Product Image 4">
                <div class="description">
                    <h2>Morphy Richards Crystal Clear Steam Iron</h2>
                    <p>30g Per Min Constant Steam allows you to glide from item to item with ease</p><br>
                    <p>100g Steam Boost can be triggered with the touch of a button</p><br>
                    <p>Easy Store Cable Clip may able you to wrap the cable around the base of the iron and secure in place</p><br>
                    <p>Price: RM 189.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Cleaning & Laundry/RobotCleaner.jpeg" alt="Product Image 5">
                <div class="description">
                    <h2>Sweeping Household Robot Vacuum Cleaner</h2>
                    <p>Multi function vacuuming, sweeping, mop.</p><br>
                    <p>This robot vacuum cleaner can recognize the barrier and avoids collision</p><br>
                    <p>Suitable for cement floors, ceramic tiles, wooden floors, short-haired carpets</p><br>
                    <p>Price: RM 29.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Cleaning & Laundry/" alt="Product Image 6">
                <div class="description">
                    <h2>LG Front Load Washer</h2>
                    <p>Sample Product Page.</p>
                    <p>Price: RM XX.XX</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>
        </div>

        <footer>
            <p>&copy; 2024 Nelson Company. All rights reserved.</p>
        </footer>
    </body>
</html>

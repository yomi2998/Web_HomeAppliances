<!DOCTYPE html>
<html>
    <head>
        <title>Kitchen Category</title>
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
                <img src="src/img/Product/Kitchen/SmartRefrigerator.avif" alt="Product Image 1">
                <div class="description">
                    <h2>LG 601L French Door Fridge</h2>
                    <p>Knock twice to see inside with Black Glass Instaview</p><br>
                    <p>Remotely control the fridge and enjoy a smarter life with LG ThinQ</p><br>
                    <p>Price: RM 3299.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Kitchen/MultiCooking.webp" alt="Product Image 2">
                <div class="description">
                    <h2>Ninja Foodi 8-in-1 6L Multi Cooker</h2>
                    <p>Replaces Pressure Cooker, Air Fryer, Slow Cooker and etc</p><br>
                    <p>Can grill, steam, bake, roast, pressure cook, air fry, slow cook, all in one compact kitchen machine</p><br>
                    <p>Price: RM 1499.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Kitchen/SmartOven.avif" alt="Product Image 3">
                <div class="description">
                    <h2>IKEA SMAKSAK Microware</h2>
                    <p>Quick start function for fast warming up at full power</p><br>
                    <p>Combination of forced air and microwaves reduces both cooking time</p><br>
                    <p>Top and bottom heating is ideal for cooking dishes with a crispy finish and for slow cooking of casseroles</p><br>
                    <p>Price: RM 3999.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Kitchen/SmartScales.jpg" alt="Product Image 4">
                <div class="description">
                    <h2>Etekcity Food Kitchen Digital Scale</h2>
                    <p>Can measure liquids easily with waterproof design</p><br>
                    <p>can measure item with 5 units: grams, ounces, pounds, ounces mililiters abd fluid ounces</p><br>
                    <p>Price: RM 89.00</p>
                    <button>Add to Cart</button>
                </div>
            </div>
        </div>

        <footer>
            <p>&copy; 2024 Nelson Company. All rights reserved.</p>
        </footer>
    </body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Entertainment Category</title>
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
                <img src="src/img/Product/Entertainment/TV.avif" alt="Product Image 1">
                <div class="description">
                    <h2>Samsung 98-Inch Neo QLED 4K AI TV</h2>
                    <p>NQ4 AI Gen2 Processor - Feel the full power of AI in 4K</p>
                    <p>Quantum Matrix Technology - Catch every details enabled in accurate ultra fine light control</p><br>
                    <p>Supersize Picture Enhancer - AI Powered image enhancements tailored to super large screen</p><br>
                    <p>Price: RM 48399.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Entertainment/Nintendo.avif" alt="Product Image 2">
                <div class="description">
                    <h2>Nintendo Switch with Gray Joy-Con</h2>
                    <p>You can play the games you want, wherever you are, however you like</p><br>
                    <p>Three modes in one - TV mode, Tabletop mode and Handheld mode</p><br>
                    <p>Price: RM 1288.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Entertainment/Projector.avif" alt="Product Image 3">
                <div class="description">
                    <h2>Hisense Laser Cinema + TV Projector Screen</h2>
                    <p>90"-130" Projection size - projects colourful and bright 4k images up to 130" inches super large size</p><br>
                    <p>Filmmaker mode technique will retain the original settings to display the most authentic scenes from movies</p><br>
                    <p>Price: RM 18999.00</p>
                    <button class="nelson-button">Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="src/img/Product/Entertainment/Speakers.avif" alt="Product Image 4">
                <div class="description">
                    <h2>Sony GTK-PG10 Outdoor Wireless Speaker</h2>
                    <p>GTK-PG10 is ideal for enjoying musiv outside whether it's a party, picnic or camping trip</p><br>
                    <p>The built-in rechargeable battery powers your party for up to 13 hours</p><br>
                    <p>You can pair your smartphone with GTK-PG10 using short-range wireless Bluetooth connection</p><br>
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

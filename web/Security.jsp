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
                <img src="product-image.jpg" alt="Product Image 1">
                <div class="description">
                    <h2>Description</h2>
                    <p>Sample Product Page.</p>
                    <p>Price: RM XX.XX</p>
                    <button>Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="product-image.jpg" alt="Product Image 2">
                <div class="description">
                    <h2>Description</h2>
                    <p>Sample Product Page.</p>
                    <p>Price: RM XX.XX</p>
                    <button>Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="product-image.jpg" alt="Product Image 3">
                <div class="description">
                    <h2>Description</h2>
                    <p>Sample Product Page.</p>
                    <p>Price: RM XX.XX</p>
                    <button>Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="product-image.jpg" alt="Product Image 4">
                <div class="description">
                    <h2>Description</h2>
                    <p>Sample Product Page.</p>
                    <p>Price: RM XX.XX</p>
                    <button>Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="product-image.jpg" alt="Product Image 5">
                <div class="description">
                    <h2>Description</h2>
                    <p>Sample Product Page.</p>
                    <p>Price: RM XX.XX</p>
                    <button>Add to Cart</button>
                </div>
            </div>

            <div class="grid-item">
                <img src="product-image.jpg" alt="Product Image 6">
                <div class="description">
                    <h2>Description</h2>
                    <p>Sample Product Page.</p>
                    <p>Price: RM XX.XX</p>
                    <button>Add to Cart</button>
                </div>
            </div>
        </div>

        <footer>
            <p>&copy; 2024 Nelson Company. All rights reserved.</p>
        </footer>
    </body>
</html>

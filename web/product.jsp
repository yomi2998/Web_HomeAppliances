<!DOCTYPE html>
<html>

    <head>
        <title>Product - nelson</title>
        <link rel="shortcut icon" href="src/img/favicon.png">
        <link rel="stylesheet" href="src/css/product.css">
        <link rel="stylesheet" href="src/css/rating.css">
        <%
            //CONFIGURATION

            final boolean ALLOW_ADMIN = true;
            final boolean ALLOW_STAFF = true;
            final boolean ALLOW_CUSTOMER = true;
            final boolean ALLOW_GUEST = true;

            //END OF CONFIGURATION
        %>
    </head>
    <body>
        <div class="nelson-greeter">
            <img src="src/img/white/nelson.png" alt="Nelson Logo" class="logo" style="width: 40%;">
        </div>
        <%@ include file="navigation.jsp" %>
        <script>
            $(document).ready(function () {
                    $(".product-subimage").click(function () {
                        $("#product-image-container img").attr("src", $(this).attr("src"));
                    });
                    $("#plus").click(function () {
                        var quantity = parseInt($("input[name='quantity']").val());
                        if (quantity < parseInt($("input[name='quantity']").attr("max"))) {
                            $("input[name='quantity']").val(quantity + 1);
                        }
                    });
                    $("#minus").click(function () {
                        var quantity = parseInt($("input[name='quantity']").val());
                        if (quantity > 1) {
                            $("input[name='quantity']").val(quantity - 1);
                        }
                    });
                });
        </script>
        <style>
            input::-webkit-outer-spin-button,
            input::-webkit-inner-spin-button {
              -webkit-appearance: none;
              margin: 0;
            }
        </style>
        <div class="container" style="display: none;">
            <% Product product = pc.retrieveProduct(Integer.parseInt(request.getParameter("product_id"))); %>
            <div class="product-section">
                <div class="product-image">
                    <div id="product-image-container">
                        <img src="<%= product.getSub_images().get(0) %>" alt="<%= product.getName() %>" style="width: 500px; height: 500px;">
                    </div>
                    <div id="product-subimage-container">
                        <% for (String image : product.getSub_images()) { %>
                        <img class="product-subimage" src="<%= image %>" alt="<%= product.getName() %>" style="width: 100px; height: 100px;">
                        <% } %>
                    </div>
                </div>
                <div class="product-details">
                    <h1><%= product.getName() %></h1>
                    <div class="star-rating">
                        <% for (int i = 0; i < (int)product.getRating(); i++) { %>
                            <span class="fa fa-star checked"></span>
                        <% } %>
                        <% for (int i = 5; i > (int)product.getRating(); i--) { %>
                            <span class="fa fa-star unchecked"></span>
                        <% } %>
                    </div>
                    <p><%= product.getRating() %> | <%= product.getSold() %> sold</p>
                    <p>Price: <%= String.format("RM %.2f", product.getPrice()) %></p>
                    <p>Category: <a class="nodeco" href="search.jsp?category=<%= product.getCategory_id() %>"><%= cac.getCategoryById(product.getCategory_id()) %></a></p>
                    <p>Stock: <%= product.getStock() %></p>
                    <% if (userType.equals("customer") && product.getStock() > 0) { %>
                    <form id="quantityForm">
                        <div>
                        <input type="text" name="product_id" value="<%= product.getId() %>" hidden>
                        <input type="text" name="user_id" value="<%= customer.getId() %>" hidden>
                        <a href="#"><button class="nelson-button nomarginleft" id="minus">-</button></a>
                        <input type="number" class="nelson-number" name="quantity" value="1" min="1" max="<%= product.getStock() %>">
                        <a href="#"><button class="nelson-button" id="plus">+</button></a>
                        </div>
                        <button type="submit" class="nelson-button nomarginleft">Add to cart</button>
                        <button type="button" class="nelson-button">Buy now</button>
                    </form>
                    <% } else if (!userType.equals("customer")) { %>
                        <p style="color:red">Please register/use a valid customer account to buy/add to cart.</p>
                    <% } else { %>
                        <p style="color:red">Product is currently out of stock.</p>
                    <% } %>
                </div>
            </div>
            <hr>
            <div class="product-description">
                <h1>Description</h1>
                <p><%= product.getDescription() %></p>
            </div>
            <hr>
            <div class="product-reviews">
                <h1>Product reviews</h1>
            </div>
        </div>
    </body>
</html>

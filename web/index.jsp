<!DOCTYPE html>
<html>

    <head>
        <title>Home - nelson</title>
        <link rel="shortcut icon" href="src/img/favicon.png">
        <link rel="stylesheet" href="src/css/search.css">
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
        <div class="container" style="display: none;">
            <img src="src/img/white/nelson.png" alt="Nelson Logo" class="logo" style="width: 20%; margin: 0 auto; display: block;">
            <hr>
            <h1>Top selling products</h1>
            <div class="">
                <div class="grid-5-section">
                    <% List<Product> products = pc.getTopSellingProducts(); int cnt = 0;
                    for (Product product : products) { ++cnt; %>
                    <a class="nodeco" href="product.jsp?product_id=<%= product.getId() %>">
                        <div class="search-item">
                            <div>
                                <img src="<%= product.getDisplay_image() %>" alt="<%= product.getName() %>" style="width: 10vw; height: 10vw;">
                                <p style="font-weight: bold;"><%= product.getName().length() > 20 ? product.getName().substring(0, 20) + "..." : product.getName() %></h2>
                                <p><%= String.format("RM %.2f", product.getPrice()) %></p>
                                <p><%= product.getSold() %> sold</p>
                                <% if (product.getStock() == 0) { %>
                                <p style="color: red;">Out of stock</p>
                                <% } %>
                            </div>
                        </div>
                    </a>
                    <% } if (cnt == 0) { %>
                    <p>No product found.</p>
                    <% } %>
                </div>
            </div>
            <hr>
            <h1>Top rated products</h1>
            <div class="">
                <div class="grid-5-section">
                    <% cnt = 0; products = pc.getTopRatedProducts();
                    for (Product product : products) { ++cnt; %>
                    <a class="nodeco" href="product.jsp?product_id=<%= product.getId() %>">
                        <div class="search-item">
                            <div>
                                <img src="<%= product.getDisplay_image() %>" alt="<%= product.getName() %>" style="width: 10vw; height: 10vw;">
                                <p style="font-weight: bold;"><%= product.getName().length() > 20 ? product.getName().substring(0, 20) + "..." : product.getName() %></h2>
                                <p><%= String.format("RM %.2f", product.getPrice()) %></p>
                                <p><%= product.getSold() %> sold</p>
                                <% if (product.getStock() == 0) { %>
                                <p style="color: red;">Out of stock</p>
                                <% } %>
                            </div>
                        </div>
                    </a>
                    <% } if (cnt == 0) { %>
                    <p>No product found.</p>
                    <% } %>
                </div>
            </div>
            <hr>
            <h1>Browse</h1>
            <div class="">
                <div class="grid-5-section">
                    <% cnt = 0; products = pc.retrieveProductALL();
                    for (Product product : products) { ++cnt; %>
                    <a class="nodeco" href="product.jsp?product_id=<%= product.getId() %>">
                        <div class="search-item">
                            <div>
                                <img src="<%= product.getDisplay_image() %>" alt="<%= product.getName() %>" style="width: 10vw; height: 10vw;">
                                <p style="font-weight: bold;"><%= product.getName().length() > 20 ? product.getName().substring(0, 20) + "..." : product.getName() %></h2>
                                <p><%= String.format("RM %.2f", product.getPrice()) %></p>
                                <p><%= product.getSold() %> sold</p>
                                <% if (product.getStock() == 0) { %>
                                <p style="color: red;">Out of stock</p>
                                <% } %>
                            </div>
                        </div>
                    </a>
                    <% } if (cnt == 0) { %>
                    <p>No product found.</p>
                    <% } %>
                </div>
                <hr>
            </div>
        </div>
        <%@ include file="footer.jsp" %>
    </body>
</html>

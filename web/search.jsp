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
            <p style="font-size: 10vw;">Search</p>
        </div>
        <%@ include file="navigation.jsp" %>
        <div class="container" style="display: none;">
            <% String search = request.getParameter("search");
                if (search == null) {
                    search = "";
                }
                List<Product> products = pc.searchProducts(search);
            %>
            <h1>Search results for "<%= search %>"</h1>
            <div class="search-item-section">
                <div>
                    <form action="search.jsp" method="get" id="product-search-form">
                        <input autocomplete="off" type="text" class="search-nelson" name="search" value="<%= search %>" placeholder="Search">
                        <button type="submit" class="search-btn-ii" value="Search"></button>
                    </form>
                    <hr>
                    <p>Hello world</p>
                    <p>Hello world</p>
                    <p>Hello world</p>
                    <p>Hello world</p>
                    <p>Hello world</p>
                    <p>Hello world</p>
                    <p>Hello world</p>
                    <p>Hello world</p>
                    <p>Hello world</p>
                </div>
                <div class="search-item-list">
                <%
                    for (Product product : products) {
                %>
                <div class="search-item">
                    <div>
                    <img src="<%= product.getDisplay_image() %>" alt="<%= product.getName() %>" style="width: 10vw; height: 10vw;">
                    <p style="font-weight: bold;"><%= product.getName().length() > 20 ? product.getName().substring(0, 20) + "..." : product.getName() %></h2>
                    <p><%= String.format("RM %.2f", product.getPrice()) %></p>
                    <div class="star-rating">
                        &nbsp;<%= product.getRating() %> | <%= product.getSold() %> sold
                        <% for (int i = 5; i > (int)product.getRating(); i--) { %>
                            <span class="fa fa-star unchecked"></span>
                        <% } %>
                        <% for (int i = 0; i < (int)product.getRating(); i++) { %>
                            <span class="fa fa-star checked"></span>
                        <% } %>
                    </div>
                </div>
                </div>
                <% } %>
            </div>
            </div>
        </div>
    </body>
</html>

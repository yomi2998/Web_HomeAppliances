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
                String category_id = request.getParameter("category");
                List<Product> products = pc.searchProducts(search == null ? "" : search, category_id == null ? 0 : Integer.parseInt(category_id));
            %>
            <div class="search-item-section">
                <div>
                    <h1>Filters</h1>
                    <hr>
                    <h3>Search</h3>
                    <form action="search.jsp" method="get" id="product-search-form">
                        <input autocomplete="off" type="text" class="search-nelson" name="search" value="<%= search == null ? "" : search %>" placeholder="Search">
                        <button type="submit" class="search-btn-ii" value="Search"></button>
                    </form>
                    <hr>
                    <h3>Categories</h3>
                    <div class="category-list">
                        <%
                            for (Category category : categories) {
                        %>
                        <a href="search.jsp?category=<%= category.getId() %>"><button class="nelson-button"><%= category.getName() %></button></a>
                        <% } %>
                    </div>
                </div>
                <div>
                    <h1>Search results <%= search == null ? "" : "for \"" + search + "\"" %></h1>
                    <hr>
                <div class="search-item-list">
                <%
                    for (Product product : products) {
                %>
                <a class="nodeco" href="product.jsp?product_id=<%= product.getId() %>">
                <div class="search-item">
                    <div>
                    <img src="<%= product.getDisplay_image() %>" alt="<%= product.getName() %>" style="width: 10vw; height: 10vw;">
                    <p style="font-weight: bold;"><%= product.getName().length() > 20 ? product.getName().substring(0, 20) + "..." : product.getName() %></h2>
                    <p><%= String.format("RM %.2f", product.getPrice()) %></p>
                    <div class="star-rating">
                        <% for (int i = 0; i < (int)product.getRating(); i++) { %>
                            <span class="fa fa-star checked"></span>
                        <% } %>
                        <% for (int i = 5; i > (int)product.getRating(); i--) { %>
                            <span class="fa fa-star unchecked"></span>
                        <% } %>
                    </div>
                    <p><%= product.getRating() %> | <%= product.getSold() %> sold</p>
                </div>
                </div>
                </a>
                <% } %>
            </div>
            <hr>
            <h3>End of search results</h3>
            </div>
            </div>
        </div>
        <%@ include file="footer.jsp" %>
    </body>
</html>

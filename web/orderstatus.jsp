<!DOCTYPE html>
<html>

    <head>
        <title>Update order status - nelson</title>
        <link rel="shortcut icon" href="src/img/favicon.png">
        <link rel="stylesheet" href="src/css/order.css">

        <%
            //CONFIGURATION

            final boolean ALLOW_ADMIN = true;
            final boolean ALLOW_STAFF = true;
            final boolean ALLOW_CUSTOMER = false;
            final boolean ALLOW_GUEST = false;

            //END OF CONFIGURATION
        %>
    </head>

    <body>
        <div class="nelson-greeter">
            <p style="font-size: 10vw;">Order status</p>
        </div>
        <%@ include file="navigation.jsp" %>
        <%
            List<Order> orders = oc.getShippedOrders(); 
        %>
        <script src="src/js/order.js"></script>
        <div class="container" style="display: none;">
            <div class="division">
                <div class="cart-dropdown-content-container">
                    <div class="cart-dropdown-content-container-header">
                        <h1>Update order status</h1>
                    </div>
                </div>
                <div class="cart-dropdown-content-container-body-ii">
                    <%

                        String image = "";
                        for (Order order : orders) {
                            image = "";
                        List<OrderProduct> prods = order.getOrder_product();
                        String order_name = "#" + order.getId() + ": ";
                        for (OrderProduct prod : prods) {
                            Product p = pc.retrieveProduct(prod.getProduct_id());
                            if (image.equals("")) {
                                image = p.getDisplay_image();
                            }
                            order_name += p.getName() + ", ";
                        }
                        order_name = order_name.substring(0, order_name.length() - 2);
                    %>
                    <div class="cart-q" id="update-<%= order.getId() %>">
                        <div class="cart-item">
                            <img class="cart-item-image" src="<%= image %>">
                            <div class="cart-item-text">
                                <h2><%= order_name %>
                                </h2>
                                <p>Ordered on <%= order.getCreate_date() %></p>
                                <p>Status: <%= order.getOrder_status().get(0).getStatus() %></p>
                                <p><%= String.format("RM %.2f total", order.getFinal_price()) %></p>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            </div>
            <div class="division fqwfq">
                <h1>Order details</h1>
                <div id="js-insert-details">
                    <p>Click on an order from left to display the details.</p>
                </div>
            </div>
        </div>
    </body>
</html>

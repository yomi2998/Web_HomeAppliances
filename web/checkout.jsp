<!DOCTYPE html>
<html>

    <head>
        <title>Home - nelson</title>
        <link rel="shortcut icon" href="src/img/favicon.png">
        <link rel="stylesheet" href="src/css/checkout.css">

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
        <% String[] product_ids = request.getParameter("id").split(","); %>
        <% String[] quantities = request.getParameter("qty").split(","); %>
        <%
            List<Product> checkoutProducts = new ArrayList<>();
            double price = 0;
            for (int i = 0; i < product_ids.length; i++) {
                Product product = pc.retrieveProduct(Integer.parseInt(product_ids[i]));
                price += product.getPrice() * Integer.parseInt(quantities[i]);
                checkoutProducts.add(product);
            }
            double price_with_shipping_and_tax = price + (price >= 1000 ? 0 : 25) + (price * 0.08);
        %>
        <div class="container" style="display: none;">
            <form id="paymentForm">
                <div class="divide">
                    <div class="shipping-section">
                        <h1>Billing details</h1>
                        <div class="payment-method-section">
                            <div>
                                <h3>Select payment method:</h3>
                                <input type="radio" class="payment-method-radio" id="nelson-wallet" name="payment" value="nelson-wallet" required>
                                <label for="nelson-wallet">nelson wallet (<%= String.format("RM %.2f", customer.getBalance()) %>)</label><br>
                                <input type="radio" class="payment-method-radio" id="credit-card" name="payment" value="card" required>
                                <label for="credit-card">Card</label>
                            </div>
                            <div class="card-select" hidden>
                                <h3>Payment method: card payment</h3>
                                <select class="nelson-select topup-card-select" id="card-payment-select" style="min-width: 210px">
                                    <option value="0" disabled>Select card</option>
                                    <% for (Card card : carc.retrieveCards(customer.getId())) { %>
                                        <option value="<%= card.getId() %>"><%= card.getName() %> <%= card.getCard_number().substring(0, 4) %>-XXXX-XXXX-XXXX</option>
                                    <% } %>
                                </select>
                                <div>
                                    <a href="#"><button class="nelson-button nomarginleft" onclick="extension_toggle('profile-extension'); $('#profile-payment').click();">Manage</button></a>
                                    <a href="#"><button class="nelson-button topup-card-refresh"">Refresh</button></a>
                                </div>
                            </div>
                            <div class="nelson-wallet-info" hidden>
                                <h3>Payment method: nelson wallet</h3>
                                <p>Current balance: <%= String.format("RM %.2f", customer.getBalance()) %></p>
                                <% if (customer.getBalance() - price_with_shipping_and_tax < 0) { %>
                                    <p style="color: red;">Insufficient balance. Please top up your wallet.</p>
                                <% } %>
                                <a href="#"><button class="nelson-button nomarginleft" onclick="extension_toggle('topup-extension')">Top up</button></a>
                            </div>
                        </div>
                        <hr>
                        <div class="shipping-address-section">
                            <h3>Shipping address:</h3>
                            <% for (Address c : adc.retrieveAddresses(customer.getId())) { %>
                            <div class="hidden-address-field">
                                <input type="text" id="ship-id-<%= c.getId() %>" value="<%= c.getId() %>" hidden>
                                <input type="text" id="ship-name-<%= c.getId() %>" value="<%= c.getRecipient_name() %>" hidden>
                                <input type="text" id="ship-cont-<%= c.getId() %>" value="<%= c.getContact_number() %>" hidden>
                                <input type="text" id="ship-addr-<%= c.getId() %>" value="<%= c.getAddress() %>" hidden>
                                <input type="text" id="ship-addrii-<%= c.getId() %>" value="<%= c.getAddress_2() == null ? "" : c.getAddress_2() %>" hidden>
                                <input type="text" id="ship-city-<%= c.getId() %>" value="<%= c.getCity() %>" hidden>
                                <input type="text" id="ship-state-<%= c.getId() %>" value="<%= c.getState() %>" hidden>
                                <input type="text" id="ship-zip-<%= c.getId() %>" value="<%= c.getZip_code() %>" hidden>
                            </div>
                            <% } %>
                            <select class="nelson-select" id="ship-select" style="min-width: 210px" required>
                                <option value="0" disabled>Select address</option>
                                <% for (Address c : adc.retrieveAddresses(customer.getId())) { %>
                                    <option value="<%= c.getId() %>"><%= c.getAddress() %></option>
                                <% } %>
                            </select>
                            <a href="#"><button class="nelson-button nomarginleft" onclick="extension_toggle('profile-extension'); $('#profile-shipping').click();">Manage</button></a>
                            <a href="#"><button class="nelson-button" id="shipping-refresh">Refresh</button></a>
                        </div>
                        <div class="address-section" hidden>
                            <h3>Address details:</h3>
                            <div id="address-details">
                                <input type="text" id="address-id" hidden>
                                <p id="address-name"></p>
                                <p id="address-contact"></p>
                                <p id="address-addr"></p>
                                <p id="address-addrii"></p>
                                <p id="address-city"></p>
                                <p id="address-state"></p>
                                <p id="address-zip"></p>
                            </div>
                        </div>
                        <hr>
                        <div class="cart-purchase">
                            <button class="nelson-button nomarginleft" type="submit">Purchase</button>
                        </div>
                    </div>
                    <div class="cart-summary">
                        <h1>Cart summary</h1>
                        <hr>
                        <% for (Product product : checkoutProducts) { %>
                        <div class="cart-item">
                            <div class="cart-item-image">
                                <img src="<%= product.getDisplay_image() %>" alt="<%= product.getName() %>" style="width: 100px; height: 100px;">
                            </div>
                            <div class="cart-item-details">
                                <h3><%= product.getName() %></h3>
                                <p>Quantity: <%= quantities[checkoutProducts.indexOf(product)] %></p>
                                <p>Price: <%= String.format("RM %.2f each, RM %.2f total", product.getPrice(), product.getPrice() * Integer.parseInt(quantities[checkoutProducts.indexOf(product)])) %></p>
                            </div>
                        </div>
                        <% } %>
                        <hr>
                        <div class="cart-total">
                            <h3>Subtotal: <%= String.format("RM %.2f", price) %></h3>
                            <h3>Shipping: <%= price >= 1000 ? "Free" : "RM 25.00" %></h3>
                            <h3>Tax (8%): <%= String.format("RM %.2f", price * 0.08) %></h3>
                            <h3>Total: <%= String.format("RM %.2f", price_with_shipping_and_tax) %></h3>
                            <input type="text" id="hidden-price-total" value="<%= price_with_shipping_and_tax %>" hidden>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <%@ include file="footer.jsp" %>
    </body>
</html>

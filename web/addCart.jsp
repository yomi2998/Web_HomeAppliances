<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="src/css/addCart.css">
    <link rel="stylesheet" type="text/css" href="src/css/header.css">
    <link rel="stylesheet" type="text/css" href="src/css/body.css">
    <script src="src/js/addCart.js"></script>
    <title>Add To Cart</title>
</head>
<body>
    <h1>Your Cart</h1>
    <div class="productList">
        <div class="cart-and-suggestions">
            <div class="table-container">
                <table>
                    <tbody>
                        <tr>
                            <td><input type="checkbox" id="checkbox"></td>
                            <td><img src="https://via.placeholder.com/150x150" alt="Product 1"></td>
                            <td>Product 1</td>
                            <td>
                                <div class="quantity-control">
                                    <button onclick="totalClick(-1)" class="nelson-button">-</button>
                                    <span class="totalClicks">1</span>
                                    <button onclick="totalClick(1)" class="nelson-button">+</button>
                                    <button onclick="totalClick(0)" class="nelson-button">Reset</button>
                                </div>
                            </td>
                            <td>
                                <button class="nelson-button">Pay</button>
                                <button class="nelson-button">Remove</button>
                            </td>
                        </tr>
                        <tr>
                            <td><input type="checkbox" id="checkbox"></td>
                            <td><img src="https://via.placeholder.com/150x150" alt="Product 2"></td>
                            <td>Product 2</td>
                            <td>
                                <div class="quantity-control">
                                    <button onclick="totalClick(-1)" class="nelson-button">-</button>
                                    <span class="totalClicks">1</span>
                                    <button onclick="totalClick(1)" class="nelson-button">+</button>
                                    <button onclick="totalClick(0)" class="nelson-button">Reset</button>
                                </div>
                            </td>
                            <td>
                                <button class="nelson-button">Pay</button>
                                <button class="nelson-button">Remove</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <form action="checkout.jsp">
                    <div class="buttons-wrapper">
                        <div class="checkout">
                            <button onclick="checkOutBtn()" class="nelson-button" id="checkoutBtn">Checkout All</button>
                            <a href="#"><button class="nelson-button" id="continueShoppingBtn">Continue Shopping</button></a>
                            <button class="nelson-button" id="clearCartBtn" onclick="clearCart()">Delete Cart</button>
                        </div>
                    </div>
                </form>
            </div>
            <div class="suggestions-container">
                <h2>Suggested Items</h2>
                <ul>
                    <li><img src="https://via.placeholder.com/100" alt="Suggested Item 1">Item 1</li>
                    <li><img src="https://via.placeholder.com/100" alt="Suggested Item 2">Item 2</li>
                    <li><img src="https://via.placeholder.com/100" alt="Suggested Item 3">Item 3</li>
                </ul>
            </div>
            
        </div>
    </div>

</body>
</html>

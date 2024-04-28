<html>
<link rel="stylesheet" type="text/css" href="src/css/checkout.css">

<body>
    <h1>Checkout Page</h1>
    <hr>
    <h2>Shipping</h2>

    <div class="shipping">
            <label for="addressSelect">Select a saved address:</label><br>
            <select name="address">
                <option value="">asndansjdlksa</option>
                <option value="">aa</option>
            </select>
            <a href="/Web_HomeAppliances/addAddress.html"><button>Add Address</button></a>
            <br>
            
    <hr>    
    <div class="itemlist">
        <u><h2>Your Order</h2></u>
        <table>
            <tr>
                <th>Product</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Total</th>
            </tr>
            <tr>
                <td>Product 1</td>
                <td>$10</td>
                <td>$10</td>
            </tr>
        </table>
    </div>
    <hr>

    <table>
        <tr>
            <td>Subtotal:</td>
        </tr>
        <tr>
            <td>Tax :</td>
        </tr>
    </table>
    <hr>
    <button>Cancel</button>
    <button>Pay</button>
</body>

</html>